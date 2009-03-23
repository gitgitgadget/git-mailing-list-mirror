From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 6/6] format-patch: --numbered-files and --stdout aren't mutually exclusive
Date: Sun, 22 Mar 2009 19:14:06 -0700
Message-ID: <7bf87c296a246e417b9fac0c215c717a27289fba.1237773605.git.bebarino@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <cover.1237773604.git.bebarino@gmail.com>
 <baa327d88b54efae40b6d9df09a2fe482672101e.1237773604.git.bebarino@gmail.com>
 <616420f398701fafc45b5d5cebb1371534f88caa.1237773604.git.bebarino@gmail.com>
 <00c4e51c2ff7786be6aedb4a451b8d1ff269d7b3.1237773604.git.bebarino@gmail.com>
 <e8e0dcc738decb5f70dbc8e835263d7dc2834407.1237773604.git.bebarino@gmail.com>
 <bb1484f1a621238d8689e471cc6affd8590cd382.1237773604.git.bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 03:16:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlZhy-0000lE-LM
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 03:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320AbZCWCOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 22:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755105AbZCWCOc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 22:14:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:7334 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbZCWCO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 22:14:29 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1338594wah.21
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 19:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=LT6mBDgKQHxflxHGN/P9ESGCZG7rc7z1UWVCrIgsjvY=;
        b=pz19huhxv4v5AFzK1dOk0d1rpN93TUiKDm+cVSPnqs5TjKaQ6p/o8nu3Xo2tSR1+gN
         SQRu5E7kAkhFa3RwyrLJSzd3CAWX7cEgnwZjoiVmRO7Sir93KtM4dqWvdp+CvuTyqQSa
         vjgxDs1+ESFTIIoaqdnYn5eCD+QSO1xl4THt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=twBZo+0Kxlb/gYhvQFGJ6W7eiaGP1s0FmpTKIaeQIchUijyY3Ft7feBEhnxwEnjkQH
         GdVWUe1dv9+eJ6UpKgfP0yXlPZnO733SvPkMinYVgTsq2ggSm1mBYJtGVD7ASIsNGMxV
         pTlAIagdSVQ6yo37VWqhR8qfm51sPx77yi4ws=
Received: by 10.114.198.5 with SMTP id v5mr4439238waf.131.1237774466925;
        Sun, 22 Mar 2009 19:14:26 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id l27sm4641396waf.41.2009.03.22.19.14.25
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 19:14:26 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 22 Mar 2009 19:14:24 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <bb1484f1a621238d8689e471cc6affd8590cd382.1237773604.git.bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114233>

For example:

    git format-patch --numbered-files --stdout --attach HEAD~~

will create two messages with files 1 and 2 attached respectively.
There is no effect when using --numbered-files and --stdout together
without an --attach or --inline, the --numbered-files option will be
ignored. Add a test to show this.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 t/t4013-diff-various.sh                            |    2 +-
 ...nline_--stdout_--numbered-files_initial..master |  170 ++++++++++++++++++++
 2 files changed, 171 insertions(+), 1 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6592a4f..8b33321 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -251,7 +251,7 @@ format-patch --attach --stdout initial..master^
 format-patch --attach --stdout initial..master
 format-patch --inline --stdout initial..side
 format-patch --inline --stdout initial..master^
-format-patch --inline --stdout initial..master
+format-patch --inline --stdout --numbered-files initial..master
 format-patch --inline --stdout initial..master
 format-patch --inline --stdout --subject-prefix=TESTCASE initial..master
 config format.subjectprefix DIFFERENT_PREFIX
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
new file mode 100644
index 0000000..43b81eb
--- /dev/null
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
@@ -0,0 +1,170 @@
+$ git format-patch --inline --stdout --numbered-files initial..master
+From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:01:00 +0000
+Subject: [PATCH 1/3] Second
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
+
+This is a multi-part message in MIME format.
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/plain; charset=UTF-8; format=fixed
+Content-Transfer-Encoding: 8bit
+
+
+This is the second commit.
+---
+ dir/sub |    2 ++
+ file0   |    3 +++
+ file2   |    3 ---
+ 3 files changed, 5 insertions(+), 3 deletions(-)
+ delete mode 100644 file2
+
+
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/x-patch; name="1"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: inline; filename="1"
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..8422d40 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++C
++D
+diff --git a/file0 b/file0
+index 01e79c3..b414108 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++4
++5
++6
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+
+--------------g-i-t--v-e-r-s-i-o-n--
+
+
+
+From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:02:00 +0000
+Subject: [PATCH 2/3] Third
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
+
+This is a multi-part message in MIME format.
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/plain; charset=UTF-8; format=fixed
+Content-Transfer-Encoding: 8bit
+
+---
+ dir/sub |    2 ++
+ file1   |    3 +++
+ 2 files changed, 5 insertions(+), 0 deletions(-)
+ create mode 100644 file1
+
+
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/x-patch; name="2"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: inline; filename="2"
+
+diff --git a/dir/sub b/dir/sub
+index 8422d40..cead32e 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2,3 +2,5 @@ A
+ B
+ C
+ D
++E
++F
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+
+--------------g-i-t--v-e-r-s-i-o-n--
+
+
+
+From c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:03:00 +0000
+Subject: [PATCH 3/3] Side
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
+
+This is a multi-part message in MIME format.
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/plain; charset=UTF-8; format=fixed
+Content-Transfer-Encoding: 8bit
+
+---
+ dir/sub |    2 ++
+ file0   |    3 +++
+ file3   |    4 ++++
+ 3 files changed, 9 insertions(+), 0 deletions(-)
+ create mode 100644 file3
+
+
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/x-patch; name="3"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: inline; filename="3"
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+
+--------------g-i-t--v-e-r-s-i-o-n--
+
+
+$
-- 
1.6.2
