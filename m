Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA2FE81E1B
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 17:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjJFRDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 13:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjJFRDr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 13:03:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D7AF2
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 10:03:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-503f39d3236so2876240e87.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696611824; x=1697216624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PYXIRKmDebMWCiL4uQjwLWgEU0Shxi91ajfJGvNoDDI=;
        b=REbNmnlKaXPDS8KMPJVszWgW9rnu4V5wHvEEtMMHaR2Rq73bQoA3SzEINRmfBZ5v4H
         zjGFglfKzRRd3DHNbQ6Vrhi/vB0U8NNiVOPbGYYZb9GpPTZ+/5LVEQ7SCN2hZfwd0vQw
         LNmdec+0Qz9u4XZDXBsyzzMgvlnuWp8L/YK0hPX/XRowz+Nryb3qQCgJ7ox534kbWaZw
         poaZz87mW0rgBULr12Q1TcmBEU806Jb8TDogE8t9aBuO26DnQY6cU2eNTN9y18X2NdQy
         TON2PQIexFCW6c33Ms071xahSdxfIY3QyHYVa2VDwqqHO0NU8xCTLYRyRSC2lmQ+Qtln
         HA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696611824; x=1697216624;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYXIRKmDebMWCiL4uQjwLWgEU0Shxi91ajfJGvNoDDI=;
        b=jXL3e5xPuGW2JEDoV7PaZCZasSNJqC9qpFqzUKwf/PwsAQ+zytaXwAgbcIygfVuxyV
         bQIuBXFSjBauLA2ztL9H2F2AWuPfWD5zgOm+KXtQ0jIAbqrfpPQB1NNj4DscQHNEAYaP
         rFrQiWZdQj+Tb3sCpQnBa8cmnVfUGE/dP0SnKTZepZYeyvlxA8Pv3o2QnIBTiS2j+XGN
         wRl79OErOqnYHFk9J4RCVP5YYMgy0eiVzfjxM8TDFFBYITduOQ1DMVRI96A1NuRSOaiZ
         bDg4T6bW3bXx28305Lpfad9oHIZqRY09+JlOjgg+bYEt1ySoa5GtNQp3AYo+WAFDtu3g
         HLcg==
X-Gm-Message-State: AOJu0YzcmhTnC3L7hdn58dIGi303TLcXEfffftwa4ML2JUuvdZAgys6n
        fn2itOkHpBxXmv+iDI19wP152GFZWKQ=
X-Google-Smtp-Source: AGHT+IEFSGgTeWtmJGxmM5osxDvTiOjtEM6OeCjSZvn6QDnZnKZGehUJy8Kb2ve4rJJiTTCtWjkm/A==
X-Received: by 2002:a19:a414:0:b0:500:79a9:d714 with SMTP id q20-20020a19a414000000b0050079a9d714mr6582209lfc.65.1696611823859;
        Fri, 06 Oct 2023 10:03:43 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t23-20020ac25497000000b004fe0760354bsm363758lfk.275.2023.10.06.10.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 10:03:43 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
        <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
Date:   Fri, 06 Oct 2023 20:03:42 +0300
In-Reply-To: <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
        (Elijah Newren's message of "Fri, 6 Oct 2023 07:41:51 -0700")
Message-ID: <87zg0vr8cx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi,
>
> On Thu, Oct 5, 2023 at 2:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>> > ---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
>> > +-m::
>> > +     Show diffs for merge commits in the default format. This is
>> > +     similar to '--diff-merges=on' (which see) except `-m` will
>> > +     produce no output unless `-p` is given as well.
>>
>> I think the sentence reads better without the translated (q.v.) that
>> confused Eric.
>
> Agreed; confused me too.

Will remove, no problem.

Thanks,
-- Sergey Organov
