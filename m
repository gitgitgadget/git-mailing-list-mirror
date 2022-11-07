Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CB4C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiKGVqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiKGVqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:46:19 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7791AB853
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:46:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a5so19680721edb.11
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckkqUKCMJBdrfFyC2V6WILa2fCDDsqIHhROJw+5UQig=;
        b=l9/IG7Fvb8sUoZXU6SJncPLssOvJ1UNcprK0qFp2z2fYPo1O0C+SfkirUrfC7sSrXX
         UrLFUWqGH5agSK0TvJ9IjkBTeSCXRLqacyHWn+4RN6ZziZ4MxDPQVrZnMo13ouldecU1
         Ocf3wb5eF5N/T3NSiezXD9xZ7ekNu47LeikAfhkTJ1JIfjRzridlKLRzxqXyhzH58zXa
         fC2YviUzXtOV7+yKcocscdOJdvnscZB8AzLaYbWXKV6wZQuYXBwIB56Gj/3wnR/Nj7A2
         rVa7Ug1xn59nek3XFc+bv+PzQ1XXR0Z8nPew/9A52cvC2CUCNFx7kw/sC02SAeOXqnNB
         ogIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckkqUKCMJBdrfFyC2V6WILa2fCDDsqIHhROJw+5UQig=;
        b=SNXnew50ueH+McaOxHlhIeaoM40qQ1V7SPo6PcYZ+BaMvIcGm5Bs0Nn4sIWmKY0jEQ
         E/ndHxn0+0++9ZRZNH+YTiHfR55/YlBSbCKysJkJ4IcGtN1EU4SaRBUigIIR2gxBeQMB
         X7uJ+DtuvMh1EEtx4JPpzuNLjZMGvEFgtn0D2CYfh6wjqukgXS/FybiOBHmU0Xinb/Be
         2ZBTUrTTrEVFBoelrjAEte0UVRcoSQKuJlzay51muNdPi9eshNL4ANovzBRA5KwlJf4f
         9pKnApHB269NoQZnA4AH4UMoCtxAkQv43cXvINKS9c15NSn5OpO/FG/84Z6wHDpMqCla
         146Q==
X-Gm-Message-State: ACrzQf03iwpqMusI+YZbAuxW76ESdkdNpj6BZ1/8vNXK693KXrltVWnv
        Zzso0rg5NqdIfDwp/QPUFwjtgXeSZi3fwA==
X-Google-Smtp-Source: AMsMyM6c3vzeSfN2qXFqmbNRkGTmwMcHRWH7ohvzbrHCgvLEFE6IAOXLN3dkJEcwT76yuv4KY4/iyA==
X-Received: by 2002:a05:6402:d62:b0:460:42c8:fc6d with SMTP id ec34-20020a0564020d6200b0046042c8fc6dmr53306550edb.182.1667857573982;
        Mon, 07 Nov 2022 13:46:13 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 8-20020a170906300800b0078d22b0bcf2sm3873331ejz.168.2022.11.07.13.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:46:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os9wa-000MWm-2p;
        Mon, 07 Nov 2022 22:46:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 11/13] bisect--helper: remove subcommand state
Date:   Mon, 07 Nov 2022 22:45:50 +0100
References: <cover.1667667058.git.congdanhqx@gmail.com>
 <cover.1667667460.git.congdanhqx@gmail.com>
 <8037667da0f3d9f91c8f2aa477e2e95fb7f0c24b.1667667460.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <8037667da0f3d9f91c8f2aa477e2e95fb7f0c24b.1667667460.git.congdanhqx@gmail.com>
Message-ID: <221107.86fseutp3v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 06 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> In previous change, we've made 'state' optional, and replaced all of its
> usage.
>
> Let's remove it, now.

Let's remove it then? I.e. let's squash this into 10/13. No reason not
to...
