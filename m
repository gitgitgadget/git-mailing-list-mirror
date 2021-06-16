Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF214C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 09:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22E86024A
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 09:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhFPJ2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 05:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhFPJ2w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 05:28:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85372C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 02:26:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k6so1690202pfk.12
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sSITp+Z5rJhgcditxjVRFbtXQ7IZ1sWJ+ECQOPj6Wpw=;
        b=Ocg5BvKu1ZhkmLsTbxUyNtXc6m7FeDvrG3i98QFFf799fFLnKU6MzcJZlXTh2TyO3S
         LgyBVtMgFYs7DGzQi9ibU105lUk6drsdTJh7efWSLU3xAVEFJzGV1MGOeQSwEOSX4JmF
         wpA4/3kNTzBMY2dsf+TAvRKV0eMpd++fJoIZ2esd/aiKKPeIoKyKREMOfy0Zr/cLab24
         6C1TMU2mH0HsoOgiUh+NBvZyd+wPBqaHp3bRPuUJ5J+v21qPvnh+EpIpMU9X46ZfdHXy
         hqNTh3Ke+deQOkAA8bKJbDO9oYOjTTmNntp6DSr3KYUr5kZvrA9euXD3J4VXsxIXui7w
         0bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sSITp+Z5rJhgcditxjVRFbtXQ7IZ1sWJ+ECQOPj6Wpw=;
        b=qP98HTD4MIMpP0jBKqnWP2eyBe9+HhomWgFu9Ne3ydhw6qCm12R1BMFLzVLXaqn6Lh
         e96u6EbneB03bsCNg39pWfMXovh8YirrtYzJ2zktgqphwiSMvqJPmTWPo9O0SKP32+Fm
         uY8CXe8Krk9z9NLZj6LZdfmMtjXlLOK3vw+VX9quY93nEgByOYQNrtn7B4VGYWywweJj
         eTwlG0lENEsh2uFagqKIWbTzPZhSqBtGW3ScpNJVSEHFtJ+IeW5HT2xSEedyJB4IzjiM
         pWgOixkhkZ6tr/HyoIWQQoBWDsCGrtgF5uE+MNthCavatmvzHoKE9ii2Ww9ZBe/Y6j7h
         fEyA==
X-Gm-Message-State: AOAM531dSuUC4GUDY6eQBLWaS3CiBT8fWCegisE9JnOupyn8NhvNOvRJ
        putoEcJ7psMagjv98wM2F6k=
X-Google-Smtp-Source: ABdhPJz+6FNGxYPAaSULLCjyBNSK2oi6oQPPFZJV2HnT1XbJXrcUpPKnvxr4rB2AQOqem4LeHx0lJw==
X-Received: by 2002:a63:d452:: with SMTP id i18mr4141965pgj.0.1623835606048;
        Wed, 16 Jun 2021 02:26:46 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-90.three.co.id. [180.214.232.90])
        by smtp.gmail.com with ESMTPSA id m16sm1712354pgb.92.2021.06.16.02.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 02:26:45 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com> <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <ebb018a4-5d97-6cd9-9d9f-92095f1cf44d@gmail.com>
Date:   Wed, 16 Jun 2021 16:26:38 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqbl86qtyf.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/06/21 12.06, Junio C Hamano wrote:
> +  - If you still need to refer to an example person that is
> +    third-person singular, you may resort to "singular they" to avoid
> +    "he/she/him/her", e.g.
> +
> +      A contributor asks their upstream to pull from them.
> + > +    Note that this sounds ungrammatical and unnatural to those who
> +    learned English as a second language in some parts of the world.
>   

I'm also confused and found that using singular they may sound odd. So 
IMO either avoid referring to third-person singular (gendered pronouns) 
or write using plural actors. In the case above it should be 
`Contributors ask their upstream to pull from them, potentially with 
reviews`.

A prime example of rewriting using plural actors is in "doc: avoid using 
the gender of other people" patch [1], which said the diff:

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 55287d72e0..3e215f4d80 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -373,9 +373,8 @@ If you like, you can put extra tags at the end:
>  . `Acked-by:` says that the person who is more familiar with the area
>    the patch attempts to modify liked the patch.
>  . `Reviewed-by:`, unlike the other tags, can only be offered by the
> -  reviewer and means that she is completely satisfied that the patch
> -  is ready for application.  It is usually offered only after a
> -  detailed review.
> +  reviewers themselves when they are completely satisfied with the
> +  patch after a detailed analysis.
>  . `Tested-by:` is used to indicate that the person applied the patch
>    and found it to have the desired effect.

I'm OK with using they in plural context, but not as singular they.

[1]: 
https://lore.kernel.org/git/20210611202819.47077-2-felipe.contreras@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara
