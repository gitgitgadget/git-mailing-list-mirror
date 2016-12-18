Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF86B1FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 19:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756188AbcLRTBL (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 14:01:11 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35439 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbcLRTBK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 14:01:10 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so14985006wme.2
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 11:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9OzBhRzjhz6f7z0eEVZKv4Z5Uuni03rbTttCgVJ0qzw=;
        b=V5cGtztR53JgOCRYlONngvXFrNLP2NAonDgcOd2msmW/3XekJ1jDHqorDhVZHLE9GU
         CGopGD9/VPe2REUN1554Ou2v50ixAd+i3iYrPVho482AbV1tFRMcISg5VAM9i04YAFXb
         c8aWyidU++I3Z9JZjh7XEWwHajAbmfrkHqoSPWcTkR8/Kp1sCXZ2g4ST0CVNalYHBOGa
         EV7THNG4xgWsQPKwAEdN9j6ZYicmdnHpanAzQBHj6pDrhLKMpCwKpZe1b3HYLPSS7a5r
         o9GaEbXzFAr7Dj21jm2ftRzZ0AgIkV23BLG3TVk1z4zY+vg/Z8vK+9lrI2Z2JlvMVh+m
         6qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9OzBhRzjhz6f7z0eEVZKv4Z5Uuni03rbTttCgVJ0qzw=;
        b=RDxU7ooC6+q9TjdMpJSWRF+1UaMkrUz7lwyCCzrHFwoZ7VQWSN2RBFDi99X+gdQKz7
         /uhnvSYbhvt70NrWVtd0Xbkny5FocEZQExeOHOi6UpavnRBhLj+z1Zx/4X/LYMpWSM5z
         Lq33uO4GNvMdgncpFilpR4jrGQUsMmXM9vIBuJC2nBxtDz0tmV47Go/ekm9+GCnA4vda
         2A0QkIdzbSOPfD8btyMGOeM9AniNqEYJMFNHgqivX8jXdc0uwLmYF1eGZw+acEXjG7Za
         I0hDvRJvACPEfvOMK5qANBoe0xWmJ4YxWt0tVSTJYpdijYvQW2niEXrQsX7E4qp6kUCK
         2aNQ==
X-Gm-Message-State: AIkVDXKpFFUwZeR2smqD8KMz+ZhEvXOWRwolU78t3862pWreOOF8YYF43cFhQwEI15NVjA==
X-Received: by 10.28.218.213 with SMTP id r204mr11010434wmg.69.1482087668848;
        Sun, 18 Dec 2016 11:01:08 -0800 (PST)
Received: from slxBook4.fritz.box.fritz.box (p5DDB6496.dip0.t-ipconnect.de. [93.219.100.150])
        by smtp.gmail.com with ESMTPSA id ua15sm17195826wjb.1.2016.12.18.11.01.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 11:01:08 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     luke@diamand.org, gitster@pobox.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] git-p4: add diff/merge properties to .gitattributes for GitLFS files
Date:   Sun, 18 Dec 2016 20:01:40 +0100
Message-Id: <20161218190140.3732-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The `git lfs track` command generates a .gitattributes file with diff
and merge properties [1]. Set the same .gitattributes format for files
tracked with GitLFS in git-p4.

[1] https://github.com/git-lfs/git-lfs/blob/v1.5.3/commands/command_track.go#L121

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Commit: d1271bddd4 (v2.11.0)
    Diff on Web: https://github.com/git/git/compare/d1271bddd4...larsxschneider:e045b3d5c8
    Checkout:    git fetch https://github.com/larsxschneider/git git-p4/fix-lfs-attributes-v1 && git checkout e045b3d5c8

 git-p4.py                 |  4 ++--
 t/t9824-git-p4-git-lfs.sh | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fd5ca52462..87b6932c81 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1098,10 +1098,10 @@ class GitLFS(LargeFileSystem):
                 '# Git LFS (see https://git-lfs.github.com/)\n',
                 '#\n',
             ] +
