Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C85C4BA2D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102BD24679
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRNa01st"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgB0AOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:14:32 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44212 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0AOb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 19:14:31 -0500
Received: by mail-wr1-f47.google.com with SMTP id m16so1059325wrx.11
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 16:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IkNoTUeeLHTpV7oXdc5c5TqOAyKD4CVu5fl9hT0WHUE=;
        b=NRNa01stk7oH1ql7uZkjzxfnL/i+BAIopoa4604Wk+65uNTGLpvf50Hq8bX7rSO3IG
         Gn1vpb3ZbLKOy9HCrmy23UenjZXJSRLDh1L+7by+Yu1Yqof/fo8qSHrMZMeobKXRZVfd
         VK9lQ8MPe+kziBMX8PtOh8JZncXbU0bMuoneT/bT2uh5NB2qCR614jH7CRWUoG3BvCQ8
         OCyNG7HoD/VhVIHvQIbSVzj2bYg9Hh5dbTwVfZ+zHaEipis7yn1AjGDvWazw9lG+6K4F
         KngTtu6Cjq7+qVJZWGAZm2Halm3FcO4LsF4xzPfq8h/pAHX1c+M+6U3ETqRuzM1UXktb
         viKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IkNoTUeeLHTpV7oXdc5c5TqOAyKD4CVu5fl9hT0WHUE=;
        b=bXk9ey7QEyek9Dfs+e2vJZ5Th48ktUhVo5gBECNsD/su/jx5DZIyPim7vBPweFMGF+
         1OJTLZJWvZkV/KKhmg+otBN/yjY+Fg+v+ouTKc8QBHLVpdBZSNSXGr9lCYwM6OdkCfJP
         6gW0QBmO+hRFJuf5ZNKfyXptPmaDvLJ+G4dTZVQ385jwrpj3ebo2oWx+jvrVw2/FaYjC
         kYz5N0P9+rjCw2KXqxm/V6mAlgdzp4wphupmsuKoB2XZhIYO2g27EJGT35f/c/MiC26f
         EQZHIXbVAFcI4LmlEyATm+5mxSVi1X/kGM9kKhkYHRQEh7ugFm8w/BP010dg7hAnGN6O
         /+Dw==
X-Gm-Message-State: APjAAAUiN/LpUVqy3IriTbWxObQcYauEjWnV9PZZKeZZpt+sW8z3z64/
        C+PQTy9Zk5cAxVTd2G5rGtmpiBmW
X-Google-Smtp-Source: APXvYqwtiFoTVraHAGDzGC756+SDGVDok+OCn1NIViTzbZ93xGjFhlQunJXxJJyams+fa4huClUhcA==
X-Received: by 2002:adf:f342:: with SMTP id e2mr1189263wrp.15.1582762466764;
        Wed, 26 Feb 2020 16:14:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o24sm791790wmh.28.2020.02.26.16.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 16:14:26 -0800 (PST)
Message-Id: <d5bb4b5756781e3759e4aa883ffc63802e0a5e17.1582762465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 00:14:20 +0000
Subject: [PATCH 1/5] t602[1236], t6034: modernize test formatting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Indent code, and include it inside test_expect* blocks.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6021-merge-criss-cross.sh    | 135 +++-----
 t/t6022-merge-rename.sh         | 315 +++++++++---------
 t/t6023-merge-file.sh           | 568 +++++++++++++++++---------------
 t/t6026-merge-attr.sh           |  46 +--
 t/t6034-merge-rename-nocruft.sh | 122 ++++---
 5 files changed, 591 insertions(+), 595 deletions(-)

diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
index d254e020b6d..9d5e992878f 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -10,87 +10,58 @@
 test_description='Test criss-cross merge'
 . ./test-lib.sh
 
