Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1C41FC96
	for <e@80x24.org>; Wed,  7 Dec 2016 00:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbcLGAKW (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 19:10:22 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34484 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcLGAKV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 19:10:21 -0500
Received: by mail-pg0-f46.google.com with SMTP id x23so154698758pgx.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 16:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+5UzTz5ownoq6WU7MuquTI/gtfDqyQmXlHjmNSqMYxs=;
        b=WGasvjm3Ohyogw1Qzj/cq02tR+5Q9lezz+NQSKRgjBcuc9IA+Zm0Fq79tzSwW2ORFq
         6HAJDusNR9wISmpxdBZHjfdIt3ZYEKXx6u7Q8qmnE7UrUF+a5k6N9qkaxpW60zgB9kjf
         LS6zLGEy7iOFRtqG4Oz/JhjYC7LoCGvHiKybjtQ3ji+HENuz6iUVDvvfmBRVP0P8/ijw
         K4d4ZWDZkjGK2kbJAkokwsflu75suX/JHSGS7mE6UymfIa2+qgXzjOuxzO9y6suZH681
         6PNPNUy/mxKs2Vkk68Y5bDos+8EWMneL9qI0BhXHPo5DY8iDhua2ORj1QVyjYTNekQLd
         CeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+5UzTz5ownoq6WU7MuquTI/gtfDqyQmXlHjmNSqMYxs=;
        b=R0Q5MEbXa7RST96F+GrxsUgy6QpmQWgcCamokwoHPm2B8+RNcnXlciraYKCbAd9ur2
         ZLzejxUSTvw/qfC7f/T8sm8lLIdyAI3AKpecJDCC25MQYOTZSmhiAkxNNPAngEiow1aW
         b8wxzCa7ZVDGIJGM4a3ihiayjlu9VshxJydAh78tLPy+aF/11VYJqgiLSi9hg2LanMCu
         EOph002HlUs/rQy+AKOmN831CRbotj0YzkjsK0GShSvB+UVr788yFS9Ik6YPxLk8z3f3
         jDp4gX8ivlZohb+c9QYjXaW1FYcT5eXNeYUKt2CQkJVMgPtzPIMAS+ZDxj2qr81lWV+4
         IK8A==
X-Gm-Message-State: AKaTC03omy08JCKJYVG88N67FZrkNkkVe3oYI9YTj2qoeIxoGRNExOMtxENejUcM4KOUrzvm
X-Received: by 10.99.226.83 with SMTP id y19mr116455119pgj.147.1481069420639;
        Tue, 06 Dec 2016 16:10:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:e0c5:1a05:7bf2:5496])
        by smtp.gmail.com with ESMTPSA id x2sm37272065pfx.65.2016.12.06.16.10.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 16:10:19 -0800 (PST)
Date:   Tue, 6 Dec 2016 16:10:18 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com
Subject: Re: [PATCH] real_path: make real_path thread-safe
Message-ID: <20161207001018.GD103573@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +/* removes the last path component from 'path' except if 'path' is root */
> > +static void strip_last_component(struct strbuf *path)
> > +{
> > +	if (path->len > 1) {
> > +		char *last_slash = find_last_dir_sep(path->buf);
> > +		strbuf_setlen(path, last_slash - path->buf);
> > +	}
> > +}
> 
> You use find_last_dir_sep() which takes care of "Windows uses
> backslash" issue.  Is this function expected to be fed something
> like "C:\My Files\foo.txt" and more importantly "C:\My Files"?  Or
> is that handled by a lot higher level up in the callchain?  I am
> reacting the comparison of path->len and 1 here.

This function should accept both absolute and relative paths, which
means it should probably accept "C:\My Files".  I wasn't thinking about
windows 100% of the time while writing this so I'm hoping that a windows
expert will point things like this out to me :).  So in reality this
check shouldn't be (path->len > 1) but rather some function is_only_root
which would check if the strbuf only contains a string which looks like
root.

> 
> Also is the input expected to be normalized?  Are we expected to be
> fed something like "/a//b/./c/../d/e" and react sensibly, or is that
> handled by a lot higher level up in the callchain?

Yes it should handle paths like that sensibly.

> > +/* gets the next component in 'remaining' and places it in 'next' */
> > +static void get_next_component(struct strbuf *next, struct strbuf *remaining)
> > +{
> > +	char *start = NULL;
> > +	char *end = NULL;
> > +
> > +	strbuf_reset(next);
> > +
> > +	/* look for the next component */
> > +	/* Skip sequences of multiple path-separators */
> > +	for (start = remaining->buf; is_dir_sep(*start); start++)
> > +		/* nothing */;
> 
> Style:
> 		; /* nothing */

k will fix.

> 
> > +	/* Find end of the path component */
> > +	for (end = start; *end && !is_dir_sep(*end); end++)
> > +		/* nothing */;
> > +
> > +	strbuf_add(next, start, end - start);
> 
> OK, so this was given "///foo/bar" in "remaining" and appended
> 'foo/' to "next".  I.e. deduping of slashes is handled here.
> 
> POSIX cares about treating "//" at the very beginning of the path
> specially.  Is that supposed to be handled here, or by a lot higher
> level up in the callchain?

What exactly does "//" mean in this context? (I'm just naive in this
area)

> 
> > +	/* remove the component from 'remaining' */
> > +	strbuf_remove(remaining, 0, end - remaining->buf);
> > +}
> > +
> >  /* We allow "recursive" symbolic links. Only within reason, though. */
> > -#define MAXDEPTH 5
> > +#define MAXSYMLINKS 5
> >  
> >  /*
> >   * Return the real path (i.e., absolute path, with symlinks resolved
> > @@ -21,7 +51,6 @@ int is_directory(const char *path)
> >   * absolute_path().)  The return value is a pointer to a static
> >   * buffer.
> >   *
> >   * The directory part of path (i.e., everything up to the last
> >   * dir_sep) must denote a valid, existing directory, but the last
> >   * component need not exist.  If die_on_error is set, then die with an
> > @@ -33,22 +62,16 @@ int is_directory(const char *path)
> >   */
> >  static const char *real_path_internal(const char *path, int die_on_error)
> >  {
> > +	static struct strbuf resolved = STRBUF_INIT;
> 
> This being 'static' would probably mean that this is not reentrant,
> which goes against the title of the patch.

Yes I mentioned in the cover letter that this was the one last thing
that needed to be changed to make it reentrant.  I wanted to get this
out for review sooner since this is the biggest change (getting rid of
the chdir() calls) and dropping the static here would just require
making the callers own the memory which should hopefully be an easy
refactor.  It just would have taken a bit more time to actually do that
refactor now.  I'm slowly working on it while this is being reviewed and
could be ready to send out when rerolling this patch.  Sorry for having
a slightly misleading patch title :)

-- 
Brandon Williams
