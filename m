Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6873CC001B0
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 22:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjHNWPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 18:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjHNWPS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 18:15:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A5E54
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:15:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d679709cdb5so3734009276.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692051316; x=1692656116;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k1euWtJTKLSL0weGkoRVbzvKwUNcFnHuFkWGQj9ndlc=;
        b=LNajQnqJYQIjd9guPwWQ21bnzxwv2Z6j+9S/xHWRFifvMCG8rw/0AGJVN7FrC8NmoN
         s/V0KcPBkzZVDvmjCqLsj0IXzacM5lUTLhw0uJwlKrRwzhtLqjCaexMr9D6ce77gDu2E
         g6T9GNXAYkfFynqAY+JaYzzFn39iQS6YJ1utV4P8po9hm84xyfV8CLcQoX/VfAIaN9NF
         uhIHuM1zHkQymYF3uKX2YstfvLtGM8rEEXPJ/HrLgjNBdIxGnVeQzLM2/QsCR+xnDkQb
         xw/tC106ZUyAyvf3v1bSAjYL8tA6/yfjwLal6+oDKsKbqYtTkcjcWAsQLy65w6Ip6oFq
         E0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692051316; x=1692656116;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1euWtJTKLSL0weGkoRVbzvKwUNcFnHuFkWGQj9ndlc=;
        b=Ue5YChQpmY20PfDmm5g4Gl7SysX1gbb+6tyo204U0aImVD6Ji9P/d6w3bVQBdpnmfE
         15nKAgzi8bv/Er4b7dzG21oJfdeQ5XTOaLR/+xA+ajSuLtHLmU0JcNfIVACrE8AVb1AD
         YgoHUfsHqjMjRdzue3dhbnLZgZ1mVqDdd7iE1KtKimTUpChQPu7ny5a6CQBvDOIPCNgA
         G43tPSA4HhP59IstWBAVTWjcGg7KbyMv+cJSnbM8pGAGMhU99qWFEahQptDlILHZwfWS
         LBifXqibnPVw0ak78ws3nAOvTWyEiF7hVPr0oXiwFHTGDszw34M8ZSiFmx2J+wgh7F08
         3+eA==
X-Gm-Message-State: AOJu0YzLa+vBqLl3T6ggxoclJZ429rfYpSHPoYYa/YSKrs0yTHbALU4h
        MqZzn8pMw2KdIoB7B6CZIiL0KJOHkX0CxpNRpkg1
X-Google-Smtp-Source: AGHT+IHCG4hTiH5EG9/8cZdEuuADOKQJHssL2ZotYF+v7u/vb6JWZp/LKUh9evd31pTI2cDZNMOf+Owhyo4uxStf2kjh
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:51f6:bcfb:aa2f:af1f])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1084:b0:d09:17f2:d3b0 with
 SMTP id v4-20020a056902108400b00d0917f2d3b0mr157914ybu.9.1692051316741; Mon,
 14 Aug 2023 15:15:16 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:15:14 -0700
In-Reply-To: <kl6ledka8owj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230814221514.62111-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH v2 4/7] parse: create new library for parsing strings
 and env values
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> But, I don't see a why a non-Git caller would want environment value
> parsing in git-std-lib. I wouldn't think that libraries should be
> reading Git-formatted environment variables.

I think environment parsing in git-std-lib is fine, at least for the
short term. First, currently we expect a lot from a user of our library
(including tolerating breaking changes in API), so I think it is
reasonable for such a user to be aware that some functionality can be
changed by an environment variable. Second, the purpose of the library
is to provide functionality that currently is only accessible through
CLI in library form, and if the CLI deems that some functionality
should be accessible through an environment variable instead of a config
variable or CLI parameter for whatever reason, we should reflect that in
the library as well.
 
