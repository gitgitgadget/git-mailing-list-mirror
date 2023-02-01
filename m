Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD02C636D6
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 12:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBAMoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjBAMoT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 07:44:19 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA90B12866
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 04:44:03 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr8so29462551ejc.12
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 04:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=arnZSYDOwZh1V2BpvWKbDgJWxWvYkVFUEYvlOWQTQtk=;
        b=l5BrIOVPEW738BuVsh5AxdT2Cao5+s4khmiTaMbGvZ5t0MEIqVMh+KdT8FeFowhh1/
         KbkREhH6RWbscJywhOOpv+MNgqtd+EiyAiZ7J1mkROILgfzh5FEF0eAhs2E7zegCCAJr
         AH/e9lyb3V3P/Hddoc7MmrYzq5vgUauTvGvtQEYXeUnimHYHq+BpUKquCG1frQk3dkSI
         gXcx36awfnfYsJdKPFXW49j8oY4fxDZpLE8QIc9PzeD0J4Mk1EIGARP1eTMmFf4fAB6c
         4NZ93PxEj6BT3gmMgqxnRPo0V0UM/1JNLrOKrOb8hh3E8hPhAZO1g7JF0uIxNPlevxEE
         /Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arnZSYDOwZh1V2BpvWKbDgJWxWvYkVFUEYvlOWQTQtk=;
        b=PCEzbUEF08rJ/asOtfefdXlRObO26K8/xaM6L5gwb/7wMsam8L5rAeZzIwjvrX+AJJ
         7gzCQM9CC52eD641zVrHIH/waFbCqUEN+2OzXM42Y7ScsIn4tptCUJyzdCx4ksacPiNl
         G7AX2SmufIsjsl0IXNGN70jDhGB9UBOkUcmNZMxtAmHcQhU38l0ynIEAGi1ScTv2v/43
         9uZQB0J1DwghHac2iMAeYS2g9Ua2zVXFIXmuSp36NPeWMgn78Uh5Nt4tcR55Ei0NGKzS
         z9YuoUvV1HpVDHzO7+Bv0VvzHx/6PQxGlYMDnKdZ2uydwAB43ZhFrdtF4wAcvJzixTpa
         GU4A==
X-Gm-Message-State: AO0yUKVHHN5tfhgZ5V9ZQr+yppS4uSpL/CfyEpuCG1Xhh1IPgPEjTPFn
        Ql8ZQPa+gjQL2b5++wFFHMyRxG+kSAai1Q==
X-Google-Smtp-Source: AK7set+Wvy//+hTS7rDD7vKCeuo/ir0w29GPLex1zPqGIaeeQPeoFSw6duM0awmo/JaWpCe6CIOuqA==
X-Received: by 2002:a17:906:d7a4:b0:87b:d60a:fcbb with SMTP id pk4-20020a170906d7a400b0087bd60afcbbmr2378015ejb.47.1675255442304;
        Wed, 01 Feb 2023 04:44:02 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906605500b007c11e5ac250sm10078907ejj.91.2023.02.01.04.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:44:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNCT2-002Dxx-19;
        Wed, 01 Feb 2023 13:44:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Date:   Wed, 01 Feb 2023 13:42:54 +0100
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
Message-ID: <230201.86lelhr1wv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 31 2023, brian m. carlson wrote:

> Since then, I've been very opposed to us guaranteeing output format
> consistency without explicitly doing so.  I had sent some patches before
> that I don't think ever got picked up that documented this explicitly.
> I very much don't want people to come to rely on our behaviour unless we
> explicitly guarantee it.

FWIW I think the reason that didn't get picked up (I went back and read
the discussion) is that there was some feedback on the v1, [1] suggested
(at least to me) that you'd re-roll it, but that re-roll never seems to
have made it to the list.

1. https://lore.kernel.org/git/YD7aDwX%2FaiRN0GZs@camp.crustytoothpaste.net/