-test_expect_success 'prepare repository' \
-'echo "1
-2
-3
-4
-5
-6
-7
-8
-9" > file &&
-git add file &&
-git commit -m "Initial commit" file &&
-git branch A &&
-git branch B &&
-git checkout A &&
-echo "1
-2
-3
-4
-5
-6
-7
-8 changed in B8, branch A
-9" > file &&
-git commit -m "B8" file &&
-git checkout B &&
-echo "1
-2
-3 changed in C3, branch B
-4
-5
-6
-7
-8
-9
-" > file &&
-git commit -m "C3" file &&
-git branch C3 &&
-git merge -m "pre E3 merge" A &&
-echo "1
-2
-3 changed in E3, branch B. New file size
-4
-5
-6
-7
-8 changed in B8, branch A
-9
-" > file &&
-git commit -m "E3" file &&
-git checkout A &&
-git merge -m "pre D8 merge" C3 &&
-echo "1
-2
-3 changed in C3, branch B
-4
-5
-6
-7
-8 changed in D8, branch A. New file size 2
-9" > file &&
-git commit -m D8 file'
-
-test_expect_success 'Criss-cross merge' 'git merge -m "final merge" B'
-
-cat > file-expect <<EOF
-1
-2
-3 changed in E3, branch B. New file size
-4
-5
-6
-7
-8 changed in D8, branch A. New file size 2
-9
-EOF
-
-test_expect_success 'Criss-cross merge result' 'cmp file file-expect'
-
-test_expect_success 'Criss-cross merge fails (-s resolve)' \
-'git reset --hard A^ &&
-test_must_fail git merge -s resolve -m "final merge" B'
+test_expect_success 'prepare repository' '
+	test_write_lines 1 2 3 4 5 6 7 8 9 >file &&
+	git add file &&
+	git commit -m "Initial commit" file &&
+
+	git branch A &&
+	git branch B &&
+	git checkout A &&
+
+	test_write_lines 1 2 3 4 5 6 7 "8 changed in B8, branch A" 9 >file &&
+	git commit -m "B8" file &&
+	git checkout B &&
+
+	test_write_lines 1 2 "3 changed in C3, branch B" 4 5 6 7 8 9 >file &&
+	git commit -m "C3" file &&
+	git branch C3 &&
+
+	git merge -m "pre E3 merge" A &&
+
+	test_write_lines 1 2 "3 changed in E3, branch B. New file size" 4 5 6 7 "8 changed in B8, branch A" 9 >file &&
+	git commit -m "E3" file &&
+
+	git checkout A &&
+	git merge -m "pre D8 merge" C3 &&
+	test_write_lines 1 2 "3 changed in C3, branch B" 4 5 6 7 "8 changed in D8, branch A. New file size 2" 9 >file &&
+
+	git commit -m D8 file
+'
+
+test_expect_success 'Criss-cross merge' '
+	git merge -m "final merge" B
+'
+
+test_expect_success 'Criss-cross merge result' '
+	cat <<-\EOF >file-expect &&
+	1
+	2
+	3 changed in E3, branch B. New file size
+	4
+	5
+	6
+	7
+	8 changed in D8, branch A. New file size 2
+	9
+	EOF
+
+	test_cmp file-expect file
+'
+
+test_expect_success 'Criss-cross merge fails (-s resolve)' '
+	git reset --hard A^ &&
+	test_must_fail git merge -s resolve -m "final merge" B
+'
 
 test_done
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 53cc9b2ffbd..1e34e1f48bb 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -8,94 +8,94 @@ modify () {
 	mv "$2.x" "$2"
 }
 
-test_expect_success setup \
-'
-cat >A <<\EOF &&
-a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-b bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
-c cccccccccccccccccccccccccccccccccccccccccccccccc
-d dddddddddddddddddddddddddddddddddddddddddddddddd
-e eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
-f ffffffffffffffffffffffffffffffffffffffffffffffff
-g gggggggggggggggggggggggggggggggggggggggggggggggg
-h hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
-i iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
-j jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
-k kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
-l llllllllllllllllllllllllllllllllllllllllllllllll
-m mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-n nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
-o oooooooooooooooooooooooooooooooooooooooooooooooo
-EOF
-
-cat >M <<\EOF &&
-A AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
-B BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
-C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
-D DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
-E EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
-F FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
-G GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
-H HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
-I IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
-J JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
-K KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
-L LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
-M MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
-N NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
-O OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
-EOF
-
-git add A M &&
-git commit -m "initial has A and M" &&
-git branch white &&
-git branch red &&
-git branch blue &&
-git branch yellow &&
-git branch change &&
-git branch change+rename &&
-
-sed -e "/^g /s/.*/g : master changes a line/" <A >A+ &&
-mv A+ A &&
-git commit -a -m "master updates A" &&
-
-git checkout yellow &&
-rm -f M &&
-git commit -a -m "yellow removes M" &&
-
-git checkout white &&
-sed -e "/^g /s/.*/g : white changes a line/" <A >B &&
-sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N &&
-rm -f A M &&
-git update-index --add --remove A B M N &&
-git commit -m "white renames A->B, M->N" &&
-
-git checkout red &&
-sed -e "/^g /s/.*/g : red changes a line/" <A >B &&
-sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N &&
-rm -f A M &&
-git update-index --add --remove A B M N &&
-git commit -m "red renames A->B, M->N" &&
-
-git checkout blue &&
-sed -e "/^g /s/.*/g : blue changes a line/" <A >C &&
-sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N &&
-rm -f A M &&
-git update-index --add --remove A C M N &&
-git commit -m "blue renames A->C, M->N" &&
-
-git checkout change &&
-sed -e "/^g /s/.*/g : changed line/" <A >A+ &&
-mv A+ A &&
-git commit -q -a -m "changed" &&
-
-git checkout change+rename &&
-sed -e "/^g /s/.*/g : changed line/" <A >B &&
-rm A &&
-git update-index --add B &&
-git commit -q -a -m "changed and renamed" &&
-
-git checkout master'
+test_expect_success 'setup' '
+	cat >A <<-\EOF &&
+	a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+	b bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
+	c cccccccccccccccccccccccccccccccccccccccccccccccc
+	d dddddddddddddddddddddddddddddddddddddddddddddddd
+	e eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
+	f ffffffffffffffffffffffffffffffffffffffffffffffff
+	g gggggggggggggggggggggggggggggggggggggggggggggggg
+	h hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
+	i iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
+	j jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
+	k kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
+	l llllllllllllllllllllllllllllllllllllllllllllllll
+	m mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
+	n nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
+	o oooooooooooooooooooooooooooooooooooooooooooooooo
+	EOF
+
+	cat >M <<-\EOF &&
+	A AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+	B BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
+	C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
+	D DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
+	E EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
+	F FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
+	G GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
+	H HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
+	I IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
+	J JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
+	K KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
+	L LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
+	M MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
+	N NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
+	O OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
+	EOF
+
+	git add A M &&
+	git commit -m "initial has A and M" &&
+	git branch white &&
+	git branch red &&
+	git branch blue &&
+	git branch yellow &&
+	git branch change &&
+	git branch change+rename &&
+
+	sed -e "/^g /s/.*/g : master changes a line/" <A >A+ &&
+	mv A+ A &&
+	git commit -a -m "master updates A" &&
+
+	git checkout yellow &&
+	rm -f M &&
+	git commit -a -m "yellow removes M" &&
+
+	git checkout white &&
+	sed -e "/^g /s/.*/g : white changes a line/" <A >B &&
+	sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N &&
+	rm -f A M &&
+	git update-index --add --remove A B M N &&
+	git commit -m "white renames A->B, M->N" &&
+
+	git checkout red &&
+	sed -e "/^g /s/.*/g : red changes a line/" <A >B &&
+	sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N &&
+	rm -f A M &&
+	git update-index --add --remove A B M N &&
+	git commit -m "red renames A->B, M->N" &&
+
+	git checkout blue &&
+	sed -e "/^g /s/.*/g : blue changes a line/" <A >C &&
+	sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N &&
+	rm -f A M &&
+	git update-index --add --remove A C M N &&
+	git commit -m "blue renames A->C, M->N" &&
+
+	git checkout change &&
+	sed -e "/^g /s/.*/g : changed line/" <A >A+ &&
+	mv A+ A &&
+	git commit -q -a -m "changed" &&
+
+	git checkout change+rename &&
+	sed -e "/^g /s/.*/g : changed line/" <A >B &&
+	rm A &&
+	git update-index --add B &&
+	git commit -q -a -m "changed and renamed" &&
+
+	git checkout master
+'
 
 test_expect_success 'pull renaming branch into unrenaming one' \
 '
