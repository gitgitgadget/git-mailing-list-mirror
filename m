Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FEEC004D4
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 03:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjATDKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 22:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATDKM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 22:10:12 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16E49CB94
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 19:10:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso7824210pjg.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 19:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2aOotfRS+r4F+SQP+2W9XPOC1vVZpixkIyC848BidU=;
        b=By93AlSU1EnzpTlccXzYF6mXcJbfT2LHaiHFoVSbAgMdX84ZubIqXs+k8/a5W16jXU
         MSrhFPZX/ixGOugzlB6R5x5aVAPD9OzMRZkLAanxpzxDJYxmdi1FZgf1UWClqw8k5Tmy
         aNE9cAtgCvA7j6fOIP8KJWWdImGZVjfd/HQHoCw3pWvJ+8wxTNTQh12faFVTU7aklqiN
         QZRI4+ix/54Yxf5Tc1J52bSAf9+M9TIadA9L2uiQPhlh1lYtdwmptX9r1B0dr9q5kBpd
         0AHg6FZlu5MfyMibfwBca0QMKcGy0gu+dW3Di9PYDg5K1DVg55fBsibtlnssqFB8ENes
         EH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I2aOotfRS+r4F+SQP+2W9XPOC1vVZpixkIyC848BidU=;
        b=P/3WUnvvm5u1vEAiMjK0Lm+7jnQiSlGbNKEausmNFhMPwqoAZsaYoS3eYLIw9QcdzB
         /e9hqWl1rVDIH8LMawMwtgZgS09OwKqTiCqcok4lB4ky79PXy6oHmrI8qZ8TkPV/A734
         E+McgnEytYh8Ep92MUCaMJNtsgkLegJiTuJTtTrnRsjhGwWoAtS40h95zHz/S7MyGsb9
         s6GVv5tS4hEqRgcYheBZorF+7lPbbBmvhS9rSNIuUVjqmEdWqZWbGklzQZQvp1vdO0yD
         N4uD0C5pig0e8OIY/+jkeWhilkXsLJPG7y+YdPB0w+HtI2048KePffdoPpz1/AbAFvYl
         RuUw==
X-Gm-Message-State: AFqh2kqkgtU9uI15cZFVLdzLStOmFZYIethiIybLn6MWnm8vkZ603KYG
        lYLA4x3cQylG16vTZ9hv/pw=
X-Google-Smtp-Source: AMrXdXsgJrrN8qccnjUHiIhCF/KRYMz+CSNgy+shiT/3jBGiy8HvmPoDdJ5tEOQ1tHNytziM7LfOow==
X-Received: by 2002:a17:902:8215:b0:194:9106:1ab5 with SMTP id x21-20020a170902821500b0019491061ab5mr11717249pln.34.1674184211043;
        Thu, 19 Jan 2023 19:10:11 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709028c9300b001745662d568sm538174plo.278.2023.01.19.19.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:10:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jinwook Jeong <vustthat@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] checkout/switch: disallow checking out same branch
 in multiple worktrees
References: <20230118061527.76218-1-carenas@gmail.com>
        <20230119055325.1013-1-carenas@gmail.com>
Date:   Thu, 19 Jan 2023 19:10:10 -0800
In-Reply-To: <20230119055325.1013-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 18 Jan 2023 21:53:24 -0800")
Message-ID: <xmqqa62dzyst.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Merging this on top of 'seen' that used to pass the CI tests

    https://github.com/git/git/actions/runs/3963948890

now fails many tests

    https://github.com/git/git/actions/runs/3964312300

Funny thing is that nothing fails locally for me on x86_64 Linux
with gcc-12.  Anything rings a bell?

Thanks.
