Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7898B1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 20:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeGTVig (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 17:38:36 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37254 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbeGTVif (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 17:38:35 -0400
Received: by mail-ua0-f196.google.com with SMTP id y10-v6so8273823uao.4
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e0wiNUZfJSFfnCNllG9sJJYDN6dWhsmEddd9DoGCPhM=;
        b=jzXbUaErZIi4uA6zjXT/onA/1KHEmAUxsnQ0jUDbHL6s5BIMiMGvP5M1bfHPS6/sJS
         kIzL0AX6Dtpe5wjmmmCD+KwCqNzpuV+9/fuR/MwB3pVjq266l2A5TB3GhrvpzdLYCYcE
         b9dEfa+XDJMBpFNeBveD00Gb6SYcl/A3CEJHtHSb/FFsL2LPNfpMFaNEPx2cPEqJ0uFf
         6IVp28/wzZCxzVOBV3Mtp6MNQDJCSH3QM5YVCvhgHsmQhdutWDUCdqSw9BN//1VvmD0f
         +1/5/IYcR2r5zv/5niduY5LQ2T2zzxh4v3im/bVORW78XsPGW0nofC5+F+fe/jk/pzHn
         R35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e0wiNUZfJSFfnCNllG9sJJYDN6dWhsmEddd9DoGCPhM=;
        b=ef4Lmh9G2ZpvoBmMcl1eD9hgtwtQbOjARIQohnCE38iFj8q512tjLts94xMMdjLdtF
         DoGx77byCUDPyLfamZ1mR+xmbPfXLRp99mNZ3W0fOyngQ2Crb1l0dyiKueXA0PtZAXKd
         EVr760QnUnahtUu7WfqrC4zjobFHk/i0EmbY81HVi6vry+dSc2+3K/i2TWGXtank3PYJ
         Ttdf9fPSEnpK2Rmr45JK02Uw7JBwJ/Fuao+dPDjSN0CHLNuCArCbl8WiKb1aWac9/MV9
         P6gOpBCaicQmexJdJJU59kr7f6GlLpub+chZcj/6WCGnkQFxHXR2zC4oVyJck5YJcvUJ
         v9Ig==
X-Gm-Message-State: AOUpUlGPMGCPQgU4uWWd+CPB+W58NTUmxwAB76CT7QimJJ3wVYo7l2d/
        Co4a1r7M5AUZ9dEmFuuLMSA6Hzr+pGIGuCZ1jnk=
X-Google-Smtp-Source: AAOMgpdwbjR8804mV/6QvabbtXWo7X/FmHAoneClCAR/leiJ8vurSE1/HwEbn4U3oAzj1PJM8+uu8g5E9RsIXUFfSzw=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr2422136uaf.199.1532119717722;
 Fri, 20 Jul 2018 13:48:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 13:48:37
 -0700 (PDT)
In-Reply-To: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jul 2018 13:48:37 -0700
Message-ID: <CABPp-BF+Vx8YT2KAJQ+szbkYExv-_o5E-ZkywgvzsHWR0QvVEg@mail.gmail.com>
Subject: Re: [BUG] merge-recursive overly aggressive when skipping updating
 the working tree
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 12:53 PM, Ben Peart <peartben@gmail.com> wrote:
> As we were attempting to migrate to 2.18 some of our internal functional
> tests failed.  The tests that failed were testing merge and cherry-pick when
> there was a merge conflict. Our tests run with sparse-checkout enabled which
> is what exposed the bug.

Indeed, I've never used sparse checkout before.  And I've got
questions related to it below...

> What is happening is that in merge_recursive, the skip-worktree bit is
> cleared on the cache entry but then the working directory isn't updated.
> The end result is that git reports that the merged file has actually been
> deleted.
>
> We've identified the patch that introduced the regression as:
>
> commit 1de70dbd1ada0069d1b6cd6345323906cc9a9ed3
> Author: Elijah Newren <newren@gmail.com>
> Date:   Thu Apr 19 10:58:23 2018 -0700
>
>     merge-recursive: fix check for skipability of working tree updates
>
>     The can-working-tree-updates-be-skipped check has had a long and
> blemished
>     history.  The update can be skipped iff:
>       a) The merge is clean
>       b) The merge matches what was in HEAD (content, mode, pathname)
>       c) The target path is usable (i.e. not involved in D/F conflict)
>
>
> I've written a test that can be used to reproduce the issue:
>
>
> diff --git a/t/t3507-cherry-pick-conflict.sh
> b/t/t3507-cherry-pick-conflict.sh
> index 7c5ad08626..de0bdc8634 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -392,4 +392,17 @@ test_expect_success 'commit --amend -s places the
> sign-off at the right place' '
>
>         test_cmp expect actual
>  '
>
> +test_expect_success 'failed cherry-pick with sparse-checkout' '
> +       pristine_detach initial &&
> +       git config core.sparseCheckout true &&
> +       echo /unrelated >.git/info/sparse-checkout &&
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git cherry-pick -Xours picked>actual &&
> +       test_i18ngrep ! "Changes not staged for commit:" actual &&
> +       echo "/*" >.git/info/sparse-checkout &&
> +       git read-tree --reset -u HEAD &&
> +       git config core.sparseCheckout false &&
> +       rm .git/info/sparse-checkout
> +'
> +
>  test_done

Thanks for cooking up a testcase.  In short, you've got:
  - a one-line file that was modified on both sides
  - you explicitly set the skip-worktree bit for this file (by the
core.sparseCheckout and read-tree steps),
    suggesting that you DONT want it being written to your working tree
  - you're using -Xours to avoid what would otherwise be a conflict

So, I actually think merge-recursive is behaving correctly with
respect to the working tree here, because:
  - You said you didn't want foo in your working copy with your
sparse-checkout pattern
  - You manually nuked foo from your working copy when you called 'git
read-tree --reset -u HEAD'
  - You setup this merge such that the merge result was the same as
before the merge started.
In short, the file didn't change AND you don't want it in your working
tree, so why write it out?

To me, the bug is that merge-recursive clears the skip-worktree bit
for foo when that should be left intact -- at least in this case.


But that brings up another interesting question.  What if a merge
*does* modify a file for which you have skip-worktree set?
Previously, it'd clear the bit and write the file to the working tree,
but that was by no means an explicit decision; that was just a side
effect of the commands it uses.  Isn't that choice wrong -- shouldn't
it just update the index and continue on?  Or, if there are conflicts,
is that a case that is considered special where you do want the
skip-worktree bit cleared and have the file written out?

I'm worried that getting skip-worktree right in merge-recursive, when
it had never been considered before with that codebase, might be a
little messy...
