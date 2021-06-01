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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5DBC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A98461378
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhFAOvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhFAOvT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 10:51:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4189CC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:49:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so1553507pjz.3
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVzw1oM+42uzjZ12mbNrem71iMj+rR9hm+237EXfhkc=;
        b=t4ADYTtCXPMRML6dHRFS4G0epdzyxmjvz3Xl2cIk5PEEVy+MGuVLhuugRAzNRfMB/t
         mlHxPXQguqlbWKyuREUmv6w9u3mmcogWLOEwArY6B8BsY4XAZI9vnnrO5IuY93aAbQr2
         2NZaqOTpMIc8p4YXkuDAhSo+saQ2Mjyr8li9ySkVltw9bkaYdCHmhU6E/Dso7Zi9bm8y
         B0xIM1u/+ej/N0ETEgxyEPRawQNRszKzcneQxbfjA1RuKUD+CFauOcZ1kL3awy37iE7p
         y+jJ16wYAOpt6KKTCk1dsahvbCdvbugnW2b2pPxdk1KVnBVJsSzkKK5kBmXs5Hk6e2DQ
         6fMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVzw1oM+42uzjZ12mbNrem71iMj+rR9hm+237EXfhkc=;
        b=CmnwavPN/ZJRJJKCQ9fOdIPLso6IOMKNkL/Y9cYkHXxgppzlro8gd5Uz2ZWyQBKOtU
         xE/diZ/eT8fEGVbjz0jo6GKYNakufhfOO2t1ctxlsgHaxqL0DtH2pcDePVPpRKhDgbsl
         hHXZJGyT7iuN+xF/TOwU+XUok89PtQrJLxwY4TrzD0IpWMKCeseWWLO+ccKo1YCknEMx
         PwB8u8n5ES8KGOOxxSgNg7Ieegm5Eetm4Er9rB1RHXPGgk0AT/wF1ZRfrSygzpv0CYa/
         Zguo7Ae8AKF3x4S93xo1rRUkZOoXwsJk21+gpN/lKhcApuwVNclOJ6I0+hou1N3pEEqR
         Cl7w==
X-Gm-Message-State: AOAM53104f3Ggidbg6B+hiUVLGOhgucttaN7Q7K0BeTbCikCAzgHMwIv
        z/ChPcjqROwfFUY9DbkaUVA=
X-Google-Smtp-Source: ABdhPJzsvcpZJKzGkptAyamITKNYERzNrU11gYGt21iF1LU0bgM4u2LBkNHpaFmrk61eJddt8enZFQ==
X-Received: by 2002:a17:902:e5d1:b029:107:810b:9f09 with SMTP id u17-20020a170902e5d1b0290107810b9f09mr5088780plf.83.1622558977762;
        Tue, 01 Jun 2021 07:49:37 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f2sm14174507pgl.67.2021.06.01.07.49.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 07:49:37 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/2] t6020: do not mangle trailing spaces in output
