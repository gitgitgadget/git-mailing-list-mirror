From: larsxschneider@gmail.com
Subject: [PATCH v2 2/2] git-p4: fix Git LFS pointer parsing
Date: Wed, 20 Apr 2016 10:10:09 +0200
Message-ID: <1461139809-6573-3-git-send-email-larsxschneider@gmail.com>
References: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sschuberth@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 10:10:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asnDi-0005m9-98
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 10:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbcDTIKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 04:10:24 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35852 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbcDTIKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 04:10:16 -0400
Received: by mail-wm0-f48.google.com with SMTP id v188so192405534wme.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 01:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7u3D5UEzw8PdH1UyiMAR3DGIjUdaBIvnjBucHVrNNiU=;
        b=BRYDLGr7PYoaAP5DoqQYknLcsqEilOHeLE0T8mY/K8+SM1EzHRhrgaMQTNXML8caee
         nOgNMyIekMR5CuptBNYsUa7OoKwPb/BkE2oaTzRwCaPBAsiX0NWGvpn17/9hWStIC2v8
         anfQDoH/ro4eWbEqt7Zfbr7RjkHsztbp1P/Yl+ASNYbdavYyCJYhZjkYjOM599JYzhS/
         mpi5YBiDcT985woGt2IwN5ccvSy9leJflMXMHtaLDkwdCDRW1QMdmc5DWIAtKRQgqkUX
         6U0NkEFp+x3nJ36S09dZKT8gcwDMh7uIBIsaGlM04YB8AWaoCzANEZoNW5U+H2AGO9EH
         9YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7u3D5UEzw8PdH1UyiMAR3DGIjUdaBIvnjBucHVrNNiU=;
        b=cjc8bRdS3deSy1QtzZFS9MpdeaocyBZbACmeEQg2G7MczY1pM5JIaoIdl1eQoNsVfD
         fo2VgxTaAIPbEW5JIL4LrUo3J8hhaYTPpj0zM3my6TkQ9o70t+8BZYCyFrmWjjl54sYl
         WJdJ0mgwUfPvKZ7xQYlix6cqpwTcMGyGrgGCVGFplK5SozVBNxp+nhWjhVPNEj6DVrDg
         w3pFg1DH8X/ULWNZ1nfHayOE6uBSc3PqFg1LL9XN6w3jsmSLyWi69x7l0kT2fWPjxEgy
         BqPfCVS1Vi+J7sAuoy0ZQdCJklvO6423t60EmTJu6GrjbdVPf4cFwf1huMctk2SU0cu6
         ao2A==
X-Gm-Message-State: AOPr4FWoV5Z8lyv9R12QxkENBw68h3VNf/odUES+e7+ZYTxt72klcU4VGwUL1xbg8p9XlQ==
X-Received: by 10.28.131.195 with SMTP id f186mr27460484wmd.97.1461139815237;
        Wed, 20 Apr 2016 01:10:15 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAD5D.dip0.t-ipconnect.de. [80.139.173.93])
        by smtp.gmail.com with ESMTPSA id r8sm1502008wme.14.2016.04.20.01.10.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 01:10:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291993>

From: Lars Schneider <larsxschneider@gmail.com>

Git LFS 1.2.0 removed a preamble from the output of the 'git lfs pointer'
command [1] which broke the parsing of this output. Adjust the parser
to support the old and the new format.

[1] https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py                 | 15 ++++++++++++---
 t/t9824-git-p4-git-lfs.sh |  4 ++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 527d44b..ab52bc3 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1064,8 +1064,17 @@ class GitLFS(LargeFileSystem):
         if pointerProcess.wait():
             os.remove(contentFile)
             die('git-lfs pointer command failed. Did you install the extension?')
-        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
-        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
+
+        # Git LFS removed the preamble in the output of the 'pointer' command
+        # starting from version 1.2.0. Check for the preamble here to support
+        # earlier versions.
+        # c.f. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
+        preamble = 'Git LFS pointer for ' + contentFile + '\n\n'
+        if pointerFile.startswith(preamble):
+            pointerFile = pointerFile[len(preamble):]
+
+        oidEntry = [i for i in pointerFile.split('\n') if i.startswith('oid')]
+        oid = oidEntry[0].split(' ')[1].split(':')[1]
         localLargeFile = os.path.join(
             os.getcwd(),
             '.git', 'lfs', 'objects', oid[:2], oid[2:4],
@@ -1073,7 +1082,7 @@ class GitLFS(LargeFileSystem):
         )
         # LFS Spec states that pointer files should not have the executable bit set.
         gitMode = '100644'
-        return (gitMode, pointerContents, localLargeFile)
+        return (gitMode, pointerFile, localLargeFile)
 
     def pushFile(self, localLargeFile):
         uploadProcess = subprocess.Popen(
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index 0b664a3..ca93ac8 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -13,6 +13,10 @@ test_file_in_lfs () {
 	FILE="$1" &&
 	SIZE="$2" &&
 	EXPECTED_CONTENT="$3" &&
+	sed -n '1,1 p' "$FILE" | grep "^version " &&
+	sed -n '2,2 p' "$FILE" | grep "^oid " &&
+	sed -n '3,3 p' "$FILE" | grep "^size " &&
+	test_line_count = 3 "$FILE" &&
 	cat "$FILE" | grep "size $SIZE" &&
 	HASH=$(cat "$FILE" | grep "oid sha256:" | sed -e "s/oid sha256://g") &&
 	LFS_FILE=".git/lfs/objects/$(echo "$HASH" | cut -c1-2)/$(echo "$HASH" | cut -c3-4)/$HASH" &&
-- 
2.5.1
