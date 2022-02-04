Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865DCC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 08:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbiBDINz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 03:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344577AbiBDINz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 03:13:55 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CBC061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 00:13:54 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id m25so4144212qka.9
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 00:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gsujg4cTir4Syp2f8EfplpQhHsyzehZtOOgNFZMEVYA=;
        b=HEETX6BIW/1OtVdyGbpsBLdCd5BC9nry+PWVMNppb2W+NMeGN0FAkb1VMxfoNdab+u
         hOmBPkDru2TF3srT7d9X7F2J/uZZJ0f6GYeHu/jYpyxucUHmMOV0lwWI8/xJF2NphrZe
         7734JL++jecGI9vIfQ3rS7L4nTRxwimAIiosTyf+70mqWSrzz9WmXntlvMOWi5HiM1nt
         7g67bAH2y/mJRCO8CpXYC53k2Ll0vAHp0FiQS/JyI0v9mBSuYZXW+7LdOFlid+MBhjba
         6rV7gHzJUeiqHUdAT8mOD782Cjsg0l29PIC0aRDtdACqFltjBIgJtEtEzVpvYaMlhebp
         IGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gsujg4cTir4Syp2f8EfplpQhHsyzehZtOOgNFZMEVYA=;
        b=R/0O+FjUAFVR5o8yR12qb7n7E5j8v+gfwsiWLomtLzGjSRaWU0IrEos7bunRr6fnSd
         Gq4l9GlR55n+cyIm9E7KFr8JFALfiyPWwAt239KgVWNUhPt1A2/ZtvVAqCgVhOy1WFZw
         EcJ5iqe1fzCFLINX2/yYAhSaQCzr5EUfztgy363uesvvzhI9B+FOm7izoj7WBKjSKTfH
         rSSe75ZQW9XWRcZYL4DkrL9OmpGo4VG4By6fcTuBTGZmFl6kZSXWUoyxPcpna2Tj2Dei
         uado1FBcyHxTzrFYBn1sBWrRRVx9dGVmMBAvy1Ewx2HXMiLJrOG74zgJ1NMs7v+74zbQ
         JzmQ==
X-Gm-Message-State: AOAM5335IpDIt+5LktGVsAI187D3ENprAtuMWeWmli+5leR0sMtPezcz
        U5mxGqBRMnVqf0f0haUEr8DIa8DjqBY=
X-Google-Smtp-Source: ABdhPJwWdR7+GliHfY8FNimvzuQFI8bJJY8n84XKgrP0kMOudt8pcKypusjsUPNnEdKb/A+IXNQbfg==
X-Received: by 2002:a05:620a:269a:: with SMTP id c26mr889960qkp.497.1643962433608;
        Fri, 04 Feb 2022 00:13:53 -0800 (PST)
Received: from iron-rod.attlocal.net ([2600:1700:bae0:2de0::1b])
        by smtp.gmail.com with ESMTPSA id f9sm685362qkp.94.2022.02.04.00.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 00:13:52 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
