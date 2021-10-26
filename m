Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3406C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 19:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57EB60EC0
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 19:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbhJZTIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbhJZTHg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 15:07:36 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E006C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 12:04:37 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v200so60252ybe.11
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vo/yvf0DeK7oqceS8QdgdHH1ZiZcIYMi84MIXU8+CH8=;
        b=fkLUM/fHLGce9I+CdwlJz2qxgTP/RekNR1J/pFlJ9uNVB4qxjW3CVariCY57WhhBOF
         TFj4swCbFYfisD9MBNfafvwN/5niSYJLUfDEDM/zu6CnLWGpYC/sHZWk0NqCvy8nQgfm
         ogd+YKF5+NaUkMZXGURTWSlMMYNm0Pe0kFqFp+aJykDyiM7nby9qIg/B7L3l8S6B5SYz
         VlAHuDoV06m52ZnBFXEDlHRIBNguVUJ/phzP1VzsBLp2vH3TrQMK0GsxKH2V+qIP4hdT
         bjqYSH2nWWlm+qdt4vc3K9+e2xBzxQ6SKnxH9buk0Es6vlrVADt2WmSUXULciDnB8INQ
         PvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vo/yvf0DeK7oqceS8QdgdHH1ZiZcIYMi84MIXU8+CH8=;
        b=FbKzbBPw9XJVtNitVB3pQ6r2a0KjkxGaAQc/BeN49LMV1Ln/2a4vWhsTs3F1wef84M
         g+7ZDNdxD25i2aNiE5NLTFnflh8wfc/IdujrscgZnvldKuEDsDIrib2an8B+3MlTlUmY
         7+mg42ZNgkLdbnes2HFYpA3nOucX2zTZRlar0okdWcPyxZtC/yMgYMtSj1CazbD+p6+e
         Arfo7ACUR87JhVX5AEpS4HIlyMWVB1SwatEz/R3cFbcvMk8kOzDaw3TuYgvvrAPoEEJD
         cWOVW8j93cd5lTg88oTNq6iP9pj/Dy+PcEyIUOqIQ3HCDBGERGWfF/urtHOQvsnkITA9
         4lUg==
X-Gm-Message-State: AOAM531pxyfVQmzNsQLn3Ll8XwLnr+UzqT8hiErlT5MgutVgOA3qi0Hr
        JO1ZLwsSyJwfyreBg8FrRgY+XD5dNcpOvcY3f3Q=
X-Google-Smtp-Source: ABdhPJzXKrwnCy/e58h2SwOXr3P9RGkiVZG4ipgqAysyOA77vx+4SdNIdiEPcQcTUiH199qZmF9Jhjj/xRBUMurQsII=
X-Received: by 2002:a05:6902:54f:: with SMTP id z15mr16079853ybs.183.1635275076556;
 Tue, 26 Oct 2021 12:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbl3u5fhy.fsf@gitster.g> <20211024162859.6295-1-robin.dupret@hey.com>
 <20211024162859.6295-2-robin.dupret@hey.com> <xmqqsfwp2j6o.fsf@gitster.g>
In-Reply-To: <xmqqsfwp2j6o.fsf@gitster.g>
From:   Robin Dupret <robin.dupret@gmail.com>
Date:   Tue, 26 Oct 2021 21:04:25 +0200
Message-ID: <CA+G124Xci1bGG1uxt35gr9ede11ix10CtLmmWcT+eYNCDSN6Xw@mail.gmail.com>
Subject: Re: [PATCH] http-backend: remove a duplicated code branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Robin Dupret <robin.dupret@hey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Did you mean to send the same patch text (but with an updated log
> message)?  Just making sure.

Yes, exactly.

> We are all imperfect human and anything we do is merely "trying to"

Fair point. :-) Do you want me to resend the patch without this part
or is it ok ?

Thank you !

Le lun. 25 oct. 2021 =C3=A0 17:55, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>
> Robin Dupret <robin.dupret@gmail.com> writes:
>
> > Try to make reading the computation of the gzipped flag a bit more
> > natural.
>
> ... and did you succeed? ;-)
>
> We are all imperfect human and anything we do is merely "trying to",
> so let's not say "try to", unless the change is so involved that it
> is hard to judge if the result has succeeded in trying.
>
> Did you mean to send the same patch text (but with an updated log
> message)?  Just making sure.
>
> Thanks; will queue.
>
> > Signed-off-by: Robin Dupret <robin.dupret@hey.com>
> > ---
> >  http-backend.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/http-backend.c b/http-backend.c
> > index e7c0eeab23..3d6e2ff17f 100644
> > --- a/http-backend.c
> > +++ b/http-backend.c
> > @@ -466,9 +466,7 @@ static void run_service(const char **argv, int buff=
er_input)
> >       struct child_process cld =3D CHILD_PROCESS_INIT;
> >       ssize_t req_len =3D get_content_length();
> >
> > -     if (encoding && !strcmp(encoding, "gzip"))
> > -             gzipped_request =3D 1;
> > -     else if (encoding && !strcmp(encoding, "x-gzip"))
> > +     if (encoding && (!strcmp(encoding, "gzip") || !strcmp(encoding, "=
x-gzip")))
> >               gzipped_request =3D 1;
> >
> >       if (!user || !*user)
