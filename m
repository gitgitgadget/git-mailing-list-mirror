Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6532DC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 22:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358319AbiFVWDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiFVWDe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 18:03:34 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E521707F
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 15:03:34 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q102-20020a17090a17ef00b001ec706653e0so330948pja.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=5OGSuwqTCSK7nxVQAvbkNko1jopNP64mwPm8JfEBrv0=;
        b=VwwJL18p4eKwWfmMt+fAJzty2JlvB/oFO/HdKdHzVXU+GukxfFGmwqzchHp5l5Md6a
         EpF5F+LRc85vM8mL8auwIOZQ11JownShGXBEfZqRmrhtOehQhNcFFK+vQWEJau+wBCGO
         f9Cyml8m1EKofoF76o8IzuAIQR8Vf8nylbTH9otVoNaIgErp8+JG8EHLWU7XdeFbV1OG
         WbP+LuYPEd+zzJCFaXEj1gmdAZU6/kw0Qe+SHad2RuR90NjQkqApTrT3uhCNRgibufLm
         GZTt5UhO5USRrePfmVF/s2BNwtbHeZrV399EyZE3qIDmNmMhA+2xBi5EnjjvpZcOPP8k
         A00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=5OGSuwqTCSK7nxVQAvbkNko1jopNP64mwPm8JfEBrv0=;
        b=ralMx3TSmeQBZXBxXTKaltQ0ZivxyTq3saHOkE8Vn6avYoQxbCiSZ1n3SuBrWq1lL/
         2gjZLmyNNZ7Z2UxyxJZX6AuVw2CO0+nQ5mAPV6i6oZrxRRJVppSOTddntNRIlMSOT5J5
         HZRAZHc8nz28xnYySUO7TE4MJjKcgY0SaDsLYBgHlE0iJ+AMZmMcD2C2PzMcsemjfQDN
         osXlwxgsfRA2jghAfxEsaHI4N1NxEVl3rPHuuwl26HQ5ci1frIZ7jmhZanG9XAYQKpPY
         F//+sBsoo51kKDn9KrIjWAthsojbYY97a7tcOYMiYuoRzGZQbda9SjqYoCJmExP5mVo3
         /ITA==
X-Gm-Message-State: AJIora/IgLxiPWZ/cZxBlnr8pdiERhZa6+UoVEUqlPhjK7xDlu6G79Rp
        6Y02y1vrCQIBEIizFNPikdGUQd9eFt7PXbCkFEq7
X-Google-Smtp-Source: AGRyM1sS8Cj19Ugk9kA/aKkeRgp3cGvtBrm4mly5YUG9hExtD2kLRkTKTCz3jJ1s1z005ZgK5PwJt5QbBZXf8BC+0WET
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:780c:b0:1ec:d94b:2f93 with
 SMTP id w12-20020a17090a780c00b001ecd94b2f93mr503737pjk.233.1655935413793;
 Wed, 22 Jun 2022 15:03:33 -0700 (PDT)
Date:   Wed, 22 Jun 2022 15:03:31 -0700
In-Reply-To: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
Message-Id: <20220622220331.3734584-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH v4 0/5] config: introduce discovery.bare and protected config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> Glen Choo (5):
>   Documentation/git-config.txt: add SCOPES section
>   Documentation: define protected configuration

Forgot to mention when I was sending my comments on patch 2: we should
standardize on "protected config" and not use "protected configuration"
anywhere.

>   config: read protected config with `git_protected_config()`
>   safe.directory: use git_protected_config()
>   setup.c: create `discovery.bare`

Thanks - I think this is a nice feature to have. Everything looks good
except for some minor comments on text in patch 2, which I have sent.

One alternative design would have been to have separate configsets for
protected config and non-protected config (or even better, separate
configsets for trace2 config, protected config minus trace2 config, and
non-protected config) but that doesn't have to block the submission of
this patch set.
