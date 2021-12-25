Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8379C433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 02:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhLYCf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 21:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLYCf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 21:35:29 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01F7C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 18:35:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j6so38768058edw.12
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 18:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wOAVqwXn53/9Z8us6mtbyFWuiUhuJCKvyMLG2hohW6s=;
        b=NqGjFPlAMd1esIdM/wu21lnFrE49SpJTtX43iG2zCTWEJFu4y4gMIIkfgnrqYV0QM4
         JeGevDn7W9IMBq3reHvBG1eeSYgEfqYA0iMODF7aaC6eWhxa5eDNmrAraXtNXGfeAo44
         3T38JioQAupox11Q0bRUCu9lj+OkLNTOJGZ5xzgrO61xgCzSiaTWdflxEbxqkpZDmMY1
         tSCgHOiEp39YPIMtKcCUL2n1hLu930lIkomY+1rz4aez8JoK56MAsZmV+7vsWtGWyLU5
         3ByUFHKrVkVaU1LiB2blVCkgkz2AIzIjJrBGlwZJzg3zqaXYw7IMtZJAAU8zacr88llO
         62kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOAVqwXn53/9Z8us6mtbyFWuiUhuJCKvyMLG2hohW6s=;
        b=pQrmv4y65/RTvJAiMFCFjo6JiuTFxwojRUvTgyZUIi5/G1QYevCqNPMTdhEKn1vbNl
         HNjD4zUU2O9hM3ZKpOx200rSvC5VMMqFjax9XVAoayJQUe/uczZIEaCwmwt6nmi1qgEp
         Ez8OiXwWgjC4F+Pq9FpjB8zZQHRzJyLozcBPQPM5U8raKd5EcXv6MXZEuYGoDDF3+/ex
         hPipmw3hKBY6pHBXprGqSViRrN3SthZTlYKr14JMVCs42oIPFO2WtO8JmpKEGaQ0KTJq
         o0B1IQE8MWBSEPYdntSv0hBHhjFYd9Yuk/fcJkR+PrTZ00BXwX552cYB4i6gIaTE4EhR
         DRcg==
X-Gm-Message-State: AOAM531oSgxfsEb41EAWcTwCJevdayfsvKxutyVYnFcOLBTdUSXlwQI7
        6krDlhvU74LQh2oMl5t0Eygvf4l6qIgwj/2bKy4=
X-Google-Smtp-Source: ABdhPJwxGBGKz3vqUSuPvAWfjKH/rYP++mbLlGNzpl06Mke+B9g3lhkIOmBlEEzJljDcLOMBqU0cJ88TvLOW6Bvj9Tw=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr7237172ejc.476.1640399727205;
 Fri, 24 Dec 2021 18:35:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <15600df925fb06ecf2c12afecd514f551a1bf7c2.1640109948.git.gitgitgadget@gmail.com>
 <xmqqlf0dmqp5.fsf@gitster.g>
In-Reply-To: <xmqqlf0dmqp5.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Dec 2021 18:35:16 -0800
Message-ID: <CABPp-BHXDniC2J6YYxK_9DbyEOEKUn_6fAc9KFvvatxu_tOzFw@mail.gmail.com>
Subject: Re: [PATCH 6/9] diff: add ability to insert additional headers for paths
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

