Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96CFC38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778662075E
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HCxXhjGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEGRAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbgEGRAp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 13:00:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C1C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 10:00:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so2298018plo.7
        for <git@vger.kernel.org>; Thu, 07 May 2020 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=onRA/6ZQKMZYuUZMGw3W745TaXlfKKEq7LFqzHh1GB0=;
        b=HCxXhjGqj52Q+FpRdlWbvit9lqMqAH4cGDRa482QBGZE9FPtnSf9ChzcILvWU2UEDV
         weMABhSS3YE0XiCT4mvJ3xY47eiKyPDziWtZwGxHvWeJPyjJjivPQwcGtuExS8xmSOh2
         EeoBvWuSU4/tkYyLf0oAmaMxrmyZmYSzsUS3N3gFMdqALiY0nmT1V0NlUu+8zSoLrvHS
         tKxzt8G9l8B7CuouoDbOmr2GayXOUpza1rr+Tz2qG0rSpV/QIohnyat/hrJHTxnGWrtu
         RzDtuKCo7+TAA8YUKgTXb4f4Pn7u7Llcy886MdJVyxOxd0c02QyIFTSTsP/+JSeqquB5
         ktOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=onRA/6ZQKMZYuUZMGw3W745TaXlfKKEq7LFqzHh1GB0=;
        b=CG5Va3hFfexvvW4ld2rWoeEsdJ2ZAWl1MwpjL4HdXq13QzRq1JAADAMAmAk/DUGgL/
         mPrb5OnCIUhadmZgw3L12w/vQU+yoJAC7dsU8laWzr341dEIaCkQA5hLRnnq1xXJogcQ
         I/+KojHt3s/lOZHB0lRW066YgAOG99Ub0lfE0w+QEaeYxoDjrd8L/MY+xOyPhLkVcywh
         vupsLbhUdPbA4LyqO9qSY8GjIqUAfNqgsRscjCmHC/4RT6SRTfdNlk6JwNIdjLunnynS
         rm51n1mpEfRf4cYXfzvJEWFUGWHCj+kWFkKxCaV4WTLMB+kWwA+OeRPFwnCsiVaeGYiu
         w6fw==
X-Gm-Message-State: AGi0PuYHQQUqxOwu+h+8carFJDhnTFJksOGxFcHGc1ne1W0QLNVf7LHk
        +W0BIJ5mlvZO4ifKFVyN9nFstA==
X-Google-Smtp-Source: APiQypIdNAF+Eo16NyZF32HRcELJpDjoJ0BnwQReLs+MSAs+onKBZDYn4H7TprJn+jWNzGteJR+lVQ==
X-Received: by 2002:a17:90b:155:: with SMTP id em21mr1049180pjb.59.1588870844704;
        Thu, 07 May 2020 10:00:44 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v1sm287920pjs.36.2020.05.07.10.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:00:43 -0700 (PDT)
Date:   Thu, 7 May 2020 11:00:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: allow per-branch config for GitHub Actions
Message-ID: <20200507170042.GC26677@syl.local>
References: <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <20200507162011.GA3638906@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507162011.GA3638906@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, May 07, 2020 at 12:20:11PM -0400, Jeff King wrote:
> On Tue, May 05, 2020 at 05:04:51PM -0400, Jeff King wrote:
>
> > Subject: [PATCH] ci: allow per-branch config for GitHub Actions
>
> Here's a "v2" of that patch based on the discussion.

I really like this direction. I think that it's a good mix of
flexibility and convenience. I'm happy to push a one-time 'ci-config'
branch to 'ttaylorr/git' and forget about it.

