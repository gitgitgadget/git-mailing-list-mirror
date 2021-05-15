Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E82C433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 14:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA5E6127A
	for <git@archiver.kernel.org>; Sat, 15 May 2021 14:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhEOOpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 10:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhEOOpG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 10:45:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A63C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 07:43:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n2so2005688wrm.0
        for <git@vger.kernel.org>; Sat, 15 May 2021 07:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=dV4SyTrTkBVKmFNZ9Ay8GUFiQ9WvNrM119ru/CcIl1A=;
        b=PqD/aJMcfQVDGLS+J1ho3vg6u9ZqD3Ng8dZVMx00Rmq13C/OuAaD1shqpWJVk3AxbS
         m6NuQEcj+jFruTRrHt5nTDWfOrtXOtX6Wcl4x6t+Y6Kr1eYv+m9Jyh9GvRYQtGBELAcc
         4kgXMQ5jpEPUJkoZyiV31jHj65coeUV+hZjwt2iwOKpM9lFGT25A9HMLUH+rwZjCgQVN
         cXPnH04sVcbNqa2/IP+vPNoX/sw1NtcLMjnECir8PGOSqNBafrEG0pLpt/nQdIMLo4AL
         lQMbFYAj3NvKflRkqkwXVwanApnZepr4pKO3QKFQRS06Vsya6B7WFFr4XWGPdAw0qFwj
         TNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dV4SyTrTkBVKmFNZ9Ay8GUFiQ9WvNrM119ru/CcIl1A=;
        b=P8C8mx/27WnaBN0d9jy4HB8cj2g/f41JJ9iSzxZExD6kHGlmFCXsty0LO3GCSzc2Y3
         Vem/ICki/hNy4PT4OCFOJ4bH27BCMiQebsZe1u+ZZycUHx4ZFkWMiBf3fFCRtmWHlelp
         X1NplXR9bmwvcma7BdJzw099t3b5whAwBbO2f5trKPdi0i171MxUp2+5eYYcLNIoCIzd
         k+1tB/E6SUlfjiZEsvG0V0jMzIUyFAm1+4Kj5OgIjSqAdaWabOoVNsOJJHcpgkC3UYuH
         Dvh71QsdRvh/Y5CjZ5LpeYIxoIEIsaJps9iyY2M8MfoE35Vri5FdtHcA3Wzim/I5yYil
         RlIw==
X-Gm-Message-State: AOAM532XOIODVQzwTvEDV+UQfVYgcs4XyXDbNuvY64fVV0JsUJtr9FyB
        QjBcPLsJY8SAeDSihDTWRrw967aPF44=
X-Google-Smtp-Source: ABdhPJzMX2s6A13wbc2P/fioNfo+ddfbNrM1/gbApG7ZbBiIl5pcH+GGKDPI9q3DSVAo8SpbYn7C7Q==
X-Received: by 2002:a5d:5989:: with SMTP id n9mr63850742wri.60.1621089831444;
        Sat, 15 May 2021 07:43:51 -0700 (PDT)
Received: from Inspiron (2a01cb04010c42001504451e90ab6b33.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1504:451e:90ab:6b33])
        by smtp.gmail.com with ESMTPSA id l18sm9617463wrt.97.2021.05.15.07.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 07:43:51 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/README: document test_config
In-Reply-To: <CAPig+cRrVN0cqoRFA90XYSsDcJ-PZxLMNfFCye4pUXz47AhpYw@mail.gmail.com>
References: <20210514065508.247044-1-firminmartin24@gmail.com>
 <CAPig+cRrVN0cqoRFA90XYSsDcJ-PZxLMNfFCye4pUXz47AhpYw@mail.gmail.com>
Date:   Sat, 15 May 2021 16:43:49 +0200
Message-ID: <87mtswf462.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 14, 2021 at 2:55 AM Firmin Martin <firminmartin24@gmail.com> wrote:
>> test_config is used over one thousand times in the test suite, yet not
>> documented. Give it a place in the "Test harness library" section.
>>
>> Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
>> ---
>> diff --git a/t/README b/t/README
>> @@ -1046,6 +1046,21 @@ library for your script to use.
>> + - test_config <config-option> [<value>]
>> +
>> +   Set the configuration option <config-option> to <value>, and unset it at the
>> +   end of the current test. For a similar purpose, test_config_global for
>> +   global configuration is also available. Note, however, that test_config_*
>> +   should not be used under a subshell.
>
> "should" is perhaps too weak of a word. test_config() will not
> function correctly at all (just as test_when_finished() will not
> function correctly) within a subshell. So, perhaps say "must not be
> used in a subshell."
Indeed, will correct this.

Thanks,

Firmin

