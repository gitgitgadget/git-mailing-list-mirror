Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6DEC433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 22:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1A861352
	for <git@archiver.kernel.org>; Sat, 15 May 2021 22:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhEOWBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 18:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbhEOWBv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 18:01:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E878C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 15:00:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i17so2523282wrq.11
        for <git@vger.kernel.org>; Sat, 15 May 2021 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=gXDErnbyGbhg1/xt0VuPpdMCx6SIO+EpE0HjjmcvcIQ=;
        b=cViz3VDBDQ8cT5CkMGgyz/a/Q72n13Cu/fCc4k+31O0PK1BzhPGhmKLkNof2AmSG1P
         8GB7bJLCprLaoZYLH8pvbuGBnAgc3/yq4dIKwP+qLTefo5CgMz3d8iJ45XW9wxwXMHRv
         QKkArmS62nuth8pPnSoWv5QN/M1uC4PcnCBEcCfvGnYawHGUaX4EZZNUxdUVU6aGGd+X
         Bkn2o/fzch6jTiiEmO+YlUcMv4a+0jUvt2jofFHUgxvOJvlDo33OUP8t1vseJNNP1MIc
         7eslyMgGoQcQrBrQmPPFu4eWU8mUsVXSA9bRN4w6yVlHv749AwZrxwyIYwE/7o2AgVc0
         GdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gXDErnbyGbhg1/xt0VuPpdMCx6SIO+EpE0HjjmcvcIQ=;
        b=ct5LcLORhZ7IkYvlQhEAHBSsSZzbcqmB8cOVJ0NA0gcrf4SItsPqJyQ9E8m6oZATy0
         6UzLdGVVPmIv+7tSLNdiD2LnmZ730mEjfckx1omFmdQjOsKTDm36wZGuGmcu9RlBTv5g
         m/1jytnhMS3czT/m9Nf8s3ka4sulPuVIc5PI6OOU9lOqGycm+kXWn/6xFoC9A7SrNCJg
         /VFkGBOSTlFxGKCfIrnAVYkyxUeoD4gEFMwYRhyPIJUXPokVFqjL/+0ai4BLqOAv0PV6
         BK/nVmWPDfWklIp/R4UQwj49qPRjXunskBiENPcmip0yenSOkH8zGZysJd/C294Exfii
         9jgA==
X-Gm-Message-State: AOAM532QqgwygpMbDnqFmFJkHdWnyTGnrc5TI6TFCSLxCJLUk3sWiTGO
        6jEFfJ8UhsGEjcq47GlYsj4=
X-Google-Smtp-Source: ABdhPJzPvXAxiAs7LO/C0dQDw7jEOaqQsoLo0su+AokV+N1SefAwMezcTpnFQivAMTiTMBeZBVhvaw==
X-Received: by 2002:a5d:63c1:: with SMTP id c1mr12402612wrw.71.1621116034679;
        Sat, 15 May 2021 15:00:34 -0700 (PDT)
Received: from Inspiron (2a01cb04010c4200cd08ad531d1c64b1.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:cd08:ad53:1d1c:64b1])
        by smtp.gmail.com with ESMTPSA id s5sm8996044wmh.37.2021.05.15.15.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 15:00:34 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH 2/2] t: use test_config whenever possible
In-Reply-To: <60a02d62838cf_eacf5208d2@natae.notmuch>
References: <20210514065508.247044-1-firminmartin24@gmail.com>
 <20210514065508.247044-2-firminmartin24@gmail.com>
 <60a02bf2f16a2_eacf52085@natae.notmuch>
 <60a02d62838cf_eacf5208d2@natae.notmuch>
Date:   Sun, 16 May 2021 00:00:29 +0200
Message-ID: <87im3jfyiq.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> Ahh, I just read the comment about not using it in a subshell.
>
> Then outside:
>
>   test_config -C downstream fetch.recurseSubmodules on-demand &&
True. This makes me realize that I should also briefly document the -C option.

Thanks,

Firmin
