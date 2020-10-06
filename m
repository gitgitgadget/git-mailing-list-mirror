Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0FAC4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D3220B80
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFeJEPwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgJFW5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJFW5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:57:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B0FC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 15:57:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x5so23423plo.6
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1W1cZMzm8tzG5KBhs3s8/qvoR2hE2wtrqhBjOb/fbzE=;
        b=oFeJEPwyHzsDLFgwZwy4Rf5wXUxlh1bqlm/EuB46hx1k5lNm2SADd7czLD78V2VcDh
         pDRrmoM5IFC3qZRoC7bVYe4A+Dyrk32Hy5ioM8+c6yOIROtU1doMIQtJ3n6cTDbdBJD/
         zoZ1+NCO59olXQHmZruz8ptHmKRQ4dnSTDAkdOKeRBdfDgo0BqxS8lFxbMXHBNTVuKiY
         AuKUEmmpr+JhbcnSJR/Uqfhdg2pD4wFIUF0qCdsxPRBrW9HohnGHQtQPRwPdzlpn1H3M
         3YTepMDspMQ0FwIKwmlm/6tvtsYV1exe1Lxq4Ibd76BU5/ptKO6Pb4nGS81h+wh0xiKl
         /HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1W1cZMzm8tzG5KBhs3s8/qvoR2hE2wtrqhBjOb/fbzE=;
        b=aNT6HZbOgPOhU1G6v+O0C4iVkQnlVPe6hxIzRUp6s7vVUYc6Lli4AE7vYEE9tN9eLD
         lxK3a0g84G6QY5Mhz9Io3vbY9+ij/7H3pgI5huelCA6ZzACxPmLpdJDHjerkMfeLlqxe
         p/Ri/8AZ+U+OqZ54yAejoclsSUsRFQ5TAe8+iM9cNzhPhy/2Z6pUxXCU+ukjyvYJkL5h
         61IKt/BraMtqOv/7mh6yK81i74pNW5LUSV9PaoYJ+ZlaoW/mbMrBXzLheVjoOpNPonLV
         UoruD93E6rxMtXt3+7ibNzwOxcf7mL5oE/EjSGVEK018x1jLBnQygu+4UncFna4E37yq
         SjQw==
X-Gm-Message-State: AOAM5321RBwk1ttchemXVOilNfg/0+uzrMfE+BTrhPGPIsjSMu0TmyDx
        0WHO9/G3scj7bon7eAmAZxWEhPGP9vMyfA==
X-Google-Smtp-Source: ABdhPJzORml14YrZGHq42kQp2XY8jlhiV3NvUMyiyW+wItn1jI7unnhXf6Q6UFyPG1Xg5p/+u0B65w==
X-Received: by 2002:a17:902:aa0c:b029:d3:8087:c88d with SMTP id be12-20020a170902aa0cb02900d38087c88dmr312518plb.41.1602025037722;
        Tue, 06 Oct 2020 15:57:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id g4sm244371pgj.15.2020.10.06.15.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:57:17 -0700 (PDT)
Date:   Tue, 6 Oct 2020 15:57:12 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 6/9] hook: add 'run' subcommand
Message-ID: <20201006225712.GM331156@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-7-emilyshaffer@google.com>
 <20201005233903.GD1393696@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005233903.GD1393696@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 04:39:03PM -0700, Jonathan Nieder wrote:
> 
> Hi,
> 
> Emily Shaffer wrote:
> 
> > In order to enable hooks to be run as an external process, by a
> > standalone Git command, or by tools which wrap Git, provide an external
> > means to run all configured hook commands for a given hook event.
> 
> Exciting!
> 
> I would even be tempted to put this earlier in the series: providing a
> "git hook run" command that only supports legacy hooks and then
> improving it from there to support config-based hooks.  This ordering is
> also fine, though.

Oh, interesting! I sort of wish I had started with that ordering... but
now it seems a little unwieldy to switch. I'd probably want to do 100%
of the run_hook_(ve|le) conversions first, in that case, and delete the
old hook API. But at this point I think it would be a pretty large
amount of overhead to switch.

> 
> [...]
> > ---
> >  builtin/hook.c                | 30 ++++++++++++++++++++
> >  hook.c                        | 52 ++++++++++++++++++++++++++++++++---
> >  hook.h                        |  3 ++
> >  t/t1360-config-based-hooks.sh | 28 +++++++++++++++++++
> >  4 files changed, 109 insertions(+), 4 deletions(-)
> 
> Needs docs.

Done

> 
> [...]
> > --- a/builtin/hook.c
> > +++ b/builtin/hook.c
> > @@ -5,9 +5,11 @@
> [...]
> > +static int run(int argc, const char **argv, const char *prefix)
> > +{
> > +	struct strbuf hookname = STRBUF_INIT;
> > +	struct strvec envs = STRVEC_INIT;
> > +	struct strvec args = STRVEC_INIT;
> > +
> > +	struct option run_options[] = {
> > +		OPT_STRVEC('e', "env", &envs, N_("var"),
> > +			   N_("environment variables for hook to use")),
> > +		OPT_STRVEC('a', "arg", &args, N_("args"),
> > +			   N_("argument to pass to hook")),
> > +		OPT_END(),
> > +	};
> > +
> > +	argc = parse_options(argc, argv, prefix, run_options,
> > +			     builtin_hook_usage, 0);
> > +
> > +	if (argc < 1)
> > +		usage_msg_opt(_("a hookname must be provided to operate on."),
> > +			      builtin_hook_usage, run_options);
> 
> Error message nit: what does it mean to operate on a hookname?
> 
> Perhaps this should allude to the usage string?
> 
> 	usage_msg_opt(_("missing <hookname> parameter"), ...);
> 
> Or to match the conversational approach of commands like "clone":
> 
> 	usage_msg_opt(_("You must specify a hook to run."), ...);
> 

Yeah, I like this one. I noticed the same error (untranslated, even!) is
used for list, so I'll fix that too.

> [...]
> > --- a/hook.c
> > +++ b/hook.c
> > @@ -2,6 +2,7 @@
> >  
> >  #include "hook.h"
> >  #include "config.h"
> > +#include "run-command.h"
> >  
> >  /*
> >   * NEEDSWORK: a stateful hook_head means we can't run two hook events in the
> > @@ -21,13 +22,15 @@ void free_hook(struct hook *ptr)
> >  	}
> >  }
> >  
> > -static void emplace_hook(struct list_head *pos, const char *command)
> > +static void emplace_hook(struct list_head *pos, const char *command, int quoted)
> >  {
> >  	struct hook *to_add = malloc(sizeof(struct hook));
> >  	to_add->origin = current_config_scope();
> >  	strbuf_init(&to_add->command, 0);
> > -	/* even with use_shell, run_command() needs quotes */
> > -	strbuf_addf(&to_add->command, "'%s'", command);
> > +	if (quoted)
> > +		strbuf_addf(&to_add->command, "'%s'", command);
> > +	else
> > +		strbuf_addstr(&to_add->command, command);
> >  
> >  	list_add_tail(&to_add->list, pos);
> >  }
> 
> This would need to use sq_quote_* to be safe, but we can do something
> simpler: if we accumulate parameters in an argv_array passed to
> run_command, then they will be safely passed to the shell without
> triggering expansion.

Thanks. I'll do that - no point in duplicating the work :)

 - Emily



