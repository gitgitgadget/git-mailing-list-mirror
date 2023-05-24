Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D471EC77B73
	for <git@archiver.kernel.org>; Wed, 24 May 2023 16:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjEXQZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjEXQZq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 12:25:46 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57143135
        for <git@vger.kernel.org>; Wed, 24 May 2023 09:25:28 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-563874afe98so16565567b3.1
        for <git@vger.kernel.org>; Wed, 24 May 2023 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684945527; x=1687537527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y38v57DkSjnOKPsvqYV7BqsA73V49DmEll5PIv4vT0E=;
        b=qtf22VRslYBJeNL9fZ7vT9iaaYP47K9Lo9Kit014WCPAxVqktI6h66zOahTJwxXlVF
         KIKE8EgKlDTfnA2tNSRDzMhlGeJa/Pq9zHd2IzDKSWf4m0Mxyz+/jNkFbVqZRxMv+7uo
         6X943J8hauFnny+y2/+JndEm+sGgHebV5DPOYogjfkrsYn+hl+S7ssP7gEqBRv4q91/a
         rAEun4wX11rfgFfQkh0GfnKEhQmDQHuk/54PHAzhMZv7KIYw9qEb3jckiMlch7mHrrH3
         QR+4IthExFvbPp+bxTB2J2cQnrzWcaOHYsYbZqZuoH/VBP5WDfdkXtzUOnZub6vDUmS/
         Ft1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684945527; x=1687537527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y38v57DkSjnOKPsvqYV7BqsA73V49DmEll5PIv4vT0E=;
        b=GkBfFQVKKUDL9hXFRXt5Bu+SmtIkuKdjE82Ku55d5NvULEaIf49si5sw3LIhZQztIK
         uco5TcANcv9PN15OMDJhCnQ5Xug1DNI1RaX7xaA86GqJqEAXw0BKPCEmwc3kT8+Rg2JF
         x5TTvTbrzL5Qe4G+REesFBIato1psOM9JiR7CixSezh5tMTd3eEahf5CGpFfsQWgsmuD
         XTHvKh0GfW9uQJV3kHu54Y/Cq2rAlPp/guiE3c5O2+2gbkKIRIY6sDCWMfSy073BLIkt
         L31H4NnEMbO/b/brN+yKeagJDxDjkesfL9N+6nkZ7ytDsa2RXPFE8Y0QnlmY64j2VLuv
         Rcvg==
X-Gm-Message-State: AC+VfDxymIKv56dLE9Fi9J/OqAF+2CtBnKMMVtDTdXVeKYXFeLKxaD3h
        l6/5RJwu42D77SjSne8KlEON2TNMZFZ+lhrAd72h1w==
X-Google-Smtp-Source: ACHHUZ7tYVLncIdZtb0T3u96Tbi1gBINzI58G7z5VufhxzLqcQ5tm4dOfagmMN1VwUEAsd7ocRerrA==
X-Received: by 2002:a25:f821:0:b0:ba6:d45d:f363 with SMTP id u33-20020a25f821000000b00ba6d45df363mr352993ybd.57.1684945527000;
        Wed, 24 May 2023 09:25:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k185-20020a2524c2000000b00babf738533esm2102684ybk.37.2023.05.24.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:25:26 -0700 (PDT)
Date:   Wed, 24 May 2023 12:25:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Tribo Dar <3bodar@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v2] builtin/submodule--helper.c: handle missing submodule URLs
Message-ID: <bc204f450a80f7e6379b3a8564fc54637a266e7e.1684945504.git.me@ttaylorr.com>
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

Guard the checks to both of the above functions by first whether
`sub->url` is non-NULL. There is no need to check whether `sub` itself
is NULL, since we already perform this check earlier in
`prepare_to_clone_next_submodule()`.

By adding a NULL-ness check on `sub->url`, we'll fall into the 'else'
branch, setting `url` to `sub->url` (which is NULL). Before attempting
to invoke `git submodule--helper clone`, check whether `url` is NULL,
and die() if it is.

Reported-by: Tribo Dar <3bodar@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---

