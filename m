Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAA8C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 23:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26AD2468D
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 23:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbyTlfiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1XHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:07:20 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41223 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1XHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 18:07:20 -0500
Received: by mail-ot1-f44.google.com with SMTP id v19so4162773ote.8
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 15:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QAcPiiWpZeqk4q/e+FX+1y8Z6NP+LVGL7CQ1kM7EhIs=;
        b=YbyTlfivMNqtaiAb83fDUBjpDddyPxrSzf4rcV0OzZKAMQW8dZ2d40KOaYVo4zv0s9
         Huhix6AfpxBYDlYlNbmZhJTn9K3DoeLr5dcYAWTZQ8UsbrgwLV051Q10kZXpa5Qyeya0
         QN0eIyLCxJf8uorvAfBuz0WEWVn/clKsB2DwryNak7V5y0get3uskrXrSJlLGuEDNJX/
         hoFPntFZtCB5PxCJGNSVYdP1tjKVKFiqoIDXP0ThFup6SC1V94jCjDnM/b42mPELLbQy
         3Ud+89yKAyNiBNBZN5mTtOTHCwSlt3dmj1H2sM1WAq6OqfpZouU20ShpIjh0qXY7pLHG
         uc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QAcPiiWpZeqk4q/e+FX+1y8Z6NP+LVGL7CQ1kM7EhIs=;
        b=r3ZcJqbcZu2zEgh+krbXUiWBgEzeqAuemrfnG6CdOcKZhngYBsK8dqLNLZ4pG1IamZ
         sW+i6lEOKW9YsAfJyLLHrtTAuFlDenybCxKnlSKoqQ4MwWJmCtD3plrGitldWAZi8lXg
         kFogJmw2zDx+8YgCpD5VKB0qEXXEPawSp8I9guOFqZf2WyzvWVIOncrXPh8LP5QRlAHw
         +oL+zCwWqTCm4JYum5bP6QcBJhOHhHsjVgMgnpT4+E7ZQ0y3KunHia2BK0eptbm7uVYy
         6ebUXSHeCbS3fMfDeRBiSmNvoutKcD/UUXcZTu9OrkN4fb7kpk3MTDGEIVUtKHg7MxCD
         F8FA==
X-Gm-Message-State: APjAAAVlwusuxMJ2YmCHPqcU4RJ+K/jtTplpMwvZS4QcBTSrdmc+OvHy
        Iygt5ZlGhDDCV5EoR0dLMmyJWWelP50kjcq/KzM=
X-Google-Smtp-Source: APXvYqwLvm6UrBw59zonOdI8GNmfzKIazD5wlBho4gJPxIdgsnpg4P/ropMS9/Y+JFVn/xQA/jlkd5IjG/iNxc04JwA=
X-Received: by 2002:a9d:7c81:: with SMTP id q1mr5015232otn.112.1582931239137;
 Fri, 28 Feb 2020 15:07:19 -0800 (PST)
MIME-Version: 1.0
References: <xmqqimjqcoh0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimjqcoh0.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Feb 2020 15:07:08 -0800
Message-ID: <CABPp-BEJiRyCznkrri-uTqggT60vkvqsU8dAvKz3B1PH6BB6tQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #06; Fri, 28)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 2:54 PM Junio C Hamano <gitster@pobox.com> wrote:
> * en/merge-path-collision (2020-02-27) 1 commit
>  - merge-recursive: apply collision handling unification to recursive case
>
>  Handling of conflicting renames in merge-recursive have further
>  been made consistent with how existing codepaths try to mimick what
>  is done to add/add conflicts.

s/mimick/mimic/?

> * en/rebase-backend (2020-02-16) 20 commits
>   (merged to 'next' on 2020-02-22 at cae5eb0f18)
>  + rebase: rename the two primary rebase backends
>  + rebase: change the default backend from "am" to "merge"
>  + rebase: make the backend configurable via config setting
>  + rebase tests: repeat some tests using the merge backend instead of am
>  + rebase tests: mark tests specific to the am-backend with --am
>  + rebase: drop '-i' from the reflog for interactive-based rebases
>  + git-prompt: change the prompt for interactive-based rebases
>  + rebase: add an --am option
>  + rebase: move incompatibility checks between backend options a bit earlier
>  + git-rebase.txt: add more details about behavioral differences of backends
>  + rebase: allow more types of rebases to fast-forward
>  + t3432: make these tests work with either am or merge backends
>  + rebase: fix handling of restrict_revision
>  + rebase: make sure to pass along the quiet flag to the sequencer
>  + rebase, sequencer: remove the broken GIT_QUIET handling
>  + t3406: simplify an already simple test
>  + rebase (interactive-backend): fix handling of commits that become empty
>  + rebase (interactive-backend): make --keep-empty the default
>  + t3404: directly test the behavior of interest
>  + git-rebase.txt: update description of --allow-empty-message
>
>  "git rebase" has learned to use the sequencer backend by default,
>  while allowing "--am" option to go back to the traditional "am"
>  backend.

We may need to reword this description due to the last patch in the
series.  Also, the description misses the new rebase.backend
configuration setting.  I'm not the best at wording these release
notes, but something along the lines of:

"git rebase" has learned to use the merge backend by default, while
allowing "--apply" option to go back to the traditional apply backend,
or allowing an alternate default to be set via the new rebase.backend
configuration variable.  This series also renames the backends from
"interactive" (or "sequencer") to "merge" and from "am" to "apply".
