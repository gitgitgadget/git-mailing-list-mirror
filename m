Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D11EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 20:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjFUUH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFUUHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 16:07:24 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF6AC
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:07:22 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6686a103a8cso3849347b3a.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687378042; x=1689970042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9NChBJyGlCxXTgvhVtexzpj9KWObsxbwH+Sv7qE9dMc=;
        b=sUniR0Mktb/x9eKPk0vnQEtUO5lntcQdRffjf3Z73Fkzm8BrL7VCPXV3d0QhZlqlXn
         AAeIbJr/XN7UX0kbYuuFzv+cFtb3gD/V8lm6jsZEpquTR0IWwbFkYmD8xm9Ch1JjxTJy
         o+NFMOI3rTGwdcztsJHT9HjsPc9uKok209nilPXBNqWxjPeZ5VfwtEyyfbjoYv7mcbiu
         SNtscTyL6tgQ98y+ZY4c8tGvQx2+gFo4tgS4ViPYvt6C6ppKjE3nkvgTrkKwYdfyB7/H
         SJYyA6tXMR2mSj4EojWo/3GppKv/T9EzCjrd6h65Had2yvE0fR1gWXUKYDuq7iJYaAm6
         dY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378042; x=1689970042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NChBJyGlCxXTgvhVtexzpj9KWObsxbwH+Sv7qE9dMc=;
        b=KMMufwQfBMpT1BaO9YmsRqJQILCSmfK6kfdkRZsvIMoeiPbAKjtMmQSGjw8scT/kQm
         HpyU2fvtesAD5rGIq/aHYmAV0OKoyon+a87Lb17AHlb7EvU3oHOmkGttugjke7gJzuqX
         e0t0EAWa2roymCCbzYBlPru4OUzDylexXmuCx8lQYQ13k7uEAsoHMGUHKZkO+IwApfTZ
         tvBTPtdihRQmSc4EpRwpJrf1Wk2DuPKrKKtiyzplFcOp/Y2nlcVUVG4focrOjUJUWseT
         usoRmX6jR/TMg0w6npDE5B5ET7D9JytPYtHj6GA3I87fBss4YhtrGShX+gVcMb6Soubj
         YCKQ==
X-Gm-Message-State: AC+VfDzdZ1oArkVPr20jxzlNtqtn31bdbYoJghwuJA6P5kkx0DhSAwx3
        O1//7GyE6/y5B3whqjKhJD/0uWtI3TVwQg==
X-Google-Smtp-Source: ACHHUZ7eXuP+2sF/ucsCSkYr28BSoz/ab4Ne334EnUBzg4DWGbu1cRDXrDE5DOWR4sgYhVCPGvm9BgGDboxfNg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2d1c:b0:66a:525f:6496 with SMTP
 id fa28-20020a056a002d1c00b0066a525f6496mr152451pfb.6.1687378042131; Wed, 21
 Jun 2023 13:07:22 -0700 (PDT)
Date:   Wed, 21 Jun 2023 13:07:20 -0700
In-Reply-To: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com> <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
Message-ID: <kl6lv8fgr347.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 0/6] rebase -i: impove handling of failed commands
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip!

We picked up this series during Review Club. You can browse the notes at

  https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit?pli=1

but we'll post any substantial feedback back to the mailing list anyway.

Firstly, I have to acknowledge that this series appears to be geared
towards to reviewers who are already familiar with the rebase machinery
and don't require a lot of context on the changes. None of the Review
Club attendees were familiar with it, so we had trouble following along
certain patches, but we might not have been the intended audience
anyway.

I can leave comments from that perspective, i.e. what would have been
useful from _if_ this were written for folks who weren't already
familiar with the rebase code, which could be useful if we were trying
to train people to reviewer sequencer.c. However, I don't think this
warrants substantial changes if the series is already clear to the
intended audience.

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series fixes several bugs in the way we handle a commit cannot be
> picked because it would overwrite an untracked file.
>
>  * after a failed pick "git rebase --continue" will happily commit any
>    staged changes even though no commit was picked.

This sounds like a safer default for most users, but I worry that there
are seasoned users relying on the old behavior.

>  * the commit of the failed pick is recorded as rewritten even though no
>    commit was picked.

Sounds like a reasonable fix.

>  * the "done" file used by "git status" to show the recently executed
>    commands contains an incorrect entry.

This also sounds reasonable, but from Johannes' upthread response, this
sounds like this isn't universally agreed upon.

Perhaps the underlying issue is that the behavior of "git rebase
--continue", and the todo/done lists is underspecified (in public and
internal documentation), so we end up having to reestablish what the
'correct' behavior is (which will probably end up being just a matter of
personal taste). This isn't strictly necessary for the series, but it
would be nice for us to establish what the correct behavior _should be_
(even if we aren't there yet) and use that to guide future fixes.