Subject: Opinions on merging questions (Was: What's cooking in git.git (Feb 2022, #01; Thu, 3))
Date:   Fri,  4 Feb 2022 00:13:36 -0800
Message-Id: <20220204081336.3194538-1-newren@gmail.com>
X-Mailer: git-send-email 2.35.1.395.g30ac3e9a3e
In-Reply-To: <xmqqr18jnr2t.fsf@gitster.g>
References: <xmqqr18jnr2t.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I thought I'd respond to some of your questions with my opinion and
pointers, in case it's helpful...


On Fri, Feb 3, 2022 at 21:22 PM Junio C Hamano <gitster@pobox.com> wrote:

> * jc/doc-log-messages (2022-01-27) 3 commits
>  - SubmittingPatches: explain why we care about log messages
>  - CodingGuidelines: hint why we value clearly written log messages
>  - SubmittingPatches: write problem statement in the log in the present tense
> 
>  Update the contributor-facing documents on proposed log messages.
> 
>  Will merge to 'next'?
>  source: <20220126234205.2923388-1-gitster@pobox.com>

I think it looks good.

> * ds/sparse-checkout-requires-per-worktree-config (2022-01-31) 5 commits
>  - worktree: copy sparse-checkout patterns and config on add
>  - sparse-checkout: set worktree-config correctly
>  - config: add repo_config_set_worktree_gently()
>  - worktree: create init_worktree_config()
>  - Documentation: add extensions.worktreeConfig details
> 
>  "git sparse-checkout" wants to work with per-worktree configration,
>  but did not work well in a worktree attached to a bare repository.
> 
>  What's the doneness of this one?
>  source: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>

I think it's done and ready for next.

Eric and I weighed in quite a bit on this series, and it changed
direction pretty dramatically, and more than once.  But we eventually
all came to an agreement about what should be done (the hard part),
and this round implements it.  Stolee has diligently fixed or answered
each item I've raised and I'm very happy with this version.

> * en/present-despite-skipped (2022-01-14) 6 commits
>  - Accelerate clear_skip_worktree_from_present_files() by caching
>  - Update documentation related to sparsity and the skip-worktree bit
>  - repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
>  - unpack-trees: fix accidental loss of user changes
>  - t1011: add testcase demonstrating accidental loss of user modifications
>  - Merge branch 'vd/sparse-clean-etc' into en/present-despite-skipped
>  (this branch uses vd/sparse-clean-etc.)
> 
>  In sparse-checkouts, files mis-marked as missing from the working tree
>  could lead to later problems.  Such files were hard to discover, and
>  harder to correct.  Automatically detecting and correcting the marking
>  of such files has been added to avoid these problems.
> 
>  Will merge to 'next'?
>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>

Victoria says I've addressed all her feedback ("Between the RFC and
this version, you've made the changes I was looking for and answered
any remaining questions I had. This series...looks good to me.")[*].
No one else has chimed in with any issues or questions.  I'm probably
biased since it's my series, but I do think this one is ready.

[*] https://lore.kernel.org/git/14b6dbeb-5a12-3ac0-9a0e-9cf2c3a381fe@github.com/

(Sidenote: The series might look a little scary at first, since I was
originally worried with this series that I was going to need to
introduce some kind of backward compatibility break to get the
necessary fixes, or that the performance cost of the fix might be
high, and there's a super lengthy commit message with rationale
because of that.  However, in the end both problems were averted and
it just looks like a cheap and long-overdue fix, but I left the long
rationale I had already written anyway.)

> * en/remerge-diff (2022-02-02) 11 commits
>  - diff-merges: avoid history simplifications when diffing merges
>  - merge-ort: mark conflict/warning messages from inner merges as omittable
>  - show, log: include conflict/warning messages in --remerge-diff headers
>  - diff: add ability to insert additional headers for paths
>  - merge-ort: format messages slightly different for use in headers
>  - merge-ort: mark a few more conflict messages as omittable
>  - merge-ort: capture and print ll-merge warnings in our preferred fashion
>  - ll-merge: make callers responsible for showing warnings
>  - log: clean unneeded objects during `log --remerge-diff`
>  - show, log: provide a --remerge-diff capability
>  - Merge branch 'ns/tmp-objdir' into en/remerge-diff
>  (this branch is used by en/merge-tree.)
> 
>  "git log --remerge-diff" shows the difference from mechanical merge
>  result and the merge result that is actually recorded.
> 
>  Will merge to 'next'?
>  source: <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>

Ævar's recent opinion on the state of the series was "I think this is
way past good enough."[*].  He's the only reviewer that has commented
since December, leading me to believe the half-dozen or so other
earlier reviewers since August are content with the current shape.

[*] https://lore.kernel.org/git/220202.868rut8qkf.gmgdl@evledraar.gmail.com/


> * pw/fix-some-issues-in-reset-head (2022-01-26) 14 commits
>  - rebase -m: don't fork git checkout
>  - rebase --apply: set ORIG_HEAD correctly
>  - rebase --apply: fix reflog
>  - reset_head(): take struct rebase_head_opts
>  - rebase: cleanup reset_head() calls
>  - create_autostash(): remove unneeded parameter
>  - reset_head(): make default_reflog_action optional
>  - reset_head(): factor out ref updates
>  - reset_head(): remove action parameter
>  - rebase --apply: don't run post-checkout hook if there is an error
>  - rebase: do not remove untracked files on checkout
>  - rebase: pass correct arguments to post-checkout hook
>  - t5403: refactor rebase post-checkout hook tests
>  - rebase: factor out checkout for up to date branch
> 
>  Use an internal call to reset_head() helper function instead of
>  spawning "git checkout" in "rebase", and update code paths that are
>  involved in the change.
> 
>  Will merge to 'next'?
>  May want to rename the topic branch to "pw/use-in-process-checkout-in-rebase"
>  or something before doing so.
>  source: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>

This series seems good to me and I think it's ready, but the topic
branch rename sounds good.
