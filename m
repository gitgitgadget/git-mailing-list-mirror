Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD11C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BF7606A5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbhITPJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbhITPJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:09:36 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26378C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:08:10 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id a22so22530378iok.12
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NwvDa5dh2DM/JvLGPDL2B3X295hqJROa4fpz2BNdw4o=;
        b=CBuQq76I0b5iV3N1f2AMt0Ya1oY62Z8UbUQVEG65YyWePMzxPAqr+BmSLQw7JvJDnC
         9x+qYL/MsmTHZFNdY1QT63SDgZzfSkb1xi1qFViVemN3eAQQKjq+53sJSP9slyTRXj2z
         bO8f5bTew/MRZ9PEks+ARbXjTeCZRslCfG5RoyjfN71RVNOuf25Id+J5sRekUAriRuw/
         eH+U5eCDfaRBzm4phXCdQD+vjt1d7ys8WkN0uUYzKDK2S9PQ0m18C6XMYQEZCMR8KcKC
         8oih9FFwms5h4t4EMA+E7ui+6wMFGYpExKSVlLmO1Ool8etIxn2bV9KfWbcrpEEhWQ31
         6dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NwvDa5dh2DM/JvLGPDL2B3X295hqJROa4fpz2BNdw4o=;
        b=8B4+W5cC7Nj9LaIqtmmoanEpjDmB5txugRVNslGzmjqSUXJz1e+czYXhQj8pt+Re/9
         Tva+RpvZEKNYS1Z4lHk805hZM0B/9L/uahb4KpqRZ9oZTUr42und7KgSNvf97/JMqCYy
         uS3ZAHPYPOTlZ34K9jmltBqtJCLvvwp5xFVYlzlh0+SjBFBEF+tSKpvksYUgvVI0GKNw
         BEkqZyfg6RJklPWaFEoLzsFk28p6PFb+/Y08vWKa72QpOW8qhJFKygiJZS4nHcPPxK0V
         yJvUjN8SLPgvq5LPeNxwh8YeVU0zvTyfv4l43eTgGI0VRIGp/uLDplpF4z0tjECtozP1
         4eNg==
X-Gm-Message-State: AOAM532df2NcgKjz1HWq/6fK1koBBrlDfHW5eswl7byUqVeZsCKnBzmc
        sa0dBLLKXDUO+CvLOEU/eN9rDcrvfQhbLA==
X-Google-Smtp-Source: ABdhPJyvNxEkTPaDfMAq1UWgXb192VzvDVHVUO17dhxH0AK2S4eHpA5yxDWB2B0qHaykRwdjouCRTQ==
X-Received: by 2002:a6b:c3ce:: with SMTP id t197mr18828709iof.159.1632150489566;
        Mon, 20 Sep 2021 08:08:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y30sm2924073iox.54.2021.09.20.08.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:08:09 -0700 (PDT)
Date:   Mon, 20 Sep 2021 11:08:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        liu.denton@gmail.com
Subject: Re: [PATCH] ls-files: use imperative mood for -X and -z option
 description
Message-ID: <YUij2Aj04B1Q1tRV@nand.local>
References: <20210920121940.905549-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210920121940.905549-1-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

On Mon, Sep 20, 2021 at 07:19:41PM +0700, Bagas Sanjaya wrote:
> Usage description for -X and -z options use descriptive instead of
> imperative mood. Change it for consistency with other options.

Your patch looks fine to me. I don't think it's urgent to change, but it
looks correct nonetheless.

> Cc: Jeff King <peff@peff.net>
> Cc: <liu.denton@gmail.com>

These Cc trailers can be removed. (They're not entirely unprecedented,
but I can only find ~200 examples in git.git's history).

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  builtin/ls-files.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 29a26ad8ae..1f38cd7b17 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -614,7 +614,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  	struct option builtin_ls_files_options[] = {
>  		/* Think twice before adding "--nul" synonym to this */
>  		OPT_SET_INT('z', NULL, &line_terminator,
> -			N_("paths are separated with NUL character"), '\0'),
> +			N_("separate paths with NUL character"), '\0'),

The text before your patch should include an article so it reads "with
[the] NUL character" instead of "with NUL character".

So I think the right post-image would be: "separate paths with the NUL
character".

Thanks,
Taylor
