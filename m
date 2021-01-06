Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A397C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0355D2310B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbhAFKAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbhAFKAb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 05:00:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC73C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 01:59:51 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g24so3836052edw.9
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 01:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XAlRn3byVFFGX22yNIxJrtMEA5Cl0o3+gmOEH9PJAhc=;
        b=YIvk5SGm1OXQy/Y1TvXrQgsE3PP/FLsa0WgLJgoZ+UfKRc4BYQODVilkKpq6EjmoPe
         GkCjAf3yo8h6WuJjDu8fH2avhNynI1dpqvQMvqxlITmcMpj+Cxg2bvGwxHb5wwI9RMlR
         qy88O+peXZtvvN/dC4aKYcMSVu8aBDRcF5cf90e8i41oBDVLuBChzGkJtleQY2fwJUvP
         cAgZDe57TZVKTl2kpZ1X2nFGWAbZCAj4Z3BUa6bX5YhqarWzcgswhUg15iW9rnqBPA9R
         GdB6wzFIYOCrgvMuerb/V0jZZpqxilC59gBoox+epdMPq4PKKeDwyG7OX51AnO//19Nm
         WHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XAlRn3byVFFGX22yNIxJrtMEA5Cl0o3+gmOEH9PJAhc=;
        b=dXiRWxgpq4jO4jY3FatcXF7lTTdVOTMMwKUjKDaZBrA4LM6DanvnNXRTOZHraOarhd
         cvsHlyx+sNjqOOifgbMO1AVP6HWTT+ht0y30x/NWAwNMrGo0NgULSezoGtVHZ53nCVc5
         2OaVNqJ2jbwwrfmxLd6LggBeNTSHrXCsXEl5OBHpXwYZ3ZVE1cZeZenhlBVyWVbXLC0Y
         S9QTlgCS1g1MNB2g2xRfQFLPhYC7fEbjm90zCK9J4zWPvKLN0yhcqJctHNmsJW1xVavW
         0RX9xGbtjMJiKQM0L99EOipYd7k2KCE4va2M9qufLqB4K9B14Ms4E1pL3cA5bCn1i+67
         RJRg==
X-Gm-Message-State: AOAM531ADCU1/wM5GN9BnyphGCrImhFmcFpkj3yEhRzMBtWPsu8Tywzg
        tu0uHmNSrYN56F0dhSwWceA=
X-Google-Smtp-Source: ABdhPJy0XgL/DlVpCS4G+e/c39Mze/ztHJ6LqKmUa6nm1eaSOCoWR26DiUoLZHX9V/9YfBPJDIosJg==
X-Received: by 2002:a05:6402:3048:: with SMTP id bu8mr3431247edb.49.1609927189866;
        Wed, 06 Jan 2021 01:59:49 -0800 (PST)
Received: from szeder.dev (84-236-109-79.pool.digikabel.hu. [84.236.109.79])
        by smtp.gmail.com with ESMTPSA id dh19sm1243534edb.78.2021.01.06.01.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 01:59:49 -0800 (PST)
Date:   Wed, 6 Jan 2021 10:59:47 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] refs: allow @{n} to work with n-sized reflog
Message-ID: <20210106095947.GP8396@szeder.dev>
References: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
 <cover.1609923643.git.liu.denton@gmail.com>
 <18a35506b87356c1ae844d2686b2be6bd04567b2.1609923643.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18a35506b87356c1ae844d2686b2be6bd04567b2.1609923643.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 06, 2021 at 01:01:54AM -0800, Denton Liu wrote:
> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
> index 4a9964e9dc..15aac6e77a 100755
> --- a/t/t1508-at-combinations.sh
> +++ b/t/t1508-at-combinations.sh
> @@ -99,4 +99,20 @@ test_expect_success 'create path with @' '
>  check "@:normal" blob content
>  check "@:fun@ny" blob content
>  
> +test_expect_success '@{1} works with only one reflog entry' '
> +	git checkout -B newbranch master &&
> +	git reflog expire --expire=now refs/heads/newbranch &&
> +	git commit --allow-empty -m "first after expiration" &&
> +	git rev-parse newbranch~ >expect &&
> +	git rev-parse newbranch@{1} >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '@{0} works with empty reflog' '
> +	git checkout -B newbranch master &&
> +	git reflog expire --expire=now refs/heads/newbranch &&
> +	git rev-parse newbranch >expect &&
> +	git rev-parse newbranch@{0} >actual &&
> +	test_cmp expect actual

You could use 'test_cmp_rev' in these two tests to spare a few lines
and to get a bit friendlier error message on failure.