Junio: feel free to queue either, but after thinking on v1 a little more
I think that it is pretty gross and that this version is much cleaner.

Range-diff against v1:
1:  f7a8de14fe ! 1:  bc204f450a builtin/submodule--helper.c: handle missing submodule URLs
    @@ Commit message
         `prepare_to_clone_next_submodule()`.

         By adding a NULL-ness check on `sub->url`, we'll fall into the 'else'
    -    branch, setting `url` to `sub->url` (which is NULL). When we then try
    -    and invoke `git submodule-helper` below, we'll get the expected error
    -    message:
    -
    -        error: option `url' requires a value
    -
    -    Note that this means that `--url` and its value must come last when
    -    preparing the argument list, to avoid confusing the next argument as the
    -    value for `--url` if `url` itself is NULL.
    +    branch, setting `url` to `sub->url` (which is NULL). Before attempting
    +    to invoke `git submodule--helper clone`, check whether `url` is NULL,
    +    and die() if it is.

         Reported-by: Tribo Dar <3bodar@gmail.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const st
      			url = resolve_relative_url(sub->url, NULL, 0);
      			need_free_url = 1;
      		} else
    + 			url = sub->url;
    + 	}
    +
    ++	if (!url)
    ++		die(_("cannot clone submodule '%s' without a URL"), sub->name);
    ++
    + 	strbuf_reset(&sb);
    + 	strbuf_addf(&sb, "%s/.git", ce->name);
    + 	needs_cloning = !file_exists(sb.buf);
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
    + 	if (suc->update_data->filter_options && suc->update_data->filter_options->choice)
    + 		strvec_pushf(&child->args, "--filter=%s",
    + 			     expand_list_objects_filter_spec(suc->update_data->filter_options));
    ++	strvec_pushl(&child->args, "--url", url, NULL);
    + 	if (suc->update_data->require_init)
      		strvec_push(&child->args, "--require-init");
      	strvec_pushl(&child->args, "--path", sub->path, NULL);
      	strvec_pushl(&child->args, "--name", sub->name, NULL);
    @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const st
      	if (suc->update_data->references.nr) {
      		struct string_list_item *item;

    -@@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
    - 		strvec_push(&child->args, suc->update_data->single_branch ?
    - 					      "--single-branch" :
    - 					      "--no-single-branch");
    -+	/*
    -+	 * `url` might be NULL, so ensure that this argument is passed
    -+	 * last to avoid confusing the next argument as the value for
    -+	 * `--url`.
    -+	 */
    -+	strvec_pushl(&child->args, "--url", url, NULL);
    -
    - cleanup:
    - 	free(displaypath);

      ## t/t7400-submodule-basic.sh ##
     @@ t/t7400-submodule-basic.sh: test_expect_success 'clone active submodule without submodule url set' '
    @@ t/t7400-submodule-basic.sh: test_expect_success 'clone active submodule without
     +	done &&
     +
     +	test_must_fail git -C multisuper_clone submodule update 2>err &&
    -+	grep "option .url. requires a value" err
    ++	grep "cannot clone submodule .sub[0-3]. without a URL" err
     +'
     +
      test_expect_success 'clone --recurse-submodules with a pathspec works' '

 builtin/submodule--helper.c |  9 ++++++---
 t/t7400-submodule-basic.sh  | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bf8d666ce..efd0761cd0 100644
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
@@ -2065,11 +2068,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (suc->update_data->filter_options && suc->update_data->filter_options->choice)
 		strvec_pushf(&child->args, "--filter=%s",
 			     expand_list_objects_filter_spec(suc->update_data->filter_options));
+	strvec_pushl(&child->args, "--url", url, NULL);
 	if (suc->update_data->require_init)
 		strvec_push(&child->args, "--require-init");
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
 	strvec_pushl(&child->args, "--name", sub->name, NULL);
-	strvec_pushl(&child->args, "--url", url, NULL);
 	if (suc->update_data->references.nr) {
 		struct string_list_item *item;

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
2.41.0.rc1.11.gf7a8de14fe.dirty
