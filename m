Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED68C4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374AC610D0
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbhHXSCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbhHXSCm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 14:02:42 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9717C053402
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:51:11 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s3-20020a1709029883b029012b41197000so5902357plp.16
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DrZD4bqP/i05LPWhSvrbBceFUtK2+birPIG1TI4ayM0=;
        b=R4iSG9FTihfGVw1YHpcs9nLRwzml1ftL2MApWouLfn2hKDM7WrSPC9bHgPZVO8XOQd
         BauopxP+C35ZUA1YcMO483Rh/cAh5B4V8ImnFsbdI2IRg9uLDAXXWXJrMV7bz4Umpu0b
         QHTvLZzNWoKPOu/z08/jSW1NiVr84dU7ntxp+6Xda4Ej80unoxS6Ht4sm2QpO1lupehJ
         DaEoi9JYzpy5/knIru22dCFHJcS4tyyNPgdvs2plVXIIJMW4M82+RWxOx4nk8k39WpSd
         2oj1dAnnwCIAGZD/xIMldcS3cNB8t03lIjUbxjyhWB9UZvVpjLD1r2eP5PWK5ZUqK0IG
         W1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DrZD4bqP/i05LPWhSvrbBceFUtK2+birPIG1TI4ayM0=;
        b=GCFhnKiQnHIJr3MIZ8ZxSGPyCHEJYkCdgw896PkCW+A0hQNSedjka+jUkTL6r+4dyV
         L3jKgbsBs7gdumjZyXoFk96WuZ4fh8LORKJnWYJcUdRWNYiOThSvGCkDJsHB4Y1lKXo0
         SZsllofwwDbi8nFzt5veOPWcvAGETrJZKA/zI9y114p5TS+mWWnYnixMoTpJ5HOTzAOm
         ronE3CcheoGZfIZZH8taNbbv69xGYM6qqTAHNg/IqWLEd6HRO9X+0yxsTFq576lOk/DY
         nkc7sEsIPh7LraHNWf2MlS/Cm01mJHOn/fFHHjpKa/DbSh/dHFJTTJqqH33GFhJrNmG4
         v/Hg==
X-Gm-Message-State: AOAM533V8h2WXXiLzqyahDOiq2yaLQCu7xI65AN3Y8YU0zTWoFMn5V5Z
        Bb9LWUttcxJ6ATHuMENvQ6kD5HmvwcShgtSkx7Sr
X-Google-Smtp-Source: ABdhPJxw7trcXayGpYe9Q55TNyejKwZODqaUCITInNI5fdpM2ghhuFk3EfpbQP2pMxczE4txJ5ivsEu881xQLOP7Y2p8
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:702:: with SMTP id
 l2mr96358pjl.0.1629827470903; Tue, 24 Aug 2021 10:51:10 -0700 (PDT)
Date:   Tue, 24 Aug 2021 10:51:05 -0700
In-Reply-To: <xmqqo89nq1sa.fsf@gitster.g>
Message-Id: <20210824175105.200959-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqo89nq1sa.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: Re: What's cooking in git.git (Aug 2021, #08; Mon, 23)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        steadmon@google.com, emilyshaffer@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jt/grep-wo-submodule-odb-as-alternate (2021-08-13) 8 commits
>  - t7814: show lack of alternate ODB-adding
>  - submodule-config: pass repo upon blob config read
>  - grep: add repository to OID grep sources
>  - grep: allocate subrepos on heap
>  - grep: read submodule entry with explicit repo
>  - grep: typesafe versions of grep_source_init
>  - grep: use submodule-ODB-as-alternate lazy-addition
>  - submodule: lazily add submodule ODBs as alternates
> 
>  The code to make "git grep" recurse into submodules has been
>  updated to migrate away from the "add submodule's object store as
>  an alternate object store" mechanism (which is suboptimal).

For what it's worth, Emily Shaffer [1], Josh Steadmon [2], and Matheus
Tavares [3] have reviewed this patch set.

[1] Reviewed-bys in reply to the patches in
https://lore.kernel.org/git/cover.1628618950.git.jonathantanmy@google.com/
except for patch 6
[2] https://lore.kernel.org/git/YRRT4I3MPoZXJZEl@google.com/
[3] https://lore.kernel.org/git/CAHd-oW6Va31PaTQeoSrwi09wjHk63S-Xd_PYtW1trhSokoKizQ@mail.gmail.com/
