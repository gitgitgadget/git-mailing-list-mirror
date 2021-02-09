Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAF8C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B1C64E3B
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhBJAJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbhBIWG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:06:57 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212FCC08EC63
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 14:05:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cl8so2367949pjb.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BbmNRRduJIbc7Rowk6w7GHBkwu3UWeCN1Tj1gG2O0ag=;
        b=MjSNSN1z6m2qVNS7spe5uqJX6EfeiAVPv8izhfUYDdvwm/DMU1WNz0dgVgZqQfEXDP
         8gFpj3trDrhoV9QdQ4aKz1s2crAv/sr8+QYclCHoM1gY9caFT8sz0IENczJycz/AMNrw
         saY98RwKRiBOSX/LU3HT8f79Agjui9/48XRqSO1JYWxmqp6LapOQrKE5vA9xoO8RxFGn
         x1vKbZEB1fxAkgCn90ZOjoH86q/Au9qi8fxwwaOY8IqfCwpRHF6D8ZCiBEkrE4oBFTva
         30zbkQGCWLVhmqyvtRVBFyY85mRvxn0Bjpm/uP8DAo5fCvD/BvTquXl+bEFZqA1hkLqj
         X5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BbmNRRduJIbc7Rowk6w7GHBkwu3UWeCN1Tj1gG2O0ag=;
        b=lSgl2L3x2/VOoJYWqEhAtEPDCVbAKx8WEsCNKjWi43FSU5T5LsNmDlXxI6XYbp+w08
         mhPjQxT7Q/5Q2az44JVGDsG0+RJ08RnW578k90jrdFRP8QUvKM03uT5zQwxTt/GbzjBw
         PTTSlPjgwU9Cs9o9MkeBnUZxzERD7RTUDSyfzI1U4KNEy/XG3TJBpzOVgxn0Qv0zkyg4
         T6bD+Lk6twaK8Mo0xypawvdrn3ZA9laYXFOkoCQ8rA6CTL0CaKgaAsZ047eZ9okuMxJH
         jf47giWs7J+ybPIZcpsSmAjHQ35v/j81hb8ZE1rRWwm37+fO9jccILxMdx/054XSwskX
         CFpQ==
X-Gm-Message-State: AOAM5312AlqIh4QGyHhQaox8g6QLuIgrsSR4idPziY2KfvuBFnxqUQl/
        hpdM8G2k671RJs662+rLi6SkDw==
X-Google-Smtp-Source: ABdhPJyS5Cq6QsYGUhPpXS8997XLMUNNmtsOB1Grd+LjAYh6q/FodvZsp11cvMhMsnkjB5f25hRPFg==
X-Received: by 2002:a17:90b:17cb:: with SMTP id me11mr14885pjb.64.1612908352533;
        Tue, 09 Feb 2021 14:05:52 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:7413:906e:c6f8:81a1])
        by smtp.gmail.com with ESMTPSA id np7sm50221pjb.10.2021.02.09.14.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:05:50 -0800 (PST)
Date:   Tue, 9 Feb 2021 14:05:45 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 04/17] hook: include hookdir hook in list
Message-ID: <YCMHOeLqESHokPZL@google.com>
References: <20201222000220.1491091-5-emilyshaffer@google.com>
 <20210131032022.1018820-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131032022.1018820-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 07:20:22PM -0800, Jonathan Tan wrote:
> 
> > Historically, hooks are declared by placing an executable into
> > $GIT_DIR/hooks/$HOOKNAME (or $HOOKDIR/$HOOKNAME). Although hooks taken
> > from the config are more featureful than hooks placed in the $HOOKDIR,
> > those hooks should not stop working for users who already have them.
> 
> Maybe explicitly add that we're listing them in the list with a "hookdir:"
> prefix.

Sure.

> 
> > Legacy hooks should be run directly, not in shell. We know that they are
> > a path to an executable, not a oneliner script - and running them
> > directly takes care of path quoting concerns for us for free.
> 
> Not sure what this paragraph is doing here.

Yep, this is an artifact of the review process (explaining why I didn't
do something weird, which I did in an earlier version, but now it
doesn't make sense to mention it at all). Deleted.

> 
> > diff --git a/builtin/hook.c b/builtin/hook.c
> > index 4d36de52f8..a0013ae4d7 100644
> > --- a/builtin/hook.c
> > +++ b/builtin/hook.c
> > @@ -16,6 +16,7 @@ static int list(int argc, const char **argv, const char *prefix)
> >  	struct list_head *head, *pos;
> >  	struct hook *item;
> >  	struct strbuf hookname = STRBUF_INIT;
> > +	struct strbuf hookdir_annotation = STRBUF_INIT;
> 
> Right now this is never set? Maybe hold off on adding this until we set
> something.

Yeah, that makes sense. Will do.

> 
> > @@ -110,6 +113,18 @@ struct list_head* hook_list(const struct strbuf* hookname)
> >  
> >  	git_config(hook_config_lookup, (void*)&cb_data);
> >  
> > +	if (have_git_dir())
> > +		legacy_hook_path = find_hook(hookname->buf);
> > +
> > +	/* Unconditionally add legacy hook, but annotate it. */
> > +	if (legacy_hook_path) {
> > +		struct hook *legacy_hook;
> > +
> > +		append_or_move_hook(hook_head, absolute_path(legacy_hook_path));
> 
> Both find_hook() and absolute_path() use static buffers to hold their
> return values, which makes me a bit nervous. Perhaps put them all under
> the same "if (have_git_dir())" so that it's clearer that we're not
> supposed to insert code arbitrarily between their invocation and their
> usage.

Oh, that's a cool way to indicate that. Thanks, I did that, and learned
something new!

> 
> > diff --git a/hook.h b/hook.h
> > index 8ffc4f14b6..5750634c83 100644
> > --- a/hook.h
> > +++ b/hook.h
> > @@ -12,6 +12,7 @@ struct hook
> >  	enum config_scope origin;
> >  	/* The literal command to run. */
> >  	struct strbuf command;
> > +	int from_hookdir;
> 
> unsigned from_hookdir : 1?

Sure. It doesn't make a difference now but I see that would be nice for
futureproofing.

> 
> The tests look good.

Thanks.
