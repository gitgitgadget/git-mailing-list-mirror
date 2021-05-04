Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2D7C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00761613CA
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhEDR13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhEDR12 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:27:28 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425C6C06174A
        for <git@vger.kernel.org>; Tue,  4 May 2021 10:26:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t8so9543389oij.0
        for <git@vger.kernel.org>; Tue, 04 May 2021 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dmmP5CaGIsVGIIqwkd5WC2LVg2SyBVcXfA1Z6ZYaPRo=;
        b=Y4ygHueWTfy4pp7WNypqjMgwuZGEXTMcnMBkxEbo7D3gTbyLRg60sD0h1GZaVyJd0y
         ZMD7U71Tilyaw4drM2ao7KEndA11J4At+h4rwNDborF0Uao5N2ZmETdn3Sb8mXrMl94j
         H+E403izKjt+q13HW4lcnZXI63EgvFYLVzkrkhcxqUf/BJobWNufqTmmmS6KgXkv4I6X
         ENTjnYcsZV4mb1U1o4GyzyKd8TAt9oYNfxt+8dvZUWSNs9Mxzr0Ypj1oPTTzLaFPMQVL
         WvkeyTZGBK8x+TlNGQMEfJAwR47wx+TpWCHpOh48KrQJmpPsEbBIAcOZS2u3Fs/oaLj+
         TCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dmmP5CaGIsVGIIqwkd5WC2LVg2SyBVcXfA1Z6ZYaPRo=;
        b=KbQLty3l+Vn1pUrtnOR6aJ2QO+3leQ14WO73GKFFa1DRazMUwIJj8qTCXXU8z6X6Qw
         Zswsrikmb8/zyZKX2mXCLyJ+kfRCRwZ2HVHpBnXBYPM23z+L9iyg9UdXWAmCZmcs60Wq
         rgEbaEvFP4Z5I1l0SVJXrATMfRSFF2NkO2D6AbqsR+Frx/FPeupm8RyXRVGkc6LsMf9p
         XjQTmGDdfOtsCqDGIHT41252Pz5Y5rbPSNLN0cU4CFdLqaYxC9Kvd4QARvQR+ywCNVtv
         EySKEYWbjW+oXRo75hUeWPCD9xOVYJ2fcbaOulaYbko0Yw76cTFhUXAvDiQ2QRo+jvZR
         rZZw==
X-Gm-Message-State: AOAM531NxNgG4SklU0LM2ORQ06ZA8u/uRAYe/b+WPc42uhT59jcTv52n
        kKqN7uWh36hpDhhh+HjYYrhPHhSbAHzang==
X-Google-Smtp-Source: ABdhPJwD3pYgR/XJxOrx3yuXbQtSV6CN+fZNfjlPVWQq5ZTNavhwPdd1hAVABu/RAUkRke65IYLFkg==
X-Received: by 2002:aca:2813:: with SMTP id 19mr18948586oix.80.1620149191336;
        Tue, 04 May 2021 10:26:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3c2f:d08:255c:f797? ([2600:1700:e72:80a0:3c2f:d08:255c:f797])
        by smtp.gmail.com with ESMTPSA id 68sm879262otc.54.2021.05.04.10.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 10:26:30 -0700 (PDT)
Subject: Re: [PATCH 6/6] send-pack: support push negotiation
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <c2780570-81ec-bede-2f4e-75748b788bbb@gmail.com>
 <20210503220244.2878522-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <70ea6b85-bc73-3f39-3449-9c08f6738a73@gmail.com>
Date:   Tue, 4 May 2021 13:26:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503220244.2878522-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/2021 6:02 PM, Jonathan Tan wrote:
> [snip asking about whether extra_have (a.k.a. advertised) and commons (a.k.a.
> negotiated) can be merged]
> 
>> Here, it would be nice if extra_have and commons were merged before calling
>> pack_objects(). I mentioned a way to perhaps make that easier above, but
>> the context might not make that be super-simple. Running a loop here to
>> scan 'commons' and append them to 'extra_have' might be a sufficient
>> approach.
>>
>> Generally, this approach seems like it would work. I have not done any
>> local testing, yet.
>>
>> Thanks,
>> -Stolee
> 
> I was reluctant to merge them because that would involve either (1)
> adding commons to "extra_have" (as you suggest) or (2) iterating through
> "extra_have" in order to add it to the "commons" set. For (1), this
> would modify "extra_have", which is passed in from the outside. Looking
> at its callers, the main one in git_transport_push() in transport.c
> calls send_pack() with a set that has traversed the transport API, so I
> think it would be confusing if such a set suddenly changed. For (2), the
> extra loop seems more troublesome than having two parameters with
> clearer names indicating where they come from. I don't mind changing to
> (2), though, if people want it.
 
I suppose this concern about "ownership" is valid and worth having the
two parameters in the helper function for extra safety.

Thanks,
-Stolee
