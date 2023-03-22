Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B789FC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 22:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCVWgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 18:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCVWgp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 18:36:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6710269
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 15:36:44 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y35so10349315pgl.4
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 15:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679524604;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8aml6ihDXpH09qYxP0yguQ5O/9BhYQSQbBCv51q1BA=;
        b=SMbUuo1QAHOfxa3EbuwtcT6p5rGDqaZd0dBbqCnu9RtPvUh/+YgzZehYhYAz8eEepq
         4M+pNFD3ZOapGp4aKEH0goc4dBXjeTPtrBe9x+MnQ4Amm71d7eIs0kRJmbt6m/QFP6u1
         YtHelME1jQz7sT4U+GH/0bwSd8lvobgmIL5ECYy/CS2DXh+3ci/MsqNQ3YKH6nmGrxHh
         JxX0j2WjZoNVWramyIT2tHhPCWXYg2ZwJv3eHpWhOu72np/PBTV5OHgfOnjBcHXLF6cg
         JtsPXnRZWrX0RXzjhbnyQwbsUL4VdUFg+Up+WU2R1kXN+E+O0k4kEdn/IuSXTyieRgcP
         6Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679524604;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+8aml6ihDXpH09qYxP0yguQ5O/9BhYQSQbBCv51q1BA=;
        b=R/uDhwFGO6tLkRl7ItBiNXjRCEfoSy5iHiLJYNRZLFn7POftQRS3+snPbddscOBm+l
         uzO3oZF5X3ZcmyGmV2unPzflA/O1nHn8ig2od6lDEPezs2+w48aYNyXSLQ/sH/OB6ckc
         BKpB0x67qHa448F1lGTSpUKJh+kuq5QUUUgVjeX0j3eY060l6phY0vlhaQR1atahOmwR
         GbIxoifnc458P0fR3e6hkbEIremGnDumSo6x5+E0oG35nz2SEhSN0PMPOPkWH+mO/ruW
         HOUBC7JmrrPGC6Z10i6p87WD66xlBS3Tu6KTXAxMVAanrgjo189g8HOuf5Nypc/2ujoV
         AS1A==
X-Gm-Message-State: AO0yUKVWjr/WHj6PhqGf0TfG0NmAepcnp5PqYHryO3TfTLQV/+9eitoZ
        gSiOpImnwEkbaDS32hDs4nmdzbR/3nY=
X-Google-Smtp-Source: AK7set/1fq0cFqc6qjTLzkWG1NR0vf1LIAxJ5LX951XVOfCAKr3OezbQQ2qGd8LYBtk74oP7uTe7DA==
X-Received: by 2002:a62:1955:0:b0:623:77f5:eeed with SMTP id 82-20020a621955000000b0062377f5eeedmr4497060pfz.25.1679524603958;
        Wed, 22 Mar 2023 15:36:43 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78e03000000b00593c1c5bd0esm6920752pfr.164.2023.03.22.15.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 15:36:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] bugreport: also print value of no_proxy envvar
References: <20230322173421.2243947-1-jonathantanmy@google.com>
Date:   Wed, 22 Mar 2023 15:36:43 -0700
In-Reply-To: <20230322173421.2243947-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 22 Mar 2023 10:34:21 -0700")
Message-ID: <xmqqsfdwbeh0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> At $DAYJOB, there was an issue that could have been diagnosed much more
> quickly had we known what the $no_proxy environment variable was set
> to. Print this value when the user runs "git bugreport". This is useful
> not only when a command that explicitly uses the network (e.g. fetch
> or clone) is run, but also in a partial clone (in which lazy fetches
> may occur).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Taking off the author's hat and putting on the reviewer's hat, I'm
> not so sure if this is the right approach, since $no_proxy might have
> information that the user doesn't want to share (especially since it
> could be used beyond the current repository, and even beyond Git), the
> user being informed that they can delete any lines notwithstanding.

How certain are you that the "git bugreport" process will see more
or less the same set of environment variables as the process that
runs "git" for real work for the same user?  The latter may have its
environment affected due to $CORP wrapper scripts, etc.

Or other environment variables like http_proxy may be causing harm
to the user's use of Git, and inspecting no_proxy alone may not give
you anything useful.  With devil's advocate hat on, I am tempted to
suggest another approach at the the total opposite of the spectrum:
dump everything in **environ and let the user edit out what ought to
be private.  Intelligent ones may even notice a fishy setting they
forgot about while trying to cull the report of these environment
variables ;-)

> Therefore I'm sending this patch as RFC.
> ---
>  builtin/bugreport.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 5bc254be80..c9dd817e70 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -12,6 +12,7 @@ static void get_system_info(struct strbuf *sys_info)
>  {
>  	struct utsname uname_info;
>  	char *shell = NULL;
> +	char *no_proxy = NULL;
>  
>  	/* get git version from native cmd */
>  	strbuf_addstr(sys_info, _("git version:\n"));
> @@ -39,6 +40,9 @@ static void get_system_info(struct strbuf *sys_info)
>  	shell = getenv("SHELL");
>  	strbuf_addf(sys_info, "$SHELL (typically, interactive shell): %s\n",
>  		    shell ? shell : "<unset>");
> +
> +	no_proxy = getenv("no_proxy");
> +	strbuf_addf(sys_info, "$no_proxy: %s\n", no_proxy ? no_proxy : "<unset>");
>  }
>  
>  static void get_populated_hooks(struct strbuf *hook_info, int nongit)
