Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8725EC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D35761058
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344807AbhIBNCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbhIBNCq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:02:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FEBC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:01:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1391429pjc.3
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kFN+7fxvFEC0LCQIdmroJass0zB6sbXhrQEJYlr4HqY=;
        b=M+9ph2ToHrI4FwAwZkr2MFomNRadJz3SFEqSXNdW0+nBT6bEAuYd4fBziRhHoDrgc7
         WTT5JezTmKeIv1hCvs2gK77Zsk6RvfDw6xbPGdsqDzydpvMvd5rofhc29eEpXsYHTZFk
         gt9Unw3cvtQRkMscqbV2sn9OocAC+P7pN1kFUfzCocm1/z56VcDN9mlbOlkHF0dR62RZ
         g9q8qFIGnHVFmUHYb2aV9eaXzyS713FCZ829lCxcjScKHEPkx+ndqEDrJIy1jAvULbBA
         IhyhvJCcGNdJnz74WNYigcuvYaKO6nzUB0/hWXXDPieqFUcatgwJuvDFCFkMgQEFMhbe
         uu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kFN+7fxvFEC0LCQIdmroJass0zB6sbXhrQEJYlr4HqY=;
        b=kW/mNp10zdok8sxELxJp+wpLpHMN4mnRmXWPBqGT3mbtHp9sQRiWUMWiiI890RVBaC
         GmAaYQeNG45C4+JqRLCbVUuicWRY3rOD9sVaIL4SScYh5QoR+jNF1W7r2BK6w3fN6fgu
         B5NycO7F6pleRU75H8mFPhz7KUNRVJbQOdif+5L3ECYEoQQdhCv5oChQGLD++lzB61Dd
         hyNkNcv6TvMuz7z9xHpqUvO4ij1PTiwwqyWtF33BBblj+SlcSz8yM6McZE1yOKiAkudj
         JOyYWkcYSsIuGoNR/QcFK6x6YbOrKRGq3JSTsKbAD7RPJQd4ZwMv1071yaCfnx3bC18a
         fkig==
X-Gm-Message-State: AOAM5316kinBQ4DwL9qdHavMIBaLyE9ZaSQH+izTkGQDG5CuPOMJ8JL5
        Ud/+3HW8hgSIb5RlDsFK/lA=
X-Google-Smtp-Source: ABdhPJyOuZdPbVtHbX55lXL2klsn4llrGVEkBE1qr3M6/gCFIjW7s5/lERvbnCnMWh5qaizG+erRIA==
X-Received: by 2002:a17:902:e74e:b0:133:7a42:90ce with SMTP id p14-20020a170902e74e00b001337a4290cemr2791238plf.83.1630587707278;
        Thu, 02 Sep 2021 06:01:47 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.145])
        by smtp.gmail.com with ESMTPSA id 17sm2390414pjd.3.2021.09.02.06.01.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:01:46 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     adlternative@gmail.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 09/14] commit.h: add wrapped tags in commit struct
Date:   Thu,  2 Sep 2021 21:01:39 +0800
Message-Id: <20210902130139.78316-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.g1a7c4c5894.dirty
In-Reply-To: <CAOLTT8Qm2wGMU0RuX+OrzZt78zSmzxHNoh0NYUFuVKJSAZJ1Ng@mail.gmail.com>
References: <CAOLTT8Qm2wGMU0RuX+OrzZt78zSmzxHNoh0NYUFuVKJSAZJ1Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


ZheNing Hu wrote:

> /*
>  * The size of this struct matters in full repo walk operations like
>  * 'git clone' or 'git gc'. Consider using commit-slab to attach data
>  * to a commit instead of adding new fields here.
>  */
> struct commit {
>         struct object object;
>         timestamp_t date;
>         struct commit_list *parents;
> 
>         /*
>          * If the commit is loaded from the commit-graph file, then this
>          * member may be NULL. Only access it through repo_get_commit_tree()
>          * or get_commit_tree_oid().
>          */
>         struct tree *maybe_tree;
>         unsigned int index;
> };
> 
> According to the instructions above, I wonder if you should use "commit_slab" to
> store part of the data related to the commit object instead of
> modifying the member
> of struct commit itself?
> 
> See:
> https://github.com/git/git/blob/master/commit-slab.h
> https://github.com/git/git/blob/master/commit-slab-impl.h
> https://github.com/git/git/blob/master/commit-slab-decl.h
> https://lore.kernel.org/git/CAOLTT8Q8BEKCVwPDypW1w66P9_xP7QC0T-CnLqamqAL4haGzwA@mail.gmail.com/

Awesome!

Maybe it's what I really need now, I will make a try.

Thanks(比心).
