Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2817C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B1221835
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 19:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0bkN933"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFTL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:11:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40834 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFTL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 14:11:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so3092869plp.7
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 11:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8/xwvnEziANiwt0713qzGo2DtW55Q2iM/GH5KgtVVHI=;
        b=Y0bkN933i/Smnk7b/FAhTWQ6n//4Zbhxtqg8ZGhyUzZrowRQ8Y27LDUcMBvzCbXGqu
         s5SuGqQzlecoNxwrSg7AUcyB6H2xBM5UHETSV9RPAJQkJC39djwkcZZsZUolxZrFGZXN
         SQk7Jy6r8Gy4QlT/NlGpaqGwtCLi5pqDwmf6lX5mvxjWSFKjGsv/2eqpzvTPNDxWR8cL
         7GPTTioXezz49U0pKUNtTNp2bp2eepdePF3/8uUUyAj/Wp2a83KMRrZjbm41DVq2OHv7
         dEqML5ERdkbBC6O7iAFyZIWfWMX9JkP3OYzbIB4yFCe8upZwJBuGWhXbyvfuoX48OYia
         JOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8/xwvnEziANiwt0713qzGo2DtW55Q2iM/GH5KgtVVHI=;
        b=T7c5JxqIf0qZJQWNYr0jmREUtsExL13yvqxV9TDNyMzWH3FhLpaCrhHI54O9QfrsPE
         ZjKU+oLP3TIIzpHL7zAO4qUe5naTWs9bQfg2r6F0I4Ea4Nad6jeVTxJMwXR3UkWhGQ92
         lVACxlXZf/RQ4S7wZ81isDds09ddDMzOpM6YTyadGX6m6lyFYsd9hVpT0rIPAlFYvD6s
         4VWV+iCujgxj8jnBKXDrWhMauh6/dD5CuDksO6ZZc3y1y/ECWuaaIexBqdRGisrfyeBE
         BqaoKqOeMslO9uVMppQWBKSVoiBUDS5LBTGjLCHMbzvScwCehAFQGGqqXQ3LAJhE7KKS
         IVeA==
X-Gm-Message-State: APjAAAW1/Fkd2j6l4U2O8uXsc6Z9vpdvE/4egXe2SGcLmzkta1od5bMa
        4HZXBNZ5ZJZ20ecF0oQQLmc=
X-Google-Smtp-Source: APXvYqxRm6NSdDnlj0pvwe9Sa18cpnjyLZHPN+IA+OANLETFJ29GS+/NfJx388X+aP+6SB5D2EIFXQ==
X-Received: by 2002:a17:902:b403:: with SMTP id x3mr16384592plr.109.1575659485757;
        Fri, 06 Dec 2019 11:11:25 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id t137sm16102938pgb.40.2019.12.06.11.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 11:11:24 -0800 (PST)
Date:   Fri, 6 Dec 2019 11:11:47 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Alex Torok <alext9@gmail.com>, g@generichostname
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rebase: find --fork-point with full refgg
Message-ID: <20191206191147.GA16379@generichostname>
References: <20191205225322.5529-1-alext9@gmail.com>
 <20191205235704.31385-1-alext9@gmail.com>
 <20191205235704.31385-3-alext9@gmail.com>
 <20191206014828.GB16183@generichostname>
 <e898ad43-5649-8f4c-7c93-fab09197fc92@gmail.com>
 <CANmPhj38UqZiePEPbPJBwUTOEJrfA6j3aP8KBHvAY6EA-J7Nsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANmPhj38UqZiePEPbPJBwUTOEJrfA6j3aP8KBHvAY6EA-J7Nsw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Fri, Dec 06, 2019 at 08:46:29AM -0500, Alex Torok wrote:
> Thank you for the feedback Denton & Phillip!
> 
> On Fri, Dec 6, 2019 at 5:52 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > On 06/12/2019 01:48, Denton Liu wrote:
> > > nit: * should be attached to the variable name.
> >
> > I think you also need to free it once you've called get_fork_point() as
> > well.
> 
> Yup. Got it.
> 
> > On 06/12/2019 01:48, Denton Liu wrote:
> > >
> > >> +            dwim_ref_or_die(options.upstream_name, strlen(options.upstream_name), &full_name);
> > >
> > > Also, thinking about this more, would it be possible to put the dwim_ref
> > > logic into get_fork_point() directly? There are currently only these two
> > > callers so I suspect it should be fine and it'll result in cleaner
> > > logic.
> >
> > If you do that then it would be better to use error() rather than die()
> > in get_fork_point() and return an error to the caller as we try to avoid
> > adding code to libgit that dies. This lets the caller handle any cleanup
> > that they need to before exiting.
> 
> Would the signature of get_fork_point change to be something like:
> int get_fork_point(const char *refname, struct commit *commit,
>    struct commit **fork_point, struct strbuf *err)

I would drop the last parameter. If an error is detected, you could just
do

	return error(_("oh no, something bad happened"));

Even though we try and avoid dying in the middle of libgit, we print
errors out very often so it should be fine here.

> > > Also, I'm not why this test case in particular that was duplicated (and
> > > not the one above) given that the first three `--fork-point` test cases
> > > fail without the change to rebase. Perhaps we want to duplicate all
> > > "refs/heads/master" tests with a corresponding "master" test?
> 
> I only duplicated one so that there would only be one test case that
> would fail if a regression around getting the fork point with a short
> ref name was introduced.
> 
> I just happened to pick that one because it was closest to the rebase
> command I was running when I found the bug :)
> 
> I can include some of the above reasoning in the commit message.
> Alternatively:
> * I could duplicate all of tests
> * I could change all of the tests to use the short ref name
> 
> I'm leaning towards just leaving one test (maybe with a comment?)
> for the short ref name --fork-point so that there is more resolution
> around where a bug could be on test failure.

I would just duplicate all of the tests. When the tests are pretty cheap
to run (as they are in this case), I tend to err on the side of adding
more tests since they might catch more odd edge-cases but, in this case,
all of the fork point logic goes through one common block so the
duplicate logic doesn't really buy us anything.

I'm pretty impartial so I'll leave it up to you ;)

Thanks,

Denton

> 
> Let me know what you think,
> Alex