@@ -288,14 +288,15 @@ test_expect_success 'setup for rename + d/f conflicts' '
 	git commit -m "Conflicting change"
 '
 
-printf "1\n2\n3\n4\n5555\n6\n7\n8\n9\n10\n11\n" >expected
-
 test_expect_success 'Rename+D/F conflict; renamed file merges + dir not in way' '
 	git reset --hard &&
 	git checkout -q renamed-file-has-no-conflicts^0 &&
+
 	git merge --strategy=recursive dir-not-in-way &&
+
 	git diff --quiet &&
 	test -f dir &&
+	printf "1\n2\n3\n4\n5555\n6\n7\n8\n9\n10\n11\n" >expected &&
 	test_cmp expected dir
 '
 
@@ -342,24 +343,6 @@ test_expect_success 'Same as previous, but merged other way' '
 	test_cmp expected dir~renamed-file-has-no-conflicts
 '
 
-cat >expected <<\EOF &&
-1
-2
-3
-4
-5
-6
-7
-8
-9
-10
-<<<<<<< HEAD:dir
-12
-=======
-11
->>>>>>> dir-not-in-way:sub/file
-EOF
-
 test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in way' '
 	git reset --hard &&
 	rm -rf dir~* &&
@@ -373,6 +356,23 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
 	test_must_fail git diff --cached --quiet &&
 
 	test -f dir &&
+	cat >expected <<-\EOF &&
+	1
+	2
+	3
+	4
+	5
+	6
+	7
+	8
+	9
+	10
+	<<<<<<< HEAD:dir
+	12
+	=======
+	11
+	>>>>>>> dir-not-in-way:sub/file
+	EOF
 	test_cmp expected dir
 '
 
@@ -396,24 +396,6 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	test_cmp expected dir~HEAD
 '
 
-cat >expected <<\EOF &&
-1
-2
-3
-4
-5
-6
-7
-8
-9
-10
-<<<<<<< HEAD:sub/file
-11
-=======
-12
->>>>>>> renamed-file-has-conflicts:dir
-EOF
-
 test_expect_success 'Same as previous, but merged other way' '
 	git reset --hard &&
 	rm -rf dir~* &&
@@ -429,6 +411,23 @@ test_expect_success 'Same as previous, but merged other way' '
 
 	test -f dir/file-in-the-way &&
 	test -f dir~renamed-file-has-conflicts &&
+	cat >expected <<-\EOF &&
+	1
+	2
+	3
+	4
+	5
+	6
+	7
+	8
+	9
+	10
+	<<<<<<< HEAD:sub/file
+	11
+	=======
+	12
+	>>>>>>> renamed-file-has-conflicts:dir
+	EOF
 	test_cmp expected dir~renamed-file-has-conflicts
 '
 
@@ -810,48 +809,48 @@ test_expect_success 'setup for use of extended merge markers' '
 	git commit -mC
 '
 
-cat >expected <<\EOF &&
-1
-2
-3
-4
-5
-6
-7
-8
-<<<<<<< HEAD:renamed_file
-9
-=======
-8.5
->>>>>>> master^0:original_file
-EOF
-
 test_expect_success 'merge master into rename has correct extended markers' '
 	git checkout rename^0 &&
 	test_must_fail git merge -s recursive master^0 &&
