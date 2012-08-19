From: Robert Luberda <robert@debian.org>
Subject: Re: [PATCH/RFC] git svn: handle errors and concurrent commits in
 dcommit
Date: Mon, 20 Aug 2012 00:43:19 +0200
Organization: Debian
Message-ID: <50316C07.30907@debian.org>
References: <1343856397-6536-1-git-send-email-robert@debian.org> <20120802104421.GA13271@dcvr.yhbt.net> <5021F9D4.1010700@debian.org> <20120808230754.GB24956@dcvr.yhbt.net> <7v1ujgot8h.fsf@alter.siamese.dyndns.org> <20120810195133.GA16423@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 00:45:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3EEu-0007mZ-KF
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 00:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab2HSWoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 18:44:55 -0400
Received: from master.debian.org ([70.103.162.29]:34408 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab2HSWoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 18:44:15 -0400
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1T3EE9-0006fZ-TP; Sun, 19 Aug 2012 22:44:14 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by vox.robbo.home (Postfix) with ESMTP id D73CFE2ABF;
	Mon, 20 Aug 2012 00:43:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.6esrpre) Gecko/20120817 Icedove/10.0.6
In-Reply-To: <20120810195133.GA16423@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203741>

Eric Wong wrote:

Hi,

> Junio C Hamano <gitster@pobox.com> wrote:
>> I should have asked this yesterday, but do you mean you want to have
>> your "maint" in the upcoming 1.7.12?  This does look like a useful
>> thing to do, but does not seem like a regression fix to me.
> 
> Yeah, I wasn't sure what to name it since my master is still carrying
> Michael's larger SVN 1.7 changes.   Perhaps I should've named my "maint"
> "for-git-master" in this case...


While working on my next patch, I've accidentally discovered that bash gives
the following errors in the test file introduced in my commit :

./t9164-git-svn-dcommit-concrrent.sh: line 65: $hook: ambiguous redirect
./t9164-git-svn-dcommit-concrrent.sh: line 66: $hook: ambiguous redirect

(The test succeeds, even though assignments of the PATH and svnconf
variables is missing; is seems svn treats an empty value of --config-dir
as the current dir.)


Sorry about not noticing this before, dash is used as default /bin/sh on
my system. A simple patch for this issue is included below.

There is also a typo in the test file name: `concrrent' instead of
`concurrent', but it most probably doesn't make any sense to make a
patch for it.


>8--->8--->8--->8--->8--->8--->8--->8--->8--->8--->8--->8--->8
Subject: [PATCH] Add missing quotes in test t9164

This fixes `ambiguous redirect' error given by bash.
---
 t/t9164-git-svn-dcommit-concrrent.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9164-git-svn-dcommit-concrrent.sh
b/t/t9164-git-svn-dcommit-concrrent.sh
index aac2dda..676ef00 100755
--- a/t/t9164-git-svn-dcommit-concrrent.sh
+++ b/t/t9164-git-svn-dcommit-concrrent.sh
@@ -62,8 +62,8 @@ EOF1
        if [ "$hook_type" = "pre-commit" ]; then
                echo "echo 'commit disallowed' >&2; exit 1" >> "$hook"
        else
-               echo "PATH=\"$PATH\"; export PATH" >> $hook
-               echo "svnconf=\"$svnconf\"" >> $hook
+               echo "PATH=\"$PATH\"; export PATH" >> "$hook"
+               echo "svnconf=\"$svnconf\"" >> "$hook"
                cat >> "$hook" <<- 'EOF2'
                        cd work-auto-commits.svn
                        svn up --config-dir "$svnconf"
--
1.7.10.4


>8--->8--->8--->8--->8--->8--->8--->8--->8--->8--->8--->8--->8




Regards,
robert
