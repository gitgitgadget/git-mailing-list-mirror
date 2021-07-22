Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF04C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD86960EB2
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhGVWLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 18:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhGVWLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 18:11:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B8C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 15:51:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f1so1136002plg.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PXS3CkVhu6Q28cDvLDgLl3etgej//kmXK36bYK8huzE=;
        b=R1p0EbZq7fmWKOW8+pPOj/LrWjJ7NU+9csRrHRWXyBvSTmgMiJ+gKkkk23aQH0IoFr
         3JOaWvdHxqAZdb6xj+QrqBiwgAqEgW7tXQTUDYWsI23kEups5ZOEZlIRUQakdboTwGLw
         4ZA0R6buadJJXkM6FwiFaT01wmpx1j/7zRDxCsW9ADjqwWWCKFr7cymF5Dp5LVQKp76f
         sCmeAcf7A4f4V+FeGwl9VndtwezJ2ifjiMbgLRNHYMIMMc6A++Xu+7iV2ZMpeYvPZR+7
         p51QN0IX+KLUAz1WWw8cKzdyMixQF758Tt1IMM/Hysdq4dCE7Tus3A1+5yDSQkCtRWpY
         e6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PXS3CkVhu6Q28cDvLDgLl3etgej//kmXK36bYK8huzE=;
        b=fF3jkCgUA6VPKA5CTdIdhfogOBXgQycqPKD6hwMCmouvFXER3ZrmoZKS91y35mLHF4
         s+hlRPOWToEjUJYLr++laZuQaCc5xraWVkPJClXKT8XV6iTIs0ctIyYO3zWYJ+lZDqNc
         pqLaztyBQnlh1nb2KRIfIqxNy2y2chAoJ52H9YGrO+SYk8LAj1GN+9vlmq50tup6FVbb
         Dr6FNuF9mxJh8OlhDntsIP9Xbe39k6yTDkO91M7rHmE/lZN6ZjejhxMa3LUVUsxbVL6g
         KXI6rVBdOdjjCkeN9e44lJa7DyvVasJE5XurL6Qo9xp9/wOUzseyboc1vTlHtkHIJLuj
         ATbg==
X-Gm-Message-State: AOAM530JDUPkqqgc2SabgngzkB5UkpupU4zAyuMq7L7KbMv28r3/2QPT
        JFZbKIFXHIZSykW+grIAdJNMkA==
X-Google-Smtp-Source: ABdhPJxSeqfAYIE9dzR3jWJN1OCVQ5PZZM4pxmoavSaWvxtxKVra4SEamFGYeKAc33M9NwZZmsEQWA==
X-Received: by 2002:a62:a516:0:b029:333:1995:5e75 with SMTP id v22-20020a62a5160000b029033319955e75mr1839566pfm.67.1626994299781;
        Thu, 22 Jul 2021 15:51:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3c03:6226:e12f:afc9])
        by smtp.gmail.com with ESMTPSA id g2sm30953906pfv.91.2021.07.22.15.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 15:51:39 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:51:33 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/9] hook: include hooks from the config
Message-ID: <YPn2dfjzFLovIYIX@google.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-7-emilyshaffer@google.com>
 <87im1ay67y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im1ay67y.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 11:01:24AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Jul 15 2021, Emily Shaffer wrote:
> 
> > +static struct hook * find_hook_by_command(struct list_head *head, const char *command)
> 
> nit: "*find[...]" not "* find[...]", also let's wrap the long line.
ACK
> 
> > +{
> > +	struct list_head *pos = NULL, *tmp = NULL;
> > +	struct hook *found = NULL;
> > +
> > +	list_for_each_safe(pos, tmp, head) {
> > +		struct hook *it = list_entry(pos, struct hook, list);
> > +		if (!strcmp(it->command, command)) {
> > +		    list_del(pos);
> > +		    found = it;
> > +		    break;
> 
> Indented with spaces.

I don't know how I even did this. *facepalm*

> 
> Also is there some subtlety in the list macro here or can we just
> "s/break/return it/" and skip the break/return pattern?

I guess it's probably fine, but we'd need the final return anyway
("otherwise returns NULL"). IMO one return is more readable than two
returns, so I'd rather leave this.
> 
> > +static struct hook * append_or_move_hook(struct list_head *head, const char *command)
> 
> Same whitespace nits.
ACK
> 
> > +	if (!to_add) {
> > +		/* adding a new hook, not moving an old one */
> > +		to_add = xmalloc(sizeof(*to_add));
> > +		to_add->command = command;
> > +		to_add->feed_pipe_cb_data = NULL;
> > +		/* This gets overwritten in hook_list() for hookdir hooks. */
> > +		to_add->from_hookdir = 0;
> 
> I commented on init verbosity elsewhere, i.e. we could do some things
> via macros, but in this case just having an "init" helper make sense,
> but we have at least two places copying the same init of all fields,
> should just be hook_init_hook() or whatever it'll be called. Maybe with
> a second "from hookdir" param?

Hm, where is the second place where we init everything? I think with
this commit we remove anywhere we're putting together a 'struct hook' manually
except during this helper? Hooks from hookdir are initted by
'append_or_move_hook()'ing them to the end of the list and modifying the
from_hookdir field, and builtin/hook.c just calls hook_list() (and some
list.h helpers to find an entry).

> 
> > +	if (!strcmp(key, hook_key)) {
> > +		const char *command = value;
> > +		struct strbuf hookcmd_name = STRBUF_INIT;
> > +
> > +
> 
> Nit: 3x\n, not 2x\n
> 
> > +		if (!command) {
> > +			strbuf_release(&hookcmd_name);
> 
> You don't need to strbuf_release() things that you haven't done anything
> except init'd, but also...
> 
> > +			BUG("git_config_get_value overwrote a string it shouldn't have");
> 
> ...even if that were the case and it called malloc() memory diligence
> when we're calling BUG() is probably going overboard, and I say that as
> someone who'll tend to go overboard with it :)

:) ok.

> 
> > +		}
> > +
> > +		/* TODO: implement skipping hooks */
> > +
> > +		/* TODO: immplement hook aliases */
> > +
> > +		/*
> > +		 * TODO: implement an option-getting callback, e.g.
> > +		 *   get configs by pattern hookcmd.$value.*
> > +		 *   for each key+value, do_callback(key, value, cb_data)
> > +		 */
> 
> I think we should drop the TODO and just let the commit message /
> comments speak to what we actually implement, and subsequent patches can
> add more features.

Ok, sure.

> 
> > -
> > +	struct strbuf hook_key = STRBUF_INIT;
> > +	struct hook_config_cb cb_data = { &hook_key, hook_head };
> 
> Let's use designated initializers.
ACK
> 
> >  
> >  	INIT_LIST_HEAD(hook_head);
> >  
> >  	if (!hookname)
> >  		return NULL;
> >  
> > +	/* Add the hooks from the config, e.g. hook.pre-commit.command */
> > +	strbuf_addf(&hook_key, "hook.%s.command", hookname);
> > +	git_config(hook_config_lookup, &cb_data);
> > +
> > +
> 
> Another 3x\n
ACK
> 
> > +	/* to enable oneliners, let config-specified hooks run in shell */
> > +	cp->use_shell = !run_me->from_hookdir;
> 
> I've lost track at this point, but doesn't that mean we're going to use
> a shell when we run our own do-not-need-a-shell hooks ourselves?
> 
> Isn't isatty() more appropriate here, or actually even interactively why
> is the shell needed (maybe this is answered elswhere...).

use_shell means "conditionally guess whether I need to wrap this thing
in `sh -c`" - it doesn't have anything to do with TTY or not. So we need
this for something like `hook.post-commit.command = echo "made a
commit"`. In this case the entire argv[0] will be the oneliner, which
you will need use_shell set for. If we *do* just do something simple,
like `hook.post-commit.command = /bin/mail`, even though
use_shell is marked, the child_process runner will notice that there's
no reason to wrap in 'sh -c' and so will just run the /bin/mail
executable directly.

 - Emily