+
+	cat >expected <<-\EOF &&
+	1
+	2
+	3
+	4
+	5
+	6
+	7
+	8
+	<<<<<<< HEAD:renamed_file
+	9
+	=======
+	8.5
+	>>>>>>> master^0:original_file
+	EOF
 	test_cmp expected renamed_file
 '
 
-cat >expected <<\EOF &&
-1
-2
-3
-4
-5
-6
-7
-8
-<<<<<<< HEAD:original_file
-8.5
-=======
-9
->>>>>>> rename^0:renamed_file
-EOF
-
 test_expect_success 'merge rename into master has correct extended markers' '
 	git reset --hard &&
 	git checkout master^0 &&
 	test_must_fail git merge -s recursive rename^0 &&
+
+	cat >expected <<-\EOF &&
+	1
+	2
+	3
+	4
+	5
+	6
+	7
+	8
+	<<<<<<< HEAD:original_file
+	8.5
+	=======
+	9
+	>>>>>>> rename^0:renamed_file
+	EOF
 	test_cmp expected renamed_file
 '
 
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 51ee887a776..2f421d967ab 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -3,56 +3,59 @@
 test_description='RCS merge replacement: merge-file'
 . ./test-lib.sh
 
-cat > orig.txt << EOF
-Dominus regit me,
-et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-EOF
-
-cat > new1.txt << EOF
-Dominus regit me,
-et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-Nam et si ambulavero in medio umbrae mortis,
-non timebo mala, quoniam tu mecum es:
-virga tua et baculus tuus ipsa me consolata sunt.
-EOF
-
-cat > new2.txt << EOF
-Dominus regit me, et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-EOF
-
-cat > new3.txt << EOF
-DOMINUS regit me,
-et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-EOF
-
-cat > new4.txt << EOF
-Dominus regit me, et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-EOF
-printf "propter nomen suum." >> new4.txt
+test_expect_success 'setup' '
+	cat >orig.txt <<-\EOF &&
+	Dominus regit me,
+	et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	EOF
+
+	cat >new1.txt <<-\EOF &&
+	Dominus regit me,
+	et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	Nam et si ambulavero in medio umbrae mortis,
+	non timebo mala, quoniam tu mecum es:
+	virga tua et baculus tuus ipsa me consolata sunt.
+	EOF
+
+	cat >new2.txt <<-\EOF &&
+	Dominus regit me, et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	EOF
+
+	cat >new3.txt <<-\EOF &&
+	DOMINUS regit me,
+	et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	EOF
+
+	cat >new4.txt <<-\EOF &&
+	Dominus regit me, et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	EOF
+
+	printf "propter nomen suum." >>new4.txt
+'
 
 test_expect_success 'merge with no changes' '
 	cp orig.txt test.txt &&
@@ -60,9 +63,10 @@ test_expect_success 'merge with no changes' '
 	test_cmp test.txt orig.txt
 '
 
-cp new1.txt test.txt
-test_expect_success "merge without conflict" \
-	"git merge-file test.txt orig.txt new2.txt"
+test_expect_success "merge without conflict" '
+	cp new1.txt test.txt &&
+	git merge-file test.txt orig.txt new2.txt
+'
 
 test_expect_success 'works in subdirectory' '
 	mkdir dir &&
@@ -73,151 +77,176 @@ test_expect_success 'works in subdirectory' '
 	test_path_is_missing a.txt
 '
 
