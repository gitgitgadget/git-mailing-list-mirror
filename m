From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-diff: Output a warning about stale files in the index
Date: Tue, 07 Aug 2007 00:46:05 -0700
Message-ID: <7vbqdj7poi.fsf@assigned-by-dhcp.cox.net>
References: <7vbqdj9709.fsf@assigned-by-dhcp.cox.net>
	<20070807071712.GA32751@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 09:46:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIJlv-0001Uw-Rz
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 09:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbXHGHqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 03:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756020AbXHGHqI
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 03:46:08 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57637 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbXHGHqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 03:46:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807074607.GWGA26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 7 Aug 2007 03:46:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yvm51X00G1kojtg0000000; Tue, 07 Aug 2007 03:46:06 -0400
In-Reply-To: <20070807071712.GA32751@midwinter.com> (Steven Grimm's message of
	"Tue, 7 Aug 2007 00:17:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55230>

Steven Grimm <koreth@midwinter.com> writes:

> Signed-off-by: Steven Grimm <koreth@midwinter.com>
> ---
> 	Modified as suggested by Junio.

Okay.

Assuming that other people are happy with this version (I have
to warn you that I haven't even attempted to apply this patch,
let alone compiling yet), I'd prefer to keep our combined
thought process in the commit log, so that we do not have to
rehash this later, over and over again.

Something along the following lines, perhaps...?

  After starting to edit a working tree file but later when your
  edit ends up identical to the original (this can also happen
  when you ran a wholesale regexp replace with something like
  "perl -i" that does not touch many of the paths), "git diff"
  between the index and the working tree outputs many "empty"
  diffs that show "diff --git" header and nothing else, because
  these paths are stat dirty.  While it was _a_ way to warn the
  user that the earlier action of the user made the index
  ineffective as an optimization mechanism, it was felt too loud
  for the purpose of warning even to experienced users, and also
  resulted in confusing people new to git.

  This replaces the "empty" diffs with a single warning message
  at the end.  When you see such a message, you know you did
  something suboptimal to your index; you can optimize the index
  again by running "git-update-index --refresh".

  The change affects only "git diff" that outputs patch text,
  because that is where the annoyance of too many "empty" diff
  is most strongly felt, and because the warning message can be
  safely ignored by downstream tools without getting mistaken as
  part of the patch.  For the low-level "git diff-files", the
  traditional behaviour is retained.
