Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D75AC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C7223D1F
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbgLIWHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 17:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgLIWG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 17:06:58 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0696C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 14:06:17 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id b62so2967083otc.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wN/JKaCqlA3waJGhkWuv4CinADMDgQaF3R+97gS7Zro=;
        b=uRqfkiGP809Yt856kgdtfrvsqdPsb3V40amrNy55H78k0I1PCR9TI7QQCgmpnZYnTV
         icMRRSZBMhZSDjmgx4+CzSrUA93gzeyBjFtYq6gRJApX42EMAlYPoonmpxZG4OCccMfM
         snSNVW/G009wlCF4qlJJFCHrHURB00jBVquMqpTuJLD4no+wlTnzR2vn7+R3Vm2CQw+k
         L2qEoZmMg+Peaur5c48qlX938AhzMpT7PNxbgcQMgsA7hBmZEc2PqGPgIXE6Fql81fMm
         UeIixnZD8Mw3mkciFsOChS8JNjc+V61Tux0iWIHR70boiVYv1Nl52yFelVL6V1W5oHOF
         /tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wN/JKaCqlA3waJGhkWuv4CinADMDgQaF3R+97gS7Zro=;
        b=V6vDJ0xvG6irVWxNfXGHiMXnUYCCtwS6p+tCm5J5iU0400A2EVyRKOeJ5zjHgEje6s
         6vbMA9HMAYgAthY+glhKPS3nXh9ZxIRHXF8A52SwiMRJ7s8YnLujPYp3xUxQNA5wDwV0
         D/dFHprbjSBxmUAIhga/AMV3Z7xz2wpujO+LR4VD002x/RKbL/ccq54l4GLsEgxtJU/+
         PbCwSVbciAwUnmnhyRX5XO9x6bKLoDia0Yklysy2I7a6YqBPSLrc/6RT+ViK/tRl1svi
         ULYQqSUxaeUGgFFzbLfSifTS+MEgmGVXPm62v7lGUNpsjDxucQsPav1zJVkPbAVi6Igp
         3YmA==
X-Gm-Message-State: AOAM530avQ5PIGRq5jfdxMhjMT7dNLsAdsHtwO6KB5xKJbBoxaOKf+EA
        cMCIgM5NKj4+0oMi0DGUmhKq8w==
X-Google-Smtp-Source: ABdhPJzHoxeadcH9LwCS6hnXaVuVDvE2um9EgRC4ukXM/frPDt89uQjk6x6tLkZTXsupBeMnb1lnVQ==
X-Received: by 2002:a9d:200b:: with SMTP id n11mr3628195ota.348.1607551575876;
        Wed, 09 Dec 2020 14:06:15 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id n31sm654808otn.33.2020.12.09.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 14:06:15 -0800 (PST)
Date:   Wed, 9 Dec 2020 17:06:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/7] diffcore-rename: avoid usage of global in
 too_many_rename_candidates()
Message-ID: <X9FKVUT+daRqS0cY@nand.local>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <95a3fcb8be08cce186144d175a6cda71ab42d445.1607223276.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95a3fcb8be08cce186144d175a6cda71ab42d445.1607223276.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 06, 2020 at 02:54:30AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> too_many_rename_candidates() got the number of rename targets via an
> argument to the function, but the number of rename sources via a global
> variable.  That felt rather inconsistent.  Pass in the number of rename
> sources as an argument as well.
>
> While we are at it... We had a local variable, num_src, that served two
> purposes.  Initially it was set to this global value, but later was used
> for counting a subset of the number of sources.  Since we now have a
> function argument for the former usage, introduce a clearer variable
> name for the latter usage.
>
> This patch has no behavioral changes; it's just renaming and passing an
> argument instead of grabbing it from the global namespace.  (You may
> find it easier to view the patch using git diff's --color-words option.)
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  diffcore-rename.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index d367a6d2443..68ddf51a2a1 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -434,12 +434,11 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
>   * 1 if we need to disable inexact rename detection;
>   * 2 if we would be under the limit if we were given -C instead of -C -C.
>   */
> -static int too_many_rename_candidates(int num_create,
> +static int too_many_rename_candidates(int num_targets, int num_sources,

OK, so num_create becomes num_targets, and the global num_src becomes a
new parameter named num_sources.

Makes sense, but it took me a second to figure all of that out. I don't
think that you need to split this across two patches (e.g., one to
rename num_targets, and another to introduce the num_sources parameter),
but including the new names for each of these variables in the patch
message might make this clearer to follow.

>  				      struct diff_options *options)
>  {
>  	int rename_limit = options->rename_limit;
> -	int num_src = rename_src_nr;
> -	int i;
> +	int i, limited_sources;
> [...]

Everything else from here looks fine, and indeed viewing this with
--color-words made it much easier to verify.

Thanks,
Taylor
