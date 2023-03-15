Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C34C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 22:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjCOWmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 18:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjCOWmD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 18:42:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B573347A
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 15:42:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e129-20020a251e87000000b00b56598237f5so1406790ybe.16
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678920120;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XzPU8biz1EIJdyZyqY+1Zmj7Is5+6M3Uk6tVIuyNZjs=;
        b=PW9YtYxe7pIY6FzLnAc44XuBpKys59atZb6jcoqjHdENPGw7Pd27rcqCuEg7J7/gZ4
         0RTr4e9ZxAB+OAYDP23XDk7CYTgAjf6mT3uBS7XsRgfz5LW/aOZIjf7is/vfVzq4SG8R
         PW3Zc+SrdZCeUqOfwwQiLXiLbI0aQfGi3oqLNmX5uf6j8/+JLv3SgXjGmmDOj/z82t/7
         OdvCtbgu+iQPLP95pHmcUPtN6lHmOITZd0XntIMJ/CUBh+x5bJjnyYghtEpuFwAqCcRX
         5SR0lZoJRDPhuGugN3+c3eZb6gT1iex+x0s9nZOUIARDtw3F9gTGlSiwklJFVcHo+OQW
         SI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678920120;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzPU8biz1EIJdyZyqY+1Zmj7Is5+6M3Uk6tVIuyNZjs=;
        b=3BjiySGQ7syqu7572fP9kTvpULzL0QdalLO1aXfZyQ5HeDgFUTOmOP0eL0CYRHWx0O
         +4+xvG38cDUZTrjsY2X99OwpSC51sYgZSDLULsCftN5YfnG/MTEjlFaAFdSSObL37wu+
         U41Sdk2CL7NdE8Zwd7sz0vxQ40VIhMB9KZUKoD3OBFR/wOC3PSjiWkqbKAkponWOG0rH
         B56sGp3Fox23strkEPhi9k16rFwfNY5GoBg6Fk6JoYqS41mtl+vXMdKGuXedQUth5IXU
         4myvXhxmZkJWEwCSkOHUNxY97yHEg55u8BiY929Wjjx8Vs0Abzdf2+QZwt2Kd5IN5E6x
         NMGw==
X-Gm-Message-State: AO0yUKUU97enMjXBNn0d5abD7GnowOV0N9ENmzqSscIPBf++E64G1ltg
        qrn7EVwISye7z4Wn2hzhwrbzYv+jJizhE044mpTC
X-Google-Smtp-Source: AK7set+3uxuq8ovEOi8X/6dKIfWLkxd0eGYIdDjq0AX6bS+mC5tib1JZv66FwRfkDG36iSJGT8nyXUW2EmI+6oUyXBz/
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:524e:ff9a:ee19:127f])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:38d:0:b0:8ea:3d09:b125 with SMTP
 id k13-20020a5b038d000000b008ea3d09b125mr22177611ybp.0.1678920120524; Wed, 15
 Mar 2023 15:42:00 -0700 (PDT)
Date:   Wed, 15 Mar 2023 15:41:57 -0700
In-Reply-To: <f9e80e233f1ca26f07f9db49261e54b7deaf83b8.1678902343.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230315224157.167705-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 1/8] for-each-ref: add --stdin option
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -75,7 +79,21 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
>  	filter.ignore_case = icase;
>  
> -	filter.name_patterns = argv;
> +	if (from_stdin) {
> +		struct strbuf line = STRBUF_INIT;
> +
> +		if (argv[0])
> +			die(_("unknown arguments supplied with --stdin"));

As a reference point, both fetch and send-pack accept input from stdin
too, and use them to augment what's provided on the CLI (and not only
accept them when nothing's provided on the CLI).

Having said that, it's also reasonable to start by prohibiting CLI
arguments when --stdin is given, and we can always relax this later
if needed.
