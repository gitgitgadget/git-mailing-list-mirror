Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87ADC77B73
	for <git@archiver.kernel.org>; Wed, 24 May 2023 19:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjEXTvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 15:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEXTvr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 15:51:47 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF52B6
        for <git@vger.kernel.org>; Wed, 24 May 2023 12:51:45 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so2657172276.2
        for <git@vger.kernel.org>; Wed, 24 May 2023 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684957905; x=1687549905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjqfTCHVeCFeOzlhtCVKRbltLw+nkGvUuT74gEhWcxI=;
        b=FqLgb/6Y3bUPqnlT0Mtp6oU4ntBDQktxGQkj7lZg6Lx734X+tyKox8GTfDjNypWwFA
         ZT7vfWNdR+1PW7fywsedvMATKVchh3XSbQhLmSg795onypj4eVSq7K+GJsuZDj7JpHy6
         GLFzlA4m1qPejzvB4opZaLtVCRvtFKh8GoQxKrvgYw6X6JNrwUIAKJONO7MCJ1LGnb30
         PgOfd+Onp++kbNhxViKd/3F0Ej/KfUBfrUcqVbFvLwmzGqpIx4536a8Kjet8w0Uo9sf9
         J2yKI3oMeu+Ccu7QBL6Z472LA1idwKXbz+/2sUNnFI8ZN+6vfHshL4ye0f7usL3FUiBJ
         7VNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957905; x=1687549905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjqfTCHVeCFeOzlhtCVKRbltLw+nkGvUuT74gEhWcxI=;
        b=PC2n+ch3MwZzaPHFX+CgzIL6c0Is/ftNh2M0ySu27b9OrauUlAe1YK47SYArvfFUGf
         JWvEFTHY/m1uKggEu8NboovvDi1ABIbmuQZWh6ntX4tvB8lb1Xz0Dyn5S1vJaNx3qK3y
         7qjiQfGlgpcvX/6WZHIFGUw2GXfh0aFfhuZD8MoLDmq+1JM8vSvmKmWi8q10Pd+dqz4N
         6Cl7vVju65PaQ99Ui4gG+syi/TcbhJB16P6/CjLHAo3gZVWVFp461E2yJDSetOHTVMxP
         JnAkzzAkIaln0xLb2MpSaxZtLHDUXGGJzik5NfMo9OP1Tq7eEWjn9U1DAm4vFEaU9gz5
         Rgnw==
X-Gm-Message-State: AC+VfDzLxRdFEJK2/yz8J7F4Vexl2/VnTD0h5JgRY+P/wcYd2l1twIgB
        4Q9vLf9kQ76kaVSR7l4WA2LhrBdRU8dEwamD2jUsLw==
X-Google-Smtp-Source: ACHHUZ6vVsX1EltWLg/8AbYkkCz0176NNm1w3Etuu/qomD4gG8YIwtN2zO4fXvjfno7nIYx5kKSeng==
X-Received: by 2002:a81:5247:0:b0:561:c5c3:9d79 with SMTP id g68-20020a815247000000b00561c5c39d79mr18726690ywb.45.1684957904948;
        Wed, 24 May 2023 12:51:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w2-20020a81a202000000b0055a1069886fsm3884163ywg.129.2023.05.24.12.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 12:51:44 -0700 (PDT)
Date:   Wed, 24 May 2023 15:51:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Tribo Dar <3bodar@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3] builtin/submodule--helper.c: handle missing submodule URLs
Message-ID: <ae6cf3fa461b85e346f034371dae56a2790dfa20.1684957882.git.me@ttaylorr.com>
References: <f7a8de14fe255286e62fc46d0a3083189f46bcc6.1684944140.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7a8de14fe255286e62fc46d0a3083189f46bcc6.1684944140.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e0a862fdaf (submodule helper: convert relative URL to absolute URL if
needed, 2018-10-16), `prepare_to_clone_next_submodule()` lost the
ability to handle URL-less submodules, due to a change from:

    if (repo_get_config_string_const(the_repostiory, sb.buf, &url))
        url = sub->url;

to

    if (repo_get_config_string_const(the_repostiory, sb.buf, &url)) {
        if (starts_with_dot_slash(sub->url) ||
            starts_with_dot_dot_slash(sub->url)) {
                /* ... */
            }
    }

