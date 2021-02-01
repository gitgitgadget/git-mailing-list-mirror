Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B30CC433E9
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCDB64E9B
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhBALKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhBALKB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 06:10:01 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05DC061574
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 03:09:21 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id q23so2371789vsg.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 03:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=os5QiYPjEFwxPU5ai4yLt26TzRqfRh1MCuJVByVK3Bc=;
        b=HDCwbTocJ3HLqlSrbRXa5nORdK+J72Vygzx2JU8Mz7A6KAogyrrGDxHXE25xTY0wFc
         vtU5WYOaOILC+jK6ulEHNWyrobOeEz+b4XPmsB+ALpcR7iTv26Vfae2OkIhDduY8qc0P
         afqvqx3+ccaDFQniBaQTW/aIrOHNJTN1aSu40l5OCpZtPU9muJzOz5AValirfOnC+KPO
         92xY6LWMpl5i5ZDoTsuKgJE6ScobTVTqe1FV99D7Zo2t3fh88mKx94SBW7UxxyETCoxF
         HpxW4G+/KFLtodsUf71XZyUAbApFYJSYBJpJ50wSXnaYMK9HJKtfHbyBmcZSAh/2jfwK
         5IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=os5QiYPjEFwxPU5ai4yLt26TzRqfRh1MCuJVByVK3Bc=;
        b=mhOIw41MbY4fj46xBUF56rfI4IKDuGFXy0I7JMbnu5J1VPj/eSn7YD81VF+V6Mm4Ue
         mrmqy581BAXRPd/rsMnrEX0CuJ9vDOTWechCFCwTTXV6/J3sIATZwjW8ADtzQVBznVkL
         jH+IH2O9cLPPTJrvK9BvWaCG+dyTxw1Qr7U2Tf1KWKr+kzp+VzJTdYloCei3ITEFmEg9
         aznA6g5rZg5HZJ3rGEJgN7DB3cHdeUTJZ32caOWxif6C4nLrLQv724za4/RkYbrGryC0
         EgZpJNCPyecYx69IuN3LOXTIRQf/fPJ3xld8JF4PRKMHqzWnB0BlBeEW60ajHLWINedn
         jDJw==
X-Gm-Message-State: AOAM532ixP+2NV2xmhberEx9QxkOmgXZO/nM6ycFZKypvLxm7TMFo2ob
        1MGM1USLeLDTnSr03A/xGE/ZZUdqLjYE1fccnHGMZww280pEgw==
X-Google-Smtp-Source: ABdhPJwh66B3/uEq+YOPy2udwZgtoGhgEyfRgPFXvqIYSddi7ZfT/ToxUyzDBMF0yk5SNr4XoF47jKxzbczKhPFY4f8=
X-Received: by 2002:a67:b42:: with SMTP id 63mr8655891vsl.50.1612177760024;
 Mon, 01 Feb 2021 03:09:20 -0800 (PST)
MIME-Version: 1.0
References: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c>
 <fec7ef37962da584a89012234ae4a1a@72481c9465c8b2c4aaff8b77ab5e23c>
 <xmqqa6sqp827.fsf@gitster.c.googlers.com> <028152B6-DA5B-40F7-B944-FF4F31C2BC56@gmail.com>
 <xmqqy2gang0e.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2gang0e.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 1 Feb 2021 12:09:08 +0100
Message-ID: <CAFQ2z_Mb86W7PnRfO2wcRqqS3UBOb+TpvOXQ5-UJr0aH6OnJFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] t/t1417: test symbolic-ref effects on ref logs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 31, 2021 at 12:48 AM Junio C Hamano <gitster@pobox.com> wrote:
> > On Jan 30, 2021, at 11:56, Junio C Hamano wrote:
> >
> >> The said commit came as part of this topic, ...
> >>
> >> https://lore.kernel.org/git/pull.669.v2.git.1594401593.gitgitgadget@gm=
ail.com/
> >>
> >> ... so I've added the true author of it on the Cc: list.
> >
> > Out of curiosity, if Han-Wen Nienhuys is the true author of commit
> > 523fa69c36744ae6 why is it that you are both the committer and author
> > of that commit in the commit's header?
>
> See how the e-mail message was formatted in that thread.  I just ran
> "am" on it (which makes me responsible for committing), and the
> authorship comes from the "From:" that was in the body.  I suspect
> he may have based the patch on some of the "how about doing it like
> so" suggestions I made during an earlier discussion and wanted to
> give me credit for the input, but I do not remember the context the
> patch was originally written in X-<.

The classic reflog format doesn't allow '\n' in messages, but
different parts of the code did try to write '\n'. This patch was
supposed to sanitize the messages in a central location, so alternate
ref backends do not trigger spurious differences in how reflogs are
represented.

Your patch says

> has changed in an unexpected way.

Can you make the expectations and current behavior explicit?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
