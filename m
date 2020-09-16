Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52628C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10E62087D
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGmFKY27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgIPWvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIPWvb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:51:31 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0547C061756
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 15:51:29 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v123so249167qkd.9
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0+2H3RUO1lj1UPyn/xtdorh+yr9UNmVIOzCjbefkMk=;
        b=XGmFKY27qq2aRWaNz4Xkjde6E++0dir2IxyYprrmwqo4zDHtYfcV2EvuwiGDR/R3rn
         9CWDRgAZxlD2Y41q1wS+Qpr2SXpbQwm5bz+TrxvuGRjRuxpDrL/IItXsSjdDMYFm2dG0
         MEYf2NSAf84qHTW63dw+uW25gzZ5ipnwD1UceuFW7UYCPKF88HxynLFt5DjypHLNpZ5a
         1SF8wJ9QJ1Ym5QJUL26FTI8KBab6p4zjh34JQoX3JeyTCSc3ytq2RmWSenS1n/Z7E/Ud
         Bu5u5uViZd+mWJ0B9cWeN0elkzXoQLUxpJtEiDYRP8JvIvyAIPqJCpyaWsGgaZlJuRRu
         pVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0+2H3RUO1lj1UPyn/xtdorh+yr9UNmVIOzCjbefkMk=;
        b=gfy9vWLCnGtWXhGF4EVPWTeZSAQ9H77s6NR+w1Q8QXQmOlqudkGagwPn2PkXIolxEn
         Zve6s3rmMkzT/arz2AamRqH0mLb1pE1uvxwL8XOpkwmaGzLzU7bj9dSJGHcUw7PFeXDZ
         xEwqXTmlEzhRHyhtnk2CNRrZxoZoLLWsCzWdXNuzjXtNtfi0gSSJGIM3Q9ounhvyCyCb
         SBdcKy7Xozltj8AX4+sPu1jcrFl8lbe9unp8FWM7zB/9EshVvvgFTyPNQSWDRZyVYGZa
         xW94dowJTFdvvLPOPIhh2ZdqDX3wfQANyJt9l6Gz0bDUWbCxFWB9hq8uybpPZu9LkHqP
         2mdw==
X-Gm-Message-State: AOAM532/2+ssgRYbuiX3cdC9bQPFbRNxP+naIukGGrYQxl7L4k/ACvuB
        l/PWgxMlCwzW2qfQ+fSF66Q=
X-Google-Smtp-Source: ABdhPJwIKjFv4rmIpjxTpSRBJvDi7PTl+KyvOeBHxFWr0pyluSIfxsTW99lljFwY9XnppRpsf8tyLA==
X-Received: by 2002:a37:d41:: with SMTP id 62mr24182499qkn.444.1600296688938;
        Wed, 16 Sep 2020 15:51:28 -0700 (PDT)
Received: from Derricks-MacBook-Pro.local ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r42sm20740066qtk.29.2020.09.16.15.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 15:51:28 -0700 (PDT)
Subject: Re: [PATCH v2 00/13] more miscellaneous Bloom filter improvements,
 redux
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <40abfff8-3b5f-fa63-73fd-280cd80cd25f@gmail.com>
Date:   Wed, 16 Sep 2020 18:51:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <cover.1600279373.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/16/20 2:06 PM, Taylor Blau wrote:
> Hopefully this is it for this series ;). I think that it's in good shape
> now, and I couldn't find anything in my own inspection that I wanted to
> change. So, if others feel good, too, I think we should focus on
> incremental fixes on top of this.

I am also happy with this version. The test updates are
rather nice.

It is worth highlighging the tracing changes, in case
anyone was planning to use that style of JSON data in
production. I think it is better to include this simpler
data model of one variable per event instead of rolling
our own JSON format.

Thanks,
-Stolee