-cp new1.txt test.txt
-test_expect_success "merge without conflict (--quiet)" \
-	"git merge-file --quiet test.txt orig.txt new2.txt"
-
-cp new1.txt test2.txt
-test_expect_failure "merge without conflict (missing LF at EOF)" \
-	"git merge-file test2.txt orig.txt new4.txt"
-
-test_expect_failure "merge result added missing LF" \
-	"test_cmp test.txt test2.txt"
-
-cp new4.txt test3.txt
-test_expect_success "merge without conflict (missing LF at EOF, away from change in the other file)" \
-	"git merge-file --quiet test3.txt new2.txt new3.txt"
-
-cat > expect.txt << EOF
-DOMINUS regit me,
-et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-EOF
-printf "propter nomen suum." >> expect.txt
-
-test_expect_success "merge does not add LF away of change" \
-	"test_cmp expect.txt test3.txt"
-
-cp test.txt backup.txt
-test_expect_success "merge with conflicts" \
-	"test_must_fail git merge-file test.txt orig.txt new3.txt"
-
-cat > expect.txt << EOF
-<<<<<<< test.txt
-Dominus regit me, et nihil mihi deerit.
-=======
-DOMINUS regit me,
-et nihil mihi deerit.
->>>>>>> new3.txt
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-Nam et si ambulavero in medio umbrae mortis,
-non timebo mala, quoniam tu mecum es:
-virga tua et baculus tuus ipsa me consolata sunt.
-EOF
-
-test_expect_success "expected conflict markers" "test_cmp expect.txt test.txt"
-
-cp backup.txt test.txt
-
-cat > expect.txt << EOF
-Dominus regit me, et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-Nam et si ambulavero in medio umbrae mortis,
-non timebo mala, quoniam tu mecum es:
-virga tua et baculus tuus ipsa me consolata sunt.
-EOF
-test_expect_success "merge conflicting with --ours" \
-	"git merge-file --ours test.txt orig.txt new3.txt && test_cmp expect.txt test.txt"
-cp backup.txt test.txt
-
-cat > expect.txt << EOF
-DOMINUS regit me,
-et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-Nam et si ambulavero in medio umbrae mortis,
-non timebo mala, quoniam tu mecum es:
-virga tua et baculus tuus ipsa me consolata sunt.
-EOF
-test_expect_success "merge conflicting with --theirs" \
-	"git merge-file --theirs test.txt orig.txt new3.txt && test_cmp expect.txt test.txt"
-cp backup.txt test.txt
-
-cat > expect.txt << EOF
-Dominus regit me, et nihil mihi deerit.
-DOMINUS regit me,
-et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-Nam et si ambulavero in medio umbrae mortis,
-non timebo mala, quoniam tu mecum es:
-virga tua et baculus tuus ipsa me consolata sunt.
-EOF
-test_expect_success "merge conflicting with --union" \
-	"git merge-file --union test.txt orig.txt new3.txt && test_cmp expect.txt test.txt"
-cp backup.txt test.txt
-
-test_expect_success "merge with conflicts, using -L" \
-	"test_must_fail git merge-file -L 1 -L 2 test.txt orig.txt new3.txt"
-
-cat > expect.txt << EOF
-<<<<<<< 1
-Dominus regit me, et nihil mihi deerit.
-=======
-DOMINUS regit me,
-et nihil mihi deerit.
->>>>>>> new3.txt
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-Nam et si ambulavero in medio umbrae mortis,
-non timebo mala, quoniam tu mecum es:
-virga tua et baculus tuus ipsa me consolata sunt.
-EOF
-
-test_expect_success "expected conflict markers, with -L" \
-	"test_cmp expect.txt test.txt"
-
-sed "s/ tu / TU /" < new1.txt > new5.txt
-test_expect_success "conflict in removed tail" \
-	"test_must_fail git merge-file -p orig.txt new1.txt new5.txt > out"
-
-cat > expect << EOF
-Dominus regit me,
-et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-<<<<<<< orig.txt
-=======
-Nam et si ambulavero in medio umbrae mortis,
-non timebo mala, quoniam TU mecum es:
-virga tua et baculus tuus ipsa me consolata sunt.
->>>>>>> new5.txt
-EOF
-
-test_expect_success "expected conflict markers" "test_cmp expect out"
+test_expect_success "merge without conflict (--quiet)" '
+	cp new1.txt test.txt &&
+	git merge-file --quiet test.txt orig.txt new2.txt
+'
+
+test_expect_failure "merge without conflict (missing LF at EOF)" '
+	cp new1.txt test2.txt &&
+	git merge-file test2.txt orig.txt new4.txt
+'
+
+test_expect_failure "merge result added missing LF" '
+	test_cmp test.txt test2.txt
+'
+
+test_expect_success "merge without conflict (missing LF at EOF, away from change in the other file)" '
+	cp new4.txt test3.txt &&
+	git merge-file --quiet test3.txt new2.txt new3.txt
+'
+
+test_expect_success "merge does not add LF away of change" '
+	cat >expect.txt <<-\EOF &&
+	DOMINUS regit me,
+	et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	EOF
+	printf "propter nomen suum." >>expect.txt &&
+
+	test_cmp expect.txt test3.txt
+'
+
+test_expect_success "merge with conflicts" '
+	cp test.txt backup.txt &&
+	test_must_fail git merge-file test.txt orig.txt new3.txt
+'
+
+test_expect_success "expected conflict markers" '
+	cat >expect.txt <<-\EOF &&
+	<<<<<<< test.txt
+	Dominus regit me, et nihil mihi deerit.
+	=======
+	DOMINUS regit me,
+	et nihil mihi deerit.
+	>>>>>>> new3.txt
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	Nam et si ambulavero in medio umbrae mortis,
+	non timebo mala, quoniam tu mecum es:
+	virga tua et baculus tuus ipsa me consolata sunt.
+	EOF
+
+	test_cmp expect.txt test.txt
+'
+
+test_expect_success "merge conflicting with --ours" '
+	cp backup.txt test.txt &&
+
+	cat >expect.txt <<-\EOF &&
+	Dominus regit me, et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	Nam et si ambulavero in medio umbrae mortis,
+	non timebo mala, quoniam tu mecum es:
+	virga tua et baculus tuus ipsa me consolata sunt.
+	EOF
+
+	git merge-file --ours test.txt orig.txt new3.txt &&
+	test_cmp expect.txt test.txt
+'
+
+test_expect_success "merge conflicting with --theirs" '
+	cp backup.txt test.txt &&
+
+	cat >expect.txt <<-\EOF &&
+	DOMINUS regit me,
+	et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	Nam et si ambulavero in medio umbrae mortis,
+	non timebo mala, quoniam tu mecum es:
+	virga tua et baculus tuus ipsa me consolata sunt.
+	EOF
+
+	git merge-file --theirs test.txt orig.txt new3.txt &&
+	test_cmp expect.txt test.txt
+'
+
+test_expect_success "merge conflicting with --union" '
+	cp backup.txt test.txt &&
+
+	cat >expect.txt <<-\EOF &&
+	Dominus regit me, et nihil mihi deerit.
+	DOMINUS regit me,
+	et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	Nam et si ambulavero in medio umbrae mortis,
+	non timebo mala, quoniam tu mecum es:
+	virga tua et baculus tuus ipsa me consolata sunt.
+	EOF
+
+	git merge-file --union test.txt orig.txt new3.txt &&
+	test_cmp expect.txt test.txt
+'
+
+test_expect_success "merge with conflicts, using -L" '
+	cp backup.txt test.txt &&
+
+	test_must_fail git merge-file -L 1 -L 2 test.txt orig.txt new3.txt
+'
+
+test_expect_success "expected conflict markers, with -L" '
+	cat >expect.txt <<-\EOF &&
+	<<<<<<< 1
+	Dominus regit me, et nihil mihi deerit.
+	=======
+	DOMINUS regit me,
+	et nihil mihi deerit.
+	>>>>>>> new3.txt
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	Nam et si ambulavero in medio umbrae mortis,
+	non timebo mala, quoniam tu mecum es:
+	virga tua et baculus tuus ipsa me consolata sunt.
+	EOF
+
+	test_cmp expect.txt test.txt
+'
+
+test_expect_success "conflict in removed tail" '
+	sed "s/ tu / TU /" <new1.txt >new5.txt &&
+	test_must_fail git merge-file -p orig.txt new1.txt new5.txt >out
+'
+
+test_expect_success "expected conflict markers" '
+	cat >expect <<-\EOF &&
+	Dominus regit me,
+	et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	<<<<<<< orig.txt
+	=======
+	Nam et si ambulavero in medio umbrae mortis,
+	non timebo mala, quoniam TU mecum es:
+	virga tua et baculus tuus ipsa me consolata sunt.
+	>>>>>>> new5.txt
+	EOF
+
+	test_cmp expect out
+'
 
 test_expect_success 'binary files cannot be merged' '
 	test_must_fail git merge-file -p \
