Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E65C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16428610A4
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbhHYOUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241036AbhHYOUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 10:20:15 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB73DC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:19:29 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 14so27272601qkc.4
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gZs5kMSxAD+OVbt9KizUq2CUjQjxd7F71gMPUFUXtcE=;
        b=Fd+oBy6B0l037UwvJHqF2zQgjqGSJ+5vlGYE7JwAclhu+r5CWsA/sUMldcR4PkMQlh
         Xu4ok+hYPUPcLbKRY2tyAYy+w7jMeGF9m0fg4L0lTCJ+L86J0TlJWYMWQ3Lolmp8aGBP
         VeY9/IUcHxD2b6RzLacR86jnuEYVgUquCj1mLsAvKdpfz8mxadYNvOZOYFMIIrCQsITD
         odTHMrmB/q+hNT7fXf80AO2NDyaKAtnBMY1DejOHD2g9TNzI1IPfupyNb6bpHy5PQH67
         Afi0qLkVsT4Rr/yx0AsMgiau332TbSMla996pB6KL0ozAiO2gITSXrmHtJot/IAbvRS+
         BdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gZs5kMSxAD+OVbt9KizUq2CUjQjxd7F71gMPUFUXtcE=;
        b=BmHZACcih/Y20ceVckVigeVqIszEiQZXF1zQ2nq6AYcRZn0iCA5KnyI2CK8TuCTofH
         JeMyaTuBAwH959t6dt3vu+aZNYBPhf+z43k/n0SXgnrp6qeVkmZR2XDzUHSEfivWq+za
         P28tZwr5ICezrDiaVXYkYXFcAudgN6w3P15wZLhS5EBv275Mmgn2OhrHEDKlY2PT+OtG
         Ntoo99b/KJJUUkX4/W3hbAEQChnVG0LAQersuvylCYGl3KErevfQYEZvuS7XZCEgW5Yy
         o4PrIRwgxC6vyFfjS9PvPIqkYo9VmTDZJlqDV6urIKipPxHw3aBisJ88pmcbeA4Z8PlA
         dQMg==
X-Gm-Message-State: AOAM5328JPU/Cix3osSS1HgCwwruR6uPCg+/eeFVSi5I/xQsxAG0t98b
        WeBd5EzT8WONtTmhA1JykNk=
X-Google-Smtp-Source: ABdhPJwJqa+VeXZD9S8i9yQg5wPiWEiwxk9TGLfy9lTQk/2SKZvcMvL3+JglQYdu4WZ2O7wwCBIN8g==
X-Received: by 2002:a37:45c9:: with SMTP id s192mr32824784qka.21.1629901168647;
        Wed, 25 Aug 2021 07:19:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6d81:bb65:3870:d879? ([2600:1700:e72:80a0:6d81:bb65:3870:d879])
        by smtp.gmail.com with ESMTPSA id j18sm86337qkg.31.2021.08.25.07.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 07:19:28 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] fetch: refactor fetch refs to be more extendable
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover.1629452412.git.ps@pks.im> <cover.1629800774.git.ps@pks.im>
 <56a9158ac331f9911a4347d7d4afc2bbd2cf4d33.1629800774.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0481bb7d-2799-740c-a3de-e16ae05b8f45@gmail.com>
Date:   Wed, 25 Aug 2021 10:19:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <56a9158ac331f9911a4347d7d4afc2bbd2cf4d33.1629800774.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2021 6:37 AM, Patrick Steinhardt wrote:
> Refactor `fetch_refs()` code to make it more extendable by explicitly
> handling error cases. The refactored code should behave the same.
...
> +	/*
> +	 * We don't need to perform a fetch in case we can already satisfy all
> +	 * refs.
> +	 */
> +	ret = check_exist_and_connected(ref_map);
>  	if (ret) {
>  		trace2_region_enter("fetch", "fetch_refs", the_repository);
>  		ret = transport_fetch_refs(transport, ref_map);
>  		trace2_region_leave("fetch", "fetch_refs", the_repository);
> +		if (ret) {
> +			transport_unlock_pack(transport);
> +			return ret;
> +		}>  	}

I see that this nested organization makes it more clear what cases
lead into this error state.

> -	if (!ret)
> -		/*
> -		 * Keep the new pack's ".keep" file around to allow the caller
> -		 * time to update refs to reference the new objects.
> -		 */
> -		return 0;
> -	transport_unlock_pack(transport);
> -	return ret;
> +
> +	/*
> +	 * Keep the new pack's ".keep" file around to allow the caller
> +	 * time to update refs to reference the new objects.
> +	 */
> +	return 0;

And it happens that 'ret' is zero here. Should we keep returning 'ret'
or perhaps add an "assert(!ret);" before the return? The assert()
doesn't do much, but at minimum would serve as an extra indicator to
anyone working in this method in the future.

Thanks,
-Stolee
