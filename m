Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC583C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20F5206D7
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 10:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdVv8HTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFMKER (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgFMKEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 06:04:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AE9C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 03:04:16 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w16so11957562ejj.5
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOjTekKho8mb9CEhmjFrJ4odavEyevqOR9nyx0HRzsM=;
        b=MdVv8HThrg4a/t0EXODSY3mfttZgSdfMjSDOBAH0F0AdoPV39eOlgfVt+r+KJcxbc7
         NXQCMti+I+s16qIxg+hZGs9F11aOQHF2Ea189khHRWJLOeZrD18jIOKdKUn7A20dqKct
         a0pziv3OdOx0zQaTGEtGhEgr82SAZ6lsMxr0X28eKLo2TIgH6xOE6S+sC+imU6WI/Vx4
         ka1z3yf22YGIBXqCe/xgUXRRt4xTJmKnQVqFGb/ZIiYE6wmmjP7EpAdhUZJAVzkGJRGG
         FMadB8ZBehhj8eGkd/7y0KKqrntKdKEVYSqQpSDXgA68+solZrz0EITG66kjEOIOTQop
         6PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOjTekKho8mb9CEhmjFrJ4odavEyevqOR9nyx0HRzsM=;
        b=lL0PqIkS5OSd3FOwdX/+PDx3qOF+jW2Lo+jDjZmsn4+Y0x+aybM5kWxjhaV8ExSQqc
         ZaM8yU0Wv5SkUrAr6KigDV8gtslF8BZVeU0H/fxvaFKUbbACWoDPbZk+gCKGamRIbTlv
         WzUbz+xG0RQ7tzYeDvNHQpbr7yXSLLZ0rzxpAZfLUbmqoknkAcjURnbx9Vs/qHhHTLct
         zcb6X2mGfQF27soVj0JzbkLpLwW/t6a4ht/SxgjZeS2p9c82DpF/nKn+oi/a5DVVQVVP
         UCKHKgi/tcioJTFiVspKE9ZcuC2NDwx4haLim5f0Jbpjjk9ANY6AITFyRGUKeCcHY1Ha
         3FhQ==
X-Gm-Message-State: AOAM531BuAZvWadkSyrEVsvkDF86hPCeMP0yh8ME4pXxyCqcqJuaNmDH
        8s6gXIwI1OAant4luTl6bkz+oRAS3oYS6Qm4FpY=
X-Google-Smtp-Source: ABdhPJw3P6KYg/Mwb6n2XHfjXyhCqdqlyonAy8FaqbpYhVBSHbauSuhtHx+k96cN4Cv/U6dLECDlpntT8c/bSnNaN58=
X-Received: by 2002:a17:906:9402:: with SMTP id q2mr17005689ejx.216.1592042654522;
 Sat, 13 Jun 2020 03:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200505104849.13602-1-alban.gruin@gmail.com> <20200505104849.13602-4-alban.gruin@gmail.com>
 <CAP8UFD26Df266Q9QnnQjM+dvKWmi8Rgj_J+BgsNrOyttxqVpQQ@mail.gmail.com>
In-Reply-To: <CAP8UFD26Df266Q9QnnQjM+dvKWmi8Rgj_J+BgsNrOyttxqVpQQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 13 Jun 2020 12:04:03 +0200
Message-ID: <CAP8UFD31FdBgPy3p4Riryn4BNuZJxH0r4qDOu3hDcrJ9cSJeyg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/6] stash: remove the second index in stash_patch()
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 13, 2020 at 11:38 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wrote:
> >
> > This removes the second index used in stash_patch().
> >
> > This function starts by resetting the index (which is set at `i_tree')
> > to HEAD, which has been stored in `b_commit' by do_create_stash(), and
> > the call to `read-tree' is replaced by reset_tree().  The index is
> > discarded after run_add_interactive(), but not `diff-tree' as this
> > command should not change it.
> >
> > Since the index has been changed, and subsequent code might be sensitive
> > to this, it is reset to `i_tree' at the end of the function.
>
> [...]
>
> >         /* State of the working tree. */
> > -       if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
> > -                               NULL)) {
> > -               ret = -1;
> > -               goto done;
> > -       }
> > +       discard_cache();
> > +       if (write_cache_as_tree(&info->w_tree, 0, NULL))
> > +               return -1;
>
> In the previous patch you use the following:
>
> +       if (write_cache_as_tree(&info->w_tree, 0, NULL) ||
> +           reset_tree(&info->i_tree, 0, 1))
>
> Here the reset_tree(&info->i_tree, 0, 1) call is in the "done:" part
> of the code. Is there a reason for that? Can't
> reset_tree(&info->i_tree, 0, 1) be tried here before returning an
> error? Or was the previous patch wrong?

Sorry I think I misunderstood the code in the previous patch. It
actually doesn't try reset_tree(&info->i_tree, 0, 1) when
write_cache_as_tree(&info->w_tree, 0, NULL) fails.

> I guess the reason why the
> reset_tree(&info->i_tree, 0, 1) call here is in the "done:" part of
> the call is because it should be after the diff tree command is
> launched. I see that the commit message tries to explain this a bit,
> but it is still not very clear to me.
