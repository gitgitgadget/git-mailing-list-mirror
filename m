Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6197AC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 18:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A28A60F44
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 18:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhJRSKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 14:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJRSKt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 14:10:49 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F774C06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 11:08:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h3-20020a170902704300b0013dbfc88e14so6736458plt.13
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=q0JQCU0QY+japUsaBTF7mXOytCmnM+9NocKtlU2Lab8=;
        b=EqM5ynTa5u/mKQHoRusSi4o5eTw3mojiMW8z7vjUKfE+Ap0o30pMBpSHip2CAySNdU
         oBvrskMcS9bVPtzYQ3YBggkO0rGJm30Q4exm5AlRFCQAz+4nNpEvMQQzeoEXvEX7wOyc
         UFNGzM7i0kTQ43nr56vBLMFxOYe01fb53mI7JEAUV7mMOhpHtj7htWsQ8Xv4VoIdZVVM
         PsLpWYHW9Ly+vv0UW/cqbqgQT/J2EMvPpQOlFVPaM3leBVB1r0ta9T2G/aBZxq/EEdwP
         +a3dTVmGrpJXw36iQNwqwkBjgqBZnXssrrtpHiH9R+UVYnbgqSjQlbBorgj394Pr4aH5
         rAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=q0JQCU0QY+japUsaBTF7mXOytCmnM+9NocKtlU2Lab8=;
        b=YOVbfS+gJCRl7mcQNMMR5sa4kT/8zlYDWSG3FJDz4SuUNZy3/s/VwR//cklnzaLjWn
         kLrI+jM26whZVMt4ryvKVLJP3/cEnT3tRf/uh43+L2UbqBweWwcIPqzRliu/9UofERjR
         7ADxXwAE3tVNha/ULSWsGREZ8YG3wi7iNKUQpqrmwbJFElklVvP9Sv+HfnyJG+3aMoTA
         44vLIakBe2zCHduQiOyW8M3/aqKP5frZwgx6BXI/l8pgb5ovU2A+t00BrPNWZ4+PNCld
         xvupDCl/p2bLmZJTfHjoUtlItYBwh28t4FwSpmo7pmuajHqpoercirPKe9awz6KRoxCM
         kNWw==
X-Gm-Message-State: AOAM532h8mX9kb2OCYI0So1z9z7N0IcPuDbf6j6DTFsurzWompldbTvG
        dNAtYMM5lT5P6M4dO0eXSmfA/uGM/sfe3w==
X-Google-Smtp-Source: ABdhPJzC29a8OyToE1EwIZhQIrD227gW6lGUDYm34giGE7B+HPjLeOuzlNghWyjE8ur0S7b5ayTID0tQTJCx3w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:398:: with SMTP id
 ga24mr476329pjb.87.1634580517573; Mon, 18 Oct 2021 11:08:37 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:08:35 -0700
In-Reply-To: <kl6lwnmaz0gy.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6ltuheyzmk.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <kl6lwnmaz0gy.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH] branch: add "inherit" option for branch.autoSetupMerge
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I believe that we can get the branch remote via struct branch. Instead
> of reading the config, we could do something along the lines of:
>
>    int *explicit;
>    struct branch *branch = branch_get();
>    char *remote = remote_for_branch(branch, explicit);
>    /* Optionally check explicit if we don't want to fall back to
>     * "origin" */
>
> I'm not sure which is the idiomatic way to get the branch remote, feel
> free to correct me.

Gah, I read and responded to v1 thinking it was v3. Reading v3, it looks
like the feedback is still relevant, so please pretend I responded to
the right email :P
