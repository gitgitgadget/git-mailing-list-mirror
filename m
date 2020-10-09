Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F1C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 07:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329AF22244
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 07:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awTnfBD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbgJIH33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 03:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbgJIH31 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 03:29:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209CEC0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 00:29:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so9147274wrp.8
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Bh/IUY86XNmqOkLMHoiDV6SsM4pRlD6jmKOeLCI3Y4=;
        b=awTnfBD86lxmVAAQg4fsPxAkLxiWJttCEXW8uUiSpPB5SJ8scmQg4HGItDulWZL8iQ
         m7wLHXqpVemj36N6BDg6Z7u4jsyrSm9NDSwT5LjAHK+TXV4UdnHYOhXaJ3ZZjqVZnIZA
         z7EiCFmTAD/wGnQ+F4gabvAv3UUOcEJMa40gj3NJNrlsf/WeG74azyv9pxEije5jxrtK
         7JvuANj9x65D0gpsmduTYPGVORrja/n7fp78VFMj4cH20+HV+9YAlI70aQuXOy7URKYi
         /4L0yfkNv7Kwutk48Np9+hkF02ye1K0vdBt8yZ0EYxgY/+j6FkWKKFAMz8VEdVHxXub1
         Gd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Bh/IUY86XNmqOkLMHoiDV6SsM4pRlD6jmKOeLCI3Y4=;
        b=FkHitfvhjzizBdfOdhAKbLdrcDzKsTP3qZ44sRxwZosBr0bT7v6LjlHWrJngKm8Bpu
         +JztmTrC+1Jk5d3oUuv8Cr+vB0XE9Ws/xSV/tKFsRdOlJV4BsOMAUGHdJNO/DkXThHwX
         /DTff/zt+TwJai6nUiOW43RJ5ilDI9rqI5yoaUH/iCcm1H0DQJAweE81O+s7IuPCKd8z
         IVipINFLEojwrznCjEGRlKFYVOELWYQKI0ImGIubc73BpEG7IsjXmA8lBlOjKzoCx2Va
         uikeUBaPfUpf4/cK/Ok7H05gEUOfDuj2UbD03SCGkMmkVHqXQvHdLzIgfhYInhgxYZK8
         Xm9w==
X-Gm-Message-State: AOAM530RQnT50cM/ZyOphen0Qmd409PIdqMDW2P7XN3wbtLn3uVkFxi8
        ADEaa2CM2bssYdmy3QXMAPEc2npjj8Q=
X-Google-Smtp-Source: ABdhPJzGp/BykE57Fs31lI35gvJo2ly12aCcJZ2LiexEA+CnK8klwWvL72FuPDXBVTB5FYVataL4Ug==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr12819460wrs.23.1602228564849;
        Fri, 09 Oct 2020 00:29:24 -0700 (PDT)
Received: from szeder.dev (92-249-246-51.pool.digikabel.hu. [92.249.246.51])
        by smtp.gmail.com with ESMTPSA id d2sm398306wrq.34.2020.10.09.00.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 00:29:24 -0700 (PDT)
Date:   Fri, 9 Oct 2020 09:29:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] ci: skip GitHub workflow runs for already-tested
 commits/trees
Message-ID: <20201009072922.GC24813@szeder.dev>
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
 <pull.619.v2.git.1602170976.gitgitgadget@gmail.com>
 <914868d558b1aa8ebec6e9196c5ae83a2bd566bf.1602170976.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <914868d558b1aa8ebec6e9196c5ae83a2bd566bf.1602170976.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 03:29:34PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When pushing a commit that has already passed a CI or PR build
> successfully, it makes sense to save some energy and time and skip the
> new build.
> 
> Let's teach our GitHub workflow to do that.
> 
> For good measure, we also compare the tree ID, which is what we actually
> test (the commit ID might have changed due to a reworded commit message,
> which should not affect the outcome of the run).

We have been doing this on Travis CI for a few years now.  Does that
approach not work on GitHub actions?  Please explain in the commit
message why a different approach is taken here.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/main.yml | 39 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 5bd321e5e1..7391b46d61 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -9,7 +9,7 @@ jobs:
>    ci-config:
>      runs-on: ubuntu-latest
>      outputs:
> -      enabled: ${{ steps.check-ref.outputs.enabled }}
> +      enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
>      steps:
>        - name: try to clone ci-config branch
>          continue-on-error: true
> @@ -35,6 +35,43 @@ jobs:
>              enabled=no
>            fi
>            echo "::set-output name=enabled::$enabled"
> +      - name: skip if the commit or tree was already tested
> +        id: skip-if-redundant
> +        uses: actions/github-script@v3
> +        if: steps.check-ref.outputs.enabled == 'yes'
> +        with:
> +          github-token: ${{secrets.GITHUB_TOKEN}}
> +          script: |
> +            // Figure out workflow ID, commit and tree
> +            const { data: run } = await github.actions.getWorkflowRun({
> +              owner: context.repo.owner,
> +              repo: context.repo.repo,
> +              run_id: context.runId,
> +            });
> +            const workflow_id = run.workflow_id;
> +            const head_sha = run.head_sha;
> +            const tree_id = run.head_commit.tree_id;
> +
> +            // See whether there is a successful run for that commit or tree
> +            const { data: runs } = await github.actions.listWorkflowRuns({
> +              owner: context.repo.owner,
> +              repo: context.repo.repo,
> +              per_page: 500,
> +              status: 'success',
> +              workflow_id,
> +            });
> +            for (const run of runs.workflow_runs) {
> +              if (head_sha === run.head_sha) {
> +                core.warning(`Successful run for the commit ${head_sha}: ${run.html_url}`);
> +                core.setOutput('enabled', ' but skip');
> +                break;
> +              }
> +              if (tree_id === run.head_commit.tree_id) {
> +                core.warning(`Successful run for the tree ${tree_id}: ${run.html_url}`);
> +                core.setOutput('enabled', ' but skip');
> +                break;
> +              }
> +            }
>  
>    windows-build:
>      needs: ci-config
> -- 
> gitgitgadget
> 