@@ -225,59 +254,55 @@ test_expect_success 'binary files cannot be merged' '
 	grep "Cannot merge binary files" merge.err
 '
 
-sed -e "s/deerit.\$/deerit;/" -e "s/me;\$/me./" < new5.txt > new6.txt
-sed -e "s/deerit.\$/deerit,/" -e "s/me;\$/me,/" < new5.txt > new7.txt
-
 test_expect_success 'MERGE_ZEALOUS simplifies non-conflicts' '
+	sed -e "s/deerit.\$/deerit;/" -e "s/me;\$/me./" <new5.txt >new6.txt &&
+	sed -e "s/deerit.\$/deerit,/" -e "s/me;\$/me,/" <new5.txt >new7.txt &&
 
 	test_must_fail git merge-file -p new6.txt new5.txt new7.txt > output &&
-	test 1 = $(grep ======= < output | wc -l)
-
+	test 1 = $(grep ======= <output | wc -l)
 '
 
-sed -e 's/deerit./&%%%%/' -e "s/locavit,/locavit;/"< new6.txt | tr '%' '\012' > new8.txt
-sed -e 's/deerit./&%%%%/' -e "s/locavit,/locavit --/" < new7.txt | tr '%' '\012' > new9.txt
-
 test_expect_success 'ZEALOUS_ALNUM' '
+	sed -e "s/deerit./&%%%%/" -e "s/locavit,/locavit;/" <new6.txt | tr % "\012" >new8.txt &&
+	sed -e "s/deerit./&%%%%/" -e "s/locavit,/locavit --/" <new7.txt | tr % "\012" >new9.txt &&
 
 	test_must_fail git merge-file -p \
-		new8.txt new5.txt new9.txt > merge.out &&
-	test 1 = $(grep ======= < merge.out | wc -l)
-
+		new8.txt new5.txt new9.txt >merge.out &&
+	test 1 = $(grep ======= <merge.out | wc -l)
 '
 
-cat >expect <<\EOF
-Dominus regit me,
-<<<<<<< new8.txt
-et nihil mihi deerit;
+test_expect_success '"diff3 -m" style output (1)' '
+	cat >expect <<-\EOF &&
+	Dominus regit me,
+	<<<<<<< new8.txt
+	et nihil mihi deerit;
 
 
 
 
-In loco pascuae ibi me collocavit;
-super aquam refectionis educavit me.
-||||||| new5.txt
-et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-=======
-et nihil mihi deerit,
+	In loco pascuae ibi me collocavit;
+	super aquam refectionis educavit me.
+	||||||| new5.txt
+	et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	=======
+	et nihil mihi deerit,
 
 
 
 
-In loco pascuae ibi me collocavit --
-super aquam refectionis educavit me,
->>>>>>> new9.txt
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-Nam et si ambulavero in medio umbrae mortis,
-non timebo mala, quoniam TU mecum es:
-virga tua et baculus tuus ipsa me consolata sunt.
-EOF
+	In loco pascuae ibi me collocavit --
+	super aquam refectionis educavit me,
+	>>>>>>> new9.txt
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	Nam et si ambulavero in medio umbrae mortis,
+	non timebo mala, quoniam TU mecum es:
+	virga tua et baculus tuus ipsa me consolata sunt.
+	EOF
 
