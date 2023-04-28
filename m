Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8834C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 12:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345783AbjD1MVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 08:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346070AbjD1MVc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 08:21:32 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A426583
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 05:21:22 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-541b60e2647so5187643eaf.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682684481; x=1685276481;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E+VSjHmzlhMA8d02KZsLg/fwP2FgiswLTjBYhqa2cU=;
        b=gB05lEP/3Yp7Jmaz2WXSOqRU181PL+exztwq7A+pkLBdUleqK8CvmM/gruiY6mBl3k
         6OohloDbIp+r3OiqpAClhveUYfLy1MYgZPgd29LbGysCreB1YT6UR5+QmF79M0+2eb8/
         RI1QfrSX8dcRZg2xYYtBuResLh3W5TshbkyyQiV0XopFm/S7RGPswFXl+ZJhiSSW/TZV
         cnFVkaQkhz3+V+iRUq43FckbRy+y5JGX3A75IYherPXKS1ofutGhA+EGe6YqpmslbI/I
         43FPrh2fJdknLMt9HitOxic9MkuZpQMLdDNdIjtqDsXyg8P7DqJLfphuXnU2dsD9gKNA
         L7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682684481; x=1685276481;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1E+VSjHmzlhMA8d02KZsLg/fwP2FgiswLTjBYhqa2cU=;
        b=JA5Rqr76d3WwQpAvw1KpRMyL1EQGmb2Dko/wEKhe0DbIbsRwWzdeIYZtEwtnghxPE3
         6UsXRBl0so1q75o+OMVkkXM0SCgXS40LxY0ludDICKmL/dMylMnWOAL5nADFOqbuB7Zk
         AoTW2UBSAijrMDuqW3P6CHvBWkvI3iB7Bp6p3+S7fUrqOZ4ZB7tRBsy0N2MgkuA/B7g5
         oifgw71D87nbWEcBVVqBXp3ucaXn6xKsDVsqms9Bw8rGKFnaFfko54aD8fm+PO3DxUxR
         5qQ7ZtQOKLoi/ec+luUW8+CSdojnfpzZOEV20L2BZSYUWOaohCeYfSsn7M9dx953pkR6
         Ghcg==
X-Gm-Message-State: AC+VfDzoAIQN+h9drG3g14ugeF5YUl3QHYFNGZQMPNEIKNNR/E+A3yFZ
        47TbBREcbgJx/FJgtUg60qM4JndlBhE=
X-Google-Smtp-Source: ACHHUZ4iCB2AJd/Jb6xJ6f5KIweCQQ5+miRqNvGDovmp1pJYDxtQEPeNhCvoTqQNGC7ywYfJpjj0cA==
X-Received: by 2002:aca:2107:0:b0:388:fff3:61e6 with SMTP id 7-20020aca2107000000b00388fff361e6mr2689746oiz.38.1682684481254;
        Fri, 28 Apr 2023 05:21:21 -0700 (PDT)
Received: from localhost ([2806:230:6026:c32c:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r128-20020acada86000000b003895430852dsm5793330oig.54.2023.04.28.05.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 05:21:20 -0700 (PDT)
Date:   Fri, 28 Apr 2023 06:21:19 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org
Cc:     --cc=avarab@gmail.com, tenglong.tl@alibaba-inc.com,
        me@ttaylorr.com, Teng Long <dyroneteng@gmail.com>
Message-ID: <644bba3f96e3b_1c66e29436@chronos.notmuch>
In-Reply-To: <20221205133525.60464-2-tenglong.tl@alibaba-inc.com>
References: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com>
 <20221205133525.60464-2-tenglong.tl@alibaba-inc.com>
Subject: Re: [RFC PATCH 1/1] push: introduce '--heads' option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>
> 
> The '--all' option of git-push built-in cmd support to push all branches
> (refs under refs/heads) to remote. Under the usage, a user can easlily
> work in some scenarios, for example, branches synchronization and batch
> upload.
> 
> '--all' was introduced for a long time, meanwhile, git supports to
> customize the storage location under "refs/". when a new git user see
> the usage like, 'git push origin --all', we might feel like we're
> pushing _all_ the refs instead of just branches without looking at the
> documents until we found the related description of it or '--mirror'.

Completely agree.

This is something I spotted a long time ago. Although I would prefer
`--branches` over `--heads`.

-- 
Felipe Contreras
