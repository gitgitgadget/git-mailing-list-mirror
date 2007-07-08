From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] t7004: Skip tests for signed tags in an old version of gpg.
Date: Sun, 08 Jul 2007 21:36:34 +0200
Message-ID: <46913CC2.4030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sven Verdoolaege <skimo@liacs.nl>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 21:36:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7cYv-0001Aw-19
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 21:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbXGHTgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 15:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755012AbXGHTgr
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 15:36:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:25380 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbXGHTgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 15:36:46 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1021518ugf
        for <git@vger.kernel.org>; Sun, 08 Jul 2007 12:36:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=hG0XBx9ShtxWS3F4IVrEOoCeFKFIkM4oOlUouYbyx1QrSlr4twTDE//ZO4yWe+zUhbHcVN4FEfVqcu5c6OVjzuadw61wPVoBF/d5nUIzYDef87dnCNapUciIEAK6HEGwTippK/RdY7bFY763EbzzS9HqpLgCwNcdUiqHqjrY0YU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=A4vlauK1C+2vpuDp3ZE7GFRkTWXNJhXO8rVE589hW/m1EkBPfoFjQcZVR3VqhwTl7eTT6hHdqohh8v8X/p3yNucm/p2jJ+nosTdMwxFebEcrKkf3x7bGQU7uQ4h6Ei5YCbi2/tKPMwMoMSE9ssv0Ouk+eZJhxbfAF8qO66HSgeU=
Received: by 10.67.121.15 with SMTP id y15mr4528961ugm.1183923403785;
        Sun, 08 Jul 2007 12:36:43 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id h1sm899627ugf.2007.07.08.12.36.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Jul 2007 12:36:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51910>

As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
the gpg version 1.0.6 didn't parse trust packets correctly, so for
that version, creation of signed tags using the generated key fails.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
This was already discussed in a previous message from Sven,
who runs that old version of gpg:
http://thread.gmane.org/gmane.comp.version-control.git/51291

The page describing the bug was found by Johannes after some research:
http://colabti.de/irclogger/irclogger_log/git?date=2007-07-01,Sun&sel=482#l814

 t/t7004-tag.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index a845930..b785080 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -460,6 +460,17 @@ if [ $? -eq 127 ]; then
 	exit
 fi

+# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
+# the gpg version 1.0.6 didn't parse trust packets correctly, so for
+# that version, creation of signed tags using the generated key fails.
+case "$(gpg --version)" in
+'gpg (GnuPG) 1.0.6'*)
+	echo "Skipping signed tag tests, because a bug in 1.0.6 version"
+	test_done
+	exit
+	;;
+esac
+
 # key generation info: gpg --homedir t/t7004 --gen-key
 # Type DSA and Elgamal, size 2048 bits, no expiration date.
 # Name and email: C O Mitter <committer@example.com>
-- 
1.5.0