> I think it smooths some of the rough edges of the orphan-branch
> approach, while still having a cost on par with other suggestions (or at
> least ones that truly allow any config; we can check for "for-ci/**" or
> something very cheaply, but that implies hard-coding it for everybody).
> I think the cost here is acceptable, and it gives us room to add more
> features in the future.
>
> If Actions eventually adds per-repo variable storage that can be used in
> "if:" conditionals, then we could eventually switch to that. :)
>
> The documentation here should be enough to let people work with it. But
> we'd probably want to take Danh's patch to mention Actions in
> SubmittingPatches on top (and it possibly could be modified to point to
> the ci/config directory).
>
> -- >8 --
> Subject: [PATCH] ci: allow per-branch config for GitHub Actions
>
> Depending on the workflows of individual developers, it can either be
> convenient or annoying that our GitHub Actions CI jobs are run on every
> branch. As an example of annoying: if you carry many half-finished
> work-in-progress branches and rebase them frequently against master,
> you'd get tons of failure reports that aren't interesting (not to
> mention the wasted CPU).
>
> This commit adds a new job which checks a special branch within the
> repository for CI config, and then runs a shell script it finds there to
> decide whether to skip the rest of the tests. The default will continue
> to run tests for all refs if that branch or script is missing.
>
> There have been a few alternatives discussed:
>
> One option is to carry information in the commit itself about whether it
> should be tested, either in the tree itself (changing the workflow YAML
> file) or in the commit message (a "[skip ci]" flag or similar). But
> these are frustrating and error-prone to use:
>
>   - you have to manually apply them to each branch that you want to mark
>
>   - it's easy for them to leak into other workflows, like emailing patches
>
> We could likewise try to get some information from the branch name. But
> that leads to debates about whether the default should be "off" or "on",
> and overriding still ends up somewhat awkward. If we default to "on",
> you have to remember to name your branches appropriately to skip CI. And
> if "off", you end up having to contort your branch names or duplicate
> your pushes with an extra refspec.
>
> By comparison, this commit's solution lets you specify your config once
> and forget about it, and all of the data is off in its own ref, where it
> can be changed by individual forks without touching the main tree.
>
> There were a few design decisions that came out of on-list discussion.
> I'll summarize here:
>
>  - we could use GitHub's API to retrieve the config ref, rather than a
>    real checkout (and then just operate on it via some javascript). We
>    still have to spin up a VM and contact GitHub over the network from
>    it either way, so it ends up not being much faster. I opted to go
>    with shell to keep things similar to our other tools (and really
>    could implement allow-refs in any language you want). This also makes
>    it easy to test your script locally, and to modify it within the
>    context of a normal git.git tree.
>
>  - we could keep the well-known refname out of refs/heads/ to avoid
>    cluttering the branch namespace. But that makes it awkward to
>    manipulate. By contrast, you can just "git checkout ci-config" to
>    make changes.
>
>  - we could assume the ci-config ref has nothing in it except config
>    (i.e., a branch unrelated to the rest of git.git). But dealing with
>    orphan branches is awkward. Instead, we'll do our best to efficiently
>    check out only the ci/config directory using a shallow partial clone,
>    which allows your ci-config branch to be just a normal branch, with
>    your config changes on top.
>
>  - we could provide a simpler interface, like a static list of ref
>    patterns. But we can't get out of spinning up a whole VM anyway, so
>    we might as well use that feature to make the config as flexible as
>    possible. If we add more config, we should be able to reuse our
>    partial-clone to set more outputs.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  .github/workflows/main.yml  | 42 +++++++++++++++++++++++++++++++++++++
>  ci/config/allow-refs.sample | 26 +++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100755 ci/config/allow-refs.sample
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index fd4df939b5..802a4bf7cd 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -6,7 +6,39 @@ env:
>    DEVELOPER: 1
>
>  jobs:
> +  ci-config:
> +      runs-on: ubuntu-latest
> +      outputs:
> +        enabled: ${{ steps.check-ref.outputs.enabled }}
> +      steps:
> +        - name: try to clone ci-config branch
> +          continue-on-error: true
> +          run: |
> +            git -c protocol.version=2 clone \
> +              --no-tags \
> +              --single-branch \
> +              -b ci-config \
> +              --depth 1 \
> +              --no-checkout \
> +              --filter=blob:none \
> +              https://github.com/${{ github.repository }} \
> +              config-repo &&
> +              cd config-repo &&
> +              git checkout HEAD -- ci/config
> +        - id: check-ref
> +          name: check whether CI is enabled for ref
> +          run: |
> +            enabled=yes
> +            if test -x config-repo/ci/config/allow-ref &&
> +               ! config-repo/ci/config/allow-ref '${{ github.ref }}'
> +            then
> +              enabled=no
> +            fi
> +            echo "::set-output name=enabled::$enabled"
> +
>    windows-build:
> +    needs: ci-config
> +    if: needs.ci-config.outputs.enabled == 'yes'

