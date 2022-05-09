Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FCBC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiEIPpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 11:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiEIPpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 11:45:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C493120AF
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:41:36 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id kl21so10704651qvb.9
        for <git@vger.kernel.org>; Mon, 09 May 2022 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yDCKZaPCiRq/WGiIy/R+eRB2Bm1RH0k9FiXh2iesI6k=;
        b=xbdy74Ip4Jv403E2LeyNNB1qIV3BHiz1hpTF81hlc6jNoCV0PIF6RCROT9RjBv2hGD
         NU0Ao0vi2cKoxeunxHLeNlLO06AG3Jg0MqroSUkg4uLw1izJEoHmxwff0Fku0K5MnC/Z
         1V924TzmYfoa8AGOxWZi0btylivrlszasyIw8laKMkZiQhAhrFJ/+iWNrJ/0xG40yYAk
         L6g6AWFGIBUI/l++KEwEl9QNkdhFlym/075jgmkQFHvMIZh7ZVqjaAY7RdzoPupiegTG
         aeRUTjTnewfy2rPXZDCpZ3v2kE3n8GtIWIuSM7tYO+Gxc5oYoshhMphntiatqLbNcoD0
         P3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yDCKZaPCiRq/WGiIy/R+eRB2Bm1RH0k9FiXh2iesI6k=;
        b=Hlh6QgcnbCInKIAlyBPUH6GNJgwTuoJKhXBklSmeAmUFU4h+lpy87De4HgyGXpS2nq
         etRlkkQ63BybwUEWRSD7FyJ2B/C3du1GKe00KjcwgC2471JD5EzS4HniOFb4Kg+oodxK
         Uf/EHcDhz65PpJfllLmz0F7TrkSJVEJqOypbNJA+9ZzT/y7tlmEDo73/Aa9zR0rssyJ5
         T9UbM5pUAwzfV3SzvlU04irVaWkCopewnoOcKCuyz9AfIJrFwc2WnAq2KqYEJdz38kEZ
         d6R1PspSSuTXfQkOlcUbX9Ia5z0sJk+bIs+y6+lv+ukaRPTBCsNsKnayaYlyW6t9rECi
         zBAw==
X-Gm-Message-State: AOAM531GgLB7+KJeNDzadSWzcvI1z8I/TghPDlL89Zg23qehqoeuwXmq
        G5nuiZ5BUEKdQFHyuxFpQnBBklGlKN2c9HdX
X-Google-Smtp-Source: ABdhPJz5FZDFx2WVubZIH8qBRC7yg1ytTSzesvmMGBG3wv7sR0bW1MB91YhzMsmlJwM64I/IhdhZKg==
X-Received: by 2002:ad4:5945:0:b0:45b:39b:313a with SMTP id eo5-20020ad45945000000b0045b039b313amr7080187qvb.23.1652110895364;
        Mon, 09 May 2022 08:41:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d78-20020a379b51000000b0069fc13ce21csm7135199qke.77.2022.05.09.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:41:34 -0700 (PDT)
Date:   Mon, 9 May 2022 11:41:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] bisect: output bisect setup status in bisect log
Message-ID: <Ynk2LrMyHIKyK63i@nand.local>
References: <cover.1651796862.git.chris@chrisdown.name>
 <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
 <YnSQDzhNjmu5ws4f@nand.local>
 <YnTz6mbP2UDrsTaL@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnTz6mbP2UDrsTaL@chrisdown.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 11:09:46AM +0100, Chris Down wrote:
