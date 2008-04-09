From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: [PATCH 3/8] git-send-email.perl: Handle shell metacharacters
	in $EDITOR properly
Date: Wed, 9 Apr 2008 10:28:08 -0400
Message-ID: <20080409142808.GC24402@shion.is.fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <1207704604-30393-2-git-send-email-bdonlan@fushizen.net> <1207704604-30393-3-git-send-email-bdonlan@fushizen.net> <47FC62B6.9020304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 16:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjbIF-0004Yp-8Q
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 16:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbYDIO2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 10:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbYDIO2L
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 10:28:11 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:60093 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbYDIO2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 10:28:10 -0400
X-Greylist: delayed 873 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Apr 2008 10:28:10 EDT
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JjbHU-0001Fl-UB; Wed, 09 Apr 2008 14:28:09 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JjbHU-00071o-Sg; Wed, 09 Apr 2008 10:28:08 -0400
Content-Disposition: inline
In-Reply-To: <47FC62B6.9020304@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79107>

On Wed, Apr 09, 2008 at 08:31:18AM +0200, Johannes Sixt wrote:
> Bryan Donlan schrieb:
> > Also, update t/t9001-send-email.sh to test for this bug.
> > 
> > Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
> 
> Your defintion of "properly"? I didn't immediately see what is wrong with
> the status quo and, hence, why your fix would solve a problem.

This fixes the git-send-perl semantics for launching an editor when
$GIT_EDITOR (or friends) contains shell metacharacters to match
launch_editor() in builtin-tag.c. If we use the current approach
(sh -c '$0 $@' "$EDITOR" files ...), we see it fails when $EDITOR has
shell metacharacters:

$ sh -x -c '$0 $@' "$VISUAL" "foo"
+ "$FAKE_EDITOR" foo
"$FAKE_EDITOR": 1: "$FAKE_EDITOR": not found

Whereas builtin-tag.c will invoke sh -c "$EDITOR \"$@\"".

Note that with the method git-send-perl uses currently, it's difficult
(impossible?) to deal with a editor path that contains arbitrary shell
metacharacters. It's certainly impossible when the various git tools use
different semantics :)

I'll amend the commit message along with the other suggested changes.
