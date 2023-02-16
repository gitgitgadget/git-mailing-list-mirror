Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB08C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 20:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBPUhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 15:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBPUhe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 15:37:34 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01A57288
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:37:33 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h24so3597911qtr.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sg2yIaszpzeblKhjLIVFJIRl4A8PPoh0BWi2a64GNCU=;
        b=kMLqXpyCbvYoOOCzS6Rij0V1BlU2NSzXTslmWY6fMyRQ0UPdTt8mOgmjEtvxU0EdVq
         0FMkSjlMKXlBnILgyibwvpYXixeW+ejW5KOXanTQ21bTWuNz5J8r9DmFxV1wtH9pf6Be
         UEs40wk7EpxhhNkFKMLuQYxcntBnmH4LkLNu8MWZC2rWPl9XmuW63a2wwLSo/RNO3+eu
         Ze9zQUKBkHN8NcZYclSJ8Lplcqsn5Jovw52Q/QHS6QPhkHcRABLimzQXJ9/2ESvZGZue
         MQG5dL9c9gs+pJ3yZVUxQXw7u7KvmSUlvxI4L0MY1qWBdHZhKcMn5rf3cE4IBrh8M1Cg
         5f+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg2yIaszpzeblKhjLIVFJIRl4A8PPoh0BWi2a64GNCU=;
        b=hHjR32YiB0fK6Tg1e01X1eC5PYw2oqVSF+LCZNZvyZyDTKySCr5uJUDulKQyPQA9wQ
         dG0Om/k56fx0qQPBy2WYRbGRBfd0NBvRF/fdpiz7hrVLcTFmOTcOO3plys3zJi2dhwAs
         HJLw85xhpHkljOuLEdGpfukYrtrr15BYSWtYjS9qU+q2EbP8Ip2q0+/XKcwYCHr5m8LY
         T4s0zyJH5yXgedbONJYmRJeuQmrRDIQ0eaD74WiNu1Wh68EJibUIPBhLxLef/Enn6hVo
         WCTPIQOfTEmomOI63Ihb4Rmqbo7tGNMX+UK7nLfut1BXim3XNZrNnRUnr7gDSMzR6cmo
         Z/eg==
X-Gm-Message-State: AO0yUKUi3BNg0KF0zW2NbSQ0Z8oV97eVoNaLlzX2JrxFaj1HBR0Bc/vm
        bUPzJby26Wuc8DNUXWjdeGM=
X-Google-Smtp-Source: AK7set8ZG5kH/QdMd2UKFHRrDLa2rV4l4quefWDbr6kztDns5zFmefqUYepyxxE6fStzBeRJ46pgBA==
X-Received: by 2002:ac8:5c50:0:b0:3a9:86dd:3c5d with SMTP id j16-20020ac85c50000000b003a986dd3c5dmr13268722qtj.5.1676579852807;
        Thu, 16 Feb 2023 12:37:32 -0800 (PST)
Received: from localhost (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id d64-20020a37b443000000b0073b69922cfesm1859903qkf.85.2023.02.16.12.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:37:32 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:37:31 -0500
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] diff: teach diff to read gitattribute
 diff-algorithm
Message-ID: <20230216203731.uu3wvgs5ka5flmfv@pop-os>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <cb0305631496eb4c2d51e5b586ac0ca8580c7dc1.1676410819.git.gitgitgadget@gmail.com>
 <xmqq4jrn3ac7.fsf@gitster.g>
 <xmqqwn4j1uon.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwn4j1uon.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/02/14 07:20PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> diff --git a/diff.c b/diff.c
> >> index 92a0eab942e..24da439e56f 100644
> >> --- a/diff.c
> >> +++ b/diff.c
> >> @@ -4456,15 +4456,11 @@ static void run_diff_cmd(const char *pgm,
> >>  	const char *xfrm_msg = NULL;
> >>  	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
> >>  	int must_show_header = 0;
> >> +	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, attr_path);
> >
> > Do we run this look-up unconditionally, even when .allow_external
> > bit is not set?  Why?
> 
> Ah, this is perfectly fine.  It used to be that this codepath can
> tell that there is no need to check the diff driver when it is told
> never to use any external diff driver.  Now, even when it is computing
> the diff internally, it needs to check the diff driver to find out
> the favoured algorithm for the path.
> 
> Strictly speaking, if we are told NOT to use external diff driver,
> and if we are told NOT to pay attention to algorithm given by the
> diff driver, then we know we can skip the overhead of attribute
> look-up.  I.e. we could do this to avoid attribute look-up:
> 
> 	struct userdiff_driver *drv = NULL;
> 
> 	if (o->flags.allow_external || !o->ignore_driver_algorithm)
> 		drv = userdiff_find_by_path(...);
> 
> 	if (drv && o->flags.allow_external && drv->external)
> 		pgm = drv->external;
> 	...
> 	if (pgm)
> 		... do the external diff thing ...
> 	if (one && two) {
> 		if (drv && !o->ignore_driver_algorithm && drv->algorithm)
> 			set_diff_algo(...)
> 
> I was not sure if it would be worth it before writing the above
> down, but the resulting flow does not look _too_ bad.

Yes I think it's worth it to save on execution if we know we are not using
external diff algorithm.

> 
> >> @@ -4583,6 +4584,10 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
> >>  	const char *name;
> >>  	const char *other;
> >>  
> >> +	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);
> >> +	if (drv && drv->algorithm)
> >> +		set_diff_algorithm(o, drv->algorithm);
> >
> > Interesting.  Does external diff play a role, like in run_diff_cmd()
> > we saw earlier?
> 
> As whoever wrote "diffstat" did not think of counting output from
> external diff driver, of course in this codepath external diff would
> not appear.  So what we see is very much expected.
> 
> Just move the blank line we see before these new lines one line
> down, so that the variable decls are grouped together, with a blank
> line before the first executable statement.  I.e.
> 
> 	const char *name;
> 	const char *other;
> +       struct userdiff_driver *drv;
> +
> +	drv = userdiff_find_by_path(...);
> +	if (drv && drv->algorithm)
> +		set_diff_algorithm(o, drv->algorithm);

makes sense, thanks.

> 
> Shouldn't this function refrain from setting algorithm from the
> driver when the algorithm was given elsewhere?  E.g.
> 
> 	$ git show --histogram --stat
> 	
> or something?  IOW, shouldn't it also pay attention to
> o->ignore_driver_algorithm bit, just like run_diff_cmd() did?

Yes we should add the same guard as above.

> 
> 
