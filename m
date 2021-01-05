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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA28C433E9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC92522D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbhAEToz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbhAEToy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F391C0617A5
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 91so335882wrj.7
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AM9uuCOItbCCbYBiK240RGRW4dpnMVLWiZV07hQ2LRM=;
        b=NqggQuIwcg9IqDw9NuPDjHQNoVdt2oMVvJgNXBV9yhLZbpu20B2UX+6TJd5dknlG9p
         qeax795czjeirmbIyHAnCre24I4X2Rbh2XjeLvvFzteiIZvobpZN+XceZsFtB4wSIA0a
         EE+KBV6WfCgpVNlwfAyITgs9mpZVzw6s6TdeV69IyBk21OI4z7eS/9U7TBQ4BbeiVNc6
         K6YEF3Zc55Wz6tkiQlQwrSUNGxHbpftvKXpq7D7JQJpR6LydlKpmcNtlBtqkQPqTq8pj
         P9Y54pc70q6vUwzFlvCe82Loae3fJNAuaG7MUb4MArOPlN5+lJVwpg/1su2Sch2UX3rE
         CyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AM9uuCOItbCCbYBiK240RGRW4dpnMVLWiZV07hQ2LRM=;
        b=CQnNCcSDyBl14xuxxTFCtxeIFwEvm+sgzl/5hYMy8Oyxu6R67/lJplzU4tpvB7JZkA
         PUcKUaIYbWb1kx1Sh3Q5hGEc4HfxYYnVrM7L9PTEuL2KcOCxsBxF2Yl6cuIC7OFUS8Oc
         9oBRxZXNuGKed+7ZvxnHUslVjdUrKJKyDvkDtlxxGB1z1nzPqa9JZ4AtkAPxf0IlIxd7
         eKf3x+Zf9VxX434vE9Gh9HEnMCGBgsg4IxRTOoxpOPGK0cs6Mh+GlSY6O9tx+iOmjJuW
         IYSVKgcN6O5aLo5+nf5C0n721K/ysrq33brNcZZMzk+c0fIQCyKT9wIowcckQktRZRdf
         C84g==
X-Gm-Message-State: AOAM533xLh/JKIIcRvV4MOXgvqo7w02uFK3RtIElIo0DBonTnTbwXUnk
        JZjDGi9Ddud2Dh0jr/zkRc1xnl5xHJLWOg==
X-Google-Smtp-Source: ABdhPJxEB/4xuryrz45dwHH+7xn9F910IHqjW9h7x+4ajC/gsbDdy2CYJZnwu+AYnxSjKBJej26m1g==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr1062461wrq.238.1609875820079;
        Tue, 05 Jan 2021 11:43:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/23] mktag tests: improve verify_object() test coverage
Date:   Tue,  5 Jan 2021 20:42:41 +0100
Message-Id: <20210105194252.627-13-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The verify_object() function in "mktag.c" is tasked with ensuring that
our tag refers to a valid object.

The existing test for this might fail because it was also testing that
"type taggg" didn't refer to a valid object type (it should be "type
tag"), or because we referred to a valid object but got the type
wrong.

Let's split these tests up, so we're testing all combinations of a
non-existing object and in invalid/wrong "type" lines.

We need to provide GIT_TEST_GETTEXT_POISON=false here because the
"invalid object type" error is emitted by
parse_loose_header_extended(), which has that message already marked
for translation. Another option would be to use test_i18ngrep, but I
prefer always running the test, not skipping it under gettext poison
testing.

I'm not testing this in combination with "git replace". That'll be
done in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 47380292223..ced540035d4 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -14,7 +14,8 @@ test_description='git mktag: tag object verify test'
 check_verify_failure () {
 	expect="$2"
 	test_expect_success "$1" '
-		test_must_fail git mktag <tag.sig 2>message &&
+		test_must_fail env GIT_TEST_GETTEXT_POISON=false \
+			git mktag <tag.sig 2>message &&
 		grep "$expect" message
 	'
 }
@@ -136,19 +137,52 @@ check_verify_failure '"type" line type-name length check' \
 	'^error: char.*: type too long$'
 
 ############################################################
-#  9. verify object (SHA1/type) check
+#  9. verify object (hash/type) check
 
 cat >tag.sig <<EOF
 object $(test_oid deadbeef)
+type tag
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (hash/type) check -- correct type, nonexisting object' \
+	'^error: char7: could not verify object.*$'
+
+cat >tag.sig <<EOF
+object $head
 type tagggg
 tag mytag
 tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure 'verify object (SHA1/type) check' \
+check_verify_failure 'verify object (hash/type) check -- made-up type, valid object' \
+	'^fatal: invalid object type'
+
+cat >tag.sig <<EOF
+object $(test_oid deadbeef)
+type tagggg
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
 	'^error: char7: could not verify object.*$'
 
+cat >tag.sig <<EOF
+object $head
+type tree
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
+	'^error: char7: could not verify object'
+
 ############################################################
 # 10. verify tag-name check
 
-- 
2.29.2.222.g5d2a92d10f8

