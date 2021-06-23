Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50231C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCE861166
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFWTxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFWTxY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 15:53:24 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D3C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:51:06 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id v11-20020a4a8c4b0000b029024be8350c45so1008448ooj.12
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=AXXe23CYkox3DF0HhqMvkZpk8Uwg3lL0XatZGWGmUOw=;
        b=jchWmffS+2BdywkTQKsRBBcF7guYKwWS7p2H6sarEGqC2PETy5R7ukggPOpAe6Akxs
         qhB+Gz7YsHHetUTeDJNs5R98cLO13PFIANmlK/WZ8bTRGEpTrSwt10nx+23OGfMjSstY
         Va0217SrorZ21NPkbIi7KSicJitQaUuQA+YV9+PkGY8Lonue855SgNHa0COTBLL9lZv0
         gJsXBC9VUIprAgd+m6NtMuMJXSbL4mzoLNoPDfZ0Iv01ykCBb4dGzoujjEnvX5QQxKEk
         hvcO/zh34LazHxNT2w1Rfi80WZUxlHauRG731CaUs8MJD/Wm+6rPoAdezcAdGG5cj+62
         QbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=AXXe23CYkox3DF0HhqMvkZpk8Uwg3lL0XatZGWGmUOw=;
        b=lf5K3dVklEAPgN/hPBWzRENzo73xSG/XvDCSef29N2K5P/TVd29zZp9jhBOOTiv+3x
         RoPzp3FUm7EtZkhCVCuEp4ZonqYllaHoZILZ7EMwMFMLMQkYCxht5FvSG70WXtWiQFSb
         Qz0dxWfgMF5XalWNCaonBbfASpcWg4Q9qqnddwTyC8Zb10bSXv21gi8A5DzAbp/ahfLj
         94S+jd84OTYMraUUnDRa7F60u1XOwgWZOojUkRso9Wn+59pQ+PECbOHus6iHEAB5u0v1
         dyA1yHnKc5YhQ2lCFJCJcHxVKLxgXrqnBELVb/yHV6dNilH7/xovl2jSSNQkLXMzAAyG
         bnTg==
X-Gm-Message-State: AOAM5314S9sHuhpXGhs2R0VWLg9SailJ3pXhA4CL+AAzwvt20CEXv+yk
        TSYsW7zK0K/rUebZVXbANzNjJh7pmTnI/w==
X-Google-Smtp-Source: ABdhPJycJKGBJor4F+huKQHYJa6GThBlAfo40wcsxc2bKHozjCTtFFx17OSnWVjm/17oc9F4D0fkcw==
X-Received: by 2002:a4a:98b0:: with SMTP id a45mr1273282ooj.22.1624477866106;
        Wed, 23 Jun 2021 12:51:06 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id p4sm192836oth.30.2021.06.23.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:51:05 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:51:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>
Message-ID: <60d390a81f618_429020823@natae.notmuch>
In-Reply-To: <YNI5KVGT2mLlTrnz@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
 <patch-2.3-ea39f1f5cd2-20210622T141844Z-avarab@gmail.com>
 <YNI5KVGT2mLlTrnz@coredump.intra.peff.net>
Subject: Re: [PATCH 2/3] Makefile: fix "cscope" target to refer to cscope.out
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> I don't use cscope myself, but it can generate other files (e.g., with
> "-q"). It looks like we don't even allow people to set $(CSCOPE),
> though, so that shouldn't ever happen.
> 
> (I wonder if anybody even really uses cscope.

I do. I don't use it regularly, as I find `git grep` sufficient most of
the time, but sometimes I do use cscope.

-- 
Felipe Contreras
