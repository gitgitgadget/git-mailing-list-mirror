Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579E5C05027
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 01:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjBOBXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 20:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjBOBXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 20:23:16 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C403527A
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 17:22:38 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 78so11469947pgb.8
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 17:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676424147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNfTggu85MmES3XN00L1pGejo8pMpUrMRPOt6bmWT0E=;
        b=mIVeTkqMXBxrUP7FPpRy2WuX+ba0IWI7MeWacTw28KQHA1BkZ+FthP+QB5kiyXIgfd
         +qQAEAPxEE9AAh0qZbXDWty7ek8Lgx4APGKNllkFK3YKccbCJbfVUPmJpQZwqzIcHOR7
         A/w4UEP4pVHfPmoCUGkfttAi/+dzjrS+c75Slv9bIlGOJa9dKEHvkWMFEne6pIGSib5P
         9VQcb0kDBiNHRdL+dFxHKX9/IHKxmQ3cln1FWuOoYkxehYIpXRI2xbwMBHID/U+0P137
         Ma8Y7Fz+SgLwEWEZJI/Sma0kViUoGGfXx7lzfoBVPkcDjikOa85gQGAeYJA2en25JfKe
         xFDg==
X-Gm-Message-State: AO0yUKW6kNCNC3L+DkvPN+O/oKsKwHxJs5TST9h+lMPuC9Ab/8gEmipx
        YYJ+9UqnSbY3ln8APqZuc/tYx8GmmwF50oz9pRhaTdd3
X-Google-Smtp-Source: AK7set8UwXoEBeMDjSeLGJIzOcMwVa9UuwKYg4ZiiTe3YSkM2+D4hVM+ePlPHetM3s/jd50WLAzTAI08/nxtKpLxKmc=
X-Received: by 2002:aa7:8eca:0:b0:5a8:c0e0:3b2 with SMTP id
 b10-20020aa78eca000000b005a8c0e003b2mr26262pfr.45.1676424146672; Tue, 14 Feb
 2023 17:22:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
 <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com>
 <xmqq1qnjhlbf.fsf@gitster.g> <CAEroKagUY5PfuC2CDn=pTJ=brPsjPy6MVz54mH1tvN8E-Pvk7g@mail.gmail.com>
 <CAPig+cTNk1RvfdFembKcxTOUs0UsiXmz8rsEnab-0fQp-QE3Lg@mail.gmail.com> <xmqqedridzjw.fsf@gitster.g>
In-Reply-To: <xmqqedridzjw.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 20:22:15 -0500
Message-ID: <CAPig+cSO1kMp_ck6q-2xRZth2LkfF5sw9rf0MijtkKjRhEoCQQ@mail.gmail.com>
Subject: Re: [PATCH v2] ssh signing: better error message when key not in agent
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Szkoda <adaszko@gmail.com>,
        Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2023 at 5:23 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Wed, Jan 25, 2023 at 8:05 AM Adam Szkoda <adaszko@gmail.com> wrote:
> >> On Tue, Jan 24, 2023 at 6:52 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> > Does GitGitGadget allow its users to describe the differences since
> >> > the previous iteration yourself?
> >>
> >> No, I don't think it does.   It got generated automatically without
> >> giving me an opportunity to edit.
> >
> > Yes, the user can describe the differences since the previous
> > iteration by editing the pull-request's description. Specifically,
> > when ready to send a new iteration:
> >
> > (1) force push the new iteration to the same branch on GitHub
> >
> > (2) edit the pull-request description; this is the very first
> > "comment" on the pull-request page; press the "..." button on that
> > comment and choose the "Edit" menu item; revise the text to describe
> > the changes since the previous revision, then press the "Update
> > comment" button to save
> >
> > (3) post a "/submit" comment to the pull-request to tell GitGitGadget
> > to send the new revision to the Git mailing list
>
> Thanks.  I thought the above would make a good addition to our
> documentation set.  Documentation/MyFirstContribution.txt does have
> this to say:
>
>     Next, go look at your pull request against GitGitGadget; you should see the CI
>     has been kicked off again. Now while the CI is running is a good time for you
>     to modify your description at the top of the pull request thread; it will be
>     used again as the cover letter. You should use this space to describe what
>     has changed since your previous version, so that your reviewers have some idea
>     of what they're looking at. When the CI is done running, you can comment once
>     more with `/submit` - GitGitGadget will automatically add a v2 mark to your
>     changes.
>
> before it talks about doing the "/submit" again.  Expanding the
> above into a bulletted list form like you did might make it easier
> to follow through, perhaps?  I dunno.

Perhaps, though I wonder how many people consult MyFirstConstribution.
Maybe SubmittingPatches would be a better location for such
instructions, although (I notice now that) that would be an even
bigger change since SubmittingPatches doesn't mention GitGitGadget at
all. Another appropriate place might be the "welcome" message that
GitGitGadget posts the very first time someone submits a patch series
via that tool (assuming that the welcome message doesn't already
explain it).
