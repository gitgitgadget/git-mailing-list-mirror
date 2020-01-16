Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96531C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5395920728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiRiu3Xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbgAPVzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:55:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37629 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgAPVzc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:55:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so8935494plz.4
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 13:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qU2MMJbYTxnH0y7esiu8Rl4r7FLzppHdgnbzb6vEM7s=;
        b=GiRiu3XtMgRzJE23FVnraDe1BIg1tsOzKpNAKfRJzsC7bkp4LhhV32oxrsdthckQXU
         BDcX2AppsOxqUBQWOgTwhwofAUEW1XisDIaJs/k2O4GptWDvlrKc7OR0WpxphQiVnfT1
         m8+N6cxXUqOneFdKNJj4kt9yV0KGaLKlug6xw5krIDloPY5peecvUGOGyfcpDT7rMYf0
         f2yd/Jx8UMmymZuNl73AMBQdgFKfX9txosYdOXnKO06zVU/AMddBMqTF5n+VnkTsy9Ta
         EMJSXOP2l4qRheoutyimYz3NyWEnOUrRFZB9XvPmVSpzlhmVR5FdamfSILlUBRJuTqOw
         H7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qU2MMJbYTxnH0y7esiu8Rl4r7FLzppHdgnbzb6vEM7s=;
        b=ddxi0IiyJUUxRLgIc7fK0nOTqzPXy5oXm4aOV566d/6SfX+Jb4gC3t29U0TSn/rB2a
         lzg8qXKm8+PLiOeEEjwp/Z52VA4KlspNVXToKumgCYgZzNceRY+HKtGf2F9NKucrp1Ya
         E8ii7HzdHbtJhNO60kMiqHSSzgkqNv6260YcG2mZSVxYP3j6i6L2fecFmtehfZjGggbD
         75CCWfb5QpPaEGKvLfWSH5eV5TiK1Z0UN+jZgxp22Oj/nffYfnJjlC+TVZ9zm1yB93SF
         rJU5j+X7SF92WDLoKaIME3NEQhvma2FR9Qxyn2ZrozH1yhjAWIcVpsdUJ18mQBS7kGJP
         rkFA==
X-Gm-Message-State: APjAAAUZHWcaVNccSFCZR4N0cYoF3vFD/v8kZe3+X7S7nXukcBncbtFW
        brdH4iet2EGyDhIT3WA6aQHE+g==
X-Google-Smtp-Source: APXvYqz6teVW/oKWbLsYgl23vmjLbSUkXtmXP2mUVagggE/7nLavnp/exK3DkcHhnffmr25HWPg3uw==
X-Received: by 2002:a17:90a:17e5:: with SMTP id q92mr1748312pja.28.1579211731739;
        Thu, 16 Jan 2020 13:55:31 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id l2sm26724053pff.59.2020.01.16.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:55:31 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:55:26 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch: emphasize failure during submodule fetch
Message-ID: <20200116215526.GK181522@google.com>
References: <20200116025948.136479-1-emilyshaffer@google.com>
 <xmqq1rrzi7k1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rrzi7k1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 16, 2020 at 10:23:58AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > @@ -1280,10 +1280,13 @@ struct submodule_parallel_fetch {
> >  	/* Pending fetches by OIDs */
> >  	struct fetch_task **oid_fetch_tasks;
> >  	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
> > +
> > +	struct strbuf submodules_with_errors;
> > +	pthread_mutex_t submodule_errors_mutex;
> 
> Hmph, it is kind of surprising that we need a new mutex for this.
> 
> Isn't the task_finish handler, which is what accesses the
> with_errors field this patch adds, called by pp_collect_finished()
> one at a time, is it?

Hm. It is called by pp_collect_finished() one at a time, but while other
processes may still be running. So I guess that is OK - spf might still
be read by other tasks but this field of it won't be touched by anybody
simultaneously. Ok, I'm convinced.

> It seems oid_fetch_tasks[] array is also a shared resource in this
> structure among the parallel fetch tasks, but there is no protection
> against simultaneous access to it.  Am I missing what makes the new
> field different?  Somewhat puzzled...

I think it's similar. As I understand it, it looks something like this:

  loop forever:
    can i start a new process?
      get_next_task cb (blocking)
      start work cb (nonblocking unless it failed to start)
    process stderr in/out once (blocking)
    is anybody done? (blocking)
      task_finished cb (blocking) <- My change is in here
        did fetch by ref fail? (blocking)
          put fetch by OID onto the process list (blocking)
    is everybody done?
      break

That is, everything but the work unit itself is blocking and runs in a
single threaded infinite loop. So since oid_fetch_tasks is read in
get_next_task callback and modified in the task_finished callback, those
areas don't need thread protection.

Thanks for poking me to think it through better. I'll remove the mutex
and include a short note about why it's not needed in the commit message.
I suppose if I wanted to try and catch more precise error information
during the actual work, then I would need it, but I'm not sure it's
necessary or trivial because of how the stdout/stderr is handled for
cohesive printing.

> Other than that, I think this is a vast improvement relative to the
> initial round.  I wonder if we want to _("i18n/l10n") the message,
> though.

Sure, sorry to have missed it.

Thanks for the thoughtful review. Will send a reroll in a moment.

 - Emily

> 
> 
> >  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
> >  		  STRING_LIST_INIT_DUP, \
> > -		  NULL, 0, 0}
> > +		  NULL, 0, 0, STRBUF_INIT, PTHREAD_MUTEX_INITIALIZER}
> >  
> >  static int get_fetch_recurse_config(const struct submodule *submodule,
> >  				    struct submodule_parallel_fetch *spf)
> > @@ -1547,7 +1550,10 @@ static int fetch_finish(int retvalue, struct strbuf *err,
> >  	struct string_list_item *it;
> >  	struct oid_array *commits;
> >  
> > -	if (retvalue)
> > +	if (!task || !task->sub)
> > +		BUG("callback cookie bogus");
> > +
> > +	if (retvalue) {
> >  		/*
> >  		 * NEEDSWORK: This indicates that the overall fetch
> >  		 * failed, even though there may be a subsequent fetch
> > @@ -1557,8 +1563,11 @@ static int fetch_finish(int retvalue, struct strbuf *err,
> >  		 */
> >  		spf->result = 1;
> >  
> > -	if (!task || !task->sub)
> > -		BUG("callback cookie bogus");
> > +		pthread_mutex_lock(&spf->submodule_errors_mutex);
> > +		strbuf_addf(&spf->submodules_with_errors, "\t%s\n",
> > +			    task->sub->name);
> > +		pthread_mutex_unlock(&spf->submodule_errors_mutex);
> > +	}
> >  
> >  	/* Is this the second time we process this submodule? */
> >  	if (task->commits)
> > @@ -1627,6 +1636,11 @@ int fetch_populated_submodules(struct repository *r,
> >  				   &spf,
> >  				   "submodule", "parallel/fetch");
> >  
> > +	if (spf.submodules_with_errors.len > 0)
> > +		fprintf(stderr, "Errors during submodule fetch:\n%s",
> > +			spf.submodules_with_errors.buf);
> > +
> > +
> >  	argv_array_clear(&spf.args);
> >  out:
> >  	free_submodules_oids(&spf.changed_submodule_names);
