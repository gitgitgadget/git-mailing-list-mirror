Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD0C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BDD22525
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdBOLesk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLEXZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:25:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42255 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfLEXZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 18:25:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id e28so5526131ljo.9
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 15:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quH8+LRJ/HAH3xPEhdtToG6M7nu5IXFhqzPLDzs0Axs=;
        b=kdBOLesk75sanPmgIVfA1UgvN6sLkcNHP63DTf3cJslBFENYd1godDYIPf/GEIQoC2
         7YPD/CtrKYSm6MTf0DaIaQ9yIKXjTKWAsXv1jk2cJzjcxTaSaislm1w85VrPs+o3wOYn
         yTnQV568AmYHx9CgkwkyEhzZtFFgubpUQGYM/klY05RxfJ5tMCOo6EdH+CrY2GYFqmwo
         CYKdQSj2RdiyjECHxD7zTucCInh0tnSfenaN8NIfnPAeZP0DBV/0fSSzT6QMyfYjrRrd
         5texebQhTxCwZ03ngcMZNQP8YDAkjfxEN7Tu7MgHxjq8YEDPUVZlakJ2KiE0lqfNin6Q
         cvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quH8+LRJ/HAH3xPEhdtToG6M7nu5IXFhqzPLDzs0Axs=;
        b=SALRHsybcGyCBXlynDy4CLR0ox84tB6esxVgq11S/VFf8hCnp8qWqmZx/zRGQ3iUAy
         0FMrpkcCR3lI8VYOjB+GCtn2H/pmiIv36vTved+2ehRFUcVisi11FyIMJZ/JuJdKClfc
         mH/t4vfGB1eKZc/WpBjdccH5/jaCScWv0mreyZnA0QrYTx//+xhYruKFIdnVugpjcztZ
         lF0mSZJ8J7tTRnbNwlEr6z6oqgnG8P8how6iyOyVe2TuF8eqns8lTqkaifNDrG9ozR/Q
         79iWl4BRogR/9a4IAjjklZ2urBhfFqBDQbOP3x+NaGg7jhspG9pOTZfu8WoCL043uEqf
         FNrw==
X-Gm-Message-State: APjAAAUuaA+cFj6EqrnB8/F1YoO7Mc76LIDdkdLjaF72UC8XMiING1vp
        MVOLfbkzL4t21Jn+5fl3xixSU+qQDm9l1CKo54A=
X-Google-Smtp-Source: APXvYqypPpalQPVYlVmdYF//RZs5EAM+KU3X/1BW24Eptz5PG2gNZSCMVzqbMeO4POMCHqIrbaaSmdCByjsa4+gthWI=
X-Received: by 2002:a2e:9606:: with SMTP id v6mr7004369ljh.223.1575588347484;
 Thu, 05 Dec 2019 15:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20191205225322.5529-1-alext9@gmail.com> <20191205225322.5529-2-alext9@gmail.com>
 <xmqqv9quxtle.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9quxtle.fsf@gitster-ct.c.googlers.com>
From:   Alex Torok <alext9@gmail.com>
Date:   Thu, 5 Dec 2019 18:25:36 -0500
Message-ID: <CANmPhj20-K1f4sL6m3YmZEy+9WdV9YknXfUdLsGCaehv+axb+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] rebase: add test for rebase --fork-point with short upstream
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That was the intention. Your idea for ordering makes more sense.

I'll reorder the commits and submit new patches.


On Thu, Dec 5, 2019 at 6:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Torok <alext9@gmail.com> writes:
>
> > This proves the bug of "rebase --fork-point upstream branch" not using
> > the fork point of upstream and branch if upstream is not the full
> > refname of the upstream branch.
> >
> > Signed-off-by: Alex Torok <alext9@gmail.com>
> > ---
> >  t/t3431-rebase-fork-point.sh | 1 +
> >  1 file changed, 1 insertion(+)
>
> Is this new test expected to fail after applying only 1/3 and then
> starts working after applying all 3 patches?
>
> If so, it probably makes a lot mroe sense to reorder the series to
> have 2/3 as a single preparatory patch, with 1/3 + 3/3 combined into
> a single patch "rebase: find --fork-point with full ref" to fix the
> code and protect the fix with the test at the same time.
>
> > diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> > index 78851b9a2a..6ecdae918e 100755
> > --- a/t/t3431-rebase-fork-point.sh
> > +++ b/t/t3431-rebase-fork-point.sh
> > @@ -49,6 +49,7 @@ test_rebase 'G F C D B A' --no-fork-point --onto D
> >  test_rebase 'G F C B A' --no-fork-point --keep-base
> >  test_rebase 'G F E D B A' --fork-point refs/heads/master
> >  test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
> > +test_rebase 'G F D B A' --fork-point --onto D master
> >  test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
> >  test_rebase 'G F C E D B A' refs/heads/master
> >  test_rebase 'G F C D B A' --onto D refs/heads/master
