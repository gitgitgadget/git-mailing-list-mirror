Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE0FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 19:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiJ0TwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiJ0TwK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 15:52:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF2B85A83
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:52:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n7so2692445plp.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K1kQgzTfZZPUk7ptBvsvez61xyYqC4tuL8uXS1NydY=;
        b=WJmSKBCZIbMoiNhinluRcx5uDVDxFk7Nastbterh02eCpnaOKV2D9C2lnwaFxa0be1
         qQ7mtRIXN8Xl+UbXX+b7vBdVTmXbyKktslfCB9xNtFwuLZuVuGA7+R/Muyy7LzgM3zIk
         glAJMDdI7a7VfRLwo1sNrvND6+btYKx89fqAc1+mf8Fkep9/ULwZvHcbqI+1MfqU2MXX
         NSRwVOu/UBJAye9bdabiP6a2mfuvWqmbMulEKm3rxoMlhgovI73ZxyGkolpNOonuQtjz
         8lZgp/Irh2gooVeLi4q8PYA4X9mZ3qgBqEpuzuILIGsZYcHUZjxIvtJ6McpSCp+Z00Uy
         6HFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K1kQgzTfZZPUk7ptBvsvez61xyYqC4tuL8uXS1NydY=;
        b=cPt4oWB/T5/Hfk8cAtu518rsldiUAb2WZraFWV45qzAs8iFwvOqo71TKojGO7DX0LB
         zFmitT+c/43ORbGuTlsWR8nyNf8XuU4AZtdwNf5PmvhinsHB2l2zcMkH9vCc8ogEFT3k
         ODczm24bqeBlJfN1040FGS/hpkzWMjKoiLf2QYA6llcVyNu80Cp8+2SLq358/kP+1Byh
         I3SnRSyV0Rp1CmnA8EGpOH1cHmExnesK4Wk/qF3eqs87M9yE0BsgpYwgOQl4SMJWnhre
         hietFdex8641qYTK1O19bRUZXCrtDSlPGdsZsejdwUQx3si252L/YRxZ4hWQMo/MmF8I
         ZDdw==
X-Gm-Message-State: ACrzQf0EEIwkI6jX0Lhe+njsQEoOkh5wnPUmAYQeLHY3dZl6l+NK7pii
        2+4ao+iWDaq6O2NcH2S39iSmJITM720=
X-Google-Smtp-Source: AMsMyM7VKkqtGEAGYvg14OhqUC/QPiMste93E0Aj57UOW+gx8uGTs7LHKko6x0e1/0JFFRYDtN9CSQ==
X-Received: by 2002:a17:90b:3ecb:b0:212:ce31:33c3 with SMTP id rm11-20020a17090b3ecb00b00212ce3133c3mr12139259pjb.53.1666900327104;
        Thu, 27 Oct 2022 12:52:07 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b00186c54188b4sm1539679plk.240.2022.10.27.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:52:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 09/10] config API: add "string" version of
 *_value_multi(), fix segfaults
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
        <patch-09.10-bda9d504b89-20221026T151328Z-avarab@gmail.com>
        <xmqq4jvpkpxd.fsf@gitster.g>
Date:   Thu, 27 Oct 2022 12:52:06 -0700
In-Reply-To: <xmqq4jvpkpxd.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        27 Oct 2022 12:49:18 -0700")
Message-ID: <xmqqzgdhjb89.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Fix numerous and mostly long-standing segfaults in consumers of
>> the *_config_*value_multi() API. As discussed in the preceding commit
>> an empty key in the config syntax yields a "NULL" string, which these
>> users would give to strcmp() (or similar), resulting in segfaults.
>
> Sounds like a good idea.
>
> I would have called them _nonbool(), not _string(), especially
> because we are not going to have other variants like _int(), though.

Actually, I take it back.  Instead of introducing _string(), how
about introducing _bool() and convert those minority callers that do
want to see boolean values to use the new one, while rejecting NULLs
for everybody else that calls the traditional "get_value" family of
functions?  That would "optimize" for the majority of simpler users,
wouldn't it?

