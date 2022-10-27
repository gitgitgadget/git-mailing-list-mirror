Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19C4ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 18:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiJ0Snj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 14:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiJ0Sni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 14:43:38 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E305F9C2C1
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:43:37 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c10-20020a170902d48a00b001825736b382so1589799plg.15
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wDr/1JH8f8zDy1SpFfkHuZjD7luc9xUCGHZQYY0sRKU=;
        b=B/5TlLu5tmvwDUUmU1oFeWAfWtPs3162wbNi1s3knUvur4nmT8lI1CchWYHJFckjD9
         l1s/8/YmEoQTJAYHtcxxp2ZzQ33p3x4aI6aOQCxe26JGPKKsSVHJD0bvXuiwemhxTP3u
         CXQh3rS6TKnw4M3gAREoxLvA/4C51yc5o1aic1vp8c4Rb3EdScvFYhFWLFhSVk59hWuV
         v+fUrO4hGWfZiclHsqoKIhY1b+bhxynb5jIyySoHDx7Km6nngInGeUFKTRTrsxwdksK2
         kU/QJlKopI90vCpbO8HqGi7NLfrdRtmnYWTTT3ZMDJEEue8FyDFE1EQKb2I4c3RxNDeO
         BXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDr/1JH8f8zDy1SpFfkHuZjD7luc9xUCGHZQYY0sRKU=;
        b=BgTUAHG5dMgcHo2N8krH2mgwvws13R59MZcY4SjEaAF1oXClZ8INX3vFmJSfDZUXuz
         lZkBFWRik/MySwbC4wzkt3iSqNUcYjRIJKOEJigD/yKp5k3l9b3KkLdjb8qdUo+cpqwe
         nJ4/VFRAXahpPRodWvmYE0KlVbG7j7o/DffVcSHggOUak7ivdvEmf2T7AHaT2LjNKBEu
         gKSKu5JYH3SlcAY56xz1Ux/lULLPuuT45dyPSrggvnLAg/kfHbpzT6Rmmo3KkfujcmC0
         lccAz4FMEhhRJKJkq8MUj40bKDMGiUqeGMZHs0PcnMAgJGHsXfcU3VVzogLD916wV1VA
         Jyug==
X-Gm-Message-State: ACrzQf1x4YK5C/4+F/utqp96HlaHh3HTwx0FU+kz6uu6WaaPDwhID6bF
        uJ5YeYL6HsgP2IHt8qUQuuRB4WkYjwqocr5+u9u7
X-Google-Smtp-Source: AMsMyM5qwOBe7ogkytWQNoCzrDIQrARSobmoczU47caL8cBPZZOJgMpcS+m27QcqNPTUQHGAkzeIFrlv1fc7bVk22/d0
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:4e50:0:b0:56b:d5e8:335e with
 SMTP id c77-20020a624e50000000b0056bd5e8335emr21755336pfb.61.1666896217461;
 Thu, 27 Oct 2022 11:43:37 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:43:35 -0700
In-Reply-To: <d3d1738e670d5dbf1378fc5c3209b2e98234a771.1665973401.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027184335.1840969-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 4/9] tree: handle submodule case for read_tree_at properly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Heather Lapointe <alpha@alphaservcomputing.solutions>
> 
> This supports traversal into an actual submodule for read_tree_at.
> The logic is blocked on pathspec->recurse_submodules now,

What do you mean by "blocked"? Do you mean only that 
pathspec->recurse_submodules needs to be specified, or do you also mean 
that no caller specifies pathspec->recurse_submodules now, so this code 
path is never executed? 

> but previously hadn't been executed due to all fn() cases
> returning early for submodules.

What do you mean by "previously hadn't been executed due to..."? At a 
glance, I would think that this new logic is introduced in this patch, 
so of course it would never have been previously executed. 

> +			if (repo_submodule_init(subrepo_p, r, submodule_rel_path, null_oid()))

I don't think this can be null_oid() here - it has to match the tree 
from which you constructed submodule_rel_path. (That tree may not be 
the tree at HEAD.) 
 
