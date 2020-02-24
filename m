Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F83C11D34
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8B920836
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhPSzWZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgBXPNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:13:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34441 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBXPNY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 10:13:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id r18so12296119edl.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QbbNQJggUQVuBIA4KeAUgaYNN4+RuqaE9HkPDCP0KdE=;
        b=OhPSzWZjU6BXLY6IvIyd1htZuxyE72FUQxk8AWuWnygPfe/nK/jkynLwIqj6tLfFBD
         WkE0sO4SRdIii1gRwSM2BbWmAGMgUOtKIkb2JgG5+pLjQGSN8x+L1eH4r+Fw+ShobvrF
         KHXDAXXCSPZjUGtbMKLyJ0JnDv/6n/gFPVUB72/Ww5H9oB9zce/JAx6NTEsCzgs5zkVn
         bgOqZ4gvlAJdMZHvBP6rVfilb7Udt95nXrfx48zdTq1E84KUUjlPtwnra3Sf44YzqAEC
         mIX5ZFqMHlxbTMA3/4TDlBLlMm3zsX04AMP5slGLagRHfXyy1sZCKF8tc4XUEL+pRh8T
         8grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QbbNQJggUQVuBIA4KeAUgaYNN4+RuqaE9HkPDCP0KdE=;
        b=Uoniv79K+rRlQ3YY0VK9b6b2n8EMaYBv7JAEaLGZTjXFcFep+/7tWpA6tIXSeaAjDV
         Cm8Xvo960eRAqD6wUxJe3on7TGQZPr1AqYCC+oZW2U+Zcs4zAdU4j7ZMcclRtMXAknu9
         NojuYPlP9k+vi+xEfUbJIzQsFJJAUxMQBrTndhHlZwf+BJd14W0ck9iUQrBkdBMtKt26
         pGUGDOnZl9DWjtRECzHa83fh4Cc6qNJLdpdK3xSTY1/qHPC9LaxmFEdfuXkrRPJtNbvM
         Id9noloN2CQekfrmQheUUqQ7AeEWZzWnJh9TBtKpD5OTsIEVjkjkvrxpVqOD0xCRLI9L
         GT0A==
X-Gm-Message-State: APjAAAXWSWDWvymceaUhN200B8jQxOX+C/35aMzGJRirWwFZudiW8Lwr
        cXNzSoKIt1V6wlEMxIre2kE9gWKP
X-Google-Smtp-Source: APXvYqz4Fsohf/50mUR/52z+JJyFsIW0hia7bNpPUmC0CMz4600bSeMR/CM+EziobAu8iZk+LzFGLA==
X-Received: by 2002:a17:906:c7d5:: with SMTP id dc21mr49562953ejb.316.1582557202927;
        Mon, 24 Feb 2020 07:13:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs4sm822874ejb.39.2020.02.24.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:13:22 -0800 (PST)
Message-Id: <3cc0a17123dc2575deacb62f762a35fef5f2c185.1582557199.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
        <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Feb 2020 15:13:18 +0000
Subject: [PATCH v4 3/3] tag: use new advice API to check visibility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Following the new helpers added to the advice library,
replace the global variable check approach by the new
API calls

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c       | 2 --
 advice.h       | 1 -
 builtin/tag.c  | 5 +++--
 t/t7004-tag.sh | 1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/advice.c b/advice.c
index ff25087fa7e..4af5a4205de 100644
--- a/advice.c
+++ b/advice.c
@@ -29,7 +29,6 @@ int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
-int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 
 static int advice_use_color = -1;
@@ -89,7 +88,6 @@ static struct {
 	{ "waitingForEditor", &advice_waiting_for_editor },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
-	{ "nestedTag", &advice_nested_tag },
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 
 	/* make this an alias for backward compatibility */
diff --git a/advice.h b/advice.h
index 61a7ee82827..c8be662c4b1 100644
--- a/advice.h
+++ b/advice.h
@@ -29,7 +29,6 @@ extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
-extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
 
 /**
diff --git a/builtin/tag.c b/builtin/tag.c
index e0a4c253828..45e959d5f8f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -231,8 +231,9 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 	if (type <= OBJ_NONE)
 		die(_("bad object type."));
 
-	if (type == OBJ_TAG && advice_nested_tag)
-		advise(_(message_advice_nested_tag), tag, object_ref);
+	if (type == OBJ_TAG)
+		advise_if_enabled(NESTED_TAG, _(message_advice_nested_tag),
+				  tag, object_ref);
 
 	strbuf_addf(&header,
 		    "object %s\n"
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 6db92bd3ba6..74b637deb25 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1726,6 +1726,7 @@ test_expect_success 'recursive tagging should give advice' '
 	hint: already a tag. If you meant to tag the object that it points to, use:
 	hint: |
 	hint: 	git tag -f nested annotated-v4.0^{}
+	hint: Disable this message with "git config advice.nestedTag false"
 	EOF
 	git tag -m nested nested annotated-v4.0 2>actual &&
 	test_i18ncmp expect actual
-- 
gitgitgadget
