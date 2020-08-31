Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30CEC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB3D206F0
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QglX8EN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgHaKuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgHaKup (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:50:45 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DDAC061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:50:44 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w3so611806ilh.5
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SjTxJWHap4i59MCIO+iLb7mDbZ20Vpo0Icaxl4L/bKs=;
        b=QglX8EN6N/sKTsKXai3YkyxhNf2mhHttbs0crcdsIJhHbz9/5PZv+7x7A/c9CAdbNg
         hzmj+sZrHxZFDqtFls77C54qduHRuRttSmHctfzxSm8ySddhl/912ghjaSTjUYGXApkU
         cnB3Jy0tFbKkcV6/beSbjGKhhICNXhm5ut0W2lVhKbGMnYIwqHUyT8j1KmdT8v5dWLzZ
         rY/XuuNlQphv22rLVaKJSAqt6YO5mInmmc2t3C4fjWiPtt1hKHBoe+xfvFyXo8LjloeE
         SKKVDzg9wmNxjTUA02XE/A5K83GKVBrxMqWDf1MYdcwQudXlyxwaxZJEGhqgZw3RUoZ7
         2uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SjTxJWHap4i59MCIO+iLb7mDbZ20Vpo0Icaxl4L/bKs=;
        b=IH3tgPwxg2FBD59OKeMM4QIWHrxb86b394/msLAvhKTzjWJrSwouBfrI6cc2LbdZsy
         D273SRNw4gK0rnlU+WSwSCHVcu+mEYqcdHgxNhs0M5WeZ5XZSxUGI7CRjtkM3ehmxjjA
         VIn5qDyCcaTKnVWWOKOCzp9qPO4Ih2CYGWvp1AWYWI0Q2YhoMtAHWIu37COHwPgbHLSv
         /CETXoHsN13pvaZzVIblOAMdh6xuBbRex0bKnFXvEgek1+B8jQ+R+5GdoYx5HDscOZi2
         3xwZWRZBcUmdyB7JEBFMxuG2809/xmL5shoglJDWf+FLCOX26ATOfor0XtmMnDnzCIrA
         8BzA==
X-Gm-Message-State: AOAM533EL8R1fGonZba6TYebA/7XVX0jq6sSolEEmWRyZ9gGTLN3W8kZ
        Z5O9H2PJjBIqvvE7AOr3um93DNDo97beZDf1im3i/v3l
X-Google-Smtp-Source: ABdhPJzZpDkopIs5P1DGnVjlFv7AeqcLNLg50UlgcCaSVMrMBBBYi4kzhd3fFUpL2DtdvcbT7Fw0PhpLxNo/qcrCagk=
X-Received: by 2002:a92:cc4d:: with SMTP id t13mr809847ilq.107.1598871044070;
 Mon, 31 Aug 2020 03:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200828124617.60618-1-mirucam@gmail.com> <20200828124617.60618-7-mirucam@gmail.com>
 <xmqq8sdxi70a.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sdxi70a.fsf@gitster.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Mon, 31 Aug 2020 12:50:33 +0200
Message-ID: <CAN7CjDBd=41PQ5qfqazdtx4uoRcfcc6cUWf5u0cNiooSo24ENg@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] bisect--helper: reimplement `bisect_next` and
 `bisect_auto_next` shell functions in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El s=C3=A1b., 29 ago. 2020 a las 21:31, Junio C Hamano
(<gitster@pobox.com>) escribi=C3=B3:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > diff --git a/bisect.c b/bisect.c
> > index c6aba2b9f2..f0fca5c6f3 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -988,6 +988,12 @@ void read_bisect_terms(const char **read_bad, cons=
t char **read_good)
> >   * the bisection process finished successfully.
> >   * In this case the calling function or command should not turn a
> >   * BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND return code into an error or =
a non zero exit code.
> > + *
> > + * Checking BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND
> > + * in bisect_helper::bisect_next() and only transforming it to 0 at
> > + * the end of bisect_helper::cmd_bisect__helper() helps bypassing
> > + * all the code related to finding a commit to test.
> > + *
> >   * If no_checkout is non-zero, the bisection process does not
> >   * checkout the trial commit but instead simply updates BISECT_HEAD.
> >   */
>
> Not a problem introduced by this step, but the above description on
> no_checkout describes a parameter that no longer exists.
>
> The comments before a function is to guide the developers how to
> call the function correctly, so it should have been removed, moved
> to where no_checkout is used in the function, or moved to where
> BISECT_HEAD ref gets created, as necessary, but by mistake be5fe200
> (cmd_bisect__helper: defer parsing no-checkout flag, 2020-08-07),
> forgot to do any of the three.
>
>
> > +static enum bisect_error bisect_next(struct bisect_terms *terms, const=
 char *prefix)
> > +{
> > +     int no_checkout;
> > +     enum bisect_error res;
> > +
> > +     bisect_autostart(terms);
> > +     if (bisect_next_check(terms, terms->term_good))
> > +             return BISECT_FAILED;
> > +
> > +     no_checkout =3D ref_exists("BISECT_HEAD");
> > +
> > +     /* Perform all bisection computation */
> > +     res =3D bisect_next_all(the_repository, prefix);
> > +
> > +     if (res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> > +             res =3D bisect_successful(terms);
> > +             return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
> > +     } else if (res =3D=3D BISECT_ONLY_SKIPPED_LEFT) {
> > +             res =3D bisect_skipped_commits(terms);
> > +             return res ? res : BISECT_ONLY_SKIPPED_LEFT;
> > +     }
> > +     return res;
> > +}
> > +
>
> The no_checkout local variable is assigned but never used.  It is
> understandable if a variable that used to be used becomes unused
> when some part (i.e. the part that used to use the variable) of a
> function is factored out, but it is rather unusual how a brand new
> function has such an unused code and stay to be that way throughout
> a topic.  Makes a reviewer suspect that there may be a code missing,
> that has to use the variable to decide to do things differently, in
> this function.  It seems to break -Werror builds.

Ok, I will send a new version with this local variable removed.

I don't know if it is something related to my compiler but my -Werror
build does not break. Something similar happened with a previous patch
series version and a warning related with missing-prototypes.
I always compile with : make -j 16 DEVELOPER=3D1 CFLAGS=3D"-O0 -g3" install=
;
and I have also tested adding the -Werror flag and commits always
compile without problems.
Maybe someone in the community knows what my problem is, because it
could avoid extra patch series versions and reviewers work.

Thank you.

>
> Thanks.
>
>
