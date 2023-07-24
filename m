Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0468C001DF
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 17:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjGXRjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGXRjl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 13:39:41 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A8E55
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 10:39:40 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9f46ec07aso2933538a34.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690220380; x=1690825180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=befMl6xpo1S3j1LvbI9TO1bdm4Nl8UCptHYqGaEyb00=;
        b=F0Rwc6om8ZFNKAi2uRQ+rODDIATDxbUWr4HSYlub+VgC0AqQuyo6MC8gOwdCbZrxR2
         DNy7qg3TpK4f/PXcBHsPHNpu1U/5gNnX9tInpLnd/2C0jFVtVEEOrzUvDoB6EHSV35Rg
         8ckY+NJF6v4q7N4VJ8s7lcwyZxIMwJmJBnQmRA9grkH7sr9x6gc7MZsp5dEtfjw6MC2N
         RRW5HoRAl/b//FYEHjS6KqB4KJuEgv/nAcAffa4iTagdtKCe+d70RzIHc2AcFqWYSC68
         Agln9XWdwaVcqE8B7ozzVSzGQ3LvP7tflLQaFGKJ0E1Jp+az8CS/dS0gSSEdR9W6xMAg
         10zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690220380; x=1690825180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=befMl6xpo1S3j1LvbI9TO1bdm4Nl8UCptHYqGaEyb00=;
        b=FJeKjAMt4nFP0iEJfWr7mMBrltJdN20sjPj4e+6Ph0sJvirX92cNh4aIqryZZ/3w/p
         G3yXIXP6OIvdzadjk3Jb19p7o1JcGL7qFEilSY69qDXsbNWiveIU+J9VHnCmCtEcnFko
         DZlb9tfeEaahNWpw1HQp1CzjPKNjd/AkM8rMYUqQwHlqLzQsaLF/lyWa9FmB6NTz8KbV
         2ZlruJ5aYhTJyweZiev0Txrqv0vf+fixbkSljLcMMsWMJ9vcjOGxlyYL2ztZ5cRk21RQ
         K5nWf/Alepeqx3gFe0UnArmaaSkDigg8IZwcEss+wmhJ+EI/RrP5I2AhMFHP7TprdqnD
         ghxw==
X-Gm-Message-State: ABy/qLbfztJey3f7dVdkQscXVhhiR1WPR1I2YJLiaV1CLOZECMi8C7Hb
        2HdJadq3z0WoOEqrHjSE9ONQyTvh19jcdqqvIeLR3IypMcg=
X-Google-Smtp-Source: APBJJlGbZJhbPc9eeB32YsfClLI7itD8gopgM1YnbIOHR9FVg9NyKHVp7yumWMtaFpVR7Ngk6TT5jrORuOSSiPOyP+M=
X-Received: by 2002:a05:6830:34a5:b0:6b8:6bd1:d0d3 with SMTP id
 c37-20020a05683034a500b006b86bd1d0d3mr6236517otu.5.1690220380072; Mon, 24 Jul
 2023 10:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230721060848.35641-1-alexhenrie24@gmail.com>
 <20230722212830.132135-1-alexhenrie24@gmail.com> <20230722212830.132135-2-alexhenrie24@gmail.com>
 <xmqqjzupqn3q.fsf@gitster.g>
In-Reply-To: <xmqqjzupqn3q.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 24 Jul 2023 11:39:03 -0600
Message-ID: <CAMMLpeSQ4xPMSOCyN7hnq6efQp0w9uzCXBcG5my8U3Yamzrnpg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] sequencer: finish parsing the todo list despite an
 invalid first line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 10:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:

> > +test_expect_success 'the first command cannot be a fixup' '
> > +     rebase_setup_and_clean fixup-first &&
> > +     (
> > +             cat >orig <<-EOF &&
> > +             fixup $(git log -1 --format=3D"%h %s" B)
> > +             pick $(git log -1 --format=3D"%h %s" C)
> > +             EOF
> > +
> > +             (
> > +                     set_replace_editor orig &&
> > +                     test_must_fail git rebase -i A 2>actual
> > +             ) &&
> > +             grep "cannot .fixup. without a previous commit" actual &&
> > +             grep "You can fix this with .git rebase --edit-todo.." ac=
tual &&
> > +             # verify that the todo list has not been truncated
> > +             grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
> > +             test_cmp orig actual &&
> > +
> > +             test_must_fail git rebase --edit-todo 2>actual &&
> > +             grep "cannot .fixup. without a previous commit" actual &&
> > +             grep "You can fix this with .git rebase --edit-todo.." ac=
tual &&
> > +             # verify that the todo list has not been truncated
> > +             grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
> > +             test_cmp orig actual
> > +     )
> > +'
>
> The structure of this new test piece, including the use of "log -1
> --format", seems to follow existing tests, and very readable.  Why
> do we have one extra level of subshell, though?  There is no "cd"
> that may affect the later test pieces, and set_something_editor that
> touches environment that may affect the later test pieces is called
> in its own subshell already.
>
> Other than that, looking good (there may be a valid reason why the
> test piece needs the subshell around it, but it was just not apparent
> to me).

The only reason for the outer subshell is that I thought it was
required when using rebase_setup_and_clean, but I see now that
rebase_setup_and_clean is used in several tests without a subshell.
I'll drop it altogether in v6 and use `test_when_finished "git rebase
--abort"` instead.

Thanks,

-Alex
