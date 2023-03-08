Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42456C6FA99
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 02:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCHCss (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 21:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCHCsh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 21:48:37 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804FC911F2
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 18:48:36 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id y184so11203368oiy.8
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 18:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678243715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ByS1lCmQjZxEBOLjBKIuIyBzuaX9pGJnjpT+eVNYzM=;
        b=Vp1YM+TreGH5j+J+9o970Y2LwCiy71MPc5DvLpYL0bbFDivNrCYM9muPL1+mhO4QOB
         +JlHeuvEPh/2tAlsv456f1OQBsFnT50T97WfesghZHALBF1SfGJzaXB1cc67sihYiUm7
         prEskxrZmUEt+Ndtgu5R/+Nw532unEXi2335cPfQMI9dg/NVA4KOOnmCrOvxmTykUcQd
         oYQxotQjCXi6kl/eDCFBuDKayCQW82Wjrz85N7wEbMffcGz9OuOHPXrrVzatjWqTyddw
         noZMqtwGKm7iWUjpz/IcK8JK4SRYPs+2vid2UWMfx7KMMRGHld3RDaDZRF9DaS3pMVpw
         yW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678243715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ByS1lCmQjZxEBOLjBKIuIyBzuaX9pGJnjpT+eVNYzM=;
        b=xD5nRjZvB1d8xNe9nnjtiAC959necvMFb14Z+LnPY2+JZTja7P/VKEdxHCq1bbsi7u
         8vXpf55eLsfJYhOKMmRPW7jcnHLVmexngyeWosSwCoIgQH16tjKwyhkN+a13xX1ZGAHM
         Fs1KUUEf1F7kjpxvrQ39mo3sMfYulpNk2hhWF2P+YG4YS1RWhGtL5uVYTx4z7FnYYfVI
         Z/Ap3MsANgkJ1DgOxZdzupiJQ+JTOedP0DPeVfjI4b1Xn2vRGi9RFm73cNXrKMF88/a9
         8bXoB1CU5PTjAipaYKPc0qBtlHtg8tto+QpZd1/BhH7w378QftSK1tNJO2X4FH22heDx
         A8zw==
X-Gm-Message-State: AO0yUKWPE1p1BYrHux4OKGvtzMNH8iQPWs9fob2T/YCsqfoQyV/77PP8
        cQtXelRiY7Zt/b2HRreQymVD3bEafM0=
X-Google-Smtp-Source: AK7set/tCpNld+21wk6XFQpVban0qv6A4xY9KkuPvF/xhbA3ZfMRemyvBU4I1jxAEM4PYfUAgyvHvQ==
X-Received: by 2002:a05:6808:215:b0:384:cf00:a5a0 with SMTP id l21-20020a056808021500b00384cf00a5a0mr2584730oie.43.1678243715518;
        Tue, 07 Mar 2023 18:48:35 -0800 (PST)
Received: from localhost ([2806:2f0:4060:3465:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r64-20020acac143000000b0037834b1a20bsm5955509oif.0.2023.03.07.18.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 18:48:35 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.tavb@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] advice: add diverging advice
Date:   Tue,  7 Mar 2023 20:48:32 -0600
Message-Id: <20230308024834.1562386-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not all our users are experts in git who understand their configurations
perfectly, some might be stuck in a simple error:

  Not possible to fast-forward, aborting.

That's not very friendly.

Let's add a bit more advice in case the user doesn't know what's going
on.

Felipe Contreras (2):
  advice: add diverging advice for novices
  advice: make diverging advice configurable

 Documentation/config/advice.txt | 2 ++
 advice.c                        | 9 +++++++++
 advice.h                        | 1 +
 3 files changed, 12 insertions(+)

-- 
2.39.2

