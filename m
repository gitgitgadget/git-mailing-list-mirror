From: sean <seanlkml@sympatico.ca>
Subject: Adding color to git diff output.
Date: Tue, 11 Apr 2006 18:32:45 -0400
Message-ID: <BAYC1-PASMTP08B0DB32592225AAD0838AAECD0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 12 00:36:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTRTD-0002o1-Ve
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 00:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWDKWgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 18:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWDKWgU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 18:36:20 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:34533 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751177AbWDKWgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Apr 2006 18:36:19 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 11 Apr 2006 15:40:08 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id A1130644C28;
	Tue, 11 Apr 2006 18:36:14 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060411183245.7723c70c.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 11 Apr 2006 22:40:08.0546 (UTC) FILETIME=[E2B42420:01C65DB8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Linus posted a colorize program a while back[1] but it wasn't taken into git.  
The patch below takes a different approach, adding a GIT_DIFF_PAGER variable.
You can use it by assigning a filter to the environment variable, like so:

export GIT_DIFF_PAGER="colordiff | less -RS"

Sean

P.S.  .gitignore is missing a few entries: "git.spec" (rpm build), "tags" 
      (ctags), and ".*.swp" (vi editor temp files).

[1] http://marc.theaimsgroup.com/?l=git&m=114315063918024&w=2


diff --git a/git-diff.sh b/git-diff.sh
index dc0dd31..f792340 100755
--- a/git-diff.sh
+++ b/git-diff.sh
@@ -69,4 +69,8 @@ case "$rev" in
 	;;
 esac
 
+if [ -n "$GIT_DIFF_PAGER" ]; then
+	cmd="$cmd | $GIT_DIFF_PAGER"
+fi
+
 eval "$cmd"
