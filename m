Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F6C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E317861008
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhHEHlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhHEHlm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:41:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CB5C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:41:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e21so6069252pla.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mb140YTlijnDMhJfOOPteejKu+/XUgzobuVOBHE0tGE=;
        b=ZH0qzQgO4vldL2c1SmOJa2VnM+dYnUTCV7fLs71w85zynPz+pH69s7fadBqJB5q1QA
         ysUsFmuK0fCU6oVfjZS435z6zX2I1kPQZsBypL9Z7SJaPBTbVrUtUcmPvZ2OiTA3lGu9
         PlcGT0z81HUgS9FtakSXRwGDEjTF8+VjvHEKcLeQmk1eU8tRxxm+dw0rrhuu4j/h9fXR
         DYSYFQfRifwgg+l4TfP8v323dYt8qdhhUvoI2UZE/hhWxb1MXbQwDzRJftGL5YT+b1dA
         OVX4BAR1enPNm/syQtqAEuhkpnQNXIIvf8xROZqaw/5PygwcpVJLc7iZ8wmGYnlIjMZP
         VsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mb140YTlijnDMhJfOOPteejKu+/XUgzobuVOBHE0tGE=;
        b=IJly/eCXlVtjd6jyxvh9lHRArGOOMPQQiDyJ+OdfMcFCZK7pma7zzDt7HXaCKE0wI5
         dfz3AzdLCVhd3Q6Jm58rdidyl4oqnwoCjDjX0tqzuLe4sVn72TWtSq3pducO7My/TbBZ
         UOkafSXBGoQOsJ8FuT6HO9073EcON2GiKfaKTbieAqWEvN+UA4EBP9/sVkpy9+3qgsan
         PToCGdGd7Zai44pt0TBTf9F36j8jp4v/uhhO4VQprt8XsolELP+czOVyoyTz7QXwG30e
         tx4yutf9uArF2gXvq6zucHexz3DPQd5w/wI5NpwLlOr9x3C7gZeIByL+McCoEtgFjZrk
         Xa1w==
X-Gm-Message-State: AOAM531LjB4b5DRv/MRRPFZCxPminXnzfT7kLYpI5nKuKqmAxaSQIGSf
        Sz81jKvE1kKZ6hNnQRnH7Z8=
X-Google-Smtp-Source: ABdhPJxHnV7RX2Qd/KAOwQHbkt+Geg+ONtZhaKUW05p1rIgefEIb5am7LjZSv/oavHtKsw93LzwfWw==
X-Received: by 2002:a17:90b:f0a:: with SMTP id br10mr3357493pjb.58.1628149287203;
        Thu, 05 Aug 2021 00:41:27 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b2sm4885153pjh.18.2021.08.05.00.41.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:41:26 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v2 0/9] submodule: convert the rest of 'add' to C
Date:   Thu,  5 Aug 2021 13:10:45 +0530
Message-Id: <20210805074054.29916-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805071917.29500-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I missed the adding the first patch of this series, so I am re-sending with the
missing commit included.

No change since v1, except for the inclusion of 75edf24186 (submodule--helper:
add options for compute_submodule_clone_url(), 2021-07-06) at the beginning.

I am including the cover letter of v1 as-is, so the discussion can start from
here, with minor edits to reflect the accurate counts of the patches:

---8<------8<------8<------8<------8<---

NOTE: This series uses the change introduced by 'ar/submodule-add-config'[1]

This series completes the conversion of all the important shell logic in
'submodule add' to C, by wrapping it in a submodule--helper builtin subcommand
called 'add'.

The first 5 patches are preparatory patches. The refactors mostly involve
exposing interfaces to C that were only previously usable as shell subcommands.

Then we have a patch that translates the shell code to C, faithfully reproducing
the behaviour before the conversion.

The last 3 patches are cleanup patches. Our conversions have introduced a lot of
dead code, all of them being 'submodule--helper' subcommands that have no
further use, as we have C interfaces for these already. We remove these
subcommands.

A question about the cache API used in [PATCH 5/9]:
  What is the difference between 'read_cache()' and 'read_cache_preload()'? [2]
  Which one is more appropriate for use in 'die_on_index_match()'?

Fetch-it-Via:
git fetch https://github.com/tfidfwastaken/git submodule-helper-add-list-1

Footnotes
=========

[1] https://lore.kernel.org/git/20210801063352.50813-1-raykar.ath@gmail.com/
[2] More about this question has been detailed in this section of my blog:
http://atharvaraykar.me/gitnotes/week5#some-challenges-with-the-changes-that-are-cooking

I'll quote it here for convenience:

> Before iterating through the cache entries of the index, you need to populate
> it.
>
> There’s two functions for this: read_cache() and read_cache_preload(). I have
> used the latter in my code. The thing is, when I swap it with the former, I
> could not find any change in the behaviour of my code. They appear to function
> equivalently.
>
> I understand that the *_preload() variant takes a pathspec which preloads index
> contents that match the pathspec in parallel. I don’t know what passing NULL to
> it does. Moreover, does this imply that read_cache() loads the cache on-demand,
> ie, it does no preloading?
>
> I am not sure about what exactly are their differences, and when is one variant
> preferred over the other.

--->8------>8------>8------>8------>8---

Atharva Raykar (9):
  submodule--helper: add options for compute_submodule_clone_url()
  submodule--helper: refactor resolve_relative_url() helper
  submodule--helper: remove repeated code in sync_submodule()
  dir: libify and export helper functions from clone.c
  submodule--helper: remove constness of sm_path
  submodule--helper: convert the bulk of cmd_add() to C
  submodule--helper: remove add-clone subcommand
  submodule--helper: remove add-config subcommand
  submodule--helper: remove resolve-relative-url subcommand

 builtin/clone.c             | 118 +-------------
 builtin/submodule--helper.c | 304 +++++++++++++++++++-----------------
 dir.c                       | 114 ++++++++++++++
 dir.h                       |   3 +
 git-submodule.sh            |  96 +-----------
 5 files changed, 280 insertions(+), 355 deletions(-)

-- 
2.32.0

