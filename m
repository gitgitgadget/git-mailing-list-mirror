Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF25DC433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 14:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiBLOt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 09:49:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiBLOtz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 09:49:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A69E214
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:49:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z13so2318066edc.12
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NWvpedEuAdTo6gdvLYNsJTHDrhDBd0pPBkxprAKahPI=;
        b=KEmeKZRUbjUyZDuk+S5HJdfcC9aFut1tR2VRuRU4yRSIkGRRLd7kwIfZlwD1y9Lefp
         Yb/AUOnX6ILzA+qp+mOcu4AG1hNx94hr+YHRfmKfPT4PVAv0zD72zmiPxdybcyRRAKgz
         A6qAq5bQ4QzvZwFbzSIVZw4LVQIipxQ3mWLxejL+geBQPmmlmt2Jchdj3JYsrIecaOCN
         agj3z71nEBaWMds/2FXyWzcDim/jF0C1gnO6ABhZep1P5IbzgOptTRnRdWSqQIlbzNB+
         BJCV0Ft+tohXUDcNMLoKzhBuR/H9f7u3vEoNawdQYQF5U4K3oYvNthvmfA4JYCN8lpEL
         Lu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NWvpedEuAdTo6gdvLYNsJTHDrhDBd0pPBkxprAKahPI=;
        b=ehOuoWDil65z2WMtuLECQpDKs/xtUB1iO2gm2kXmoRrxDjzsgHxeWehbPBp8gVnhXC
         RIzp8+BCm0cuyCCnTfCuk+M1rhTj8Afts5VvfGZBpk4VYhcU3hozKxJCqn5qe5GjHwf3
         m7+Gd+HJhnWXz74852zfDU3zI22NLZwWWaPR7MWKCtUXWLklNl/4HsfAgEarLClTUEyN
         3sc3LI8ihCWPe3Nn6HD5ZrZZTdnpQY6oVS3P2fwi9WgS2n0smzPuS3SR59Dx/rv5CPnz
         A+x0EDZAm2ZHKUUDozt/K5kT28P1+MWEny7aXnrKpso+dmgUQfSD/l2qxaGzmhR/pW+D
         KMCA==
X-Gm-Message-State: AOAM533DE019XPH4mwW4kaINyWBhR7qMc5O/mM3Eq0BfHBoEy1yVBcaX
        pGeN89QdoH0l2QPSgdBysyHIwisBpzn8gQ==
X-Google-Smtp-Source: ABdhPJzgBqKrB3S0QSw/3fvDwL89/S0Ly0HRw1mxz1baL2Bvp+6Nu1XeWjRiRR8qlXFSw1sbBm5RjA==
X-Received: by 2002:a05:6402:34d3:: with SMTP id w19mr6899338edc.377.1644677384630;
        Sat, 12 Feb 2022 06:49:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ek21sm9933861edb.27.2022.02.12.06.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:49:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nItiZ-000SJA-LH;
        Sat, 12 Feb 2022 15:49:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
Date:   Sat, 12 Feb 2022 15:45:00 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220210092833.55360-1-chooglen@google.com>
Message-ID: <220212.868rugxhq0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 10 2022, Glen Choo wrote:

> This reroll contains another 'easy' preparatory patch and the fixups I
> alluded to in v6 [1]. This isn't the split-up I described in the
> footnote of v6, but it gets the big patch (patch 17) to what I think is
> a reviewable state.
>
> The diff between v7 and v5 is no longer just NEEDSWORK comments, but I
> think it is easier to reason about. Patch 17 resembles v5 the most (I
> will include a diff in a reply to that patch); everything after patch 17
> is fixups (I did not squash them in because they would grow the diff
> even more).
>
> I will also leave a review on patch 17 since the changes were not
> originally authored by me.
>
> [1] https://lore.kernel.org/git/20220208083952.35036-1-chooglen@google.com
>
> Changes in v7:
> - Split the last patch of v6 (the big one) into patches 16-17.
> - Patch 16 moves logic out of run_update_procedure() (because the
>   command is going away), removing some noise from patch 17. This makes
>   the update_strategy parsing easier to reason about, but at the cost of
>   growing the diff vis-a-vis v5
> - Patches 18-20 are fixups that address NEEDSWORK comments from earlier
>   patches. Once maintaining a small diff vis-a-vis v5 stops making
>   sense, I will squash them in.
>
> Atharva Raykar (6):
>   submodule--helper: get remote names from any repository
>   submodule--helper: refactor get_submodule_displaypath()
>   submodule--helper: allow setting superprefix for init_submodule()
>   submodule--helper: run update using child process struct
>   builtin/submodule--helper.c: reformat designated initializers
>   submodule: move core cmd_update() logic to C
>
> Glen Choo (11):
>   submodule--helper: remove update-module-mode
>   submodule--helper: reorganize code for sh to C conversion
>   submodule--helper run-update-procedure: remove --suboid
>   submodule--helper run-update-procedure: learn --remote
>   submodule--helper: remove ensure-core-worktree
>   submodule--helper update-clone: learn --init
>   submodule--helper: move functions around
>   submodule--helper: reduce logic in run_update_procedure()
>   fixup! submodule--helper run-update-procedure: remove --suboid
>   fixup! submodule--helper run-update-procedure: learn --remote
>   fixup! submodule: move core cmd_update() logic to C
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>   builtin/submodule--helper.c: rename option variables to "opt"
>   submodule--helper: don't use bitfield indirection for parse_options()
>   submodule tests: test for init and update failure output

Thanks a lot for picking this up! This split-up is much easier to read
than my v5, particularly with the end diff-stat of the "main" patch
being:

 2 files changed, 201 insertions(+), 216 deletions(-)

Instead of:

 2 files changed, 356 insertions(+), 388 deletions(-)

I think sending a version of this with the fixups squashed in as a v8
would be good, and perhaps addressing some of my comments.

I don't know if my suggested split-up of "prep fixes" into another
series would be a good thing to pursue overall, perhaps Junio will chime
in on how he'd be most comfortable in merging this down. I'd think
splitting such trivial fixes into their own series be easier to review,
but perhaps not.

For the Signed-off-by question on v6, I think you should add your SOB to
all the patches you submit. See this in SubmittingPatches:
=20=20=20=20
    Notice that you can place your own `Signed-off-by` trailer when
    forwarding somebody else's patch with the above rules for
    D-C-O.  Indeed you are encouraged to do so.

Just running "git rebase -i -x 'git commit --amend --no-edit -s'" should
do it.
=20=20=20=20
