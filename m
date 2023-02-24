Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E340EC6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 22:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBXWiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 17:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBXWiA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 17:38:00 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CBE70813
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 14:37:34 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c525d470so12057697b3.18
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 14:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pxhuERcXqpBDovzf/b1PoZaI7W6gYEGUOExnT3g8BUE=;
        b=s0CMqIyLGDSOMJWJXMV+ocbtvnUVsI+7m7mR9FLKMZ/RIHwwzCEwowjTc+ZLwCiqt6
         5GJoxq1wP46eXjnZJwbmvCgdeJS5FAIS9WXrHCpBCN65hD3G9hQFlukhMHWKwE07rpLc
         yG9KN2Kd4idc7of5Rw5Xrt9zPezBlsoXGyQlGDKl8e0mXiV1SnjHunyDSuYikU7PMpDI
         oXWeAu4B3o/0JMVk8yvBV4dKD8NSwD4i36MDNP9GvFcCkcA63aoj6I5I+FFRJfND5SXO
         qa56eXdXjNEJ/NoT5DGzkyYvD5iQdcBX4AyDLK7I3wMBlpub4polckhHxLccJ1TsYrhF
         CSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxhuERcXqpBDovzf/b1PoZaI7W6gYEGUOExnT3g8BUE=;
        b=e14WtiY2SQ3jTqyADNgCHpIM5KOgZ48kV2wQAysP6UrCBPXaouCcMYchpXA0uU4MHn
         6PGlfCgTepmYP+z+g3KTM1+f02om1hg145sy6b1e6NvQq/oOQnO+OHS1X874w2fS+UJU
         Fbm3wR2iZbzn3mVrmVtLa7o+BBNxGWmIpYcArPwffM5ONrI+/LdCIjk5vXiKqUMQB4Hy
         gCFv04cfSmbDyvAVYniKQbhPVBuRVEYOmZNu0K7oUlpV6nYNk+wWriijcBIR4MWK/fFe
         6lKBkearvo3a/So1QUN8vFcFw3rzU2q99SJhwEI+wTzDpNuqIdMp+u0PaJAH1KA1r21i
         gj3Q==
X-Gm-Message-State: AO0yUKUBfZrmVQo2CXVxSNbDOqqlOBIFeFoW7yJvhSlGGyCjrdkkuna7
        dllvhSV1TVmyp9hJUTemBOE4fC29XUOjINy/mxrL
X-Google-Smtp-Source: AK7set8MKZ09AjBIU+NpkVFcAPsa308XNrP99cGVYTmN++VuQwEQKrmP6s7Rza4clhnC0MpJIGjxbQ1XqE0CUB8MU83F
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:6b04:35a6:9357:29a1])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:34e:b0:9a0:d4d:5d74 with
 SMTP id e14-20020a056902034e00b009a00d4d5d74mr4968433ybs.3.1677278252673;
 Fri, 24 Feb 2023 14:37:32 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:37:30 -0800
In-Reply-To: <508837fc182b0adba96c3fcbd468f47f8f0a0aef.1677143700.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224223730.1510266-1-jonathantanmy@google.com>
Subject: Re: [PATCH 05/11] sparse-checkout: avoid using internal API of unpack-trees
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index c3738154918..4b7390ce367 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -219,14 +219,13 @@ static int update_working_directory(struct pattern_list *pl)
>  	o.dst_index = r->index;
>  	index_state_init(&o.result, r);
>  	o.skip_sparse_checkout = 0;
> -	o.pl = pl;
>  
>  	setup_work_tree();
>  
>  	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
>  
>  	setup_unpack_trees_porcelain(&o, "sparse-checkout");
> -	result = update_sparsity(&o);
> +	result = update_sparsity(&o, pl);

This makes sense - setup_unpack_trees_porcelain() does not use o.pl, so
there is no logic change.

> @@ -2111,11 +2111,12 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
>  	trace_performance_enter();
>  
>  	/* If we weren't given patterns, use the recorded ones */
> -	if (!o->pl) {
> -		memset(&pl, 0, sizeof(pl));
> +	if (!pl) {
>  		free_pattern_list = 1;
> -		populate_from_existing_patterns(o, &pl);
> +		pl = xcalloc(1, sizeof(*pl));
> +		populate_from_existing_patterns(o, pl);
>  	}
> +	o->pl = pl;
>  
>  	/* Expand sparse directories as needed */
>  	expand_index(o->src_index, o->pl);
> @@ -2147,8 +2148,10 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
>  
>  	display_warning_msgs(o);
>  	o->show_all_errors = old_show_all_errors;
> -	if (free_pattern_list)
> -		clear_pattern_list(&pl);
> +	if (free_pattern_list) {
> +		clear_pattern_list(pl);
> +		free(pl);
> +	}

When free_pattern_list is true, we free "pl" which was previously
assigned to "o->pl". Do we thus need to also clear "o->pl"?