-test_expect_success '"diff3 -m" style output (1)' '
 	test_must_fail git merge-file -p --diff3 \
 		new8.txt new5.txt new9.txt >actual &&
 	test_cmp expect actual
@@ -290,61 +315,64 @@ test_expect_success '"diff3 -m" style output (2)' '
 	test_cmp expect actual
 '
 
-cat >expect <<\EOF
-Dominus regit me,
-<<<<<<<<<< new8.txt
-et nihil mihi deerit;
+test_expect_success 'marker size' '
+	cat >expect <<-\EOF &&
+	Dominus regit me,
+	<<<<<<<<<< new8.txt
+	et nihil mihi deerit;
 
 
 
 
-In loco pascuae ibi me collocavit;
-super aquam refectionis educavit me.
-|||||||||| new5.txt
-et nihil mihi deerit.
-In loco pascuae ibi me collocavit,
-super aquam refectionis educavit me;
-==========
-et nihil mihi deerit,
+	In loco pascuae ibi me collocavit;
+	super aquam refectionis educavit me.
+	|||||||||| new5.txt
+	et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	==========
+	et nihil mihi deerit,
 
 
 
 
-In loco pascuae ibi me collocavit --
-super aquam refectionis educavit me,
->>>>>>>>>> new9.txt
-animam meam convertit,
-deduxit me super semitas jusitiae,
-propter nomen suum.
-Nam et si ambulavero in medio umbrae mortis,
-non timebo mala, quoniam TU mecum es:
-virga tua et baculus tuus ipsa me consolata sunt.
-EOF
+	In loco pascuae ibi me collocavit --
+	super aquam refectionis educavit me,
+	>>>>>>>>>> new9.txt
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	Nam et si ambulavero in medio umbrae mortis,
+	non timebo mala, quoniam TU mecum es:
+	virga tua et baculus tuus ipsa me consolata sunt.
+	EOF
 
-test_expect_success 'marker size' '
 	test_must_fail git merge-file -p --marker-size=10 \
 		new8.txt new5.txt new9.txt >actual &&
 	test_cmp expect actual
 '
 
-printf "line1\nline2\nline3" >nolf-orig.txt
-printf "line1\nline2\nline3x" >nolf-diff1.txt
-printf "line1\nline2\nline3y" >nolf-diff2.txt
+test_expect_success 'conflict at EOF without LF resolved by --ours' '
+	printf "line1\nline2\nline3" >nolf-orig.txt &&
+	printf "line1\nline2\nline3x" >nolf-diff1.txt &&
+	printf "line1\nline2\nline3y" >nolf-diff2.txt &&
 
-test_expect_success 'conflict at EOF without LF resolved by --ours' \
-	'git merge-file -p --ours nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
-	 printf "line1\nline2\nline3x" >expect.txt &&
-	 test_cmp expect.txt output.txt'
+	git merge-file -p --ours nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
+	printf "line1\nline2\nline3x" >expect.txt &&
+	test_cmp expect.txt output.txt
+'
 
-test_expect_success 'conflict at EOF without LF resolved by --theirs' \
-	'git merge-file -p --theirs nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
-	 printf "line1\nline2\nline3y" >expect.txt &&
-	 test_cmp expect.txt output.txt'
+test_expect_success 'conflict at EOF without LF resolved by --theirs' '
+	git merge-file -p --theirs nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
+	printf "line1\nline2\nline3y" >expect.txt &&
+	test_cmp expect.txt output.txt
+'
 
-test_expect_success 'conflict at EOF without LF resolved by --union' \
-	'git merge-file -p --union nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
-	 printf "line1\nline2\nline3x\nline3y" >expect.txt &&
-	 test_cmp expect.txt output.txt'
+test_expect_success 'conflict at EOF without LF resolved by --union' '
+	git merge-file -p --union nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
+	printf "line1\nline2\nline3x\nline3y" >expect.txt &&
+	test_cmp expect.txt output.txt
+'
 
 test_expect_success 'conflict sections match existing line endings' '
 	printf "1\\r\\n2\\r\\n3" >crlf-orig.txt &&
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 8f9b48a4937..5900358ce9c 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -32,7 +32,29 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m Side &&
 
-	git tag anchor
+	git tag anchor &&
+
+	cat >./custom-merge <<-\EOF &&
+	#!/bin/sh
+
+	orig="$1" ours="$2" theirs="$3" exit="$4" path=$5
+	(
+		echo "orig is $orig"
+		echo "ours is $ours"
+		echo "theirs is $theirs"
+		echo "path is $path"
+		echo "=== orig ==="
+		cat "$orig"
+		echo "=== ours ==="
+		cat "$ours"
+		echo "=== theirs ==="
+		cat "$theirs"
+	) >"$ours+"
+	cat "$ours+" >"$ours"
+	rm -f "$ours+"
+	exit "$exit"
+	EOF
+	chmod +x ./custom-merge
 '
 
 test_expect_success merge '
@@ -82,28 +104,6 @@ test_expect_success 'retry the merge with longer context' '
 	grep "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" actual
 '
 
