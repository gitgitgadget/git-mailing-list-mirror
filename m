Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28592C636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 00:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjBHA5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 19:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjBHA5t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 19:57:49 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE62D60
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 16:57:48 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jg8so7733390ejc.6
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 16:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ioreKMVPdZzF+J/sB4IzQEn/D5V/CJ/R1ST7jRg4hTc=;
        b=EqY17hGGb3KX3nGsJkHPRVqjy+ddC6JH2m4C+xYvlzkLuM5T94ZtxX01Sf9Qu2lOea
         3JDvBR0HS1K9FkIHpHPeRUQmZm1R07FizNGybGc6Rr2+VRmv0IhHcT0h4eEcIzmfb7PQ
         y6exL5kHydMQ4kRQq3TsbUOYAca4WXRERux36vXXcp8+RFHrIOKZqNhgoGnlq+yWMSQR
         NlgkWUVtIZ05WYMUVVFJ95a2wE8to7P6CJJEjYipMlIrsRUJg1UDsbTOekKoSIZoNV0P
         RtAzU2VL6AxtWMx6LI9RN3sfVZwTfhzBAqlis5onE/+9F7Vm9Ed8smlayXtFPXiDS3yj
         qPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioreKMVPdZzF+J/sB4IzQEn/D5V/CJ/R1ST7jRg4hTc=;
        b=xEVaIbpUX5KLvOaENzTKGG2roKR36zOYUPMOx6TH4e7eluem0yuv37KPnJ1QBU81I5
         6H1P2KJ0fUeFcESBgOpWXIYlqNNM7rA8CRaf54UPblFHAyI5kwM/fiaNRXEjnwUglCyl
         eYBHgtUaERmXq6TjJ5jlcUuaxwZv79i+UAhGqn1oWG+2BumI4Qlhaivh0GW31cbdXvs+
         47tMImUTNGJhZTq7UhReboXMuXOmzVoa9rswbJQj67QZ8Kp7+6zKr8tvFfEch9BCWy5y
         /j4VUnpR837F0Bn44J1WEqYek44UMLbqa/RXPnjLTvrE86zHksraIMrajv5wKEsOUqQD
         myng==
X-Gm-Message-State: AO0yUKVLE5wrIR6dCGfFSEecxP79nIj+9eKXGyfTpAY3y2dCkdFT9vma
        PJGQAxuAS1HbCvAi4AvhdUuKrpsklQcVqpFf
X-Google-Smtp-Source: AK7set99Yr1CrbdXv3DGDUIIMVD6JCIPH7CgZReC5/GY6qdK2G1IUGNJjjmFe5ijRNkEQqBRGKpiEg==
X-Received: by 2002:a17:906:70c5:b0:880:5ab7:cb76 with SMTP id g5-20020a17090670c500b008805ab7cb76mr5276292ejk.33.1675817867062;
        Tue, 07 Feb 2023 16:57:47 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id t4-20020a170906268400b0087bda70d3efsm7550196ejc.118.2023.02.07.16.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 16:57:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPYmQ-00189n-0N;
        Wed, 08 Feb 2023 01:57:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v7 0/7] submodule: parallelize diff
Date:   Wed, 08 Feb 2023 01:55:35 +0100
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-1-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230207181706.363453-1-calvinwan@google.com>
Message-ID: <230208.86edr10y9h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Calvin Wan wrote:

> Original cover letter for context:
> https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/

I went over this, noticed some issues, some nits, but definitely some
things worth an eventual re-roll.

> Changes since v6

I would very much appreciate for future iterations if you can start
including a range-diff to the previous version.

> Added patches 4 and 5 to refactor out more functionality so that it is
> clear what changes my final patch makes. Since the large majority of
> the functionality between the serial and parallel implementation is now
> shared, I no longer remove the serial implementation.
>
> Added additional tests to verify setting parallelism doesn't alter
> output

I could have, but didn't manually apply both v6 and v7 and produce a
range-diff, having it in the CL would really help to track the changes
across re-rolls.
