Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33C3C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 14:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F9820782
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 14:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+NPdhB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHYOi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHYOiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 10:38:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122BCC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 07:38:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k1so669313pfu.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x6FvonCS3DQfYgnBM3C09227BsHg9T/E7n1dLImHnJg=;
        b=j+NPdhB3hKKRbinzkwD1VekAJiqwux4+uncPZcZdi1K8GIFGvxQIAyPuABG+G7ruzh
         e4i80rAxPjBvFHPt3Pvf4lHBRgU4qQecVwVu0oRZkhqmIb9zbxjKMPGd/YozVxkqOIvp
         iO1LfFG5mw4WoleVd7yl8WWfBFJQsA0czWfBJ9jfBkBWWFsafb+uxnNSmGrS7VzfYlLX
         IDv6SeNwQYHpAky8eiVenQkTi44ijllqj+yr4szgSmMe4ePtWks1l1QSMqoSaI0r1hun
         FLq8+pBtvJjv10GEudqknyHoZr7r1H4cpafP5EZvrg9B3lmmuTUunXAVFWLPQZoxUl/L
         g97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x6FvonCS3DQfYgnBM3C09227BsHg9T/E7n1dLImHnJg=;
        b=SDQ4xEKcxL5/NWaQvh0btogt6EZ4FCQJIMIhQWn3KDs1o6FhFjjzUla197m+HtETJo
         93eWc/GbziBMfB0s2k2DDUUVRbgpGDrPbw8OJKC1VsH9bTzPcBKIUwiQo5OoegEU8KEt
         JqJLv/MJEg1Ipj451xNS07MVSdbUDKXz355YcZyi37e+DwB2rdwFQFEDS9TMxTappMOh
         38gRcrMR14CKNNdHtYLbHu+tdLwUHGsWoCUmDI28yHXaZIa677GV4zQ9a5fB1QFexQR1
         h61iV2fct6mbPzV5/PhTFj2IKVLnFqBOC4Fljoskg2FCKR2Ju9S4s+TuVNZqvVL12Hsj
         TPrw==
X-Gm-Message-State: AOAM5323TOO3+c0iyERKFXX2I79knJqOZyycoMfuVqbotJK9Mx91NpKw
        PMjS02fnbKGE6UyXjup0YnE=
X-Google-Smtp-Source: ABdhPJwk3A5YZUTUlrXRMao2fWBMMhR2+WoLBUPsWj5qdv+r3jFDe6eBM9WXYKPe4+LQ63/pgvYkHA==
X-Received: by 2002:aa7:83cf:: with SMTP id j15mr8040437pfn.251.1598366301604;
        Tue, 25 Aug 2020 07:38:21 -0700 (PDT)
Received: from [192.168.208.37] ([49.205.78.114])
        by smtp.gmail.com with ESMTPSA id q5sm13199557pgv.1.2020.08.25.07.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 07:38:20 -0700 (PDT)
Subject: Re: [GSoC][PATCH 0/3] submodule: fixup to summary-v3
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, peff@peff.net, liu.denton@gmail.com
References: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <93f9eec6-dc77-01f2-c2fe-2f02b97f853b@gmail.com>
Date:   Tue, 25 Aug 2020 20:08:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25-08-2020 17:00, Shourya Shukla wrote:
> Greetings,
> 
> The v3 of 'git submodule summary' port to C is currently in 'next'
> branch of git/git. Recently, the patch recieved some comments from
> Peff, Dscho and Kaartic:
> 
>     1. The definition of 'print_submodule_summary()' contained two
>        unused parameters namely 'missing_src' and 'missing_dst'. Hence,
>        I had to eliminate them as covered in the commit a22ffa950f
>        a22ffa950f (submodule: eliminate unused parameters from
>        print_submodule_summary(), 2020-08-21). Reported by Peff.
>        Junio also advised to make the output in case of an unexpected
>        file mode a bit more user friendly by outputting an octal instead
>        of a decimal.
> 
>     2. The function definitions of 'verify_submodule_committish()' and
>        'print_submodule_summary()' had wrong styling in terms of the
>        asterisk placement. Hence it was fixed in 32934998ee (submodule:
>        fix style in function definition, 2020-08-22). Reported by
>        Kaartic.
> 
>     2. The test script 't7421-submodule-summary-add.sh' failed in
>        Windows due to failure of t7421.4. Precisely, the 'test_i18ngrep'
>        check failed on Windows since the error message which was being
>        grepped was different on Windows; it was designed to work on
>        Linux. Therefore, we had to eliminate the grep check in t7421.4
>        and replace it with a check to see if there is any error message
>        or not using 'test_must_be_empty'. Also, to support this change,
>        we had to make some small changes in 'print_submodule_summary()'
>        function. The call to verify_submodule_committish()' had to be
>        guarded using 'p->status !=D' so that it isn't called when the SM
>        directory does not exist, therefore, the error message is not
>        displayed. This resulted in 82e0956cd2 (t7421: eliminate 'grep'
>        check in t7421.4 for mingw compatibility, 2020-08-22). Reported
>        by Dscho.
> 

While the cover letter is nice, it doesn't make much sense to refer to
patches that are part of the series using the commit hashes of their
"local" commits. It's more common to refer to them as using the position
of the patch such as [1/3] etc.

-- 
Sivaraam
