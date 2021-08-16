Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04FCC432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 23:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C210F60EE0
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 23:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhHPXit (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 19:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhHPXis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 19:38:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D424CC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 16:38:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so3026454pjb.0
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uJ3WsqzV88jZeBrtNtbHshX9+SMk4OfQVS0NDAYSk5M=;
        b=t9dVUR9abYUrPjtlo01fjlTAiMwLsvyI39xGSab8TaSXJzQN8SHgyU0be9y7bylaXG
         Kn0ec33TNmsR9tvoYoSMRm+oU/uxl2AveX1dYBuWV1uyq2nst+oPFrjLvuvOxrTo/cbM
         IeUGWy/if8tH/HRXIkfEDxVsIcg0s9B3sm63sraFFuihqdcp/AjFex0CsTKlOtCWFTle
         de8oPKGCgbirht0i6Rd3G7wU/YpJ3NkWnV50OS560a0i64s5bm45hjCk0TFQ+IOO95Vn
         iikFZYSnPHK2ol8rrKBuEuSMHWSPTbFgHLeLDLpYw28Uz6OTyIRWVnIZ7xegw8jEPDHu
         mLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJ3WsqzV88jZeBrtNtbHshX9+SMk4OfQVS0NDAYSk5M=;
        b=hjKyHpDVmiuqGCXIxwAyWkXSF1ywjxc/HS/luXpYt4WsOzu2k9rQIx/KpJKdiXg7TL
         VvQwmcfq/675DKJ5hxNWkYnnnw9Y5z/Lcd1NBn+akBCgHz8AHzrbc6BgunF+RVhNhnMU
         kTcBdw3/4H0PAcRuBVVGyRH5APS+A8j3IAqMbdM+Tc4Els6NEqaJssvpYSfJobOIX6Je
         5/oauoWXlhpjhNXTQxiH9WxMTbQ5Ep0Bu7bSi7Db7Q7Uz65Ym2d9M2qYU3hL4dZ3Er7s
         eqCCFEjjGYsbZYvipY64pjgxDgK6p9cUtaKagN9Yad8uF0mXzasbI0GmNtY6jWkvQKrw
         f1pA==
X-Gm-Message-State: AOAM533T+h1DwGcx0prMdKC2DH8BKwwNUeXIgSvnGEDliLkN+YHCg3h0
        v3sW/LF60IyohtD3nfKV6/xfGA==
X-Google-Smtp-Source: ABdhPJwcG6NbCfHGeaI3mvX53n6oDOAWWw7K1e7T49McJk05ziFGVanaFejsdXEhyF34vnSIjT/hfw==
X-Received: by 2002:a63:1c66:: with SMTP id c38mr545600pgm.286.1629157096078;
        Mon, 16 Aug 2021 16:38:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:aa0c:5f92:878f:e03a])
        by smtp.gmail.com with ESMTPSA id 26sm284971pgx.72.2021.08.16.16.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 16:38:15 -0700 (PDT)
Date:   Mon, 16 Aug 2021 16:38:08 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/6] hook: run a list of hooks instead
Message-ID: <YRr24PJHlyFg7n/W@google.com>
References: <20210812004258.74318-1-emilyshaffer@google.com>
 <20210812004258.74318-2-emilyshaffer@google.com>
 <xmqqbl6260eo.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbl6260eo.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 10:25:03AM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > To prepare for multihook support, teach hook.[hc] to take a list of
> > hooks at run_hooks and run_found_hooks. Right now the list is always one
> > entry, but in the future we will allow users to supply more than one
> > executable for a single hook event.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  builtin/hook.c |  14 ++++---
> >  hook.c         | 103 +++++++++++++++++++++++++++++++++++--------------
> >  hook.h         |  16 +++++++-
> >  3 files changed, 96 insertions(+), 37 deletions(-)
> >
> > diff --git a/builtin/hook.c b/builtin/hook.c
> > index 5eb7cf73a4..4d39c9e75e 100644
> > --- a/builtin/hook.c
> > +++ b/builtin/hook.c
> > @@ -25,7 +25,8 @@ static int run(int argc, const char **argv, const char *prefix)
> >  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> >  	int ignore_missing = 0;
> >  	const char *hook_name;
> > -	const char *hook_path;
> > +	struct list_head *hooks;
> > +
> 
> Natural.  We used to use the path to the hook because we were
> expecting only one. We now use the name to find a list of hooks.
> 
> All the caller sees is just list_head without any direct visibility
> into it, which feels like a great abstraction.  Presumably everything
> will go through the API functions taking this opaque "list of hooks"
> thing (or "the first one in the list" if the API function does not
> iterate over it, perhaps?).

