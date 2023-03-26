Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066CBC74A5B
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjCZWTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjCZWTm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:19:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5FE5B97
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:19:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e18so6790257wra.9
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679869180;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk2ov6Of4Nylkg6cx/y0zhS1YPP8KacROJzZfw9AQCQ=;
        b=izgtILGYDb9pMfxbGyPF0F8UF3UwcBh94f9RjcFi/j9yw7+7Jw0z41dWYmXP55CCD/
         8XtH6ebDJURxMM3Uh4+kUnVQZN/hXYUlbXKF7wSpjGCgoHqN1x/QVKz8LHuqZoTtjYGC
         y+CB5t8DKz1rB/iW4MUdOUxcg7MNGuQCQKJKheO1+hzFi6j0Z2PhZ1buxMe8ADpfqvkw
         EJ1zr5L63wO+jyi9QfJ9MxmRJ8Nv5fbL7XV/DTe2/OTPdEXX3X+bZmSCp8pKaotCAU5U
         UeRlSgYZMHwvLQzFLMbxMczE2un4zGWLGWOv8pc3jjiO2krfUxmIxSur0JSVKG+JVxUw
         OCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679869180;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk2ov6Of4Nylkg6cx/y0zhS1YPP8KacROJzZfw9AQCQ=;
        b=cU+n4RmZpfBhFtXlDZLMaXZSvbue1dmRfgggp+Wc9uNtVS5SB8wwRfPY+z3z9c0iTD
         A5gJJfzxAsZu272aTVBbhW34/2Hg1jrAD67qZOdEbJojhTOXmYuFFLFMHzfgV9ofWyMY
         1zEjrTBfA7xM6WvEtsW4nUnT4NMtLHDmbwHcLzFEXwnGZaUYoCY5+a2dtj6il9GJj57h
         nn8ooGOyQbudxUBFriBxqlFRopw7k0HOdA8r4W5hHfZulH2aROFAr48DjMo+8MtYSWKa
         EKsZ/2GtOrvamJCsNjvnVy5Dicg2gs7OAf5PBd94QPCr8omKtW8xaWlXDkvO0O1KEmp2
         Jgkg==
X-Gm-Message-State: AAQBX9duE5Jw951sVcwtnDVss3oBQd3wPiPlJlq8dIFsbkU6syDFy6xo
        0XFHd9DsOuj1TWWLfsIeflA=
X-Google-Smtp-Source: AKy350Y2I/rNa6gq87b1TnVjrXwNm9e1SG6WJNzASmM2nRR3cUidSG9xElZvVdTmj4aLzO6wg3tkMA==
X-Received: by 2002:a5d:42c4:0:b0:2d8:47c7:7b52 with SMTP id t4-20020a5d42c4000000b002d847c77b52mr7447815wrr.9.1679869179869;
        Sun, 26 Mar 2023 15:19:39 -0700 (PDT)
Received: from [192.168.2.52] (96.red-88-14-208.dynamicip.rima-tde.net. [88.14.208.96])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm17301049wrp.42.2023.03.26.15.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 15:19:39 -0700 (PDT)
Subject: [PATCH v5 0/5] branch: operations on orphan branches
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
Message-ID: <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Date:   Mon, 27 Mar 2023 00:19:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The initial and main intention in this series is to avoid some confusing
errors operating with orphan branches, when working with worktrees.

It's been a while since the previous iteration, sorry for that.  Here is
a quick overview of the previous iterations:

In v2 a change was introduced, to avoid some unnecessary worktrees
traversals, which implies disk access.

In v3 and v4 some refactorings were done, such as making some names
more meaningful and, mainly, inlining some helper functions in its only
one caller.  No functional changes were expected.  However, those
refactorings introduced some undesired behavior changes; some were noted
in the round of reviews, some others during the preparation of this new
iteration.

In this iteration, v5, I've reverted some of those major refactorings,
mainly the inlining, because it ended up introducing unnecessary
complexity for minimal benefit in this series.  Maybe those refactorings
make more sense in future series.

A new test has been introduced, in 1/5, to notice if a behavior change
similar to that observed in v4, is reintroduced in the future.

Other than that, no functional changes are expected from v2.

Rubén Justo (5):
  branch: test for failures while renaming branches
  branch: use get_worktrees() in copy_or_rename_branch()
  branch: description for orphan branch errors
  branch: rename orphan branches in any worktree
  branch: avoid unnecessary worktrees traversals

 branch.c               | 27 ----------------
 branch.h               |  8 -----
 builtin/branch.c       | 71 ++++++++++++++++++++++++++++++++++--------
 t/t3200-branch.sh      | 29 +++++++++++++++++
 t/t3202-show-branch.sh | 18 +++++++++++
 5 files changed, 105 insertions(+), 48 deletions(-)

-- 
2.39.2
