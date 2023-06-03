Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A95C77B7A
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 02:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjFCCZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 22:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbjFCCYt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 22:24:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355CFE4D
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 19:24:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so2599236a12.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 19:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685759088; x=1688351088;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kOzeFzzVUmX6QdtCSMsE96k0gmMWFAW/QdYqOIJnxA=;
        b=VPgeZ45a2c8cORBMijoSGjrH1zrxGGHJuX+i2cWNhcspkg01NtOPRGv2AeC6dgh0YM
         /v9U9W62zlBBfSqqICGMWmqrLPkKSM+UiK2scMgXzjTJDBu8rkelulIg9cqZAd/nRQqt
         nC7FxCd0Zn8vaLc/pnKQh0SncIq0u8zD+C9u75gXzz2iC0uexRJArvyba/S00sRweVhY
         AOQaSLs6wzSEhSALYSD4JUgoEo8IoSrm0e5ncP8Z2YKOis4vzBCAXAI3LmWMzDlozYdF
         gWQmNMCcyZr5JHD0bAMfwgf20JdX8NUZcg0HbftQmfG17jtp6UcsjaYYqhLUFC51lp3W
         c4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685759088; x=1688351088;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+kOzeFzzVUmX6QdtCSMsE96k0gmMWFAW/QdYqOIJnxA=;
        b=gj/IN0qQSG24/QWrCbKiBZDMW6bfNnkje8nA/tCaz6z9PBPo4ZyH0bfj6IAqytZrHI
         mg7orMKEcGk6L5E6yoNvysmOFaNelrqlA96uI6yBJYY9hH2uBnFTGLm1SqdkG0F3tbbp
         O6h3t45KSvFGW9nbTbLhF+3s/Yx87nj1TgDZnG7seqyTaFrls4EEdOTmW+VwnTTkxWtd
         8sUFtgUCtAo+QHAjiEAwDeHOvseoO16bRHKFjeA5f7K3lBZETdz52Vos11Yf2M9E1qtM
         DOo1xO8Kw+y4X/C7y8YEBeFWzh9/AnJqdhPhgXfEjDuEM3ZTXgmdAB2+FuZWoGrOTWvJ
         qvqA==
X-Gm-Message-State: AC+VfDyoBcDSksjSO/E/VJm+vTqIv/KyACNZxfqokXaWuCKJH3/+y6v3
        ak6Gn6z/v303wOeAVrj4sjw=
X-Google-Smtp-Source: ACHHUZ4Y3Ad3/+vdvgr+r08Fbyd+ksAuK7ppQ3bq0JgMnlAgRZkDKFelG/bGUMZ+sWoPC6IuGTSZtg==
X-Received: by 2002:a05:6a21:3408:b0:f8:1101:c074 with SMTP id yn8-20020a056a21340800b000f81101c074mr395516pzb.54.1685759088581;
        Fri, 02 Jun 2023 19:24:48 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id y9-20020a62b509000000b0064aea45b040sm1535093pfe.168.2023.06.02.19.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 19:24:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/3] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1685574402.git.jonathantanmy@google.com>
        <xmqq5y858ikd.fsf@gitster.g>
Date:   Sat, 03 Jun 2023 11:24:47 +0900
In-Reply-To: <xmqq5y858ikd.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        03 Jun 2023 10:01:54 +0900")
Message-ID: <xmqqa5xh705s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Here's a new version. With this, Git can function with both version
>> 1 (incorrect murmur3) and version 2 (correct murmur3) changed path
>> filters, but not at the same time: the user can set a config variable to
>> choose which one, and Git will ignore existing changed path filters of
>> the wrong version (and always write the version that the config variable
>> says).

Seems to break t4216 when merged to 'seen' to replace the previous
round.  Could you take a look?
