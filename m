Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01346C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 19:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343574AbiEETsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 15:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385274AbiEETsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 15:48:11 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93B95E74F
        for <git@vger.kernel.org>; Thu,  5 May 2022 12:44:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g184so1904809pgc.1
        for <git@vger.kernel.org>; Thu, 05 May 2022 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=mCCH8Dl94T8fg8TQploJoPxg6J1f+q/KdSpv2iCGwsE=;
        b=qP120F+TDKIpkcilZrEbbMeXrSa8MRGwRVVMlGNh0YXYJExVwodEjFu+5YS6U+ncn1
         rcud52cF+aJCLlnv8enT0JQSkA2jdw21ZNx1BrxmzzDX0ZwEAToWcj5rXktnGvqIQxwQ
         IdxXFfzPRz2TtZKuPeuZg/nQ/9SKQHIWS/XI3MXVdWOYGiWJp4DV/5YjSGawE/OWrj2I
         Jsqgtw3y2do43nPpZ4U9zGHGhIebfwhF4o28I2dZC83/gewJ+nCmdug6fjUwgNLaNYyw
         RHNRYyoIVSgeJpIlcrpIwIhmFePo6rymOBULcZVuw63AC5yulEnyzVxdlWaxOjnGlok5
         rM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=mCCH8Dl94T8fg8TQploJoPxg6J1f+q/KdSpv2iCGwsE=;
        b=JEK0/sVaK1OoILaWs1q532spcGa7rM+Yrfv32eOWRZoOiPpVKUKU/gzbROkdmeKztN
         8XS1xNPBvpHx+BZx7L+4ukkQMJi2IDZg6rywynI+bTuzWrcBCGh+IfSvMGO7Zv1lp/+v
         jmUbXu7z8XhD2OYV5YpmynzYLi44jF8syBCTxuk0ogiiZxpV9xYO3nKhyZ2cLAPG9xlR
         9GPAZaHPF+iVqYse/DAaaQkCxJUnVE+pXXmpx7iBs7768aob22ivVcc4q/KkiCr6Qp89
         5reKSDfMvhZVewiaKgLzNhesNQvGZyPrVJIdmNlJA7PgElqgZn5yCwYzWeIss6zpLqUb
         gNRw==
X-Gm-Message-State: AOAM530ZFka2KFx0zQ9S0ImKma0ulVgMcjHqiAYwhpkFLoZCaVB+jGxq
        IXjh4TIybeQdkHIbvWKAX78iUDYtp2dZpg==
X-Google-Smtp-Source: ABdhPJxIhzWuXmiQnb5ceMZCbYF/7mXryskwKcka6ENeElq6U3D6k3lMdsxFBETaSo/RvXrJmjtXkw==
X-Received: by 2002:a63:d04a:0:b0:3c1:65f2:5d09 with SMTP id s10-20020a63d04a000000b003c165f25d09mr23558895pgi.201.1651779870140;
        Thu, 05 May 2022 12:44:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:faab:4bc4:f0f5:44a6])
        by smtp.gmail.com with ESMTPSA id c9-20020a621c09000000b0050dd876f5f8sm1774565pfc.49.2022.05.05.12.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 12:44:29 -0700 (PDT)
Date:   Thu, 5 May 2022 12:44:23 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] run-command: don't spam trace2_child_exit()
Message-ID: <YnQpFwcB3V07qNi3@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
 <xmqqr15gev94.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr15gev94.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.04.28 14:46, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > In rare cases, wait_or_whine() cannot determine a child process's exit
> > status (and will return -1 in this case). This can cause Git to issue
> > trace2 child_exit events despite the fact that the child is still
> > running.
> 
> Rather, we do not even know if the child is still running when it
> happens, right?

Correct, if you'd like me to clarify the commit message I'll send a V2.


> It is curious what "rare cases" makes the symptom
> appear.  Do we know?

Unfortunately, no. The quoted 80 million exit event instance was not
reproducible.

> The patch looks OK from the "we do not know the child exited in this
> case, so we shouldn't be reporting the child exit" point of view, of
> course.  Having one event that started a child in the log and then
> having millions of events that reports the exit of the (same) child
> is way too broken.  With this change, we remove these phoney exit
> events from the log.
> 
> Do we know, for such a child process that caused these millions
> phoney exit events, we got a real exit event at the end?

We don't know. The trace log filled up the user's disk in this case, so
the log was truncated.


> Otherwise,
> we'd still have a similar problem in the opposite direction, i.e. a
> child has a start event recorded, many exit event discarded but the
> log lacks the true exit event for the child, implying that the child
> is still running because we failed to log its exit?

Yes, that is a weakness with this approach.


> >  int finish_command_in_signal(struct child_process *cmd)
> >  {
> >  	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
> > -	trace2_child_exit(cmd, ret);
> > +	if (ret != -1)
> > +		trace2_child_exit(cmd, ret);
> >  	return ret;
> >  }
> 
> Will queue; thanks.

Thanks, and sorry for the delayed reply, I've been out sick for a few
days.
