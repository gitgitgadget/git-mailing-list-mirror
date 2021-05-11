Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290E3C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E858761288
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhEKScX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKScX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:32:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956DCC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:31:15 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso18340927otn.3
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1LMsf4BLCC93aDrdHzLRX2WvNLtjH8Yu6CHjK8Z8Cc=;
        b=PR94XRO0y4qntCtnkVhm1xxy62a8M4TXhdRokEPM64SQoRfEXdnlXRTlNS/B/6WMf6
         lRywKJz5OlvMzHPySvI/61gOgrrtHa3C3hCouxUINkQINsorn1Iy0UZnYbGFwg71mgBc
         KqfW3F3qGhZjjJk3z8/hJJyIJhhbpPiPuLRB9ABBMDfI9oC0mezviJ7a9S3XfBnU1vwT
         bbpfidxvRcIGn65O04gtiSb0I8EKnMwRhnsvg1p7L9cpR+PGFzZbqNAKI6cCuPB2OqMq
         LyactAC8znyBfWFOBX/oKtB4X4KR9keSmmeklv0hu5sluMqxMMFCMxY3zfJ6bFBb+HB3
         /LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1LMsf4BLCC93aDrdHzLRX2WvNLtjH8Yu6CHjK8Z8Cc=;
        b=EZNF8nuSt1kIxbJbcd27uheQfShTmfzKSO9Ja+rEAZmKiB833nbAqW05gP5+914yLM
         q+maI6VahceBElw/5Am3de10WZ6z04vsCmXlrMT7jmGaxFxFEqxsItDmb8U8fsKZywiu
         p1wYa9lMRESiiCL7+qQ/sPG4L/IjQAA6fN1XzTavAoGGT8R43xpaO1PWquSeQ0iE7Yft
         7bay/vuZugQSYvR0LtwoORWAD45rCz9AqrVzUQZnw0DS+r8MvWrmZTRPxXSO7lz9ER9H
         +Jq41x62O65QIFwj7BhYkRdJBi2iWil6MHJ4K0LS9rTaZ+SEzMKQqe4IJ3FBkIQYiDZs
         vfyQ==
X-Gm-Message-State: AOAM532mUYumc2KCkHQObFoQqJ+viNN/xqcQYfqriwXslLRLM9KK6/Vw
        IptDjc8DDvwI/WBWU4WMmJXunc9x/OMR8Inyh3c=
X-Google-Smtp-Source: ABdhPJx+EEChWm+IPbuqiPZWDUSoUjCBwFMCJLxokhjlTDvqx5v/XPvUj6QD71OE+HFwtIXd3aiAayKo5YUrC3YJdas=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr9109142otn.162.1620757874971;
 Tue, 11 May 2021 11:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com> <20210510153451.15090-7-sorganov@gmail.com>
 <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g> <87v97pv04p.fsf@osv.gnss.ru>
In-Reply-To: <87v97pv04p.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 May 2021 11:31:03 -0700
Message-ID: <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 7:03 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes:
>
> [...]
>
> > If we enable "some kind of diff" for "-m", I actually think that by
> > default "git log -m" should be turned into "log --cc".  As you told
> > Alex in your response, "log -m -p" is a quite unpleasant format to
> > read---it is there only because it was the only thing we had before
> > we invented "-c/--cc".
>
> Please, no! --cc has unfortunate feature of outputting exactly nothing
> for a lot of merge commits, causing even more confusion than historical
> "-m -p" format.
>
> The best default for -m output is --diff-merges=first-parent. Everybody
> is familiar with it, and it's useful.
>
> > But that might be outside the scope of this series.  I dunno, but if
> > there is no other constraints (like backward compatibility issues),
> > I have a moderately strong preference to use "--cc" over "-m -p"
> > from the get go for unconfigured people, rather than forcing
> > everybody to configure
>
> I rather have strong preference for --diff-merges=first-parent. --cc is
> only suitable for Git experts, and they know how to get what they want
> anyway. Yep, by using --cc. Why spare yet another short option for that?

Interesting.  I have a strong preference for --diff-merges=remerge
(yeah, I know it's not upstream, but it's been ready to submit for
months, but just backed up behind the other ort changes.  Sorry, I
can't push those through any faster).  I've had others using it for
about 9 months now.

I think --cc is a lot better than -m for helping you find what users
changed when they did the merge, but I agree the format is somewhat
difficult for many users to understand.  (--diff-merges=remerge, or
--remerge-diff, fixes these problems, IMO.)  I think
--diff-merges=first-parent, while fine when explicitly requested on
the command line, would be wildly misleading as a default because it
would attribute changes to a merge commit that were made elsewhere.

> Overall, let's rather make -m give diff to the first parent by default.
> Simple. Useful. Not confusing.

I think it's confusing.
