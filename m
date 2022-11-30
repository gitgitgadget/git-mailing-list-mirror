Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A60C4332F
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 04:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiK3ESI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 23:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiK3ESF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 23:18:05 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12864E41A
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 20:18:04 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w37so9827694pga.5
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 20:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ole8B7PIQiStquK720H8x8clNd+TewLeGZiPYF9eUY=;
        b=qb5ViLVTcUr+3GFo6qykejV9m9HQs8qRqo5rz/KQSbBLg2+TPxp95HT2RMNv+Qn2UM
         Df9JN7EvlK0cx9ivnRwRYS1pR1ijAk+m1CQDK4dlYR18LbCE8ODUOqlerBrKlkaRlmD3
         wIevdKUEslC9UBUVfPyC5TGlGAXTMMh6Juf5tLoNHzMAQReNDFjglzs2DEfHgPK4Dv+6
         ly9b1Xlt+BedeSeSS6jKE0s1vbam7ze+fWg2nWUUp9QlU2n9FVlj6Iz+7Lsyzhu8W5Q6
         ca+hY39ZYAY0+lPvbzPx1kh6IudSiQ8hRZx/6dtYOFRML6eWALHki3RXLg00eyHZoDav
         vDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ole8B7PIQiStquK720H8x8clNd+TewLeGZiPYF9eUY=;
        b=k/guS4FfRwRC6yykUHqaY0j/ynWjG2bM85KI3EcOYsg3wvxNEcf73ReHXcYAQGCdjZ
         J0AkjGfKLYUqAsedTJnc475vT5jI1KquAVh3AKWCE/XlYist2P8/Hlcb06DfuKfjbfIk
         sT9NTgVxmOlOeL2kZ5R2TgGxpBmF6ka9jjqDbYc+RXHYr2+MZ+WNfwopUP2UjKFXJV1t
         3KAzF6+MxYKvoCgLTSU8SioadqHPQNekMZmeaiKJ9L/8l3tYU42r/FGq+R6eP/QHTzVa
         eZc65kbppSovbFZz1UPVJlM6HlMdAPVGSxph5bz0LDoPSXb2k4tBNj3TErE2rL0F4deI
         KZ+g==
X-Gm-Message-State: ANoB5pmfLzPX4qXGu7Ps4FHlM/1gt+cUM4AR3RETXwStwPhSPEiMSFXe
        aeVUv80Y/aG4ZYA1n++qaDO9njYntZbeAg==
X-Google-Smtp-Source: AA0mqf7psQfGBPuf8PPZjWc6Ca2tSGQCZA+L5HIWqUW5+RDO/8UZhqMLyFAhq7fKsm6b9ZeV2m+TyQ==
X-Received: by 2002:a62:64c9:0:b0:575:19c6:a79a with SMTP id y192-20020a6264c9000000b0057519c6a79amr15302814pfb.68.1669781884138;
        Tue, 29 Nov 2022 20:18:04 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b0018996404dd5sm144197plg.109.2022.11.29.20.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 20:18:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Paul Smith <psmith@gnu.org>,
        Alexander Kanavin <alex.kanavin@gmail.com>
Subject: Re: [PATCH v2 2/4] Documentation/Makefile: avoid multiple patterns
 when generating one file
References: <20221127224251.2508200-1-psmith@gnu.org>
        <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
        <patch-v2-2.4-e232f308e40-20221129T140159Z-avarab@gmail.com>
Date:   Wed, 30 Nov 2022 13:18:03 +0900
In-Reply-To: <patch-v2-2.4-e232f308e40-20221129T140159Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 29 Nov
 2022 15:09:15
        +0100")
Message-ID: <xmqqpmd5yt1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> From: Paul Smith <psmith@gnu.org>
>
> A GNU make pattern rule with multiple targets has always meant that
> a single invocation of the recipe will build all the targets.
> However in older versions of GNU make a recipe that did not really
> build all the targets would be tolerated.

This was in 'next' and was merged to -rc1 already.

Thanks, both.