Date:   Tue,  1 Jun 2021 22:49:01 +0800
Message-Id: <20210601144901.31375-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbEXiaJ-iN+wLijoKGB_ebEF3eDK8BBwtYz0unE0mKtR8w@mail.gmail.com>
References: <CANYiYbEXiaJ-iN+wLijoKGB_ebEF3eDK8BBwtYz0unE0mKtR8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We used to call `make_user_friendly_and_stable_output` to mangle
trailing spaces in output before comparing with the expect file.
Ævar recommends generating expect file using pattern "'s/Z$//'" to
compare expect file with raw output.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t6020-bundle-misc.sh | 89 ++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 43 deletions(-)

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index c6a8ea7f76..7ee43fb1df 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -83,7 +83,7 @@ test_commit_setvar () {
 
 # Format the output of git commands to make a user-friendly and stable
 # text.  We can easily prepare the expect text without having to worry
-# about future changes of the commit ID and spaces of the output.
+# about future changes of the commit ID.
 make_user_friendly_and_stable_output () {
 	sed \
 		-e "s/$A[0-9a-f]*/<COMMIT-A>/g" \
@@ -104,8 +104,11 @@ make_user_friendly_and_stable_output () {
 		-e "s/$P[0-9a-f]*/<COMMIT-P>/g" \
 		-e "s/$TAG1[0-9a-f]*/<TAG-1>/g" \
 		-e "s/$TAG2[0-9a-f]*/<TAG-2>/g" \
-		-e "s/$TAG3[0-9a-f]*/<TAG-3>/g" \
-		-e "s/ *\$//"
+		-e "s/$TAG3[0-9a-f]*/<TAG-3>/g"
+}
+
+format_and_save_expect () {
+	sed -e 's/^> //' -e 's/Z$//' >expect
 }
 
 #            (C)   (D, pull/1/head, topic/1)
@@ -180,11 +183,11 @@ test_expect_success 'create bundle from special rev: main^!' '
 
 	git bundle verify special-rev.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	cat >expect <<-\EOF &&
-	The bundle contains this ref:
-	<COMMIT-P> refs/heads/main
-	The bundle requires this ref:
-	<COMMIT-O>
+	format_and_save_expect <<-\EOF &&
+	> The bundle contains this ref:
+	> <COMMIT-P> refs/heads/main
+	> The bundle requires this ref:
+	> <COMMIT-O> Z
 	EOF
 	test_cmp expect actual &&
 
@@ -201,12 +204,12 @@ test_expect_success 'create bundle with --max-count option' '
 
 	git bundle verify max-count.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	cat >expect <<-\EOF &&
-	The bundle contains these 2 refs:
-	<COMMIT-P> refs/heads/main
-	<TAG-1> refs/tags/v1
-	The bundle requires this ref:
-	<COMMIT-O>
+	format_and_save_expect <<-\EOF &&
+	> The bundle contains these 2 refs:
+	> <COMMIT-P> refs/heads/main
+	> <TAG-1> refs/tags/v1
+	> The bundle requires this ref:
+	> <COMMIT-O> Z
 	EOF
 	test_cmp expect actual &&
 
@@ -226,16 +229,16 @@ test_expect_success 'create bundle with --since option' '
 
 	git bundle verify since.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	cat >expect <<-\EOF &&
-	The bundle contains these 5 refs:
-	<COMMIT-P> refs/heads/main
-	<COMMIT-N> refs/heads/release
-	<TAG-2> refs/tags/v2
-	<TAG-3> refs/tags/v3
-	<COMMIT-P> HEAD
-	The bundle requires these 2 refs:
-	<COMMIT-M>
-	<COMMIT-K>
+	format_and_save_expect <<-\EOF &&
+	> The bundle contains these 5 refs:
+	> <COMMIT-P> refs/heads/main
+	> <COMMIT-N> refs/heads/release
+	> <TAG-2> refs/tags/v2
+	> <TAG-3> refs/tags/v3
+	> <COMMIT-P> HEAD
+	> The bundle requires these 2 refs:
+	> <COMMIT-M> Z
+	> <COMMIT-K> Z
 	EOF
 	test_cmp expect actual &&
 
@@ -294,13 +297,13 @@ test_expect_success 'create bundle 2 - has prerequisites' '
 		--stdin \
 		release <input &&
 
-	cat >expect <<-\EOF &&
-	The bundle contains this ref:
-	<COMMIT-N> refs/heads/release
-	The bundle requires these 3 refs:
-	<COMMIT-D>
-	<COMMIT-E>
-	<COMMIT-G>
+	format_and_save_expect <<-\EOF &&
+	> The bundle contains this ref:
+	> <COMMIT-N> refs/heads/release
+	> The bundle requires these 3 refs:
+	> <COMMIT-D> Z
+	> <COMMIT-E> Z
+	> <COMMIT-G> Z
 	EOF
 
 	git bundle verify 2.bdl |
@@ -318,11 +321,11 @@ test_expect_success 'create bundle 2 - has prerequisites' '
 test_expect_success 'fail to verify bundle without prerequisites' '
 	git init --bare test1.git &&
 
-	cat >expect <<-\EOF &&
-	error: Repository lacks these prerequisite commits:
-	error: <COMMIT-D>
-	error: <COMMIT-E>
-	error: <COMMIT-G>
+	format_and_save_expect <<-\EOF &&
+	> error: Repository lacks these prerequisite commits:
+	> error: <COMMIT-D> Z
+	> error: <COMMIT-E> Z
+	> error: <COMMIT-G> Z
 	EOF
 
 	test_must_fail git -C test1.git bundle verify ../2.bdl 2>&1 |
@@ -353,13 +356,13 @@ test_expect_success 'create bundle 3 - two refs, same object' '
 		--stdin \
 		main HEAD <input &&
 
-	cat >expect <<-\EOF &&
-	The bundle contains these 2 refs:
-	<COMMIT-P> refs/heads/main
-	<COMMIT-P> HEAD
-	The bundle requires these 2 refs:
-	<COMMIT-M>
-	<COMMIT-K>
+	format_and_save_expect <<-\EOF &&
+	> The bundle contains these 2 refs:
+	> <COMMIT-P> refs/heads/main
+	> <COMMIT-P> HEAD
+	> The bundle requires these 2 refs:
+	> <COMMIT-M> Z
+	> <COMMIT-K> Z
 	EOF
 
 	git bundle verify 3.bdl |
-- 
2.32.0.rc0

