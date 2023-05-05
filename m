Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E2FC77B7D
	for <git@archiver.kernel.org>; Fri,  5 May 2023 22:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjEEWaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 18:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjEEWap (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 18:30:45 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB25244
        for <git@vger.kernel.org>; Fri,  5 May 2023 15:30:40 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so2147856a12.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 15:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683325839; x=1685917839;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCS8vmtq0oFMqd/uqbsCMeA0ezBrXdC4lpU0a67aZ70=;
        b=PmscEmHEeJOnpntREp8b620qZh50q9a6l44DfciNv+CtTwfj8cG5uQq74jVtUmec2F
         EpcJsFkMVFV2kY9q6VqnJRiMEe9/IWkTB9LWN9zCN6IqbKoNZ9dvYk6O/+cr8oXIrs4L
         H2yZ6epuR5eq5CjOZaCghuVY8qjr2/eQvWlcdewMiGpWRxaKOdjSrO+g1Qi2OaIhI81Y
         AUMjmo+eAKEVSBTyiLj6b6RNnmMZsWmz3ubwXmegQbs5zEbh0xWqgnM02AtyT+s+soNx
         /tca6iuCUgrrvvFxecm7Nyb/HsEnI5Fr1aXFOehDa4+M2IXj3UkZLtX5ZTuAYkDcHWSk
         EeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683325839; x=1685917839;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FCS8vmtq0oFMqd/uqbsCMeA0ezBrXdC4lpU0a67aZ70=;
        b=UaVNv9A0tY9dkoFZPNWSQWbJ6nstv7k8/Yi/fbfnj9Irxf0i9PP518Pov1jqnJ77Su
         ZxVCuE7AX8br5Mkdcsrs7kgnpvwzeauQ/ODNzszHHY+1S5pBqP5+/tgBO1pSvwx+y1Sf
         Qkh0e5p0rUWGJC81k7Un1xeZGWHR8/4wV5Itz9/5vIK7V8NcjEDK49ExwehdmaeNChZq
         oZgmDtbu8jcIwl7r831YP31aK14vpvhMYwvZwazeaSn+X/DkfykMgdCI+kKeiyHwdSKG
         SaSFlYumu8fuAu290wrcElnn5noj8W8/04Xqpcf2lV3tYNYrouhbdfmeyICkDG1sArg0
         VUQg==
X-Gm-Message-State: AC+VfDwXGYQaz/HgNSAJwkwTI8UN8D4i1Qzb87wKDY2pq5IC5RTxCEdd
        gEEhmeAM52N9/V0WwMqq+3o=
X-Google-Smtp-Source: ACHHUZ4bXGTev5zzY+A88iW9j+lqsk2E2t5JKkSNawK+av8Q1SLmZRCvva0AtNXDaDYIvibVs7OXmQ==
X-Received: by 2002:a17:902:ea03:b0:19f:2dff:2199 with SMTP id s3-20020a170902ea0300b0019f2dff2199mr3109622plg.68.1683325839451;
        Fri, 05 May 2023 15:30:39 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b001aae64e9b36sm2264759plg.114.2023.05.05.15.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:30:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com
Subject: Re: [PATCH v3] setup: trace bare repository setups
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
        <e98be8e7f703fc741e06d9208545abc8c24d1a4a.1682962110.git.steadmon@google.com>
Date:   Fri, 05 May 2023 15:30:38 -0700
In-Reply-To: <e98be8e7f703fc741e06d9208545abc8c24d1a4a.1682962110.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 1 May 2023 10:30:37 -0700")
Message-ID: <xmqqa5yicsxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> safe.bareRepository=explicit is a safer default mode of operation, since
> it guards against the embedded bare repository attack [1]. Most end
> users don't use bare repositories directly, so they should be able to
> set safe.bareRepository=explicit, with the expectation that they can
> reenable bare repositories by specifying GIT_DIR or --git-dir.
>
> However, the user might use a tool that invokes Git on bare repositories
> without setting GIT_DIR (e.g. "go mod" will clone bare repositories
> [2]), so even if a user wanted to use safe.bareRepository=explicit, it
> wouldn't be feasible until their tools learned to set GIT_DIR.
>
> To make this transition easier, add a trace message to note when we
> attempt to set up a bare repository without setting GIT_DIR. This allows
> users and tool developers to audit which of their tools are problematic
> and report/fix the issue.  When they are sufficiently confident, they
> would switch over to "safe.bareRepository=explicit".
>
> Note that this uses trace2_data_string(), which isn't supported by the
> "normal" GIT_TRACE2 target, only _EVENT or _PERF.
>
> [1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com/
> [2] https://go.dev/ref/mod
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> I'm sending a lightly-adapted version of Glen's tracing patch because
> Glen will be on vacation next week and we'd like to get this upstream
> ASAP.
>
> Changes in V3: added a test_unconfig test case for safe.bareRepository
> Changes in V2: cleaned up test-style issues.

Thanks.  We saw no interest on the list in reviewing this patch
further, it seems, but I didn't see anything glaringly wrong, see
no reason not to merge it, and this should help noticing potential
issues by $corp folks, I would presume, so let's merge it as-is.
