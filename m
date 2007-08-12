From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git --work-tree=... status
Date: Sun, 12 Aug 2007 12:32:27 -0700
Message-ID: <7vlkcgim5w.fsf@assigned-by-dhcp.cox.net>
References: <20070812185855.GA16704@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:32:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJAv-0004U7-6j
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934116AbXHLTca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 15:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933624AbXHLTca
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:32:30 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48347 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbXHLTc3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 15:32:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812193230.IMZV3478.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 12 Aug 2007 15:32:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id b7YU1X00r1kojtg0000000; Sun, 12 Aug 2007 15:32:29 -0400
In-Reply-To: <20070812185855.GA16704@informatik.uni-freiburg.de> (Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig's?= message of "Sun, 12 Aug 2007 20:58:56
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55708>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> The problem seems to be that require_work_tree demands more that I th=
ink
> it should.  It calls `git rev-parse --is-inside-work-tree`.

I think the semantics of require_work_tree is (currently and has
been) indeed "you are supposed to be inside the work tree".

"git-status $args" is a "git commit --dry-run $args" and $args
are often filenames relative to $cwd that name paths to include
in the partial commit, so for this particular case I think it is
understandable that it wants you to be _IN_ the work tree.

You can propose alternative semantics to "git status" that is
defined as "cd_to_toplevel && git diff --cached && git diff"
that does not care any of the $args, and I personally am open to
such a departure from "commit --dry-run" semantics, which have
been there since 1.4.0 days.  But that is a huge user level
semantics change, and will not belong to the 1.5.X series.
