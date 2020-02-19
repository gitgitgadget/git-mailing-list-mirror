Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1546C34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8131B21D56
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wnn6NWIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBSVwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:52:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33105 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSVwj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 16:52:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so770104pfn.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 13:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W1aCP3FeZbW7jrAjOske0/Gl55N3q+mwjjrtm/NNzCg=;
        b=Wnn6NWIaVKHBVmf6elHS/+D8+Uyrs7UNiUk4n/6Jj1pGC14tTWU9tNSEuDmsUvxm4I
         OPAZLhRXbDGWdBDJ4VjLrWRHJWOcwSzhH6P+08Prp7x592Y8papi+QIYnk7WFGXHqOpE
         KlV/Vy7XMAbBl3qsUd6cbwBbBM1XkQ2NmvPt6g3JNYxrLxXV0PPMCmKdk/0RZl+ijixG
         74ftxx7L7enWUIJgUjaMh0yXOhVEpSfNaElFqX0JX0MvJvIz7UdJaERnZkHNS7RRs77c
         PF5yOU+AfEnz7KgjtAhq/NwkrV1XUFJQWvHSA3iRJnmlqKCsOVz9AJIOQMVhrjlPO0EL
         J+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W1aCP3FeZbW7jrAjOske0/Gl55N3q+mwjjrtm/NNzCg=;
        b=tDZmTfe2EDV9R8sh3+AerBp7DiVLA0M9nsWRH0iv1jaLiQUwV1jW3l0avTbh4Cwlhu
         fNWJYdxer6Xs7YTuRdDyNVhEV4EyjypwsAiS94xLtuH+uHg05P+G+wxflliJwShnILvF
         X7UrVLvga1hLXkdRHfqMZxtmZa8zoOJ4Zi2KIeNGJqCzIB9/NaPIWJ+cyg69gnE2L3AE
         C9gW2pnntlGE60XJU4u/m+Oy1rqAiBXwpRRgqYW37BdcbOuZTkLBmJk7g8aR2xjPge8d
         9nGwO3pwPvJO7vs3CxwTY7TnfSZt8HZQ+C/02rzIlChkwM8GrgVGqY4y6MFq2CXQwK5J
         rDZw==
X-Gm-Message-State: APjAAAVKetzk9MbT9lyl2z92MeatIbZcTBMq4+y2GQoqpau1aQ6U0KBP
        wLBkbQfXGb6UbcH/RGfGwF5ovwwyypM=
X-Google-Smtp-Source: APXvYqxUrfQiZ5i+OgTDoNrxeqtWmAq/qtkZGZGCiqJVumbtQ19UV5uO8+7rHca6N3hcHJBy3INyfg==
X-Received: by 2002:a63:4a47:: with SMTP id j7mr29692943pgl.196.1582149156925;
        Wed, 19 Feb 2020 13:52:36 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id t11sm749513pjo.21.2020.02.19.13.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 13:52:36 -0800 (PST)
Date:   Wed, 19 Feb 2020 13:52:31 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200219215231.GA26221@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-4-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2002191515310.46@tvgsbejvaqbjf.bet>
 <xmqq7e0ih5zr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e0ih5zr.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 08:55:04AM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> +int cmd_main(int argc, const char **argv)
> >> +{
> >> +...
> >> +	if (report == NULL) {
> >> +		strbuf_release(&report_path);
> >> +		die("couldn't open '%s' for writing", report_path.buf);
> >> +	}
> >> +
> >> +	strbuf_write(&buffer, report);
> >> +	fclose(report);
> >> +
> >> +	fprintf(stderr, _("Created new report at '%s'.\n"), report_path.buf);
> >> +
> >> +	UNLEAK(buffer);
> >> +	UNLEAK(report_path);
> >> +	return -launch_editor(report_path.buf, NULL, NULL);
> >
> > This would be the first time (at least that _I_ know of) that we use `-`
> > in this way. We seem to use `!!` a lot more often. And now I wonder
> > whether there is a reason for that `-` that I missed?
> 
> In general, our preferred way to report an error from API functions
> is to return a negative number and a success is reported by
> returning zero.
> 
> The argument to exit(3), which the return value from the main()
> function essentially is, on the other hand, is expected to be a
> small non-negative integer.  As long as we are in tight control of
> the range of the returned value from launch_editor() (i.e. it must
> return a small non-positive integer whose negation is suitable to be
> fed to exit(3)), the above is fine.
> 
> The idiom "return !!fn();" is to canonicalize the value to 0 or 1
> for the caller who asked "so, did fn() give us 0 or non-zero?",
> which can also be used as the value given to exit(3), and could be
> more appropriate under some conditions:

In editor.c, launch_editor() returns launch_specified_editor() without
altering the return code.

> 
>  - we MUST know launch_editor() returns zero if and only if it is
>    successful.

launch_specified_editor() has a handful of exit points, of three kinds:
 1. return error(something)
 2. raise(sigsomething)
 3. return 0
    a. when the editor process closed happily, but the user supplied
       NULL instead of a buffer. That is, the user didn't want the
       contents of the editor given back to them in a strbuf.
    b. when the editor process closed happily and the user's supplied
       buffer was filled with the file's contents with no issue.

So I think we can check "yes" here.

> 
>  - we do not have to be confident to be in tight control of the
>    range of the returned value from launch_editor() (e.g. it could
>    return a positive upon an error).

According to 'man 3 raise' (POSIX), raise() exits the current thread. If it
can't exit itself(?) it seems it returns "nonzero for failure". We've
also got a mingw_raise() in compat/mingw.h which could be used instead;
this one seems to return -1 or the result of raise(), presumably the one
from the MSC runtime[1], which also returns "a nonzero value" if not
successful.

So it's true that we aren't confident that launch_editor() returns a
positive or negative value.

>  - we MUST NOT care to differenciate different error codes returned
>    from launch_editor().  IOW, we must be fine to give the invoker
>    of the program only 0 (success) or 1 (unspecified failure).

This part is a little sticking point for me; I think I'd rather give the
user some hint of what's broken than no hint at all, especially in this
scenario, where it's conceivable someone could say "I tried to run
'git-bugreport' and it crashed, here is the return code and I have
manually collected some relevant info too".

The uncertainty coming from raise() (POSIX and MSCR both) leads me to
believe if I do want to return the error on exit, I should at least
check the sign before I flip it. Anybody else have opinions?

 - Emily

[1] https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/raise?view=vs-2019
