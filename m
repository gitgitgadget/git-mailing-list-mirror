Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B62C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 16:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD612070C
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 16:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpzghyoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLUQlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 11:41:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34335 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfLUQlE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 11:41:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so6593243pgf.1
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 08:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=27FkbwHhbBBPljDKoKIT3kwAehAOb+8kuO+nqcLVLbs=;
        b=CpzghyoOG380tv1pL5ISYPNN9xanp8c0FjXjHsuQWPoYyw3sVypHf/K/Cg3+awOWHO
         Gd9NvDhb5sn5E8LyXBHEVf50gwMdv6q7N7VQipMKTQjP0REBMam2P7gDio0QtI6SrL2T
         cPUMllJMeHYMSWsRyj+4VEmYJWsLtd7IHl241M82rogdc3KN1YnAibaRFAoXh0b20Rit
         zY+IJD6mN2bk4zLYOJ3qaKCpzECRn3vu8IBO3PlYEz67csX/4wazGW9kQY2V+Eyr5FdZ
         eeFw0xyC562lgUikSAbIyTn8yWACVqI6B9yXso9k2mpqzlzP4z4c9tbaBso7+tjBNvqb
         lq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=27FkbwHhbBBPljDKoKIT3kwAehAOb+8kuO+nqcLVLbs=;
        b=nqg3M+AxSNH7qLNX/UmIgMRWNbpqUWAr+7YNj2u89XkY3bEmmDhDOsnE5Z2P8hHILa
         UM4JrxrFn+uT+F+h7Pee23exI8XgkVRHVa8qT/2ABO9tHUkfqmNQoQEtg77JBRa7v2RB
         gyYqnrBwpjOIBR7EgthUgqJ+nJgNm/KDJyLQK0hBhHmgIziwQDB3y3a2c9q/I+KhMdcg
         vLS3xw84n5Jx4zZjBF1wNZuB3dZw5NwWa5JD6FEzkDbexun+0C2+hKEmmVUihsyK7S9V
         RcTH8DYO+Fl7YbQIb7sAePscLP2rOXDtutAz9VWuR0H7qkfL/9iLqLIGa3EqrrbFBIXf
         6Jpw==
X-Gm-Message-State: APjAAAW8iFiARc33kHguq1PfYH4kDFa6KPm+PGRPoBucjHPiVG1HCNQi
        739PMsxv0UWsLuVdZBJPPH9bvQ/p
X-Google-Smtp-Source: APXvYqxx94zOFp8mxxbwwscdfr3TVCWmExoHcOvoB9WV0+my89sLAtVdYW1Kfg6ToPg8elSyUFGYLQ==
X-Received: by 2002:a62:1684:: with SMTP id 126mr2636953pfw.234.1576946463424;
        Sat, 21 Dec 2019 08:41:03 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6374:a714:860b:62b8:d6c5:f06c])
        by smtp.gmail.com with ESMTPSA id d24sm18544671pfq.75.2019.12.21.08.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 08:41:02 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH] test: switch to POSIX compliance symlink check
Date:   Sat, 21 Dec 2019 23:40:57 +0700
Message-Id: <20191221164057.24616-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.1.485.gad05a3d8e5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

POSIX doesn't specify `-L' flag for test(1), POSIX specify `-h' for
checking symlink instead.

While most shells and test(1) implementation provides both `-L' and
`-h' for checking symlink,
OpenBSD and NetBSD says we shouldn't rely on its existence. [1]

Replace all usages of `test -L' with `test -h'.

[1]: https://man.openbsd.org/test.1

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 t/t9131-git-svn-empty-symlink.sh  | 4 ++--
 t/t9132-git-svn-broken-symlink.sh | 4 ++--
 t/t9802-git-p4-filetype.sh        | 2 +-
 t/t9830-git-p4-symlink-dir.sh     | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9131-git-svn-empty-symlink.sh b/t/t9131-git-svn-empty-symlink.sh
index 3bf4255aa3..6812028258 100755
--- a/t/t9131-git-svn-empty-symlink.sh
+++ b/t/t9131-git-svn-empty-symlink.sh
@@ -97,14 +97,14 @@ test_expect_success 'disable broken symlink workaround' \
 test_expect_success '"bar" is an empty file' 'test_must_be_empty y/bar'
 test_expect_success 'get "bar" => symlink fix from svn' \
 		'(cd y && git svn rebase)'
-test_expect_success '"bar" does not become a symlink' '! test -L y/bar'
+test_expect_success '"bar" does not become a symlink' '! test -h y/bar'
 
 # svn.brokenSymlinkWorkaround is unset
 test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" z'
 test_expect_success '"bar" is an empty file' 'test_must_be_empty z/bar'
 test_expect_success 'get "bar" => symlink fix from svn' \
 		'(cd z && git svn rebase)'
-test_expect_success '"bar" does not become a symlink' '! test -L z/bar'
+test_expect_success '"bar" does not become a symlink' '! test -h z/bar'
 
 
 test_done
diff --git a/t/t9132-git-svn-broken-symlink.sh b/t/t9132-git-svn-broken-symlink.sh
index aeceffaf7b..2b15b97cdf 100755
--- a/t/t9132-git-svn-broken-symlink.sh
+++ b/t/t9132-git-svn-broken-symlink.sh
@@ -86,7 +86,7 @@ EOF
 test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" x'
 
 test_expect_success SYMLINKS '"bar" is a symlink that points to "asdf"' '
-	test -L x/bar &&
+	test -h x/bar &&
 	(cd x && test xasdf = x"$(git cat-file blob HEAD:bar)")
 '
 
@@ -95,7 +95,7 @@ test_expect_success 'get "bar" => symlink fix from svn' '
 '
 
 test_expect_success SYMLINKS '"bar" remains a proper symlink' '
-	test -L x/bar &&
+	test -h x/bar &&
 	(cd x && test xdoink = x"$(git cat-file blob HEAD:bar)")
 '
 
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 94edebe272..197752b45a 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -262,7 +262,7 @@ test_expect_success SYMLINKS 'ensure p4 symlink parsed correctly' '
 	git p4 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
-		test -L symlink &&
+		test -h symlink &&
 		test $(readlink symlink) = symlink-target
 	)
 '
diff --git a/t/t9830-git-p4-symlink-dir.sh b/t/t9830-git-p4-symlink-dir.sh
index 3fb6960c18..4b4cc015fc 100755
--- a/t/t9830-git-p4-symlink-dir.sh
+++ b/t/t9830-git-p4-symlink-dir.sh
@@ -30,7 +30,7 @@ test_expect_success 'symlinked directory' '
 	(
 		cd "$cli" &&
 		p4 sync &&
-		test -L some/sub/directory/subdir2 &&
+		test -h some/sub/directory/subdir2 &&
 		test_path_is_file some/sub/directory/subdir2/file.t
 	)
 
-- 
2.24.1.485.gad05a3d8e5

