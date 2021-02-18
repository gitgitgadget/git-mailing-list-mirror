Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1151C433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 06:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C32664E6F
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 06:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBRGiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 01:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhBRGd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 01:33:59 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677E2C061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 22:32:58 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b8so671382plh.12
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 22:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hbD7kAp+J6oIoW/QYlG7XlRF6KZnymj8nuF92b8SQYE=;
        b=uGP2EfiACVDOqYY7saAeX3mfCtyGqOd339HGQAW7pdV5ou5khL/QVUtzz5RuBds78l
         Fnjkdq+7pfrfi9ZsPnIWCegPVnkOVKrF+baCfrMjru9hw/KLsDPR09tM5d8jNiNthp6F
         qnNETTKln4gI7Kxn3QV6KOmnWLmNtuqqkAxzcJztxf0FwL8N4YSbS9ETMv4uLqs9D2og
         2G4DJQoGyiF+lZ4+3cqK+i52lLT5M71aoZcQFscdTu2mmGCKiI1zgdvjShPehXM1FMFW
         ExHR96aE+sJaXNHJXCh5ixeyfmtlvE2ewnEHL35qBMtEonsaojprBvy5kOcMkLi9b2Zy
         G2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hbD7kAp+J6oIoW/QYlG7XlRF6KZnymj8nuF92b8SQYE=;
        b=ab1wa3HVHHL2NZ2QN/fS6+UYLer3kAm+o8vA4BtSkjlhZBxCs/PPZQwW7dWVkGX/P8
         2SE0w+nH8x71L88Py0VYz5/0NfQxDtX3u75/DFPRylbYqTK0uWQLBVLhOQ66aFS3rNuh
         HshkGTrQ5ESWhUV6iO5aR4H4SSCpyF3ZqosMvmYogOSkgqAxAwAy5APW4vWAp+teCrPf
         svmSOt6hQkceFBvNGxv8k+2/S9rtlDkxyHU1zzGHZkRs2aoVGC4MH9s0RMhtYC9Qa6+q
         AQWKZOZCy/RjHL7Mjjm9bfvDBj57WxKWDpupTv0VmHnppDKfcn3TceMFClo8B51cqEK3
         4srw==
X-Gm-Message-State: AOAM532s6aYcSj4xdxJ9Qs20pqf+ljNNKDGzB7ZZc4elag8pCADx0jqM
        Yfr8MZ8EycEwBEhg7eH1htY/D+jojDB42mHGtaM=
X-Google-Smtp-Source: ABdhPJzaevFDlfdvJew6u0562XYPhff/mJnZuctiSca2wVSiPTk4K/621C+kcvKwdzH8Q5iLVlPtnz0h8Nh4sSjtsZg=
X-Received: by 2002:a17:902:6b06:b029:e3:5edf:c2a1 with SMTP id
 o6-20020a1709026b06b02900e35edfc2a1mr2920226plk.51.1613629976925; Wed, 17 Feb
 2021 22:32:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613590761.git.martin.agren@gmail.com> <97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6.1613590761.git.martin.agren@gmail.com>
 <YC4I20bQ0jeNLO+M@ncase>
In-Reply-To: <YC4I20bQ0jeNLO+M@ncase>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 18 Feb 2021 07:32:46 +0100
Message-ID: <CAN0heSqn+b70tPJjigeKj4cDE=YW7vSDyZLrmP02qZd0tN8PCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] git.txt: fix monospace rendering
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Feb 2021 at 07:27, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Feb 17, 2021 at 08:56:05PM +0100, Martin =C3=85gren wrote:
> > When we write `<name>`s with the "s" tucked on to the closing backtick,
> > we end up rendering the backticks literally. Rephrase this sentence
> > slightly to render this as monospace.
> >
> > Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> > ---
> >  doc-diff:
> >  --- a/.../man/man1/git.1
> >  +++ b/.../man/man1/git.1
> >  @@ -77,8 +77,8 @@ OPTIONS
> >              setting the value to an empty string, instead the environm=
ent
> >              variable itself must be set to the empty string. It is an =
error if
> >              the <envvar> does not exist in the environment.  <envvar> =
may not
> >  -           contain an equals sign to avoid ambiguity with `<name>`s w=
hich
> >  -           contain one.
> >  +           contain an equals sign to avoid ambiguity with <name> cont=
aining
> >  +           one.
>
> Over here you're also dropping the backticks, while...
>
> >              This is useful for cases where you want to pass transitory
> >              configuration options to git, but are doing so on OS=E2=80=
=99s where other
> >  Documentation/git.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git.txt b/Documentation/git.txt
> > index d36e6fd482..3a9c44987f 100644
> > --- a/Documentation/git.txt
> > +++ b/Documentation/git.txt
> > @@ -88,7 +88,7 @@ foo.bar=3D ...`) sets `foo.bar` to the empty string w=
hich `git config
> >       empty string, instead the environment variable itself must be
> >       set to the empty string.  It is an error if the `<envvar>` does n=
ot exist
> >       in the environment. `<envvar>` may not contain an equals sign
> > -     to avoid ambiguity with `<name>`s which contain one.
> > +     to avoid ambiguity with `<name>` containing one.
>
> ... here you don't. Is this on purpose?

Your mail crossed with my response to Chris, who had the same question.
I'd post a link to lore.kernel.org, but it seems my response hasn't
reached it yet. The short answer is the first diff is an indented diff
of the rendered manpages (our "doc-diff" script), whereas the second
diff is the actual, to-be-applied diff.

I thought it would be helpful to include the doc-diff, but it seems it
just created more confusion than it avoided. I'll try to avoid that. :-)

Thanks
Martin
