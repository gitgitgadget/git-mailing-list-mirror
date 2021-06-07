Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C3C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA856108D
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFGNPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhFGNPb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 09:15:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD7C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 06:13:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h24so26640317ejy.2
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 06:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vhvrsGZ49JYUU6fRM7MlDVwJUkEaPhr4xLWeDCNufw=;
        b=TDbxW9UPNQvTA/G4obJsD7BE5vb/haWkzoN87g8ObkRF/ep0CbeshzL7AQycq841pq
         t2q/L8Zii0CxmHkb1vNF/2IYjVczpF2LOVMHLH4bP0UFqJko2v7nVRHTD/YC8NxS9e4o
         OVCr/VpltxLTzVm6T6ocUomMnsJuxgm049sgdm1s7cVorcLhhZPfHtyp9g2i0U7W0WCq
         su0EElxxw2/IkRx6ypQjgfuEJ4UuXcYCvOtHYC4YXyO12PBqVx2687fhdjzfkCrMPHAG
         iMRC1URl79/3bAVQJkzH1IHJuo50mPFogf4Q1HOzNzzLgB5g5vw7y/TKaJ51e3wVrc9P
         zEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vhvrsGZ49JYUU6fRM7MlDVwJUkEaPhr4xLWeDCNufw=;
        b=Ow5ucj4p9I9LgWw52TlMokmDkDNRNCfUvOuqjE/zCotX0Q4cg7gFcFiTr77HDXBxlm
         mP1hAeD3RXGbZVqJoF6GjyEvkRSWK6CmxDxRQnyArZEizTh49wvIKT9WAiy6FYA6nlih
         om+/JPuz7o77AaDbjmknfcqo5KuXdpVKKsnDCtkIMkbCNEE/65sT3nIYRp6jgb3z+bp9
         XMJiV2QIsruSBhvcXkmNgXJSo7Aw5KR9ZbLvlBTg5Y+LNwMv/PxBj4yfgLguzJDWs2Xx
         2b/PX69tVGe1i9FLZz3EajpyYT6TItAH86tAYcZU8uunJ+AsQcqENiGoBZRqBTuJTT6q
         E59A==
X-Gm-Message-State: AOAM5314rpcJQTynskLZLM5gE5APCUMCLWw8iJj7XQLhOQZfZjaDVbNK
        5bifQsVrec5Rr/8Nb6Shd48PlpkQkCk=
X-Google-Smtp-Source: ABdhPJzoYB46LKEX2WiimJAYb/EB/qCFw/NfPIvSF5M7TGcLsWM5ASYxvzN9jkaic/+5A0KVdcI+Qw==
X-Received: by 2002:a17:906:1d11:: with SMTP id n17mr17538999ejh.215.1623071603266;
        Mon, 07 Jun 2021 06:13:23 -0700 (PDT)
Received: from localhost.localdomain ([212.102.57.9])
        by smtp.gmail.com with ESMTPSA id ga3sm6616344ejb.34.2021.06.07.06.13.22
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 06:13:22 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] t: fix whitespace around &&
Date:   Mon,  7 Jun 2021 15:13:20 +0200
Message-Id: <20210607131320.982362-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing spaces before '&&' and switch tabs around '&&' to spaces.

These issues were found using `git grep '[^ ]&&$'` and
`git grep -P '&&\t'`.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh | 2 +-
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh  | 4 ++--
 t/t1092-sparse-checkout-compatibility.sh     | 2 +-
 t/t3920-crlf-messages.sh                     | 2 +-
 t/t4203-mailmap.sh                           | 2 +-
 t/t4205-log-pretty-formats.sh                | 2 +-
 t/t7800-difftool.sh                          | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
index 4c39bda7bf..f08890d9e7 100755
--- a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
+++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
@@ -86,7 +86,7 @@ test_expect_success 'Git clone works with page added' '
 test_expect_success 'Git clone works with an edited page ' '
 	wiki_reset &&
 	wiki_editpage foo "this page will be edited" \
-		false -s "first edition of page foo"&&
+		false -s "first edition of page foo" &&
 	wiki_editpage foo "this page has been edited and must be on the clone " true &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_6 &&
 	test_path_is_file mw_dir_6/Foo.mw &&
diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
index 6b0dbdac4d..526d92850f 100755
--- a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
+++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
@@ -287,7 +287,7 @@ test_expect_success 'git push with \' '
 		git add \\ko\\o.mw &&
 		git commit -m " \\ko\\o added" &&
 		git push
-	)&&
+	) &&
 	wiki_page_exist \\ko\\o &&
 	wiki_check_content mw_dir_18/\\ko\\o.mw \\ko\\o
 
@@ -311,7 +311,7 @@ test_expect_success 'git push with \ in format control' '
 		git add \\fo\\o.mw &&
 		git commit -m " \\fo\\o added" &&
 		git push
-	)&&
+	) &&
 	wiki_page_exist \\fo\\o &&
 	wiki_check_content mw_dir_20/\\fo\\o.mw \\fo\\o
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index e9a815ca7a..d028b73eba 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -268,7 +268,7 @@ test_expect_success 'diff with renames' '
 	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
 	do
 		test_all_match git checkout rename-base &&
-		test_all_match git checkout $branch -- .&&
+		test_all_match git checkout $branch -- . &&
 		test_all_match git diff --staged --no-renames &&
 		test_all_match git diff --staged --find-renames || return 1
 	done
diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 70ddce3a2e..a8ad5462d9 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -64,7 +64,7 @@ test_crlf_subject_body_and_contents() {
 	while test -n "${atoms}"
 	do
 		set ${atoms} && atom=$1 && shift && atoms="$*" &&
-		set ${files} &&	file=$1 && shift && files="$*" &&
+		set ${files} && file=$1 && shift && files="$*" &&
 		test_expect_success "${command}: --format='%${atom}' works with messages using CRLF" "
 			rm -f expect &&
 			for ref in ${LIB_CRLF_BRANCHES}
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index d8e7374234..0b2d21ec55 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -959,7 +959,7 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
 	test_when_finished "rm .mailmap" &&
 	ln -s map .mailmap &&
 	git log -1 --format=%aE >actual &&
-	echo "orig@example.com" >expect&&
+	echo "orig@example.com" >expect &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 8272d94ce6..5865daa8f8 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -988,7 +988,7 @@ test_expect_success '%(describe) vs git describe' '
 
 test_expect_success '%(describe:match=...) vs git describe --match ...' '
 	test_when_finished "git tag -d tag-match" &&
-	git tag -a -m tagged tag-match&&
+	git tag -a -m tagged tag-match &&
 	git describe --match "*-match" >expect &&
 	git log -1 --format="%(describe:match=*-match)" >actual &&
 	test_cmp expect actual
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 3e041e83ae..a173f564bc 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -770,7 +770,7 @@ test_expect_success 'difftool --rotate-to' '
 	echo 4 >4 &&
 	git add 1 2 4 &&
 	git commit -a -m "124" &&
-	git difftool --no-prompt --extcmd=cat --rotate-to="2" HEAD^ >output&&
+	git difftool --no-prompt --extcmd=cat --rotate-to="2" HEAD^ >output &&
 	cat >expect <<-\EOF &&
 	2
 	4
-- 
2.31.1

