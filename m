Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686F1C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 12:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DE920767
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 12:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E87S0FML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgIAMXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgIAMVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 08:21:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CADC061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 05:14:35 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t20so635610qtr.8
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nDVcdGQigE4iq6koljsMTC3gneha9vUDN3Wd0jjVuUY=;
        b=E87S0FML5XJuGNzIWOIPTzPnyZxrKZ2CmGrQm7wrTxVd+jT/yM9trRWL+3BhMd1Nfw
         9ElqcO6sZZotCAKgVZxhZvhVFnzl8Vm71meJZIpnEegEF2NziDBgoKF11AQ6stwJkanJ
         ZZ9lrUdfxrLy8Sb3IlZ4RdJr0N/ftt46f7JWHIPydHfe3YDPW1theEG1/HXxpuxB4Dx8
         ESYG89QKot1B0hWSHsUP6jobOwNEmJeI9puAIOFIueqKL4GUlyY4Z947/AW4W6/BDaWH
         n6KejqNTT56DsRFGiSKE+5z9eBH0GS73tnJ0WXPJobbAw1gA3lQ4FCqyrNZtm6ccYxWS
         AMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nDVcdGQigE4iq6koljsMTC3gneha9vUDN3Wd0jjVuUY=;
        b=pISI+MasaqWT65dz20VhriD2T0SHEj5YtGmNOkPpudX4TGxkmFW3QUScTcOOTU4i5J
         g3CIUx8ljn/eTFb015OlQ1Tcau3nNe4l/Y0lRi7jcduOxu2X0+LuFhWihaaV+LEV4y/b
         t7hULD35OH9vXw+imm1NNo/kvg8hE3B5I4Fmbzb5saI0RcG8au6FW5Gcg3YjDJum8CRy
         VAkZhAdao3EG74KziK0aM7J6Y9zkcrf8Y5UWMeCqKlo/1UHGACQbbxxip/V0yAmrqOyc
         dRxhv/oKE3xX5HnC9GB+DkeMwtk4hAaZUqabATj/k/O4g2KqmMHPeCpZ9PPMoSr2ivBy
         5P8Q==
X-Gm-Message-State: AOAM5325yaN0b2uTbK5GRQ9CyzpbaURWpDO7Q45K0X49acDuJgK3mIwD
        pwTijkNJucYNJ8Gr6P5xfKXcl/Bby5GuhA==
X-Google-Smtp-Source: ABdhPJyXamw6GS63Sq4UHpsYlbKTyLiiPKqYTJrOdJUCNoOKG9IireFaJis1XfIcytErtNvyrt+fRA==
X-Received: by 2002:aed:3c4c:: with SMTP id u12mr1322544qte.312.1598962473788;
        Tue, 01 Sep 2020 05:14:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5166:a025:6686:ff84? ([2600:1700:e72:80a0:5166:a025:6686:ff84])
        by smtp.gmail.com with ESMTPSA id 184sm1301281qkl.104.2020.09.01.05.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 05:14:33 -0700 (PDT)
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
To:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20200901074355.GA4498@dcvr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
Date:   Tue, 1 Sep 2020 08:14:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200901074355.GA4498@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2020 3:43 AM, Eric Wong wrote:
> These allows users to write hash-agnostic scripts and configs to
> disable abbreviations.  Using "-c core.abbrev=40" will be
> insufficient with SHA-256, and "-c core.abbrev=64" won't work
> with SHA-1 repos today.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>   I kinda wanted to allow a value of "max", but I figured the existing
>   boolean falsiness words might make more sense with `--no-abbrev' in
>   for some commands...  Naming is hard :x
> 
>  config.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/config.c b/config.c
> index 2bdff4457b..f2e09c72ca 100644
> --- a/config.c
> +++ b/config.c
> @@ -1217,6 +1217,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>  			return config_error_nonbool(var);
>  		if (!strcasecmp(value, "auto"))
>  			default_abbrev = -1;
> +		else if (!strcasecmp(value, "false") ||
> +			 !strcasecmp(value, "no") ||
> +			 !strcasecmp(value, "off"))
> +			default_abbrev = the_hash_algo->hexsz;

I'm not sure we need three synonyms for "no-abbrev" here.

"false" would be natural, except I think in a few places
the config value "0" is also interpreted as "false", but
as seen below a value of "0" snaps up to the minimum
allowed abbreviation.

>  		else {
>  			int abbrev = git_config_int(var, value);
>  			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)

Perhaps "core.abbrev = never" would be a good option?

After we decide on the word, this patch needs:

* Updates to Documentation/config/core.txt
* A test that works with both hash versions.

Thanks,
-Stolee
