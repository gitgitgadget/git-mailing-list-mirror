Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A6C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23922332A
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgLJC6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgLJC6G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 21:58:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC28C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 18:57:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h75so4902893ybg.18
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 18:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TfbWJX2NuigGXi227a1LRsTRoKTSw2XaoPgE3mkTVYE=;
        b=g4EzKhKGs5FI634mKoPaut1FFQbxmCUibeQQA+FXCdWMBhJ8wQ70qEppukhDkx1ojr
         tNeYp7Ydwyw2V4bAkyQt3RNTz7v9Ahy+w+y6w+pvkScNVy7xrniU4B7fU0++4qiu2S9r
         zDPVhuUXgqdopaYO8Ywz9rJFnMH/qjM2svajIbic/Dcu6lXbvFrJKw3VrUpDCo0TUnmB
         2xZVjsGtvKvThncl4B8J+g863jwnVkpHXYXhrhyeUk9eV6xWNSrqxAZdNatBFrh/ZI2Q
         D4sSCtfevcoCsNLpUT5JwkExmixSukgV9MejwZo3OevKDOTv4A17iLsMcbdM7GK02Ad4
         MfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TfbWJX2NuigGXi227a1LRsTRoKTSw2XaoPgE3mkTVYE=;
        b=ePgjVx2oXw6YWfVkyccxMAOd42P0hz/Y47zJNzw7wzl2nC7YYDA9lITiB4STgUYZfi
         7bWk8LDrc4f+3HIvlR/UnQw3+8RpCnAp2DzBpnA3pmlGi6/1AY7lpaHEzxhwXYhWtM1W
         3UBCG9UheoHUgxzeR6cV4RW7HyAPpyvcCR6f3Mm6VRWIKYBHG8cnbmqO6RlD22hKINLZ
         gPZyy2kAJF7QPHiAAWuavGZeWpBcf4r44m93F+EEH+LsIGgnDjug8Ku3tL9gyw3oQLgc
         evZSQgjPCiQxPcHvJxcr9OcKBAGlww5JbzwMLL30gmHBghxkzuhKOg9EbzF2rMI4l/4W
         dQNw==
X-Gm-Message-State: AOAM530O3tgpAuFD1RFjvU2L7bqapWHBtUCwzaW+92uDjTcR5N1iw+UV
        F6EgZrt387rVO3bK5ejBj1LEIZ4xAWdhqk03Xwte
X-Google-Smtp-Source: ABdhPJxcrwtlF1btpvNOmr+1XxK9GOlPx21O1YiSSpI8SOy92V3suq/dcQLtSztYly76wnzc6T4WCSXtfcC4QnHGQmiO
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:abc8:: with SMTP id
 v66mr7724753ybi.281.1607569044892; Wed, 09 Dec 2020 18:57:24 -0800 (PST)
Date:   Wed,  9 Dec 2020 18:57:22 -0800
In-Reply-To: <CABPp-BGcyRURykePOafjcE1z9J8U5awF=PZw1ufx+8Ow+k3j3w@mail.gmail.com>
Message-Id: <20201210025722.1645961-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGcyRURykePOafjcE1z9J8U5awF=PZw1ufx+8Ow+k3j3w@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: Re: What's cooking in git.git (Dec 2020, #01; Tue, 8)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > * en/merge-ort-impl (2020-12-06) 21 commits
> >  - merge-ort: free data structures in merge_finalize()
> >  - merge-ort: add implementation of record_conflicted_index_entries()
> >  - tree: enable cmp_cache_name_compare() to be used elsewhere
> >  - merge-ort: add implementation of checkout()
> >  - merge-ort: basic outline for merge_switch_to_result()
> >  - merge-ort: step 3 of tree writing -- handling subdirectories as we go
> >  - merge-ort: step 2 of tree writing -- function to create tree object
> >  - merge-ort: step 1 of tree writing -- record basenames, modes, and oids
> >  - merge-ort: have process_entries operate in a defined order
> >  - merge-ort: add a preliminary simple process_entries() implementation
> >  - merge-ort: avoid recursing into identical trees
> >  - merge-ort: record stage and auxiliary info for every path
> >  - merge-ort: compute a few more useful fields for collect_merge_info
> >  - merge-ort: avoid repeating fill_tree_descriptor() on the same tree
> >  - merge-ort: implement a very basic collect_merge_info()
> >  - merge-ort: add an err() function similar to one from merge-recursive
> >  - merge-ort: use histogram diff
> >  - merge-ort: port merge_start() from merge-recursive
> >  - merge-ort: add some high-level algorithm structure
> >  - merge-ort: setup basic internal data structures
> >  - Merge branch 'en/strmap' into en/merge-ort-impl
> >  (this branch is used by en/merge-ort-2.)
> >
> >  Needs review.
> 
> I think I've addressed all the feedback in v4 (which is sadly labelled
> as v2 due to switching from send-email to gitgitgadget part way
> through the series).  If there's more review needed, I'd say getting a
> thumbs-up or thumbs-down from Stolee and Jonathan on whether I
> addressed their feedback adequately would be great, and having someone
> give a look over the 2nd-to-last and 4th-to-last patches would always
> be a plus.  Was that what you had in mind in marking this as "Needs
> review"?

Rereading my feedback and the parts of the v4 patch set that correspond
to my feedback, my comments (which were more about clarity anyway - I
didn't notice any correctness or performance issues) have been addressed
adequately. But to be fully sure, I would need to reread the patches to
ensure that nothing unexpected was introduced. :-P (If nobody does this,
I can do this - hopefully by the end of the week.)

I wonder if it would be worth splitting this branch into the first 15
patches (which I reviewed, and which has more of an algorithmic focus)
and the last 5 patches (which I didn't review, and which has more of an
integration-into-Git focus). That way, the last 5 wouldn't hold up the
first 15.
