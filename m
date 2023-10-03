Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7AEE7AD77
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 16:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbjJCQaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjJCQaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 12:30:19 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3103C91
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 09:30:17 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7740cedd4baso84496385a.2
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696350616; x=1696955416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7/rBJVNuWlbsu6OpZfJeysJHeSuU+vL9MFRkqLn/1M=;
        b=PXsd+oNPt7sqb/J2CANM2z3J2wMUVb1zHI6uutZEP3Fz2X/ALvH1NndU67jgSAYMeq
         2VsX8zdSXgHH9XaIn9GX8fKSyPuPVpookWpyQxjvMxtmMNWaVfyQu8NwCvEE7xGVc8Fp
         vAmbkAj2wS8nY9yxB7F3L6RwVmFnp84pQmL7RiUtpJsktSamszF95EjZ9BpmCglgu0e4
         caZ5iT008ZdbmaNDuk/PumG2sGEZq981C5vatuqu0hYVSk1viBOShIQsuCpwXJazrsQz
         Bk4JNIaeSEwo2iNkKPloj2W3lyUIJVGJ/GJppDlH5WhL+GC2X1ingW7f0FjKwKwiWq4W
         3MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350616; x=1696955416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7/rBJVNuWlbsu6OpZfJeysJHeSuU+vL9MFRkqLn/1M=;
        b=MsY7ueg8+t8UpZKSpgpetVqzBNjxlalG0qE3giL9BENgSakuSS68Uv0dNTR70jTIzM
         Pz3kGh7BBwhp51AuoeDQ2tR6KpgK5QZbJLHM6w5GzSp5WLstYceM3qAJ7E2CwJoNW6+V
         n6DQK4s0Lt4ZokRxEi0rH1TULh2GVmC1DVIWbborqvuEwTDExKiVS3pQdcOrk1VLWnjX
         S/Hme6zXA57DBT9Hp0o8cklNJmIryjaqeBwVzN2UoosOoBksxz4oEGIQHbVSgo0uA13E
         k3sQtF9Po4iNu8VPbUfR9NyuHBeq1p/HS5fjoSieXvq2tC8KPcw/fBdaX42IxtBgQg88
         4MzQ==
X-Gm-Message-State: AOJu0Yx1YeBdkkg8tUQtDBdYOelo0i3souFeUZK62IqMVL3vP+oRP7Re
        +dz3qkfCfhQxJ/cKzCUxtXv/ep+XLM9oSC/miPxU6g==
X-Google-Smtp-Source: AGHT+IECx4LExfCw6M64HG+qg7A9pvAE4/nRJbJzCy+XuBEWjO9AX7DDB8prus+0MgMwprZiN5qfvA==
X-Received: by 2002:a05:620a:2483:b0:76f:19fd:5063 with SMTP id i3-20020a05620a248300b0076f19fd5063mr110047qkn.34.1696350616180;
        Tue, 03 Oct 2023 09:30:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a131000b007659935ce64sm584241qkj.71.2023.10.03.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:30:15 -0700 (PDT)
Date:   Tue, 3 Oct 2023 12:30:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/repack.c: avoid making cruft packs preferred
Message-ID: <ZRxBlrjyuBmJnx3p@nand.local>
References: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 12:27:51PM -0400, Taylor Blau wrote:
> I've had this sitting in my patch queue for a while now. It's a
> non-critical performance fix that avoids the repack/MIDX machinery from
> ever choosing a cruft pack as preferred when writing a MIDX bitmap
> without a given --preferred-pack.
>
> There is no correctness issue here, but choosing a pack with few/no
> reachable objects means that our pack reuse mechanism will rarely kick
> in, resulting in performance degradation.
>
>  builtin/repack.c        | 47 ++++++++++++++++++++++++++++++++++++++++-
>  t/t7704-repack-cruft.sh | 39 ++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 1 deletion(-)

Oops, I should have mentioned that this is meant to be applied on top of
'tb/multi-cruft-pack' to reduce the conflict resolution burden. Sorry
about that.

Thanks,
Taylor
