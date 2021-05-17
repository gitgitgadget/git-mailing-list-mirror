Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00274C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 20:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CDC61002
	for <git@archiver.kernel.org>; Mon, 17 May 2021 20:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbhEQUNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbhEQUNL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 16:13:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C759C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 13:11:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w15so8756778ljo.10
        for <git@vger.kernel.org>; Mon, 17 May 2021 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Z1ZFD+RsPO/uEB4UOp64/Uc211w9dPg+Ybiyo4zepiE=;
        b=YVrrYXpS69UJgyh+qKUHANbVVdukv+dhQMtI4kaHoqC4zm2BMpgQiphf6ghfjMID/b
         xB6KwqRCxj0fiyedxNTsGdkQzjFCnxWtY4v8b7XJL/RY29ODOgY3amPcdeCuJcjwlZ94
         RPoavEGLwX8r3mKP9iLsMKDklc191ackORHUB7+4dLUxCrGdBBcVjPoKYrhij/WzOaN2
         /Fpi6Cyh38Va8UJcWPau3jV5d7ahhPJoNLkwuHGg3wG/Y3ZTVIcDeJfJYWQRO0SarH2B
         qJo96W1Dqpmv0h0Sq8J9/deE9iAT0xsDlG4+WP5nODhw5uOVv/DZHYwXNc0gIYijP/SA
         xN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Z1ZFD+RsPO/uEB4UOp64/Uc211w9dPg+Ybiyo4zepiE=;
        b=CPot8V6h0WBbv0t5TGhxBWn0wXMlJlPOaODmksYz2ycTrqp4NwMN9n40ZBLFvXpkH8
         G2A3oLX27vkMtLHMUfWxczip8pkZYCqSq/1ktJ8WuxSierBfhpSXziov4VjrhIqwbknm
         pHI8dCqLJJ0GR5HowZX/wkQq6bsf+UoqVKlFwHtwH/A+F6lcF4XGv6eyv/KZnTq3x4gm
         sqh7m6Eino2crs+7e0EqrhNo5d5suRbfAy0hP3Krmm91PJKcQooCvITsiX8tCJMTL4Ms
         TaYuGRU54z68y1FOdec76NR8sreop0XTS7QzVNORNo1kIZGj+BCwWjh24+fVLwc1dA4X
         M0UA==
X-Gm-Message-State: AOAM530W/H/Unk0UGrvn7u3HOFFVcgPyTVioRQrHelV/vo/YVbmOd0Ra
        YOuWzJsMgRyMuweTn0ETln01by/HWHQ=
X-Google-Smtp-Source: ABdhPJxZKJ+KcVlEbHGoSeS+erY8Yl2JfXCIrGYoM3V110TJXBgpG10mAKdTSEtAjqWTIqssCktsqQ==
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr884807ljp.201.1621282311249;
        Mon, 17 May 2021 13:11:51 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h14sm3025320lji.57.2021.05.17.13.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:11:50 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 0/9] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
        <xmqq1ra56svo.fsf@gitster.g>
Date:   Mon, 17 May 2021 23:11:49 +0300
In-Reply-To: <xmqq1ra56svo.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 May 2021 04:51:39 +0900")
Message-ID: <875yzhf7cq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Fix long standing inconsistency between -c/--cc that do imply -p, on
>> one side, and -m that did not imply -p, on the other side.
>> ...
>> Exact historical semantics of -m is still provided by
>> --diff-merges=separate.
>>
>> Updates in v1:
>
> OK, so this is [v2] not v1 ;-)

I dunno. Actually, I'm a bit confused.

Is simple [PATCH] v0 or v1? For me, as C-programmer, it's obviously v0,
and that's what

  git format-patch --reroll-count=0
 
produces anyway, and the next one is

  git format-patch --reroll-count=1

that produces [PATCH v1]. That's how it became v1.

>
> Will replace.  Thanks.

Thanks!

-- Sergey Organov
