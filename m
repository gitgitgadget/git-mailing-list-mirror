Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF7EC433FE
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 07:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKYHLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 02:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKYHLI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 02:11:08 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5BC19296
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:11:07 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f3so3255810pgc.2
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE9cugetGKs5/c5w8OL0kel8dp3DUw8kbVdhDdXsJvk=;
        b=p9DPEjRR7omem40lfZftG/Rh8TwwnUY/zTbtsXPn9XbD/pjlpRm0t+7fJbeo9lzL5K
         AdrlJrQgpzFqyuojzEv1K8H/dvsSqZBNpRktCvB4ocmiblTfmRDDRjY63liMIkCKAiGF
         t/Ea8oskbY8PKvJaqRpX4ARSpXKey+QYVzJyDRVR2Yq8yTNG/QwzzJzPoEYvzv60xPfL
         Jnoqhk78a5czeCeMS/8XZ27Dwsw0N3YKNotn8G8gyjrjvcCTWEnknjP3byHSzw7SCZaK
         ckj8oqH7fPEJnSN6bEVQGTwnH5meKoGNhQrmYUABzTSAXiEfiPrwIcze6kwSCq0ddESl
         Llzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE9cugetGKs5/c5w8OL0kel8dp3DUw8kbVdhDdXsJvk=;
        b=Ej+ngrPSME2tm0BZO7gHsFgID9gWy8gabdZ2nq4CHmOXuXngvjwMd4vi0FJzi/rXws
         RkrLbD5qBYDFbPhbDP8WM+PPxK3kE8hlfxbV0EIqoc4zilf5X/cNALjnd5Opg3X/xr96
         +hJV8XwjQxkRQZIkbZXyT7utlI4KSqeTx8glrYoAyJ5DDontCPUz3J18HPbH2gHbhD1F
         WVx634TrPEOcnzConWRUwbBj4L45I9wY8Kdiu0lbK+iY2/vKlaNuM/rOHVZhvOaod3IR
         T+qyoy6KQ8ikJ++6+QihTv4TpQj+x4X48ttZPfwK7b95rOyapOgE9JSSrgOC4sfmcMYJ
         7GZg==
X-Gm-Message-State: ANoB5pn4yUqJrf4BuaH+R/qAdu3DeuPMNFmdkQic1RbujEPNo3yIIOuT
        TBPMwoNVZs0mbARjCrA2iqE=
X-Google-Smtp-Source: AA0mqf4l1B6qrJQhTue2d3EmzbaDcGXRKlgQDI2rJ7Q18ezkktNrMXwcR/mSrCdpFQ8UOBmHo0LwpQ==
X-Received: by 2002:a05:6a00:2883:b0:572:7b49:4f47 with SMTP id ch3-20020a056a00288300b005727b494f47mr19360804pfb.16.1669360266737;
        Thu, 24 Nov 2022 23:11:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00189548573a2sm2581624plg.161.2022.11.24.23.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:11:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: python 2 EOL
References: <20221123150233.13039-1-worldhello.net@gmail.com>
        <20221124090545.4790-1-worldhello.net@gmail.com>
        <2219s80r-q7s3-391o-o3or-7q70sn37ooo9@tzk.qr>
        <4oonnq45-s269-sr8n-o5sr-n214593nps8s@tzk.qr>
        <221124.865yf4plw1.gmgdl@evledraar.gmail.com>
Date:   Fri, 25 Nov 2022 16:11:05 +0900
Message-ID: <xmqq1qprecfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> So I agree that the best idea in this patch series is the stop-gap
>> solution to install `python2` on `ubuntu-22.04`, and deal with deprecating
>> Python v2.x support separately, later, or never, whichever comes first ;-)
>
> Yes, let's address that later. We had a recent discussion relating to
> EOL-ing it in-tree. See the ML discussion around[2].
> ...
> 2. f7b5ff607fa (git-p4: improve encoding handling to support
>    inconsistent encodings, 2022-04-30)

I agree with two of you that a good first step is the posted patch.

I do not seem to find any message in the thread that led to the
commit about dropping Python 2 support, though.

Thanks.
