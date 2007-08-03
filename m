From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug in t3700-add.sh?
Date: Fri, 03 Aug 2007 14:29:43 -0700
Message-ID: <7v643wmhmg.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0708031351g5e585a4bj849fbf2ec3720a18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <johannes.sixt@telecom.at>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 23:29:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH4iS-00056k-0l
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 23:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762210AbXHCV3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 17:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762195AbXHCV3p
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 17:29:45 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57104 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762174AbXHCV3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 17:29:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803212944.BJS26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 3 Aug 2007 17:29:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XZVj1X00U1kojtg0000000; Fri, 03 Aug 2007 17:29:44 -0400
In-Reply-To: <fcaeb9bf0708031351g5e585a4bj849fbf2ec3720a18@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Fri, 3 Aug 2007 16:51:37 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54761>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> Running test 17, I got this output:

Gaah.  Those $s seem completely bogus.

This test only cares to see if the blob type is retained (it
does "git add" to the path later to throw away the unmergedness
and data at higher stage prepared by this step), so it really
does not matter what is fed to hash-object.  But it should be
hashing a file whose contents is '1' and a symlink to '2'.


diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b52fde8..213e924 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -131,8 +131,8 @@ test_expect_success 'git add with filemode=0, symlinks=0 prefers stage 2 over st
 	(
 		echo "100644 $(git hash-object -w stage1) 1	file"
 		echo "100755 $(git hash-object -w stage2) 2	file"
-		echo "100644 $(printf $s | git hash-object -w -t blob --stdin) 1	symlink"
-		echo "120000 $(printf $s | git hash-object -w -t blob --stdin) 2	symlink"
+		echo "100644 $(printf 1 | git hash-object -w -t blob --stdin) 1	symlink"
+		echo "120000 $(printf 2 | git hash-object -w -t blob --stdin) 2	symlink"
 	) | git update-index --index-info &&
 	git config core.filemode 0 &&
 	git config core.symlinks 0 &&
