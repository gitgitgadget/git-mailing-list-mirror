Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32FBC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DDE206D6
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 15:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeK6FkXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505330AbgDPP2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395269AbgDPP2P (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 11:28:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E367FC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 08:28:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i27so3378692ota.7
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZD93f4ogDySz/iFhdLK11JS4JyF91JRF4tOokPq17O0=;
        b=UeK6FkXohyd1jEQOozWFVmCDhyq5vx8+tz/Hyp5vke5LrkFeSQjiBxaNCsfpB9BT8R
         6OrubuhEj1yb5GScue7m5IkMebyJPdq8YWXVyNweQ9HIuM0C4vtZTpzGjEvWT5i5QuzA
         8FymJdO8lt8AlgYIfTQUrbfM02G5/sdRDK+rr79NsuOk54MGYVlUBfyoHsQEEqnNhVe/
         hMJCk/c92aPUXjg6xPo1AYUnTomK9B7fPJnAjneyTp3Zt8TZQboZVn1V23D4dhxZSxDo
         bsc5zCWckH2QFgFZqi3TsioQmIyaCOHVJArREyCDIJrW/OqXp6mO9VEVayIzIYSIQn1a
         xsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZD93f4ogDySz/iFhdLK11JS4JyF91JRF4tOokPq17O0=;
        b=Oxj7pdvwmfkF1BQ3NlfAANdFxmg/DdJpueCINSatBXY8z8/jJ2nyN0+zStly2urYq3
         h4OfgZmscSAjxd2HOb71nq+FgXRyqqM3eNlfa8ncrqnbvFVr+ctSqQ3CaYi2OfLlbGQb
         /Z+O5BtMBzicEEY8HH7P2HVWtxeBh4bsvUo+GJzzb7jtEqLWgiw4ROfU4vatyagb9X+N
         oUy41CJAacbZ8CJRpRANBM7X5qfpZdNfnBnnJWQ5QLkGkGmWEulRXDU2g01wcFeywUwS
         MDJ5qvVTD5usBkDgR4ENK60tge7s/iVqAAFzznRpuT+VXHRaf99M2bfjCTRdVk8YwS5m
         no/Q==
X-Gm-Message-State: AGi0PubDVEnd6ODlbn28dSf9XXTf/WZkRCAKGT0w95Q6Cb7Qv7xKJ+DC
        5+vUPBW1bVx22ntq/i6gz7emDMdXL+gD/I3FyeXzFlxs
X-Google-Smtp-Source: APiQypKS0CA5wFK2Ke2xR9wLSnD2NjN83wm/e3P2md99BzbUiIrZHRWtlO8WyST8yBbCP+LrpmuSNUaMR6TuD/o8BNs=
X-Received: by 2002:a9d:23e2:: with SMTP id t89mr6537509otb.316.1587050894163;
 Thu, 16 Apr 2020 08:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 16 Apr 2020 08:28:02 -0700
Message-ID: <CABPp-BE6xrKLA26Xn4apW-MReCeeyPKu=UMkgr4DsPW0vH4kDw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 6:13 PM Junio C Hamano <gitster@pobox.com> wrote:

> * en/fill-directory-exponential (2020-04-01) 12 commits
>  - completion: fix 'git add' on paths under an untracked directory
>  - Fix error-prone fill_directory() API; make it only return matches
>  - dir: replace double pathspec matching with single in treat_directory()
>  - dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in treat_directory()
>  - dir: replace exponential algorithm with a linear one
>  - dir: refactor treat_directory to clarify control flow
>  - dir: fix confusion based on variable tense
>  - dir: fix broken comment
>  - dir: consolidate treat_path() and treat_one_path()
>  - dir: fix simple typo in comment
>  - t3000: add more testcases testing a variety of ls-files issues
>  - t7063: more thorough status checking
>
>  The directory traversal code had redundant recursive calls which
>  made its performance characteristics exponential with respect to
>  the depth of the tree, which was corrected.
>
>  Is this ready for 'next'?

I think it's as ready as it's going to get.  I'm not aware of any
current issues, am not planning further work barring a report or
further review, and I'm feeling much better about it than when I first
submitted it with a bunch of big warnings (though the big warnings it
contains in that one commit message are still justified).  I'm glad it
spent a good long while in pu.  My biggest worry with this series is
that it might get merged just slightly before a release; I hope it
either spends an average amount of time in next and then merges down
quickly or else sits in next for a long time and merges at the
beginning of the 2.28 cycle.

Either way, at $DAYJOB I got a minor victory by getting many
volunteers who will take newish git versions (as opposed to the old
"please install at least git>=2.20.0), and I'm currently trying to set
up a pipeline for them to get new versions easily.  This series will
be one of the things I include, in order generate more real-world
testing.
