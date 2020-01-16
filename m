Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A5BC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BF720748
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FM1vzBcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgAPWEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:04:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35681 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgAPWEn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:04:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so8955130plt.2
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 14:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zwmPgfhhQaSkNMZwOBw7lj+t8TKHctE18sLFMLf/4Q0=;
        b=FM1vzBcu2/xYW5fkAsetGYdWgBG3JrxCgoMK5MADnLkHy0Rmhi03IKiSvdaGMKhTMq
         bY0/pHYcy7N+kRbigJRHnq6FZ9rWJBP8Oq+5jM8Xrb5xfQnJ0ScrNlsWzJQTd0DhmcYe
         sG9l3H4cG3feVsuRbgw/tlJ1MxAyBzVpdyCGcUMhVGVFdHCYepv8C/goQuE81pC/2I8f
         IqOALntc9d2LUTLMumRhpAdV+/GhrBxqnHqDrizGsRssA7Ip1rH205ddJ4tMI1ZZ0dJY
         kCbUOdD1Zk8UOtIjY3bT2Hdaue8ZqGJVk84N/IK2zRslTDJ6MFWuoQBAiAzX5R1XApNv
         5cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zwmPgfhhQaSkNMZwOBw7lj+t8TKHctE18sLFMLf/4Q0=;
        b=l1AzXnUF0AUrbOZFWn5rAMDenA2RcPGuAjq+bCc4daNoGXfXnGINQJsap3M7Oii4j0
         x8rI0UlVMV3/Tv4BDqgIdxQgDcark4CE9btp4nFhqFDYlo76jaZK8h1eswTvNzeQYzLb
         1JjJg6HWBu7y+0rxIL8hUnCVunj03pKNH7N6vlqIkIBTHHi7MAoH6lq1xNO76M/+YUZc
         qZyFQ+g7n8PFkl5NSlLwY18+0fzXkSvcoTYf4dloFnhW51PQSK6HqHjHuatlBBg2z2ky
         67UzAMr1uGnorAPjjPyBkfZO+TNXzirgUHE0+5faJsIHSIKgqs/X4/asqdh650aVeEq0
         zRiQ==
X-Gm-Message-State: APjAAAUf1BrHgoxASEIqYhFMz3/MyWXhUxWdSSRmetgx1jf9H+fQi391
        vP+VDSM3LTJVknbIPCX5Knm5aT4X34U=
X-Google-Smtp-Source: APXvYqwnBNq8HjzFgSvSv3g81ujqckD/6fq2g3Tt5P+uv5q3yg9MVL+AQ13I2KFpiuh1lLN59j+Qbw==
X-Received: by 2002:a17:90a:3643:: with SMTP id s61mr1749895pjb.44.1579212282377;
        Thu, 16 Jan 2020 14:04:42 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id t1sm25790461pgq.23.2020.01.16.14.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 14:04:41 -0800 (PST)
Date:   Thu, 16 Jan 2020 14:04:37 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch: emphasize failure during submodule fetch
Message-ID: <20200116220437.GL181522@google.com>
References: <20200116025948.136479-1-emilyshaffer@google.com>
 <xmqq1rrzi7k1.fsf@gitster-ct.c.googlers.com>
 <20200116215526.GK181522@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116215526.GK181522@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 16, 2020 at 01:55:26PM -0800, Emily Shaffer wrote:
> On Thu, Jan 16, 2020 at 10:23:58AM -0800, Junio C Hamano wrote:
> > Emily Shaffer <emilyshaffer@google.com> writes:
> > 
> > > @@ -1280,10 +1280,13 @@ struct submodule_parallel_fetch {
> > >  	/* Pending fetches by OIDs */
> > >  	struct fetch_task **oid_fetch_tasks;
> > >  	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
> > > +
> > > +	struct strbuf submodules_with_errors;
> > > +	pthread_mutex_t submodule_errors_mutex;
> > 
> > Hmph, it is kind of surprising that we need a new mutex for this.
> > 
> > Isn't the task_finish handler, which is what accesses the
> > with_errors field this patch adds, called by pp_collect_finished()
> > one at a time, is it?
> 
> Hm. It is called by pp_collect_finished() one at a time, but while other
> processes may still be running. So I guess that is OK - spf might still
> be read by other tasks but this field of it won't be touched by anybody
> simultaneously. Ok, I'm convinced.
> 
> > It seems oid_fetch_tasks[] array is also a shared resource in this
> > structure among the parallel fetch tasks, but there is no protection
> > against simultaneous access to it.  Am I missing what makes the new
> > field different?  Somewhat puzzled...
> 
> I think it's similar. As I understand it, it looks something like this:
> 
>   loop forever:
>     can i start a new process?
>       get_next_task cb (blocking)
>       start work cb (nonblocking unless it failed to start)
>     process stderr in/out once (blocking)
>     is anybody done? (blocking)
>       task_finished cb (blocking) <- My change is in here
>         did fetch by ref fail? (blocking)
>           put fetch by OID onto the process list (blocking)
>     is everybody done?
>       break

Ah, as I look deeper I realize that it's a child process, not a thread,
so this code becomes even simpler to understand. I think then I don't
need to worry about thread safety at all here.

 - Emily
