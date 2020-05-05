Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FAC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9F4206A4
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m22zhrCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgEEMBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 08:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEMBc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 08:01:32 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F67C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 05:01:32 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b188so1901073qkd.9
        for <git@vger.kernel.org>; Tue, 05 May 2020 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ErP/IzYWb6BwmVkGpgJbdqUuvpsLLVwKBGDqkcCTfws=;
        b=m22zhrCBc4ievqLGrJ4x/G1mm+wAFw+HMdhhTlUtI5uT5gPltImYYXZyTwgJe1gH+v
         av3gthllNG7noT18Hjg5vCaOdWEP8OpMdAnunD43+fkwGKmTQ0Pjxi45En4/OphHqOr5
         0AdcLHmvf7JpWkOFv8TWURzZkTi5VgVbS6+MW05HTB33ZzAdeaXfKnJAB8fkVuBDqXc/
         yFuxXr2XXlCJP8yncAXR6IV6twL22e9l4Shyinutxk17R6O4rWj12E8U7TOeguLHccez
         okjVxs2Z1BpHJQmcKAVc8NfWxF+N+zAU6OuNFGqqGRPz4KPBijG1esQBrLmknI14CIes
         xQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ErP/IzYWb6BwmVkGpgJbdqUuvpsLLVwKBGDqkcCTfws=;
        b=sdbS6WN7WbG/C+XMZGjOq+6nq9O4JTrSnwD3COiqemGq7ulYTEWhdwvAnrVJATLbUD
         +y4dhAlUaFNC4TwJNS3WJafghKT1APMOyMSX3/d0uJqeuLh4ZgtpjEgNRQmfXnyZ51j1
         Cs+F68GJwqK6XfogVwiUY3a5kZ5oq4qMMLECzxEAr6CakJN1qJIzBM7EA3DmCm7vds8m
         TymVeNYOlAHw7C4SvhwGFCZancXrTAH+MWztQBDCybPgY08MfpdEY3cH/I+HXN+TzbLD
         ECTpidhNYjJLpIn7RuQ/oSgZiukaEj9aatDuQ1Xwl76Y3G7viemA0PvaQtsbcnD4yrA4
         bIlQ==
X-Gm-Message-State: AGi0PuYXSPQhZWhogx0Fn3dVqoguWqr/e9lko6yMsRA4Z8cuypMgSQGD
        EbmK1+UNWlezo1N2Lq/7L7jSA2SVabo=
X-Google-Smtp-Source: APiQypLDZznh7d8iOidPxMzTccIg9+4B+oNBCAVitRbZjn144WhsKkIdcLwtjWmdY9Xm1RUPcvZqTQ==
X-Received: by 2002:ae9:ebc8:: with SMTP id b191mr2875408qkg.1.1588680090875;
        Tue, 05 May 2020 05:01:30 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s14sm1544597qts.70.2020.05.05.05.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 05:01:30 -0700 (PDT)
Subject: Re: [PATCH 5/8] builtin/commit-graph.c: dereference tags in builtin
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
References: <cover.1588641176.git.me@ttaylorr.com>
 <513a634f14e90ec0c2e80a6aaf8cb66bbedf8966.1588641176.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1b0bf610-640e-de4e-ab31-ca8719d533f7@gmail.com>
Date:   Tue, 5 May 2020 08:01:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <513a634f14e90ec0c2e80a6aaf8cb66bbedf8966.1588641176.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2020 9:13 PM, Taylor Blau wrote:
> @@ -228,18 +240,25 @@ static int graph_write(int argc, const char **argv)
>  		if (opts.stdin_commits) {
>  			oidset_init(&commits, 0);
>  			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
> +			if (opts.progress)
> +				progress = start_delayed_progress(
> +					_("Analyzing commits from stdin"), 0);
The code functions as you intend and is an improvement. Similar to my
earlier suggestion to use something like "Collecting referenced commits"
for the --reachable case, perhaps this could be "Collecting commits from input"?

Thanks,
-Stolee
