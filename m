Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F4EC41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 19:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC490206CB
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 19:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bp85DqSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgJFTGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFTGW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 15:06:22 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F886C061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 12:06:22 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b26so6242683pff.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M2BosvCX9iJhj/o5+Nlr7dPVjGXtE1PXnUqB/UHx22o=;
        b=bp85DqSvfYWJ9RwWqHFidjoz34aqViTbhirihLV0eACbnlLgqH+6Xya0t9zQzT8N9g
         2aYkC/i30H0QvIHctYhaHhsL2oR2M+bWbI+X464YIKU8PkmIagCy0YETuLr/clwSdq5y
         ZwU337a0ezH0OlK/U2530lIj9/YBZywBRqUuSvp9X0cXZzUvNctQIYCX4Ey2bq9kJF2A
         xskxx0aIpJC5IIu80xrvxPmmdGxg4R30pqbw+L4skK7e0viYrwa9P9DHcw/QaaJnV73d
         9SA74b2OiKATRNtp89ZUU+ykJmMIrIE3fkdJVNgshV/KhJyru9x/zu3F2ItClZ3UwLfQ
         oHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2BosvCX9iJhj/o5+Nlr7dPVjGXtE1PXnUqB/UHx22o=;
        b=rZvSy0U9D295AeU+8W/0aPVE2DvQpRr/f+Ep4Y5lYDYtsh+O4qNFptz4+gmBo2Ljxx
         L3JpcDNLh+1mdfa1jZgc54Kqh6D8f1Xchj6zMQNeMpfSzdZY/K8ginjPiFelCvU/nHxv
         P/oEGxuyA8AQhbKuCUM5rx1oQc2dicxeDugVvhXziiVZCFETgKwr8y7PYdIYAKMe2P4G
         AX1dn4PX4yHQur1gcJj8pvDA7StUAuz1/N9KWj65k6MeLjJlr/+Tmai3pRy/Br81hgqI
         yfNm2JaAK8TvFDUkWf0516iP6Wmh4C0TRURdUdcJroaHio2KuU1j5L3+R4hvLa5vK4K6
         Chhg==
X-Gm-Message-State: AOAM530tWavqi5gSs1z1ZthMgZaot+WB+aj4ZKeBzXjDi8YV4tpKQECW
        uEGJbfEtuPDmk5OO21QyR7Ucmg==
X-Google-Smtp-Source: ABdhPJxZABEQgQ1g/eqG+Ni5x0XvnEGscVzbeup0rssSnU8xe5j53XgQSOXj6w8MUzRlnfG6w4z4LQ==
X-Received: by 2002:a63:f60f:: with SMTP id m15mr5082552pgh.298.1602011181452;
        Tue, 06 Oct 2020 12:06:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id z13sm3616613pjn.51.2020.10.06.12.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:06:20 -0700 (PDT)
Date:   Tue, 6 Oct 2020 12:06:16 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 2/9] hook: scaffolding for git-hook subcommand
Message-ID: <20201006190616.GI331156@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-3-emilyshaffer@google.com>
 <20201005232418.GA1393696@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005232418.GA1393696@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 04:24:18PM -0700, Jonathan Nieder wrote:
> 
> Hi,
> 
> Emily Shaffer wrote:
> 
> > Introduce infrastructure for a new subcommand, git-hook, which will be
> > used to ease config-based hook management. This command will handle
> > parsing configs to compose a list of hooks to run for a given event, as
> > well as adding or modifying hook configs in an interactive fashion.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  .gitignore                    |  1 +
> >  Documentation/git-hook.txt    | 19 +++++++++++++++++++
> >  Makefile                      |  1 +
> >  builtin.h                     |  1 +
> >  builtin/hook.c                | 21 +++++++++++++++++++++
> >  git.c                         |  1 +
> >  t/t1360-config-based-hooks.sh | 11 +++++++++++
> >  7 files changed, 55 insertions(+)
> >  create mode 100644 Documentation/git-hook.txt
> >  create mode 100644 builtin/hook.c
> >  create mode 100755 t/t1360-config-based-hooks.sh
> 
> optional: I could imagine this being squashed into patch 3 --- that way,
> the command has functionality as soon as it exists.  Alternatively:

I would prefer to leave it on its own. Managing changes like
builtin<->standalone or even the one you mentioned below about
RUN_SETUP_GENTLY is somewhat easier to manage when they aren't in the
same patch as the business logic, IMO.

> 
> [...]
> > --- /dev/null
> > +++ b/Documentation/git-hook.txt
> > @@ -0,0 +1,19 @@
> > +git-hook(1)
> > +===========
> > +
> > +NAME
> > +----
> > +git-hook - Manage configured hooks
> > +
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git hook'
> > +
> > +DESCRIPTION
> > +-----------
> > +You can list, add, and modify hooks with this command.
> 
> This could say something like "This is a placeholder command that will
> gain functionality in subsequent patches" to make the current state
> clear.

Done.

> 
> [...]
> > --- a/git.c
> > +++ b/git.c
> > @@ -519,6 +519,7 @@ static struct cmd_struct commands[] = {
> >  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
> >  	{ "hash-object", cmd_hash_object },
> >  	{ "help", cmd_help },
> > +	{ "hook", cmd_hook, RUN_SETUP },
> 
> This makes the command require that it run within a git repository,
> but I can imagine wanting to list hooks outside of any.  Should it use
> RUN_SETUP_GENTLY instead?

Nice catch. I'll add a test to the list patch to that effect also.