, which will segfault when `sub->url` is NULL, since both
`starts_with_dot_slash()` does not guard its arguments as non-NULL.

Guard the checks to both of the above functions by first checking
whether `sub->url` is non-NULL. There is no need to check whether `sub`
itself is NULL, since we already perform this check earlier in
`prepare_to_clone_next_submodule()`.

By adding a NULL-ness check on `sub->url`, we'll fall into the 'else'
branch, setting `url` to `sub->url` (which is NULL). Before attempting
to invoke `git submodule--helper clone`, check whether `url` is NULL,
and die() if it is.

Reported-by: Tribo Dar <3bodar@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Range-diff against v2:
1:  38202878b5 ! 1:  ae6cf3fa46 builtin/submodule--helper.c: handle missing submodule URLs
    @@ Commit message
         , which will segfault when `sub->url` is NULL, since both
         `starts_with_dot_slash()` does not guard its arguments as non-NULL.
     
    -    Guard the checks to both of the above functions by first whether
    -    `sub->url` is non-NULL. There is no need to check whether `sub` itself
    -    is NULL, since we already perform this check earlier in
    +    Guard the checks to both of the above functions by first checking
    +    whether `sub->url` is non-NULL. There is no need to check whether `sub`
    +    itself is NULL, since we already perform this check earlier in
         `prepare_to_clone_next_submodule()`.
     
         By adding a NULL-ness check on `sub->url`, we'll fall into the 'else'
    @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const st
      	strbuf_reset(&sb);
      	strbuf_addf(&sb, "%s/.git", ce->name);
      	needs_cloning = !file_exists(sb.buf);
    -@@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
    - 	if (suc->update_data->filter_options && suc->update_data->filter_options->choice)
    - 		strvec_pushf(&child->args, "--filter=%s",
    - 			     expand_list_objects_filter_spec(suc->update_data->filter_options));
    -+	strvec_pushl(&child->args, "--url", url, NULL);
    - 	if (suc->update_data->require_init)
    - 		strvec_push(&child->args, "--require-init");
    - 	strvec_pushl(&child->args, "--path", sub->path, NULL);
    - 	strvec_pushl(&child->args, "--name", sub->name, NULL);
    --	strvec_pushl(&child->args, "--url", url, NULL);
    - 	if (suc->update_data->references.nr) {
    - 		struct string_list_item *item;
    - 
     
      ## t/t7400-submodule-basic.sh ##
     @@ t/t7400-submodule-basic.sh: test_expect_success 'clone active submodule without submodule url set' '

 builtin/submodule--helper.c |  7 +++++--
 t/t7400-submodule-basic.sh  | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bf8d666ce..6a16208e8a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2024,14 +2024,17 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
-		if (starts_with_dot_slash(sub->url) ||
-		    starts_with_dot_dot_slash(sub->url)) {
+		if (sub->url && (starts_with_dot_slash(sub->url) ||
+				 starts_with_dot_dot_slash(sub->url))) {
 			url = resolve_relative_url(sub->url, NULL, 0);
 			need_free_url = 1;
 		} else
 			url = sub->url;
 	}
 
+	if (!url)
+		die(_("cannot clone submodule '%s' without a URL"), sub->name);
+
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/.git", ce->name);
 	needs_cloning = !file_exists(sb.buf);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eae6a46ef3..d9fbabb2b9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1351,6 +1351,22 @@ test_expect_success 'clone active submodule without submodule url set' '
 	)
 '
 
+test_expect_success 'update submodules without url set in .gitconfig' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+
+	git -C multisuper_clone submodule init &&
+	for s in sub0 sub1 sub2 sub3
+	do
+		key=submodule.$s.url &&
+		git -C multisuper_clone config --local --unset $key &&
+		git -C multisuper_clone config --file .gitmodules --unset $key || return 1
+	done &&
+
+	test_must_fail git -C multisuper_clone submodule update 2>err &&
+	grep "cannot clone submodule .sub[0-3]. without a URL" err
+'
+
 test_expect_success 'clone --recurse-submodules with a pathspec works' '
 	test_when_finished "rm -rf multisuper_clone" &&
 	cat >expected <<-\EOF &&
-- 
2.41.0.rc1.11.gae6cf3fa46