Hum, I guess that in a later patch builtin/hook.c does learn to take
apart the list_head into a 'struct hook' to print the output of 'git
hook list'. I haven't read your review of that patch yet though.

> > diff --git a/hook.c b/hook.c
> > index ee20b2e365..80e150548c 100644
> > --- a/hook.c
> > +++ b/hook.c
> > @@ -4,6 +4,28 @@
> >  #include "hook-list.h"
> >  #include "config.h"
> >  
> > +static void free_hook(struct hook *ptr)
> > +{
> > +	if (ptr) {
> > +		free(ptr->feed_pipe_cb_data);
> > +	}
> 
> Lose the extra {}, as we do not do more than the above free() even
> at the end of the series?

ACK

> 
> > +struct list_head* hook_list(const char* hookname)
> 
> Shift both of the asterisks; our asterisks do not stick to the type
> but to the identifier.

ACK

> 
> > +{
> > +	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> > +
> > +	INIT_LIST_HEAD(hook_head);
> > +
> > +	if (!hookname)
> > +		return NULL;
> 
> Checking for invalid hookname first would avoid leaking hook_head,
> no?  The caller of hook_list() we saw earlier immediately calls
> list_empty() which will segfault.  The caller need to be tightened,
> but I wonder if it would be a programmer's error to pass a NULL
> hookname to this function.  If so, this can simply be a BUG() and
> the earlier allocation and initialization of hook_head can stay
> where they are.  Otherwise, the caller should see if this returns a
> NULL.

Ah, good point. I think this makes sense to BUG().

> 
> > +	if (have_git_dir()) {
> > +		const char *hook_path = find_hook(hookname);
> > +
> > +		/* Add the hook from the hookdir */
> > +		if (hook_path) {
> > +			struct hook *to_add = xmalloc(sizeof(*to_add));
> > +			to_add->hook_path = hook_path;
> > +			to_add->feed_pipe_cb_data = NULL;
> > +			list_add_tail(&to_add->list, hook_head);
> > +		}
> > +	}
> 
> Calling this function to grab a list of hooks when we are not in any
> repository is not an error but just we get "there is nothing to
> run".  Does the design give us a more useful behaviour, compared to
> alternatives like "you have to be in a repository or calling this
> function is an error"?

Later we enable calling hook_list without a gitdir, in patch 6
(https://lore.kernel.org/git/20210812004258.74318-7-emilyshaffer%40google.com).
So maybe the behavior as it is now is premature?

But leaving the hook list empty means we can behave gracefully if
anybody is calling a hook without necessarily being sure they have
gitdir. I would need to audit callsites to check if they are checking
whether they have one or not. I think in most cases they probably are
checking that.

> 
> Not an objection wrapped in a rhetorical question, but a genuine
> question.  "It would help this and that usecase" would be an ideal
> answer, "We could do either way, but we happened to have written the
> code this way first, and at the end of the series we did not see any
> practical downsides" would also be a great answer.

The main use case, today, for letting this work nicely even outside of
a gitdir, is sendemail-validate hook. But mostly, I was thinking that
when we're freed from dependence on .git/hooks/, there's no reason to
disallow out-of-repo hooks in case someone wants to add a new one in the
future - for example to 'git maintenance' daemon runs.

> 
> > +	return hook_head;
> > +}
> > +
> 
> > +/*
> > + * Provides a linked list of 'struct hook' detailing commands which should run
> > + * in response to the 'hookname' event, in execution order.
> > + */
> > +struct list_head* hook_list(const char *hookname);
> 
> struct list_head *hook_list(const char *hookname);
ACK

Thanks for the thoughts.
 - Emily
