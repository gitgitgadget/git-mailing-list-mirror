Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8D6C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJKBsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJKBsu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:48:50 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD406D578
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:48:49 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z197so4862034iof.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6wo7ndKNZuI0Q3TMHCzzYyxOy0eBWVDBj72znaW56w=;
        b=lgZiY4Eqy+rK13I7n2zTsyxMlKvrr79O0e+ZTC1CaMoeir9B6Vx36u+0H7uZ3TGPZR
         6SQe5m5OBzZ4UKttUt/zbdsL6RnJmI8ve2WjFVFIH5btaWSc5jqZgZVBJoH8x2deMyVG
         A8WYzujEWXUZI3YUzTMiuk1iOijujfCB+rPbOrWFvO3hRqdmixIfRy5d0bUvg3Wql7m4
         ZEyegYpGp+Hj66Qm7b+q5M87hmtnYr1ou4cVIdVPsIL22XrJsd3OIrABBzQO0QO+FTTx
         euIPkaH9bVLY8YOwBcbGkONnCjMDdJGd97yJKvnZUpGtvw7v21CR0dpqGET895pkbag4
         d92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6wo7ndKNZuI0Q3TMHCzzYyxOy0eBWVDBj72znaW56w=;
        b=DsBmEkOVpVUOddWZy+5Nbo/Oqd4EC0WmyGpbVZ2sOQTXiUnEFgO/JsT8GIfqEf0i5D
         tGSXHXAOIbAQhauhiNyt/veLTlfNRjijDdMFEpqoAuWTcEeJpK5InwIKExwbOL05MElK
         fJo+TAp5ZqNuUCog2OK+wCJ1fpcCJlERhojoKgjNZzFySW7U3LOy6inUBiHggFbix7AO
         jKM3B9EkFVJtPfqg7nZTg2pm9f0sBRURl6I0RNKYqP/yh/15VurZRHMs16xz9TTd3/Ve
         T9rflFYgJ2C0RLGcDj6aoi5KkUuvzUHQ6/Ay+6FoGl6uYjub+ITGzV+4yhxPgclKbHOi
         paqA==
X-Gm-Message-State: ACrzQf2NbQkXeP65mBXUylEbmRCYI9Bm08fLBn2jQ16ojcUA0FuUnxAz
        mwqELsj08fg++G+E6/ZZQ2/zAw==
X-Google-Smtp-Source: AMsMyM5YbwMaNqscJYxpe1tMv5KVzjEOu8iUklDiMWMhXQmuedw8li/ihlMqopSA4JIVxKbD/PQEjg==
X-Received: by 2002:a05:6638:240d:b0:363:d34c:3710 with SMTP id z13-20020a056638240d00b00363d34c3710mr165414jat.281.1665452929085;
        Mon, 10 Oct 2022 18:48:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w11-20020a92c88b000000b002f4aa150479sm4329701ilo.9.2022.10.10.18.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:48:48 -0700 (PDT)
Date:   Mon, 10 Oct 2022 21:48:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 5/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <Y0TLf/J22ioQ5UCt@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
 <Y0TIMlrrifYKuBnR@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TIMlrrifYKuBnR@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 09:34:42PM -0400, Jeff King wrote:
> On Mon, Oct 10, 2022 at 08:34:15PM -0400, Taylor Blau wrote:
>
> I think the name of the helper function puzzled me a bit. It is really
> "finish up any setup for the shortlog struct". We could lazily do it in
> shortlog_add_commit(), but that's pretty subtle. But could we maybe call
> it:
>
>   shortlog_finish_setup();
>
> or something? I dunno. I might be nit-picking, but I actually had to
> scratch my head quite a bit to understand what was going on here.

I think that shortlog_finish_setup() is probably the most reasonable
choice (and I changed it to that locally). I spent a day or so thinking
on and off about this while writing the series, and didn't come up with
any satisfying names.

I think it points to something deeper about the API that doesn't quite
sit right with me. But shortlog_finish_setup() is the least-unsatisfying
name so far, so let's go with that ;-).

> > diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> > index f708d96558..aac8c7afa4 100644
> > --- a/builtin/shortlog.c
> > +++ b/builtin/shortlog.c
> > @@ -245,15 +245,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
> >  	}
> >  	oneline_str = oneline.len ? oneline.buf : "<none>";
> >
> > -	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
> > -		strbuf_reset(&ident);
> > -		format_commit_message(commit,
> > -				      log->email ? "%aN <%aE>" : "%aN",
> > -				      &ident, &ctx);
> > -		if (!HAS_MULTI_BITS(log->groups) ||
> > -		    strset_add(&dups, ident.buf))
> > -			insert_one_record(log, ident.buf, oneline_str);
> > -	}
>
> This loses the HAS_MULTI_BITS() optimization. The idea there is that if
> you have a single group-by that can't produce multiple outputs, then
> there's no need to do duplicate detection.
>
> The equivalent in an all-formats world is something like:
>
>   log.format.nr > 1 && !log.trailers.nr
>
> (because trailers are special in that one trailer key can produce
> multiple idents for a single commit).

Hmm. I suspect that this is going to become more complicated by the time
that you read the final patch ;-). Let's wait until then and see what
you think.

> > +void shortlog_init_group(struct shortlog *log)
> > +{
> > +	if (!log->groups)
> > +		log->groups = SHORTLOG_GROUP_AUTHOR;
> > +
> > +	if (log->groups & SHORTLOG_GROUP_AUTHOR)
> > +		string_list_append(&log->format,
> > +				   log->email ? "%aN <%aE>" : "%aN");
> > +}
>
> Regardless of the naming suggestion I made, I think things would be more
> obvious if this top conditional remained in cmd_shortlog(). And then the
> explicit assignment of "log.group" in make_cover_letter() would remain.

Yep, works for me.

> > @@ -439,8 +440,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
> >  	log.file = rev.diffopt.file;
> >  	log.date_mode = rev.date_mode;
> >
> > -	if (!log.groups)
> > -		log.groups = SHORTLOG_GROUP_AUTHOR;
> > +	shortlog_init_group(&log);
> > +
> >  	string_list_sort(&log.trailers);
>
> Now that we have a "finish the shortlog init" function, probably this
> trailer sort should go into it, too. The current caller doesn't need it,
> but it removes on more gotcha from using the shortlog API.

We'll drop this list by the end of the series, too, so it probably isn't
worth moving it into shortlog_finish_setup() in the interim.

> -Peff

Thanks,
Taylor
