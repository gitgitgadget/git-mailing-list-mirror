Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15601C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 01:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiGUBhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 21:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGUBhR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 21:37:17 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A92459A1
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 18:37:16 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l14so331120qtv.4
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 18:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tiAVuG/QEWShrq5pHWRQaA5nX6nflt9r7LsT1WZRfNM=;
        b=NxwSsBuwDVwU0gBzqi6RJUG/+ZxCXqhDTaCvUHL3ullWKUoDLpYDcrk+PwoNuYqhiu
         8WLBzmU0DwRCPmqm7PREwBCet0u1Sx/TbR3Tf+s4Yk3mzy+O05vMW1l+t08XW8yfReRY
         LLUSECbhI69KXzcUfvVLc7PryUOliB2Zkw7ysTE+1cWoTkksYz/a8GcrxG+3QPEU5ZXN
         LcIR8AypC2x6dbe1/iLnzps0JPzsYRwAla5ibzXU6riHW4USyGWc6VP5mhl/VfAu82LI
         gajt3BK+iJhCLMPSwmf16pRii2CLV0HDtmFcPC5jDn4XjYiT+Rl4uoquL9gkD6egUf/6
         a/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tiAVuG/QEWShrq5pHWRQaA5nX6nflt9r7LsT1WZRfNM=;
        b=P31Dq0IrneaCizOSkQClQ3Tr/GG6rB57D2gA/YPNlY8+aEaip50CEB/HlNkRazKXXB
         BHmzw4flPsnr2+lEANsYFCv1JwsFoeXb58Ode5477hWEC7MOlmGgHVTZfNjZEkK6+1y9
         79PPxAyk4C9D0yakO446XDH3UyqClQe/FUUBBEWjbZ/aw1sf3/63zte2dNx3TAv/btLY
         pMi0k0tM8QNlU/f/7+Urai8vkmbF1g4WoMloVbZBytqHsspSzVIm5b3l8c7UkLLQVoa+
         nWwrfsUQ085C7W2wJwjjPVMGmEPMpOuBcXXV/2S6mAOafHelyr924pO4qnG9gUIS1FOu
         WeWw==
X-Gm-Message-State: AJIora9YrrcGnw3FEszVjcafMfiW785DcL25Zmy3YiwBGIDxow3NMVxS
        IxNNOCwW5sKXloY0ulKfPzoGrXBsxocznny55l/p8uDQkWY=
X-Google-Smtp-Source: AGRyM1sOZUvz8L4LdFmi5szyrd9h80kVLmc/52sOifaylSjfv02afEmQgopMUA9IpLAOeQRFd/dcngpETTZUqIu0A0E=
X-Received: by 2002:a05:622a:1391:b0:31e:f6b2:d3aa with SMTP id
 o17-20020a05622a139100b0031ef6b2d3aamr11185623qtk.523.1658367435850; Wed, 20
 Jul 2022 18:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
 <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com> <4a8b7c9e06df36444b94b929b2558f40e3f72e81.1655621424.git.gitgitgadget@gmail.com>
 <xmqqsfmw66gq.fsf@gitster.g> <xmqq7d4865t6.fsf@gitster.g>
In-Reply-To: <xmqq7d4865t6.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jul 2022 18:37:05 -0700
Message-ID: <CABPp-BEfpwmEcR3TR8xu_+1TQfOvOTQceNE7-H76rsno6TmFPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] merge: make restore_state() restore staged state too
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 19, 2022 at 4:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> From: Elijah Newren <newren@gmail.com>
> >>
> >> merge can be invoked with uncommitted changes, including staged changes.
> >> merge is responsible for restoring this state if some of the merge
> >> strategies make changes.  However, it was not restoring staged changes
> >> due to the lack of the "--index" option to "git stash apply".  Add the
> >> option to fix this shortcoming.
> >
> > Shouldn't this be testable?

Yes, I will add a test.

> I actually take this part (which implied that the change is a good
> idea) back. I think we have clearly documented for the past 17
> years that you can have local changes but your index must match the
> HEAD before you start your merge.

Actually, we don't enforce that the index must match HEAD in all
cases, as noted in commit 55f39cf755 ("merge: fix misleading pre-merge
check documentation", 2018-06-30).  That commit also pointed out how
the documentation was a bit unclear in this area.

We also apparently fail to enforce the condition in at least two cases
that weren't a valid exception, which I just found while working on a
testcase for this patch.  (Thus, we have one more sordid tale to add
to the saga in commit 9822175d2b ("Ensure index matches head before
invoking merge machinery, round N", 2019-08-17))

However, the failed enforcement and the "valid" special exceptions
aren't too relevant here, so...

> If "stash apply" vs "stash apply --index" makes any difference,
> there is something wrong.  We should be aborting the "git merge"
> even before we even start mucking with the working tree and the
> index with strategies, no?  I think it is the bug, if this change
> makes any difference, to be fixed---we shouldn't be proceeding to
> even create a stash with index changes to begin with.

I agree with you that generally if the index does not match HEAD, then
(A) we should abort the merge, and (B) the working tree and index need
to be left intact when the merge aborts.

But I don't think your conclusion follows from those two items,
because of the last sentence of this comment:

   /*
    * At this point, we need a real merge.  No matter what strategy
    * we use, it would operate on the index, possibly affecting the
    * working tree, and when resolved cleanly, have the desired
    * tree in the index -- this means that the index must be in
    * sync with the head commit.  The strategies are responsible
    * to ensure this.
    */

Due to this requirement, if a user has staged changes before starting
the merge, builtin/merge.c will:

   * stash the changes
   * try all the merge strategies in turn, each of which report they
cannot function due to index not matching HEAD
   * restore the changes via "git stash apply"

This sequence has the net effect of not quite cleanly aborting the
merge -- it also unstashes the user's changes.

One way to fix this problem is the simple patch I proposed.  An
alternative fix would be to rip out the extra code from all the merge
strategies that enforces the index matches HEAD requirement, and then
adding enforcement of that condition early in builtin/merge.c.  That
alternative fix probably would have saved us from a lot of the
headache detailed in commit 9822175d2b above, but it may also make
recursive and ort a bit slower (which had relied on unpack-trees to do
some of this checking, and thus they'd have some redundant checks).