-            ['*.' + f.replace(' ', '[[:space:]]') + ' filter=lfs -text\n'
+            ['*.' + f.replace(' ', '[[:space:]]') + ' filter=lfs diff=lfs merge=lfs -text\n'
                 for f in sorted(gitConfigList('git-p4.largeFileExtensions'))
             ] +
-            ['/' + f.replace(' ', '[[:space:]]') + ' filter=lfs -text\n'
+            ['/' + f.replace(' ', '[[:space:]]') + ' filter=lfs diff=lfs merge=lfs -text\n'
                 for f in sorted(self.largeFiles) if not self.hasLargeFileExtension(f)
             ]
         )
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index 110a7e7924..1379db6357 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -81,9 +81,9 @@ test_expect_success 'Store files in LFS based on size (>24 bytes)' '
 		#
 		# Git LFS (see https://git-lfs.github.com/)
 		#
-		/file2.dat filter=lfs -text
-		/file4.bin filter=lfs -text
-		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
+		/file2.dat filter=lfs diff=lfs merge=lfs -text
+		/file4.bin filter=lfs diff=lfs merge=lfs -text
+		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs diff=lfs merge=lfs -text
 		EOF
 		test_path_is_file .gitattributes &&
 		test_cmp expect .gitattributes
@@ -109,7 +109,7 @@ test_expect_success 'Store files in LFS based on size (>25 bytes)' '
 		#
 		# Git LFS (see https://git-lfs.github.com/)
 		#
-		/file4.bin filter=lfs -text
+		/file4.bin filter=lfs diff=lfs merge=lfs -text
 		EOF
 		test_path_is_file .gitattributes &&
 		test_cmp expect .gitattributes
@@ -135,7 +135,7 @@ test_expect_success 'Store files in LFS based on extension (dat)' '
 		#
 		# Git LFS (see https://git-lfs.github.com/)
 		#
-		*.dat filter=lfs -text
+		*.dat filter=lfs diff=lfs merge=lfs -text
 		EOF
 		test_path_is_file .gitattributes &&
 		test_cmp expect .gitattributes
@@ -163,8 +163,8 @@ test_expect_success 'Store files in LFS based on size (>25 bytes) and extension
 		#
 		# Git LFS (see https://git-lfs.github.com/)
 		#
-		*.dat filter=lfs -text
-		/file4.bin filter=lfs -text
+		*.dat filter=lfs diff=lfs merge=lfs -text
+		/file4.bin filter=lfs diff=lfs merge=lfs -text
 		EOF
 		test_path_is_file .gitattributes &&
 		test_cmp expect .gitattributes
@@ -199,8 +199,8 @@ test_expect_success 'Remove file from repo and store files in LFS based on size
 		#
 		# Git LFS (see https://git-lfs.github.com/)
 		#
-		/file2.dat filter=lfs -text
-		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
+		/file2.dat filter=lfs diff=lfs merge=lfs -text
+		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs diff=lfs merge=lfs -text
 		EOF
 		test_path_is_file .gitattributes &&
 		test_cmp expect .gitattributes
@@ -237,8 +237,8 @@ test_expect_success 'Add .gitattributes and store files in LFS based on size (>2
 		#
 		# Git LFS (see https://git-lfs.github.com/)
 		#
-		/file2.dat filter=lfs -text
-		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
+		/file2.dat filter=lfs diff=lfs merge=lfs -text
+		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs diff=lfs merge=lfs -text
 		EOF
 		test_path_is_file .gitattributes &&
 		test_cmp expect .gitattributes
@@ -278,7 +278,7 @@ test_expect_success 'Add big files to repo and store files in LFS based on compr
 		#
 		# Git LFS (see https://git-lfs.github.com/)
 		#
-		/file6.bin filter=lfs -text
+		/file6.bin filter=lfs diff=lfs merge=lfs -text
 		EOF
 		test_path_is_file .gitattributes &&
 		test_cmp expect .gitattributes
-- 
2.11.0

