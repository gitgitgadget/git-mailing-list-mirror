Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0CAC4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 18:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiL0Smk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 13:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0Smj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 13:42:39 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C94EB48D
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:42:38 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id i83so7255077ioa.11
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z+PusIHMpjns9EolQM/clH/GH8WVhzZvqsb+IKsYIM8=;
        b=eFIf7XG7jhZtkPxnpS4vMLctOcvLXE+sRTT4abcKVwjfqaCT028XyTliG1tLnyI2GQ
         y698MFQrHjZwu6kfRMvI/H5zVFVQOZq3fgAjTdr1Ny8Ij8uizMxhZWKAMMsKJl2ud/nu
         J/8CpLif8+vJyBsLNYSgD6ReHL/KSPqRM0Qr66uk3k/OtJFI0OjNq2s3Gym77dPN9Lny
         XkPLCwiWpEYmMuVOJQmszcGL9BuB3tRtwGR1NCKJ+7Hbi1MjWqj1eSZihLuoMKPP0f2+
         zYCyTc/jkJjwOgCvf5uyoatyfazEhL3sIwd++59nnMIWBbP7BTaUQfgZtMazSCfv1pId
         xxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+PusIHMpjns9EolQM/clH/GH8WVhzZvqsb+IKsYIM8=;
        b=cidJbKueYCVOdnX2Z0ZcJvW7R6hAVkjNs30XMB0h+mKn2uiZA20MVtjSULB690zStQ
         golsktjI18N/KstQdQ5wnUFaW+x8n8nCQaQptd89uFG3aZzJBY0p3oNTAfafhkzfNzSt
         HP5zx7hSmyHC5MZtqn3BcnjSy9d2rlAFTettoxqhrZYUsR39Y3JgRfwnOuu8J1f/78sB
         vEojL2lheYBon5XYY29UY6O4VpHInSiZSiAQWnGr/Oj+6E8bWxSKtP7DLSC5oviZ07Gj
         CmWFFyyLfMIT7BHQQgDW20Fgs81jFzj9L5c98/ZFSTNzRZ16GJFmOhwq2vkzz/GoLPOY
         WFQA==
X-Gm-Message-State: AFqh2kp2jsPltS+2rUOO7LkFtXCgXTeS5v45tjWFVk+0Zh6oi367JNUd
        +djHRshHlR/ovIrUufiTjdb1G7xSnbL35DgqmMjIJQmB4bNFKos=
X-Google-Smtp-Source: AMrXdXuxN1AlxXcFbzBU9fWk2dHyRqbzdlzcSVUn5ZOMwQS/emCtJsy9yy6h6cSmJVon1Y08k3dnMfLtkrDRUUF0evk=
X-Received: by 2002:a05:6638:2203:b0:38a:3978:f014 with SMTP id
 l3-20020a056638220300b0038a3978f014mr1620173jas.32.1672166557214; Tue, 27 Dec
 2022 10:42:37 -0800 (PST)
MIME-Version: 1.0
References: <CAO_RewZeUBVvqT+UgXL5V5EeTOt14zZ-5vJYA4YvNr-jNyupXg@mail.gmail.com>
 <xmqqcz85t3dr.fsf@gitster.g>
In-Reply-To: <xmqqcz85t3dr.fsf@gitster.g>
From:   Tim Hockin <thockin@google.com>
Date:   Tue, 27 Dec 2022 10:42:25 -0800
Message-ID: <CAO_RewbVicTznpDeCDG0Uqng-MdQ_GKtp-Vgz8kmtaXoczQGOg@mail.gmail.com>
Subject: Re: git fetch --dry-run changes the local repo and transfers data
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  What threw me is that I expected it to be "very fast" and
"very cheap" . If I commit a multi-gig file on the server, I see the
dry-run fetch takes several seconds (clearly indicating some work
proportional to the server repo size).  I don't want to transfer that
file on a dry-run, I hoped the server and client were both
dry-running, andb the server could simply say "here's metadata for
what I _would have_ returned if this was real".  Not possible?

Tim

On Tue, Dec 27, 2022 at 4:52 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tim Hockin <thockin@google.com> writes:
>
> > I'm trying to test if a remote repo has a given SHA. `ls-remote` does
> > not work for this unless it is a tag or a HEAD (which is not
> > guaranteed for this case).
> >
> > `git fetch --dry-run $remote $rev` SEEMS to fit the bill, except it
> > changes local state. For example:
>
> Well, without changing the "local state", you cannot see if that
> report repository has or does not have the commit.
>
> > FETCH_HEAD was not updated (good)
>
> None of your refs are updated, either.
>
> There are things that are not reachable from your refs (or other
> anchoring points like the index and the reflog).  As far as Git is
> concerned, they don't exist [*], and that is why Git will happily
> remove them with "git gc", for example.  They are crufts and it is
> easier to think of them as not a part of "local data".
>
> So I suspect that ...
>
> > but the rev in question is now
> > present locally (bad),
>
> ... this complaint is a bit misguided.  After all, the procdure you
> gave above is exactly how you would ask the "I'm trying to test if a
> remote repo has a given SHA" question about commit f80f1b23b4ca.  If
> the operation did not transfer data, you would not be able to get
> the answer to that question.
>
> > Am I using --dry-run wrong (or misunderstanding its purpose)?
>
> Maybe (mis)understanding on Git's data model (see above [*]) is the
> root cause of this confusion.
