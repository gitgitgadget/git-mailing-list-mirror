Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C463C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1180C61357
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhHXQxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhHXQxA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:53:00 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9BCC0613D9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:52:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r21so17316702qtw.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hxFjpBHdyDsmFKBK9zFmh14eHyHDBh6F5WqB60fERiE=;
        b=W0a8FcLOK+KqaTZBt/P6bLIypCzBJ1eVPuOKG2VomJiTjxDYKwptWCD5JWEQilM0ia
         kqUkK25o1iWBjJ7QracFSMxWWrLW88ZDSx5yXNJc2MOo4ofYi/3rAf0dnFvdPN+Na99Y
         GSkTpdjaSZWOf7PRQ3FIv+uUygDnOMjHCo8apbDeGHzjehX+G2R5pp/Q62S41d3mj967
         7pJLqMwgdyqwEVe137ISVXH3tNMJTY4yuLFQYQziT3XVUpckgSNs7C2lz23YzqgAJcfp
         BnEHBQbgnfddBOZQZRzjvoXYQ1NU69YX2sUMZlv9znfCvjzzy2DAqd6XkpM9nQOF57Gj
         TwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hxFjpBHdyDsmFKBK9zFmh14eHyHDBh6F5WqB60fERiE=;
        b=KLXOBlaPEiXJxd3upGLYsmaMT1hlISoiyvPCIxU3YgnHxNfgwEwlAWUSQBC0X1LbwF
         i22hGMC1elY63HO3oM1KpS2QqBVIfEQpO7aGkUmbm39+lmtviW7xiIxtRFdOm1xcDaAH
         GT4H9B56M4ETk29xMljt9ETcbUbxaF5DfVRVGPco48UQ2Xbxt0AikKiTt6sb30+tAgLK
         sqNgs+rTJS9pJTw5e0LcEQ8XDpDso8LRoFGjVQZmeRDHk25ZzrzS5eyKazdeAE1Atq2k
         Hcogd/FSWp473dPNslOfRbeWylzqF0i9gYypzqvZfswI4msCDlxrnQ3J9EQBwEf0O7xw
         wnTw==
X-Gm-Message-State: AOAM532EcobPyvMHL17e13CFWhqIuB67c8NqGfzYxYDW/gPK2zvknTl+
        sb4/RcKFyqScEzwliZEWJOU=
X-Google-Smtp-Source: ABdhPJxxs77RHbSk2ykvilLHj3qwRTmDjeLzBKscZHZ5VSgxA+nEBqXxenaKWcD7+AHoM/gOmPhHaA==
X-Received: by 2002:a05:622a:138c:: with SMTP id o12mr35804998qtk.346.1629823935725;
        Tue, 24 Aug 2021 09:52:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id h24sm3029717qtp.63.2021.08.24.09.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:52:14 -0700 (PDT)
Subject: Re: [PATCH v4 09/10] serve.[ch]: remove "serve_options", split up
 --advertise-refs code
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
 <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
 <patch-v4-09.10-c9a35868933-20210805T011823Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <17efcff7-9a62-046b-ecf9-2cbed84280e9@gmail.com>
Date:   Tue, 24 Aug 2021 12:52:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <patch-v4-09.10-c9a35868933-20210805T011823Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2021 9:25 PM, Ævar Arnfjörð Bjarmason wrote:
...  
> -struct upload_pack_options {
> -	int stateless_rpc;
> -	int advertise_refs;
> -	unsigned int timeout;
> -	int daemon_mode;
> -};
> -
> -void upload_pack(struct upload_pack_options *options);
> +void upload_pack(const int advertise_refs, const int stateless_rpc,
> +		 const int timeout);

Normally, I would err on keeping a struct that presents the different
parameters of a complicated method, since it is easier to add options
without modifying all callers. However, in this case we already had
some confusion because the 'daemon_mode' option is dependent on the
other values.

The fact that these parameters are translated into a 'struct
upload_pack_data' immediately within upload_pack() shows that these
can be grouped into a "context" object for internal use without
needing this pattern for the method signature.

Works for me.

Thanks,
-Stolee


