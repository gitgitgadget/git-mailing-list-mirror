Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9A8C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C5961C9C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhGFVO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFVO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:14:26 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DFFC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 14:11:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s17so938015oij.0
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 14:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=WAtRQL7opSgBUYTAFqj3HZyrpPpYe9oyKODR2Cfmjkg=;
        b=fAhwgp+aJX8i1SZ6cRiZOo7FGcW2uX412LNTWSScanpocrjHT2JFJURvFv6eLUcdhZ
         tpmuOcjbngFHvEd9EZho0+xmMo8rS6PvoA8Cr4zK4qpGV0ysbH8L7wjpLOGILoNNjzqI
         Jnm1vF6EnSwziq2Z5UO71C5E3c2qBlhPoZYXFZjv12LAb9NppnwvZ8M1c3BMkke3sd7c
         5ZshtKUBGAjDUXsJOIK8NyARy5jQlcJ9NS/jfzP+402AMCytOULuTAqzs4DNcaN/fXTO
         Fo0dOw3bfKHFAmENRU+WrII9lr8eLdUMagNpdLKPfv9DqMEz+lY4sx5rEbP+k9bqM5LP
         66Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=WAtRQL7opSgBUYTAFqj3HZyrpPpYe9oyKODR2Cfmjkg=;
        b=lpOfJ25pZz7NvD9/9I2YvlvrM7mUvUmd0onVnAobIhfUF0oa9wOUJ1g51UFqvoAS2u
         ZrSoptqOdnU0lpmlrVtqm2L1xq7spkl4WkbOpWYlS4S8gdSbQ3voHZhhxyGR9r5k8tp0
         8xIg2BFB6q5dgG168m3rkjXlm3oPg7Hk3qi4is8v7/gomzL92URkC9izaq3AFXQI6BXY
         u8L2yBF+M0k7tRXYdgEDFj7boXQPH8S86RVXdLOE2RrofNE/6GQE22BYOXa/AUwdwLIF
         QaOZ5sLJM2Fkb0G5T/NCb8CvedbBoxb/8e4BDEucJoPjITEicKq0F/9o7YbqfZDc75VM
         nRDg==
X-Gm-Message-State: AOAM533rIrvY7zMdh3IQez8TXrpZ2Tc8j6f/VUyeWwZMbZHTvhxAv/zp
        0Z4TyUxIWTyd1gmIqJAeDgg=
X-Google-Smtp-Source: ABdhPJxZ5BqtaoZ/j7SBtiyPmbQ9VpsoDtFxk4jx6g3grvu4OQLkFlMqp+J8p7ZzWR/gXw1uFllvMg==
X-Received: by 2002:a05:6808:494:: with SMTP id z20mr2012327oid.135.1625605905630;
        Tue, 06 Jul 2021 14:11:45 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id q13sm3053325oov.6.2021.07.06.14.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 14:11:45 -0700 (PDT)
Date:   Tue, 06 Jul 2021 16:11:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, 'Alex Henrie' <alexhenrie24@gmail.com>,
        'Richard Hansen' <rhansen@rhansen.org>,
        'Junio C Hamano' <gitster@pobox.com>
Message-ID: <60e4c71099ef_1c4281208ad@natae.notmuch>
In-Reply-To: <04de01d772a8$540c6690$fc2533b0$@nexbridge.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-2-felipe.contreras@gmail.com>
 <87bl7f5ho1.fsf@evledraar.gmail.com>
 <60e4bf9a6a628_1c4281208b@natae.notmuch>
 <04de01d772a8$540c6690$fc2533b0$@nexbridge.com>
Subject: RE: [RFC PATCH 01/35] merge: improve fatal fast-forward message
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On July 6, 2021 4:40 PM, Felipe Contreras wrote:
> >Subject: Re: [RFC PATCH 01/35] merge: improve fatal fast-forward messa=
ge
> >
> >=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>
> >> On Mon, Jul 05 2021, Felipe Contreras wrote:
> >>
> >> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> > ---
> >> >  builtin/merge.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/builtin/merge.c b/builtin/merge.c index
> >> > a8a843b1f5..05e631229d 100644
> >> > --- a/builtin/merge.c
> >> > +++ b/builtin/merge.c
> >> > @@ -1620,7 +1620,7 @@ int cmd_merge(int argc, const char **argv, c=
onst char *prefix)
> >> >  	}
> >> >
> >> >  	if (fast_forward =3D=3D FF_ONLY)
> >> > -		die(_("Not possible to fast-forward, aborting."));
> >> > +		die(_("unable to fast-forward"));
> >>
> >> I read the existing message a bit more like "this makes no sense
> >> anymore" (correct) and the latter more like "we encountered an error=
".
> >
> >I mean, this is the documentation of --ff-only:
> >
> >  With `--ff-only`, resolve the merge as a fast-forward when possible.=

> >  When not possible, refuse to merge and exit with a non-zero status.
> >
> >So if you do `git merge --ff-only` you are telling git: "I want you to=
 exit with an error when the fast-forward is not possible".
> >
> >If you do:
> >
> >  % git merge --ff-only
> >  fatal: Not possible to fast-forward, aborting.
> >
> >That "aborting" part is redundant; we know `git merge` should abort if=
 the fast-forward is not possible, we explicitely told git to do that.
> =

> `git merge` is a special operation where errors (conflicts, for one)
> may leave the repository in a merge pending state where you
> subsequently may have to use `git merge --abort` to reset the
> situation or `git add` to continue. The `aborting` output makes it
> clear that you do not have to do the `--abort` and *cannot* do the
> `add` because there was an implicit `--abort` done resulting from the
> failure.

But this is not a `git merge`, this is a `git merge --ff-only`; they are
different operations. There *never* is a need for `--abort` with
`git merge --ff-only`.

Anyway, the error message is meant for `git fast-forward` which
definitely doesn't need any `--abort`.

Initially I created a new variable to have a different error message for
`git merge --ff-only` and `git fast-forward`, precisely to avoid
changing the current error message of `git merge --ff-only` and thus
avoid any inertial comments like this one. But then I thought there was
no need to complicate the series when both can be improved at once.
Apparently that's not the case.

I guess I'll add it back.

Cheers.

-- =

Felipe Contreras=