On Tue, Dec 21, 2021 at 4:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > In support of a remerge-diff ability we will add in a few commits, we
> > want to be able to provide additional headers to show along with a diff.
> > Add the plumbing necessary to enable this.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  diff.c | 34 +++++++++++++++++++++++++++++++++-
> >  diff.h |  1 +
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/diff.c b/diff.c
> > index 861282db1c3..a9490b9b2ba 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -27,6 +27,7 @@
> >  #include "help.h"
> >  #include "promisor-remote.h"
> >  #include "dir.h"
> > +#include "strmap.h"
> >
> >  #ifdef NO_FAST_WORKING_DIRECTORY
> >  #define FAST_WORKING_DIRECTORY 0
> > @@ -3406,6 +3407,33 @@ struct userdiff_driver *get_textconv(struct repository *r,
> >       return userdiff_get_textconv(r, one->driver);
> >  }
> >
> > +static struct strbuf* additional_headers(struct diff_options *o,
>
> Style.
>
> > +                                      const char *path)
> > +{
> > +     if (!o->additional_path_headers)
> > +             return NULL;
> > +     return strmap_get(o->additional_path_headers, path);
> > +}
> > +
> > +static void add_formatted_headers(struct strbuf *msg,
> > +                               struct strbuf *more_headers,
> > +                               const char *line_prefix,
> > +                               const char *meta,
> > +                               const char *reset)
> > +{
> > +     char *next, *newline;
> > +
> > +     next = more_headers->buf;
> > +     while ((newline = strchr(next, '\n'))) {
> > +             *newline = '\0';
> > +             strbuf_addf(msg, "%s%s%s%s\n", line_prefix, meta, next, reset);
> > +             *newline = '\n';
> > +             next = newline + 1;
> > +     }
>
> The above is not wrong per-se, but we do not need to do the
> "temporarily terminate and then recover" dance, and avoiding it
> would make the code cleaner.
>
> Once you learn the value of "newline" [*], you know the number of
> bytes between "next" and "newline" so you can use safely "%.*s"
> format specifier without temporarily terminating the subsection of
> the string.
>
>         Side note. I would actually use strchrnul() instead, so that
>         we do not have to special case the end of the buffer.  For a
>         readily available example, see advice.c::vadvise().
>
> > +     if (*next)
> > +             strbuf_addf(msg, "%s%s%s%s\n", line_prefix, meta, next, reset);
> > +}
>
> > @@ -4328,9 +4356,13 @@ static void fill_metainfo(struct strbuf *msg,
> >       const char *set = diff_get_color(use_color, DIFF_METAINFO);
> >       const char *reset = diff_get_color(use_color, DIFF_RESET);
> >       const char *line_prefix = diff_line_prefix(o);
> > +     struct strbuf *more_headers = NULL;
> >
> >       *must_show_header = 1;
> >       strbuf_init(msg, PATH_MAX * 2 + 300);
> > +     if ((more_headers = additional_headers(o, name)))
> > +             add_formatted_headers(msg, more_headers,
> > +                                   line_prefix, set, reset);
>
> So, we stuff what came via path_msg() without anything that allows
> readers to identify them to the header part?  Just like we have
> fixed and known string taken from a bounded vocabulary such as
> "index", "copy from", "old mode", etc., don't we want to prefix the
> hints that came from the merge machinery with some identifiable
> string?

That's a fair question.  Most of the involved messages are of the form
    CONFLICT (<reason>): more details
and "CONFLICT" seems like a pretty identifiable string.  There are
some others, which made me wonder if we wanted some kind of additional
prefix, but I was having a hard time coming up with a meaningful
prefix; most that I thought of didn't seem like they'd help.

I've provided some testcases in the next re-roll so you can see some
examples; maybe that will help others judge if a prefix is needed and
spur creative juices for coming up with a good once since I seem to be
unable to.

> > @@ -5852,7 +5884,7 @@ int diff_unmodified_pair(struct diff_filepair *p)
> >
> >  static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
> >  {
> > -     if (diff_unmodified_pair(p))
> > +     if (diff_unmodified_pair(p) && !additional_headers(o, p->one->path))
> >               return;
>
> This does not feel quite right.  At least there needs a comment that
> says the _current_ callers that add additional_headers() would do so
> only for paths that the end-users cares about, even when there is no
> change in the contents.  It is quite plausible that future callers
> may want to add additional information to only paths that have some
> changes that need to be shown, no?  And at that point, they want to
> tweak this condition we place here, but without explanation they
> wouldn't know what they would be breaking if they did so.

I've added a comment.
