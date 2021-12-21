Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D94C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhLUXvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbhLUXvs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:51:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F778C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:51:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y22so1532954edq.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxDpgXBjqmixoTOVbh/HTq0caU/35YOer1nmUEiEock=;
        b=OZ89VZ0T0ekoW3xWrirNaSm3PF1M/8W2HK7N56rGHvR5uaxS6SQ7DwIiscE1IStY2q
         TFRjxDPsSLj/xypXkWJvwSSqeaUydkHiI0QpB8Rj4I3vVVlcGBquekjHO7J6N4VbgOXz
         5X9Z5xLk559T390qkckp6XrU6RdCy6ak8bziwzUwXFMjf6a6CnJbBrDnPyzA3PgdvrdF
         KIWkPtmi+dSHvzRDORAsx/6lMhAeUMcs+aIhghopPqrmiNj5YLHiqsLHyuQ/uQafQ7Ul
         L+XAuN8dnl6ZvUc0cRyaMkV76HTNt5PtYJPXY604QiOrf+ecUNszNB5VnfRnXCMVHakD
         o1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxDpgXBjqmixoTOVbh/HTq0caU/35YOer1nmUEiEock=;
        b=w0dynrSsISgcqnf7I9cIX99dKPhkGOtccEeuuV878FW1bV7gh38DebZKb02tzUEfxz
         MQE8kRqwiu6k9LSmWceS6oZF9GvKixL5dKMD8114aAq2UtynLrI1t7M7QC4/cLo9yn9T
         lZyuwP/3KjY4Tj5/TawyXGnlwLFIhH09YeToo+Z1VJKnOEbvixIPDfFXUhffrUVQSVzO
         AjVVdKSc74K1bVT2bJhEGkCgz1Jii96/fscUB5NFjVNtKHmHTgffCRn1hxzM621KDvUJ
         iC71xmzKEy9b2Umx4T7Y6EpP0I392X2XCf34u3kPqto3qjwbDn4N4AmvKjVjdZ+RObQx
         tqLw==
X-Gm-Message-State: AOAM5307Nl0ltcHXZMQFtV/hM9ZAdLUIq099y8KhFNo59SjNrjCNSwqg
        6jWCn8A7pa27Mmds2Ss5n/CEdi8rEXMGf8pUvo0=
X-Google-Smtp-Source: ABdhPJyUbF5FkbAz5eNoZ21kLoQK3aTvQsJto2NGfoPXuhNmchnKi/kzJ86TJ7L6gzchN2MahZmVE+bGX3HpENe1sPM=
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr494657ejc.493.1640130706703;
 Tue, 21 Dec 2021 15:51:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <fab1b2c69eafbd3f211745886786c1d0ebdc05c2.1640109948.git.gitgitgadget@gmail.com>
 <xmqqmtkto7yf.fsf@gitster.g>
In-Reply-To: <xmqqmtkto7yf.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Dec 2021 15:51:35 -0800
Message-ID: <CABPp-BEuzorQkesgyNCvS05wsfqaH4Yv5JDFgy+AenrAC+JJNQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 3:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  tmp-objdir.c | 5 +++++
> >  tmp-objdir.h | 6 ++++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/tmp-objdir.c b/tmp-objdir.c
> > index 3d38eeab66b..adf6033549e 100644
> > --- a/tmp-objdir.c
> > +++ b/tmp-objdir.c
> > @@ -79,6 +79,11 @@ static void remove_tmp_objdir_on_signal(int signo)
> >       raise(signo);
> >  }
> >
> > +void tmp_objdir_discard_objects(struct tmp_objdir *t)
> > +{
> > +     remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
> > +}
> > +
>
> OK.
>
> Without a caller, it is a bit hard to judge if a separate helper
> makes the caller easier to read and understand, or becomes an extra
> layer of abstraction that obscures the logic.  Hopefully, having a
> more specific function name with "tmp" and "discard" in it makes the
> intent at callers more clear than the function that is named after
> the detail of the operation.

This isn't just a convenience; since tmp_objdir is defined in
tmp-objdir.c rather than tmp-objdir.h, t->path is not accessible
outside of tmp-objdir.c.  Because of this, some kind of helper
function is necessary.
