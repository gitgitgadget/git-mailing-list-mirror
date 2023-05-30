Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE65AC7EE23
	for <git@archiver.kernel.org>; Tue, 30 May 2023 17:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjE3R1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 13:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjE3R1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 13:27:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216B0E4A
        for <git@vger.kernel.org>; Tue, 30 May 2023 10:26:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568ab5c813eso32612827b3.2
        for <git@vger.kernel.org>; Tue, 30 May 2023 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685467609; x=1688059609;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R9THQq63M1rgr/bX1+eJ0jNV86gFBLWaiN/DaGsh8DA=;
        b=tDXNPkwqlKz8SalXdpLu0WYm1Pqh9a9qwiiA0kjb3CSDSlLWvIRzY5VhC0zb/tGkYC
         VNq01hoFm8U+ejGeTiZDDj+3l+xfX/Ea0L9Z4hf4Dh74IPb61P1iIO6Umc/+LvmdUhco
         Xxvm9Irqw/789kwmZCE60pY/LE6/owS50y+kT/jlOMhgNYpoH92fdNtRLorRhQ3MovQQ
         nDZNBp98dkFhkhu6Gr2FXCCVKwGDSZphkktxrdSAPgkF4yPoATnOuXC7hhgI4T9CVKAF
         cfwwum/5RPUnRNaBWnBqkpkntUNZo0PZOm/HKS+DACd9NVTakE7RifhX7EtC0nuTn835
         bbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685467609; x=1688059609;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9THQq63M1rgr/bX1+eJ0jNV86gFBLWaiN/DaGsh8DA=;
        b=ZhLiBYus86sxsf55SkHl6P0jHGVyfxgJwMbJfGdSmKuAwr4OfrCqnhoQfELZYg9fVB
         RKb5a5VKNn9tKBmSFT02fpCt3qzf0jHdHtegjx3GWJzLW5amZsUhy0uPe2WPpw9iOUYl
         VuQzuaXt60KQu5v23biyuAj/8wkQTNnbmcfFtoOeaoTTbZIAlugfo3+KdF+JyF9OSDti
         vFl1A4vWZikli51ZLEEJiqmP1ok/1cjnDKgbNarFMQUp47BqFwu+ejqF2LjwGb+J9VSs
         +pTnNSyWLXCHdWGZb8o8XCwVAb3Dvh9xbnQJmI1Ie/+nHBmaWQUx5/O9Tu0AsfOZfKBM
         jz4Q==
X-Gm-Message-State: AC+VfDzE9f8I6gJbct7iqq74gltS77sO7ubDhrv8+e9chlQFf4DKPIpd
        UENLDFKKvulAt5gwAk6cB5Wgd3TZnMsWtCuCw5Ro
X-Google-Smtp-Source: ACHHUZ5PJPOEhbLBHW0nu7nWzXJcPvzXucgbOAM5hDHnrW9xdlARYBuigBkxVXLx/zY3KyXxuMALOSmmurvYzrNhrGsM
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:45c4:f45e:f82a:5d18])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ac4d:0:b0:561:b7fc:7445 with
 SMTP id z13-20020a81ac4d000000b00561b7fc7445mr1773110ywj.1.1685467609472;
 Tue, 30 May 2023 10:26:49 -0700 (PDT)
Date:   Tue, 30 May 2023 10:26:46 -0700
In-Reply-To: <a4d22518-d3e6-76aa-fe94-2ec77a1de96a@github.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530172646.2781197-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] commit-graph: fix murmur3, bump filter ver. to 2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:
> I'd be willing to modify my suggested steps:
> 
> >>> 1. v2.42.0 includes writing v2 format, off by default.
> >>> 2. v2.43.0 writes v2 format by default.
> >>> 3. v2.44.0 no longer parses v1 format (ignored without error).
> 
> to something simpler:
> 
>  1. v2.42.0 writes v2 format by default, but can be disabled by config.
>  2. v2.43.0 no longer parses or writes v1 format.
> 
> With this, we could proactively set the config value that disables the
> v2 format in our production environment, then slowly re-enable that
> config after the binaries have deployed. This allows us to limit the
> blast radius if something goes wrong, which is really important.
> 
> Further, I'm describing an environment where we control all of the Git
> versions that are interacting with the repositories. Other environments
> don't have that luxury, such as typical client users.
> 
> Even the three-version plan is an accelerated deprecation plan, based
> on previous examples in Git.
> 
> Thanks,
> -Stolee

OK, let me take a look and see what this (having at least a version
of Git that supports both versions of hash functions) would look like.
If we're going to have this, we might as well roll it out as safely
as possible, so I'll aim for your original step 1 of 3 (write v2, off
by default).