-cat >./custom-merge <<\EOF
-#!/bin/sh
-
-orig="$1" ours="$2" theirs="$3" exit="$4" path=$5
-(
-	echo "orig is $orig"
-	echo "ours is $ours"
-	echo "theirs is $theirs"
-	echo "path is $path"
-	echo "=== orig ==="
-	cat "$orig"
-	echo "=== ours ==="
-	cat "$ours"
-	echo "=== theirs ==="
-	cat "$theirs"
-) >"$ours+"
-cat "$ours+" >"$ours"
-rm -f "$ours+"
-exit "$exit"
-EOF
-chmod +x ./custom-merge
-
 test_expect_success 'custom merge backend' '
 
 	echo "* merge=union" >.gitattributes &&
diff --git a/t/t6034-merge-rename-nocruft.sh b/t/t6034-merge-rename-nocruft.sh
index 89871aa5b04..a25e7304604 100755
--- a/t/t6034-merge-rename-nocruft.sh
+++ b/t/t6034-merge-rename-nocruft.sh
@@ -3,74 +3,73 @@
 test_description='Merge-recursive merging renames'
 . ./test-lib.sh
 
-test_expect_success setup \
-'
-cat >A <<\EOF &&
-a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-b bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
-c cccccccccccccccccccccccccccccccccccccccccccccccc
-d dddddddddddddddddddddddddddddddddddddddddddddddd
-e eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
-f ffffffffffffffffffffffffffffffffffffffffffffffff
-g gggggggggggggggggggggggggggggggggggggggggggggggg
-h hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
-i iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
-j jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
-k kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
-l llllllllllllllllllllllllllllllllllllllllllllllll
-m mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
-n nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
-o oooooooooooooooooooooooooooooooooooooooooooooooo
-EOF
+test_expect_success 'setup' '
+	cat >A <<-\EOF &&
+	a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+	b bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
+	c cccccccccccccccccccccccccccccccccccccccccccccccc
+	d dddddddddddddddddddddddddddddddddddddddddddddddd
+	e eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
+	f ffffffffffffffffffffffffffffffffffffffffffffffff
+	g gggggggggggggggggggggggggggggggggggggggggggggggg
+	h hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
+	i iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
+	j jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
+	k kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
+	l llllllllllllllllllllllllllllllllllllllllllllllll
+	m mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
+	n nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
+	o oooooooooooooooooooooooooooooooooooooooooooooooo
+	EOF
 
-cat >M <<\EOF &&
-A AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
-B BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
-C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
-D DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
-E EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
-F FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
-G GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
-H HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
-I IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
-J JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
-K KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
-L LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
-M MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
-N NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
-O OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
-EOF
+	cat >M <<-\EOF &&
+	A AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+	B BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
+	C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
+	D DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
+	E EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
+	F FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
+	G GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
+	H HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
+	I IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
+	J JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
+	K KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
+	L LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
+	M MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
+	N NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
+	O OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
+	EOF
 
-git add A M &&
-git commit -m "initial has A and M" &&
-git branch white &&
-git branch red &&
-git branch blue &&
+	git add A M &&
+	git commit -m "initial has A and M" &&
+	git branch white &&
+	git branch red &&
+	git branch blue &&
 
-git checkout white &&
-sed -e "/^g /s/.*/g : white changes a line/" <A >B &&
-sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N &&
-rm -f A M &&
-git update-index --add --remove A B M N &&
-git commit -m "white renames A->B, M->N" &&
+	git checkout white &&
+	sed -e "/^g /s/.*/g : white changes a line/" <A >B &&
+	sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N &&
+	rm -f A M &&
+	git update-index --add --remove A B M N &&
+	git commit -m "white renames A->B, M->N" &&
 
-git checkout red &&
-echo created by red >R &&
-git update-index --add R &&
-git commit -m "red creates R" &&
+	git checkout red &&
+	echo created by red >R &&
+	git update-index --add R &&
+	git commit -m "red creates R" &&
 
-git checkout blue &&
-sed -e "/^o /s/.*/g : blue changes a line/" <A >B &&
-rm -f A &&
-mv B A &&
-git update-index A &&
-git commit -m "blue modify A" &&
+	git checkout blue &&
+	sed -e "/^o /s/.*/g : blue changes a line/" <A >B &&
+	rm -f A &&
+	mv B A &&
+	git update-index A &&
+	git commit -m "blue modify A" &&
 
-git checkout master'
+	git checkout master
+'
 
 # This test broke in 65ac6e9c3f47807cb603af07a6a9e1a43bc119ae
-test_expect_success 'merge white into red (A->B,M->N)' \
-'
+test_expect_success 'merge white into red (A->B,M->N)' '
 	git checkout -b red-white red &&
 	git merge white &&
 	git write-tree &&
@@ -82,8 +81,7 @@ test_expect_success 'merge white into red (A->B,M->N)' \
 '
 
 # This test broke in 8371234ecaaf6e14fe3f2082a855eff1bbd79ae9
-test_expect_success 'merge blue into white (A->B, mod A, A untracked)' \
-'
+test_expect_success 'merge blue into white (A->B, mod A, A untracked)' '
 	git checkout -b white-blue white &&
 	echo dirty >A &&
 	git merge blue &&
-- 
gitgitgadget

