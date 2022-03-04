Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A61C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 21:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiCDV20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 16:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiCDV2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 16:28:25 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E385F27C
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 13:27:36 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f18-20020a623812000000b004f6a259bbf4so2776895pfa.7
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 13:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1RyjwSuMc2Kk7Sm4noKt7oyDZBoTLbqZh1HEJoTEp98=;
        b=CeuvPACK55obQfOo3fFoE9Zj/yE1wB/9WoVFI3WKMz+gFYF6IgvZ5tSKzbzTzCbstb
         i2oQFr9mwCFnlmjJu0/+bNl8ESGTT/J5NlaA9B1MacuQa2ni30CY1hcPieIU0/3lyh1K
         u56wDh7mtvXYJNmg14c/6f6ZCy1LCq/TIc2E78alKxFEtyPhlk2NGxkm86xoXsSK8sGV
         1dYabe5aKJGmhO4RL2/zlhyrxroqPtlB9AIF4K2aN9YMmSXTHpyEvQmbqJsvb2oDPXRO
         x5YYVM7KkniMSQDo2YtnchSdYhTi8kmifkTNu6Z3JSmaGBDbf1OtcCx4iZDXxqjk+cEJ
         RJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1RyjwSuMc2Kk7Sm4noKt7oyDZBoTLbqZh1HEJoTEp98=;
        b=E4P1B6pMtoDYqcM/+SnJQWdTLvl1Z43t7ve4rAUQyC7Y/cJVUShYE0DzKiGI+rMKk0
         P1SFXwjFNYgcHD/sjzmln0MTKoL2O1EMzu4xVySo2vin7I+DEc/OmrsZneM1U6ACJIOG
         B4WuOBgYa75olhS+HwK1d3eZUBLIZEhLlyKHdQRue6tHKrAaAEXrMvngqGGvcVoAiPKy
         Ufm8zLa2cuJ8PtjVNycHy7/9x8e83QOrw7QfiurwIz+Eb1PeKq7ymBiMVih5Zhho+OIG
         5vey7erWFmjDgPPUGdjGLzpX6OWYZUsnPMhEenJ8sAHWEJ5CU+WyPd1hkhrML5DlBYNW
         0Y/A==
X-Gm-Message-State: AOAM531L4LsY9gMLW4CYAV6xolfxoE4sRfODpY6lKydOy8q5HVqSC7Wh
        jxhRE5rzyTnCEvvFGkQrAFFSLFzBQYrL2A==
X-Google-Smtp-Source: ABdhPJzHwiRZbDz1SQG2V4CVcvV4mUzNu6HmKcWFEu8q51ukMfrU9qIN/z2VeSGakIWR3wuuyMty8HiDpxk17A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with SMTP
 id pj3-20020a17090b4f4300b001bc7e5ce024mr717778pjb.0.1646429255968; Fri, 04
 Mar 2022 13:27:35 -0800 (PST)
Date:   Fri, 04 Mar 2022 13:27:34 -0800
In-Reply-To: <xmqqbkymaftr.fsf@gitster.g>
Message-Id: <kl6lfsnx4ddl.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
 <20220303005727.69270-6-chooglen@google.com> <xmqqbkymaftr.fsf@gitster.g>
Subject: Re: [PATCH v3 05/13] submodule--helper: remove ensure-core-worktree
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Move the logic of "git submodule--helper ensure-core-worktree" into
>> run-update-procedure. Since the ensure-core-worktree command is
>
> I take it as "... command is now obsolete", or "... has become
> obsolete"?

Yes, that's a better phrasing.

> On the script side, the removed call to ensure-core-worktree used
> to precede these invocations of the helper
>
>     submodule--helper relative-path
>     submodule--helper remote-branch
>     submodule--helper print-default-remote
>
> before we triggered run-update-procedure, so these helper calls were
> done only after we made sure we have a submodule there at the path
> and its configuration file has core.worktree set correctly.  If we
> failed to do so, we wouldn't have made these calls.
>
> Now we call them unprotected.  It is not immediately obvious if that
> is a safe/sensible thing to do.
>
> I would imagine that we would lose more and more code from the
> script in the "while" loop before run-update-procedure is triggered,
> and presumably the equivalent code will be added _after_ the call to
> ensure_core_worktree() this patch adds to the beginning of
> update_submodule2(), so in the end, the above will presumably become
> a non-issue, but the series structure still feels iffy because of it.

I could restructure this series so that this patch is as late as
possible, so we don't have to worry about safety for 'remote-branch' and
'print-default-remote', but we still have to consider 'relative-path'
because that's still around by the end of this series.

Fortunately, relative_path is just a wrapper around dir.h's
relative_path(), which AFAICT is just general purpose string
manipulation and has nothing to do with Git.

(I'm also certain that the other two commands don't interact with
core.worktree either, but I'll just restructure the series so that the
point is moot.)