One thing I wonder is whether the downstream 'windows-test' partitions.
I think that it should be fine, since we won't run the dependent
'windows-build', and then 'windows-test' won't have all of its
prerequisites filled.

>      runs-on: windows-latest
>      steps:
>      - uses: actions/checkout@v1
> @@ -70,6 +102,8 @@ jobs:
>          name: failed-tests-windows
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    vs-build:
> +    needs: ci-config
> +    if: needs.ci-config.outputs.enabled == 'yes'
>      env:
>        MSYSTEM: MINGW64
>        NO_PERL: 1
> @@ -154,6 +188,8 @@ jobs:
>                            ${{matrix.nr}} 10 t[0-9]*.sh)
>          "@
>    regular:
> +    needs: ci-config
> +    if: needs.ci-config.outputs.enabled == 'yes'
>      strategy:
>        matrix:
>          vector:
> @@ -189,6 +225,8 @@ jobs:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    dockerized:
> +    needs: ci-config
> +    if: needs.ci-config.outputs.enabled == 'yes'
>      strategy:
>        matrix:
>          vector:
> @@ -213,6 +251,8 @@ jobs:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
>    static-analysis:
> +    needs: ci-config
> +    if: needs.ci-config.outputs.enabled == 'yes'
>      env:
>        jobname: StaticAnalysis
>      runs-on: ubuntu-latest
> @@ -221,6 +261,8 @@ jobs:
>      - run: ci/install-dependencies.sh
>      - run: ci/run-static-analysis.sh
>    documentation:
> +    needs: ci-config
> +    if: needs.ci-config.outputs.enabled == 'yes'
>      env:
>        jobname: Documentation
>      runs-on: ubuntu-latest
> diff --git a/ci/config/allow-refs.sample b/ci/config/allow-refs.sample
> new file mode 100755
> index 0000000000..f157f1945a
> --- /dev/null
> +++ b/ci/config/allow-refs.sample
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +#
> +# Sample script for enabling/disabling GitHub Actions CI runs on
> +# particular refs. By default, CI is run for all branches pushed to
> +# GitHub. You can override this by dropping the ".sample" from the script,
> +# editing it, committing, and pushing the result to the "ci-config" branch of
> +# your repository:
> +#
> +#   git checkout -b ci-config

Should we be recommending '--orphan' instead of '-b' here? It looks
like when you clone this branch down that you try to get as few bytes as
possible, so I figure it may be easier to have this be a orphaned
branch.

> +#   cp allow-refs.sample allow-refs
> +#   $EDITOR allow-refs
> +#   git commit -am "implement my ci preferences"
> +#   git push
> +#
> +# This script will then be run when any refs are pushed to that repository. It
> +# gets the fully qualified refname as the first argument, and should exit with
> +# success only for refs for which you want to run CI.
> +
> +case "$1" in
> +# allow one-off tests by pushing to "for-ci" or "for-ci/mybranch"
> +refs/heads/for-ci*) true ;;
> +# always build your integration branch
> +refs/heads/my-integration-branch) true ;;
> +# don't build any other branches or tags
> +*) false ;;
> +esac
> --
> 2.26.2.1005.ge383644752
>

Thanks,
Taylor
