From: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] tests: test applying criss-cross rename patch
Date: Sat, 11 Apr 2009 17:26:24 +0200
Message-ID: <1239463584-1427-1-git-send-email-michal.kiedrowicz@gmail.com>
References: <alpine.LFD.2.00.0904091147290.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 11 17:30:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsfAB-0001Yi-0W
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 17:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbZDKP0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 11:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754300AbZDKP0l
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 11:26:41 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:62755 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbZDKP0k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 11:26:40 -0400
Received: by bwz17 with SMTP id 17so1476381bwz.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AqjE8LulK1k6I5l0Fec60bPnJ8muMEEub55nm78kQfo=;
        b=BQpHIXaai2NLx4TFg2Fp2NwyWzr+QmrfD4Cn2fXrHwio8iQOcsW974bpqSwlRRe1BC
         C/2PNIKwdYm5WDOU+L8aAyMbxgJSN1Wwwxvo1Ig/eVbacA6kjvx+BRHiljbq75Sce05d
         Y+tGHGlYwJM+yJ9Qza5/zhRb+8+CYie6VpobE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CM7tY7MhTPk9Rb2A0W54LWUvvh/K3hYIGcZagC072349iTn3Ha03QObkL6qj9hOZPb
         tUYIXnHK3dC1Kn/69+VkYXAv35Qbb7KJRVhyJw4bqpjMD2u1b1+T0TQsaa1az9HK1G7p
         bHQy8xn/giZwj/QUojNxFn25WMysku6Dlrt2w=
Received: by 10.204.115.143 with SMTP id i15mr4295879bkq.103.1239463598165;
        Sat, 11 Apr 2009 08:26:38 -0700 (PDT)
Received: from localhost (77-254-83-61.adsl.inetia.pl [77.254.83.61])
        by mx.google.com with ESMTPS id k29sm2887052fkk.27.2009.04.11.08.26.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 08:26:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <alpine.LFD.2.00.0904091147290.4583@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116299>


Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 t/t4130-apply-criss-cross-rename.sh |   35 +++++++++++++++++++++++++++=
++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100755 t/t4130-apply-criss-cross-rename.sh

diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-criss-=
cross-rename.sh
new file mode 100755
index 0000000..30187ff
--- /dev/null
+++ b/t/t4130-apply-criss-cross-rename.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description=3D'git apply handling criss-cross rename patch.'
+. ./test-lib.sh
+
+create_file() {
+	for ((i=3D0; i<100; i++)); do
+		echo "$2" >> "$1"
+	done
+}
+
+test_expect_success 'setup' '
+	create_file file1 "File1 contents" &&
+	create_file file2 "File2 contents" &&
+	git add file1 file2 &&
+	git commit -m 1
+'
+
+test_expect_success 'criss-cross rename' '
+	mv file1 tmp &&
+	mv file2 file1 &&
+	mv tmp file2
+'
+
+test_expect_success 'diff -M -B' '
+	git diff -M -B > diff &&
+	git reset --hard
+
+'
+
+test_expect_failure 'apply' '
+	git apply diff
+'
+
+test_done
--=20
1.6.0.6
