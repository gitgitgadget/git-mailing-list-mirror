Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90822C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDEE2087D
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgIPUfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:35:16 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35818 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgIPRMx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:12:53 -0400
Received: by mail-pj1-f66.google.com with SMTP id jw11so1865735pjb.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 10:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adkHsSnP8cNGwlZtkYk1h0Vqe+FP2ZwNof053FSK0fM=;
        b=k231p4jFZxGxfhdTmegPbPrYBbKJr4J8m+DN1yhJO6UYdGJzDQpmy+a+Vti+KYW1Ct
         hbYHQFMyvfTrJIsOyJI+d7gSVu9TK4kArxINJ1gNp3JRMk3dlC1qPztQcqtqUFwu3dCM
         6maQ8ox5kU21/hQLteklPqCXKhdguAoZWEIgWfr5KfrCNxYZaD+gHbwsAC45edFRnn5g
         VvtR5u9AgtvHZZGDNcVTKZzub5pBjZ9MO3/3H7aAd0A64C8v6O0XZ9WLY1hrwWrsnjnB
         KA3nkyioWQ9XQqhBUfT1R1PuRPAftLsJ23kHGvcuEDtqQj8M5QPmUHQFlGnPnD0VLXC7
         buRA==
X-Gm-Message-State: AOAM533dyEYKWL8DvuRUqgRXEbZZkeRdIxfgW1xejPCmkr6GltHRlAXc
        X7RdyPgYgs9EzUCrZ/Y1YQ7uVcrkreBs+Q==
X-Google-Smtp-Source: ABdhPJwgWKO5KcbFeQvlKKdhGEWqPwyK7QqT8O39b8stgCVvGibcDw/xBF4j5rDBWtztyNsU16/oDg==
X-Received: by 2002:a17:90a:a60e:: with SMTP id c14mr4995790pjq.31.1600276317817;
        Wed, 16 Sep 2020 10:11:57 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id v8sm552043pgg.58.2020.09.16.10.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:11:57 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        johannes.schindelin@gmx.de, sean@barag.org
Subject: Re: [PATCH 3/4] clone: validate --origin option before use
Date:   Wed, 16 Sep 2020 10:11:51 -0700
Message-Id: <20200916171151.1890682-1-sean@barag.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqq1rj8nj47.fsf@gitster.c.googlers.com>
References: <xmqq1rj8nj47.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 11 Sep 2020 at 13:39:20 -0700, Junio C Hamano writes:
> > From: Sean Barag <sean@barag.org>
> >
> > Providing a bad origin name to `git clone` currently reports an
> > 'invalid refspec' error instead of a more explicit message
> > explaining that the `--origin` option was malformed.  Per Junio,
> > it's been this way since 8434c2f1 (Build in clone, 2008-04-27).
>
> If you know it as a fact that it has been this way since the first
> version of rewritten "git clone", don't blame others.

Oh gosh, I'm so sorry!  I didn't mean for that to read as blaming, was
just trying to cite you as my source.  On a second read, it comes across
more "blame-y" than I originally intended.  I'll fix this in v2 (and
have learned a valuable lesson :) ).

> A micronit.  We describe the current status in present tense when
> presenting the problem to be solved, so "currently" can be dropped.
>
> > This patch reintroduces
>
> When presenting the solution, we write as if we are giving an order
> to a patch monkey to "make the code like so".
>
> "This patch reintroduces" -> "Reintroduce".

Great to know!  Thanks again for helping a newbie fit in.  Will fix in
v2.

> > validation for the provided `--origin` option, but notably _doesn't_
> > include a multi-level check (e.g. "foo/bar") that was present in the
> > original `git-clone.sh`.  It seems `git remote` allows multi-level
> > remote names, so applying that same validation in `git clone` seems
> > reasonable.
>
> Even though I suspect "git remote" is being overly loose and
> careless here, I am not sure if it is a good idea to tighten it
> retroactively.  But if this is meant as a bugfix for misconversion
> made in 8434c2f1, we should be as strict as the original.  I dunno.


To be honest, I'm struggling to decide which route to go.  It seems
like multilevel fetch and push refspecs are allowed as far back as
46220ca100 (remote.c: Fix overtight refspec validation, 2008-03-20) or
ef00d150e4 (Tighten refspec processing, 2008-03-17), so perhaps
removing the multilevel check in 8434c2f1 (Build in clone, 2008-04-27)
was intentional?  If removing that check in 8434c2f1 was a mistake and
we reintroduce it, that's probably a breaking change for some users.
What sort of accommodations would I need to include in this patchset to
ease that pain for users?

> > +	strbuf_addf(&resolved_refspec, "refs/heads/test:refs/remotes/%s/test", option_origin);
> > +	if (!valid_fetch_refspec(resolved_refspec.buf))
>
> If we reintroduce pre-8434c2f1 check, then we would want
>
> 	if (!valid_fetch_refspec(...) || strchr(option_origin, '/'))
>
> or something like that?

Absolutely!  Happy to include the multilevel check if you think it's the
right path forward (see above).

> > +		/* TRANSLATORS: %s will be the user-provided --origin / -o option */
> > +		die(_("'%s' is not a valid origin name"), option_origin);
>
> I am not sure if this translator comment is helping.
>
> The message makes it sound as if "%s" here is used to switch between
> '-o' or '--origin'.  If it said "'%s' will be the value given to
> --origin/-o option", it would become much less confusing.

Agreed.  I plan to take Derrick's suggestion [1] and use the same
" is not a valid remote name" message from `builtin/remote.c`, which
should make that translator comment a non-issue.

[1] https://lore.kernel.org/git/bf0107fb-2a6c-68d3-df24-72c6a9df6182@gmail.com/


I can't stress enough how sorry I am for the improper blame, and how
much I appreciate your help!
--
Sean
