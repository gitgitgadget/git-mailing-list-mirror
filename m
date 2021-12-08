Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0234BC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhLHTXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLHTXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:23:07 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B995FC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:19:35 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id i16-20020a17090a059000b001ade0b46a81so433916pji.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H41Lru/lhjq+/OkWXWoIhxrfr0GzWY6bmezKgfRzJKw=;
        b=TuSjORQCD8IHEKf6ADsVMDyG7i4eFanxXJdn+mTIB3L/nWk6w7RXVHLhvgrDBZzLim
         ttZVuw+CRfbZSYVVodfo2/hxkUB2Leb5YQaFbCRhIRpYc9ATOb4ThgHM3eolj5LyLup1
         HCCZtNd3i5g46XEFXm/YM2yWlC249z3rHo4MrTlGSvvCtwiNAU3OdK53aZ+zbJlHv+F/
         t6p8HrEDebmsdngKVEvfZVd77LMMMxBGcI1yscPjXnkO7fYq1vmyDIO3/p+k9sfpW3bu
         QZeriYh30dzMtnftcOz1kOZquMCVZ1SntCEMOc6Fj9n6XNG23Ft+mtxEoMwdDIiM8pZ7
         6fmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H41Lru/lhjq+/OkWXWoIhxrfr0GzWY6bmezKgfRzJKw=;
        b=1IXPdnhKI3jjTdln4WX5o/JTlw7or+n9hmZUQffG0f8Z5x+YkfACX/vcq30w+hhFJJ
         TaKRt1GeScxzBpgTisEkNA07dk6Ibe0pskEZVbE+ZMh2ckZeTmWT6GEDP7n+y/r8pJl/
         QN9MvfnHHWllWP6d2iWa9f70B7+Zs/kaB8gzEjZXQbPRMxUvwrO3B0b8GauznBVTe7/X
         3ieb9UbajEqz0SHldA4Zsx4XTSzXQdCDBhyKijA7OYJcJW0DZuAnfjUs5iVD2SRl/xOg
         VplPlsBvM8c0xZntaT2pw9qOFbWu638VBDKxjpqYrUBvQuIZMHZF5Ek7wzZWz1HPrH8G
         G6mA==
X-Gm-Message-State: AOAM5303JvNLhdREJuAEfJDt6E9A5jWxywWxdSFM9f5Q/TBlnVZg/Hci
        QRAShYZiVnEvMureafyYH+PHetIHobGmig==
X-Google-Smtp-Source: ABdhPJw5IFAVjT6rRCkGJzf8PN3I3VlG/XiM2s3DzZrReu+cwRhjGU/291nBTEd0gx5dP/BqVH+4slSkC4JXeQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1248:b0:4a2:5cba:89cb with SMTP
 id u8-20020a056a00124800b004a25cba89cbmr7560221pfi.12.1638991175099; Wed, 08
 Dec 2021 11:19:35 -0800 (PST)
Date:   Wed, 08 Dec 2021 11:19:33 -0800
In-Reply-To: <de2be06818781bbef29926c0e8e8981746242c60.1638919346.git.jonathantanmy@google.com>
Message-Id: <kl6l35n2c3ay.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1638919346.git.jonathantanmy@google.com> <de2be06818781bbef29926c0e8e8981746242c60.1638919346.git.jonathantanmy@google.com>
Subject: Re: [PATCH v6 2/2] config: include file if remote URL matches a glob
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -335,9 +427,16 @@ static int git_config_include(const char *var, const char *value, void *data)
>  		ret = handle_path_include(value, inc);
>  
>  	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
> -	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
> -	    !strcmp(key, "path"))
> +	    cond && include_condition_is_true(inc, cond, cond_len) &&
> +	    !strcmp(key, "path")) {
> +		config_fn_t old_fn = inc->fn;
> +
> +		if (inc->opts->unconditional_remote_url)
> +			inc->fn = forbid_remote_url;
>  		ret = handle_path_include(value, inc);
> +		if (inc->opts->unconditional_remote_url)
> +			inc->fn = old_fn;
> +	}
>  
>  	return ret;
>  }

Minor nit: it looks like we don't need to restore inc->fn conditionally,
so instead of:

	if (inc->opts->unconditional_remote_url)
			inc->fn = old_fn;

we could just have:

  inc->fn = old_fn;

which (purely as a matter of personal taste) looks a bit more consistent
with the unconditional assignment of:

  config_fn_t old_fn = inc->fn;



No comments on the rest of the patch; it looks clean and
easy-to-understand :)
