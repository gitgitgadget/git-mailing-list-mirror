Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24586C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02947610F7
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbhHMQvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhHMQvP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:51:15 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D597C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:50:48 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v18-20020a17090abb92b0290178fa401bdcso7150375pjr.4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ojXQc4ZbZ8WphgzF8oA73nlLcStrSJfvzuhjKblfdPg=;
        b=n3+ZYzJOCnltwnVp44KUSd9VuYpZLbW6XJA7cOdajeC3fZF/AeJOEFmLs02wDnvkPK
         nh9NAoZJFusuaZd9xWeMv7Az7Qrzp91vl1TRSv2sqEosB9uEBASFt07G5vb7OM3Go10y
         tIQ3PKMqCQbzepNLvMmeFd2Xmyvvk8DBI4kKr+sgjssCt4btQ+3hTHhVlqvLLrvIe8lw
         HBMkQD10TJXzdohmrdyMrixuA3vsvnfd4Znxd6De95IiLlqUFGu36gDlr3nlFyRM6bj4
         2a/QUK3KYgY1M4k4CfaYywB8pU48K2HqPiK8fnskyz51BUUSxcciH0gNffd4w0eQhBY6
         SjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ojXQc4ZbZ8WphgzF8oA73nlLcStrSJfvzuhjKblfdPg=;
        b=EnHPA8K8q2668XN2SkTVlRz1QddreLoBiZg81VluRWPCB+8bpIfv5qHDRe2ZrTjibg
         nR+wsqsH3Z735CqU3zv8/9FkcMUt4UVw+0CxE911+2h+jqdJlaw/o0ejgXIgrCdWGqVU
         RPLRRXi6bR9u2lDVqAHFjy/h5myGVYPtimuR3lkkk+ZKKkyFGS6mST+YzHIQP58t9dAJ
         XQemM9lXL87gFP4yYhONw6fv31capsUpSf5CVEVdYidygqvavbSQx4JNfizhSsCD62ks
         TOrreppId8ls1GJQeTgqndFudMoVUxSIA4YUEpfBjdt7xkGEhKDR5FpGcLfecOt6Bkg3
         Rq1w==
X-Gm-Message-State: AOAM533XRE3scSYLpLUF144ffW6uidyuqnd20XsYddWZ/ntcGQV8QErz
        +n7G1dYwnwyA0/Ny8ti9fli+Py1zN4sftlMTt+h5
X-Google-Smtp-Source: ABdhPJzuKUwEeKZyoJrxLTNCm0kIYz9PkzEdCTB6ilGbFBpOQ2ye0ZCIVw7vVF1nY3VRBb/XkQR7+9L7itKyne2xS2/N
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:c981:: with SMTP id
 w1mr49570pjt.1.1628873447536; Fri, 13 Aug 2021 09:50:47 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:50:45 -0700
In-Reply-To: <CAHd-oW7NKNeujverFiRUR2p1nfOpjrv1xDrsvTVa1Yw5jC1D0w@mail.gmail.com>
Message-Id: <20210813165045.3220845-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAHd-oW7NKNeujverFiRUR2p1nfOpjrv1xDrsvTVa1Yw5jC1D0w@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH 7/7] t7814: show lack of alternate ODB-adding
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matheus.bernardino@usp.br
Cc:     emilyshaffer@google.com, jonathantanmy@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hmm, there is at least one call chain in grep which might end up
> calling add_to_alternates_memory() directly (although it only seems to
> happen on a very specific case):
> 
>         grep_submodule > repo_read_gitmodules >
>         config_from_gitmodules > add_to_alternates_memory
> 
> We can check that with the following:

[snip reproduction recipe]

Thanks - it looks like my patch set is incomplete then. I'll make
config_from_gitmodules() use my new function and if the existing grep
test cases don't cover your reproduction recipe, I'll add yours in.
