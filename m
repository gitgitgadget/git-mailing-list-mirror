Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD08DC433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 02:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhLYC36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 21:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhLYC36 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 21:29:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06F9C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 18:29:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so38804822edd.8
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 18:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sSi5mDC0FYXlFWLSVN/7CtGAA3BpjaVsdp3r2nyeyUw=;
        b=hBHRx4O48hy3qWqW/k5PmLqdB84GtsHsjqL2/QwRS54bLz0DQpvz6SbgCzF4k9jdZO
         6JnnlfzxnGBzpnWHOYNWdmivND9WYJ7ByXz/M3rl2vPHpGFuxuWvR9G6RL0TcB7gzhQL
         cYKf78JwFYJt8A5+7NzNwVhLSx/T1QfuGiQXC/gnrPEUAUTo5IcB6uMMG/G+4RUn0iCw
         tSvwggfSn5QoD/xOwZhL1Qc6OENVC8J+gq4i/kZi9j/HL330905AS9NAxCKPFlC3661f
         Ud/oPu73Yqe5hVmcJTEYzWMO83PGLq/gtkjAAVtiRTqIx33rHsrIAlv2HsGHATBhrAsE
         Rzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sSi5mDC0FYXlFWLSVN/7CtGAA3BpjaVsdp3r2nyeyUw=;
        b=ebwqmaO2uvzTnBPyGnNB4qL1dkVsAsbQP2lNuZzrwUAkiN6I37TOrUgEknxRvEGm3J
         IOSJ3iuWDViVCf+vGvCYNY3qMVmvw1jcdBWWZqIs/dvXkvfEVkx9N786q1xJ/vETL/Fj
         Sq4lLcKYGsK2L/WIv6TQVJRUuQTvb8H0ikI519MNQNUqAnLe73P1OEry+j8zZ9IJ5osg
         8GguSXILeIhh8QD6IY721CGQOQlQI2c6TJMx5n3lhTHWxpXahLkiOfy//rnq+KfmElH3
         0Jwe3UiSzKTzYGZdYKPlp0euKxexSmCiYccU89BGqxvbgqv1ZtX2A+6dJgSzag/uDplO
         C0jg==
X-Gm-Message-State: AOAM530k9rVmlIbjaa++wBE4kP1Uk4EvVg0IZvvRgb264EQax3aUZlhj
        BUdl9+RmaIcemPomRuoO0y0RqXYoBXWdGulFvlI=
X-Google-Smtp-Source: ABdhPJzsgxX8RslUzLv3lCMvX4vZuNo5PQfMOksiSxTwxTMlxS7seRNL69pabRcVwLaZm7+1kjD8myC/TkP+bOKudBU=
X-Received: by 2002:a17:906:4790:: with SMTP id cw16mr6916181ejc.493.1640399396236;
 Fri, 24 Dec 2021 18:29:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <fab1b2c69eafbd3f211745886786c1d0ebdc05c2.1640109948.git.gitgitgadget@gmail.com>
 <xmqqmtkto7yf.fsf@gitster.g> <CABPp-BEuzorQkesgyNCvS05wsfqaH4Yv5JDFgy+AenrAC+JJNQ@mail.gmail.com>
 <xmqqlf0dkvig.fsf@gitster.g>
In-Reply-To: <xmqqlf0dkvig.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Dec 2021 18:29:45 -0800
Message-ID: <CABPp-BEMBkG=+g7SUXmJHqZ=qQQn-2oPg33uRtYyRHkt3SbxaA@mail.gmail.com>
Subject: Re: [PATCH 1/9] tmp_objdir: add a helper function for discarding all
 contained objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 10:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> > +void tmp_objdir_discard_objects(struct tmp_objdir *t)
> >> > +{
> >> > +     remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
> >> > +}
> >> > +
> >>
> >> OK.
> >>
> >> Without a caller, it is a bit hard to judge if a separate helper
> >> makes the caller easier to read and understand, or becomes an extra
> >> layer of abstraction that obscures the logic.  Hopefully, having a
> >> more specific function name with "tmp" and "discard" in it makes the
> >> intent at callers more clear than the function that is named after
> >> the detail of the operation.
> >
> > This isn't just a convenience; since tmp_objdir is defined in
> > tmp-objdir.c rather than tmp-objdir.h, t->path is not accessible
> > outside of tmp-objdir.c.  Because of this, some kind of helper
> > function is necessary.
>
> But adding this function as an extra level of abstration is *not*
> the only way to expose the feature.  Instead the internal of "struct
> tmp_objdir" could be exposed to the caller that wants to discard the
> files inside the path.

Ah, yes, we talked about that during the tmp-objdir discussion back in
September/October.  Peff didn't want struct tmp_objdir exposed, and I
was operating with that in mind.

> I think we now have enough material to fill between these two lines
> to help readers ;-)

I've restructured the series a bit based on =C3=86var's feedback, and this
function is now only introduced along with its caller.  Hopefully that
makes it a bit clearer.
