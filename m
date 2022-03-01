Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E7FC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 08:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiCAIEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiCAIEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 03:04:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB39A517E9
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 00:03:39 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gb39so29789392ejc.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 00:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=laPc7/h6jSk6fYCV4ERJYYAm14rgeCjrODhFPE6U0GU=;
        b=ej1zvDR+cdDZ2WNjwR2AeETrvrNDAvEV03WeslSmOKGrH1Hy8bc/gsryD76LZRJrEr
         rWym+mcTsekxd963cJfDtxDcyxvkpZ7hD2jhuGQ7UULZoFLo058znVRMjkM+AAuUr0Z2
         pTHLLv1mZL75gPo88k3mRiCLs/eLkd9OspU4djyLoGA+mh6+IPfmtNRM55NZz4a6BgmE
         OpnW5UTQ9FRuXlAwXokJkwojgENE2wvKWcv2wZszXNeaayojxc8zMI58OzrZ4GNIVRO5
         vYrVqLcXFGdYAH6C9v7F4zlBCM00R8jZ+ckGaACakYv4OdD3nAjJL6Ozhptgj8XV8CBc
         iHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=laPc7/h6jSk6fYCV4ERJYYAm14rgeCjrODhFPE6U0GU=;
        b=FIZIcjZFZ1pB+wZfjAxKfmKGjBh5oRRBm6z9onaO6U+TgWJq92rhOYLO26y+eC73ub
         Tpqb5oSRbf/2Yr4eAwIB3G3JU1mkUEjRFPzFsmAlKY3147maFafy+cIpYf9o6hCgPyA0
         kgaJRefee+vMX/vUW2W/bre2UOAnEgfBqie8I0azGV+5Ntg2O6Yd4Gi2q0Y5/GLWC1eM
         /YUNLVUBR0YGXpLI+ftkJWHlLSXT5QNPaELJibb4efrydNAD8n63zEVOXLwEf12AMQqg
         VAI5qEshGqufbxkFN3ZOWRnD/UiahEnEdq60sYnS2cYYgNpki/rMHpen+Qm/si8h64jo
         X08g==
X-Gm-Message-State: AOAM5310HxOibpNgriDnDo+GZ6RsXBHSccJbZXBIMwoyBaBUJpL4vh/S
        Cs7tswjPTh0WBueB8UhIJwY=
X-Google-Smtp-Source: ABdhPJx48j8cqHlnDB2xgUFte99+4IAZVLIuR3aLnUUKF4vKU0ekxPtFOIlQGr8qVQ7JRtARcZ7gEg==
X-Received: by 2002:a17:906:4699:b0:6d6:e503:131e with SMTP id a25-20020a170906469900b006d6e503131emr1450875ejr.115.1646121818072;
        Tue, 01 Mar 2022 00:03:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709060c5300b006d582121f99sm5064982ejf.36.2022.03.01.00.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 00:03:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOxTs-001whT-Tl;
        Tue, 01 Mar 2022 09:03:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/13] submodule--helper: get remote names from any
 repository
Date:   Tue, 01 Mar 2022 09:01:28 +0100
References: <20220301000816.56177-1-chooglen@google.com>
 <20220301044132.39474-1-chooglen@google.com>
 <20220301044132.39474-7-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220301044132.39474-7-chooglen@google.com>
Message-ID: <220301.86k0de14mf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Glen Choo wrote:

> From: Atharva Raykar <raykar.ath@gmail.com>
> [...]
> We can now use this function to save an unnecessary subprocess spawn in
> `sync_submodule()`, and also in the next patch, which will require this
> functionality.

The "next patch" is now an intermediate cleanup, so narrowly: s/next/a
subsequent commit/ or similar.