> > I'm not totally convinced it _needs_ to live in "git bisect log",
> > though, since it feels like additional information that is just added
> > for convenience. That's not the worst thing in the world, but I think
> > it would be fine to just take the first patch (with my suggestions
> > applied) as well.
>
> There was some discussion in the v1 thread (Message-ID:
> <xmqqv8uo1mk6.fsf@gitster.g>) about adding an additional `git bisect status'
> command, but while writing it my immediate thoughts were that it doesn't
> make much sense to separate from the rest of the log. I'm curious what
> Junio's thoughts are on that, happy to do it whichever way is preferred. :-)

I don't have a strong feeling either way. The way that you have
incorporated it into the output of "git bisect log" feels simple and
sane to me.

The most important thing is that you didn't break the ability to pipe
the unmodified output of "git bisect log" into "git bisect replay", so I
beyond that I don't have any strong feelings about it.

> > > Signed-off-by: Chris Down <chris@chrisdown.name>
> > > ---
> > >  builtin/bisect--helper.c    | 25 ++++++++++++++++++++-----
> > >  t/t6030-bisect-porcelain.sh |  9 +++++++--
> > >  2 files changed, 27 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > > index 9d583f651c..ef75f0a0ce 100644
> > > --- a/builtin/bisect--helper.c
> > > +++ b/builtin/bisect--helper.c
> > > @@ -404,6 +404,21 @@ static struct bisect_state bisect_status(const struct bisect_terms *terms)
> > >  	return bs;
> > >  }
> > >
> > > +__attribute__((format (printf, 1, 2)))
> > > +static void bisect_log_printf(const char *fmt, ...)
> > > +{
> > > +	va_list ap;
> > > +	char buf[1024];
> > > +
> > > +	va_start(ap, fmt);
> > > +	if (vsnprintf(buf, sizeof(buf), fmt, ap) < 0)
> > > +		*buf = '\0';
> > > +	va_end(ap);
> > > +
> > > +	printf("%s", buf);
> > > +	append_to_file(git_path_bisect_log(), "# %s", buf);
> > > +}
> >
> > This direct use of vsnprintf might be avoided by preparing the output in
> > bisect_print_status() via a strbuf and then calling:
> >
> >    append_to_file(git_path_bisect_log(), "# %s", buf.buf).
>
> I'm not intimately familiar with the codebase, so maybe I'm missing
> something, but isn't it overkill to use a string buffer for something which
> is isn't going to then be used as a mutable buffer?
>
> Happy to do it whichever way works for you folks, but would be good to
> understand the rationale so that I can write better patches next time :-)

I'm trying to avoid having a vsnprintf() when one isn't strictly needed.
This part of bisect isn't performance critical code, so having a strbuf
around doesn't bother me in the slightest.

If you really wanted to, you could treat the strbuf like a static buffer
by declaring it as such and calling strbuf_reset() before or after using
it. But allocating little bits of memory in bisect_print_status()
doesn't bother me much, either.

At the very least, it would dramatically simplify the implementation of
this patch with a negligible cost, so I'd recommend doing it.

> > >  static void bisect_print_status(const struct bisect_terms *terms)
> > >  {
> > >  	const struct bisect_state bs = bisect_status(terms);
> > > @@ -413,13 +428,13 @@ static void bisect_print_status(const struct bisect_terms *terms)
> > >  		return;
> > >
> > >  	if (!bs.nr_good && !bs.nr_bad)
> > > -		printf(_("status: waiting for both good and bad commits\n"));
> > > +		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
> > >  	else if (bs.nr_good)
> > > -		printf(Q_("status: waiting for bad commit, %d good commit known\n",
> > > -			  "status: waiting for bad commit, %d good commits known\n",
> > > -			  bs.nr_good), bs.nr_good);
> > > +		bisect_log_printf(Q_("status: waiting for bad commit, %d good commit known\n",
> > > +				     "status: waiting for bad commit, %d good commits known\n",
> > > +				     bs.nr_good), bs.nr_good);
> > >  	else
> > > -		printf(_("status: waiting for good commit(s), bad commit known\n"));
> > > +		bisect_log_printf(_("status: waiting for good commit(s), bad commit known\n"));
> > >  }
> >
> > Interesting; this patch removes the output that we were giving to users
> > in the last patch. Should it go to both places?
>
> Not sure I understand, we printf() in bisect_log_printf, no?

I missed that, thanks for pointing it out.

Thanks,
Taylor
