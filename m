Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8421CC433E1
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554292067D
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="JLU+79XW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGYBdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgGYBdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 21:33:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9B3C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:33:20 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w9so8267992qts.6
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TRQnnBRCg1beyUM4hXB8SzXktj322D/BnMZP8H0miDQ=;
        b=JLU+79XWvw3udIt7p4oAFU77Q31x0sp3veKqmotc5ZeHYhF9A+oLbbibl2pLXPPhkX
         N9tsrgePvbpIzW9+hVmkcx4ci5wMagWNlnVqXzfTNAFx9Dye5DgP2ziGQDRck9yDwM/3
         f2x9SaUoX3S8+7TV0DhJSGZr1E0r/rRw69jvsHdhfVN7sOvOnOkvLbu1/JnchGahAoh1
         lpnQ3QFo6ZA8ZKmFWmOHqbc+fOg7tDXkhNnK/hdwCYXNyvAMRu/Opek/7GZF7bPlytNZ
         YXQOtz+UMN3cUYyNgOz+mj+UX2JfMN6LWS3dMZM3wlPPXJ7UbnRuzNJgozMHJ4PDNCUa
         OCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TRQnnBRCg1beyUM4hXB8SzXktj322D/BnMZP8H0miDQ=;
        b=Xitn4Y/MjpfHmr0tcXKrzISwSgjnoMd5+VyDVa9QxtscyeSLI/ZY+jjHVSxZSdSuVI
         HIIl5i/BzGX0hOPtLJ8Z6L4MRLFrnU47xGFDAkCz2eK2zgI+6GV/VIXt9MEdJFGp4Sf1
         tE+hXMOH/GJlAagN6sjjCiFLDH9sVyRbn2ORLzU8gikkWABAdw7P8lC/1OvwtpkbutiC
         XUsv4HqJHrqccnQfWTOtUUiuF6dPJNC+V1wLRJDUuVsVgsjedLwRaChCtcxJOBRESxJ5
         0HRc7NrjFVs8le6E4aF66zqi4F06AYjnbcyw65/l+9IXM3e414yl7a2ctFxLRygTywzY
         iL2A==
X-Gm-Message-State: AOAM530uAPULyMMzGML537ckG6CYMoxs8ciACJ1vZRSqjimqnDW7cRjr
        kmG5pfBoCdFj/ZdWTPY+/yngZQ==
X-Google-Smtp-Source: ABdhPJxCIKU6hU1hlKkGgh3fa31UgLEfXRWP7SpEcc7/sQ+hw6li9xW4aDdl502ZREexnHu1r6oLig==
X-Received: by 2002:ac8:4f46:: with SMTP id i6mr12349279qtw.186.1595640799789;
        Fri, 24 Jul 2020 18:33:19 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:348b:af05:525a:6ad])
        by smtp.gmail.com with ESMTPSA id a8sm3526641qth.69.2020.07.24.18.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 18:33:19 -0700 (PDT)
Date:   Fri, 24 Jul 2020 21:33:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 03/18] maintenance: replace run_auto_gc()
Message-ID: <20200725013317.GB35171@syl.lan>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <f164d1a0b4363eb6eb174e90e88211829f8a1d55.1595527000.git.gitgitgadget@gmail.com>
 <xmqqblk6q8ws.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblk6q8ws.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 01:21:55PM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +--[no-]maintenance::
> >  --[no-]auto-gc::
> > -	Run `git gc --auto` at the end to perform garbage collection
> > -	if needed. This is enabled by default.
> > +	Run `git maintenance run --auto` at the end to perform garbage
> > +	collection if needed. This is enabled by default.
>
> Shouldn't the new synonym be called --auto-maintenance or an
> abbreviation thereof?  It is not like we will run the full
> maintenance suite when "--no-maintenance" is omitted, which
> certainly is not the impression we want to give our readers.
>
> >  These objects may be removed by normal Git operations (such as `git commit`)
> > -which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
> > -If these objects are removed and were referenced by the cloned repository,
> > -then the cloned repository will become corrupt.
> > +which automatically call `git maintenance run --auto` and `git gc --auto`.
>
> Hmph.  Perhaps the picture may change in the end of the series but I
> got an impression that "gc --auto" would eventually become just part
> of "maintenance --auto" and the users won't have to be even aware of
> its existence?  Wouldn't we rather want to say something like
>
> 	--[no-]auto-maintenance::
> 	--[no-]auto-gc::
>                 Run `git maintenance run --auto` at the end to perform
>                 garbage collection if needed (`--[no-]auto-gc` is a
>                 synonym).  This is enabled by default.
>
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 82ac4be8a5..49a4d727d4 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -196,8 +196,10 @@ static struct option builtin_fetch_options[] = {
> >  	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
> >  			N_("report that we have only objects reachable from this object")),
> >  	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
>
> > +	OPT_BOOL(0, "maintenance", &enable_auto_gc,
> > +		 N_("run 'maintenance --auto' after fetching")),
> >  	OPT_BOOL(0, "auto-gc", &enable_auto_gc,
> > +		 N_("run 'maintenance --auto' after fetching")),
>
> OK, so this is truly a backward-compatible synonym at this point.

I wouldn't be opposed to making the 'auto-gc' option an
'OPT_HIDDEN_BOOL', but I realize that users may not want to move as
quickly as that. Perhaps we should visit this in a couple of releases
(or perhaps you are getting to it in a later patch that I haven't read
yet).

> > diff --git a/run-command.c b/run-command.c
> > index 9b3a57d1e3..82ad241638 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -1865,14 +1865,17 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
> >  	return result;
> >  }
> >
> > -int run_auto_gc(int quiet)
> > +int run_auto_maintenance(int quiet)
> >  {
> >  	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
> >  	int status;
> >
> > -	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
> > +	argv_array_pushl(&argv_gc_auto, "maintenance", "run", "--auto", NULL);
> >  	if (quiet)
> >  		argv_array_push(&argv_gc_auto, "--quiet");
> > +	else
> > +		argv_array_push(&argv_gc_auto, "--no-quiet");
> > +
> >  	status = run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
> >  	argv_array_clear(&argv_gc_auto);
> >  	return status;
>
> Don't we want to replace all _gc_ with _maintenance_ in this
> function?  I think the first business before we can do so would be
> to rethink if spelling out "maintenance" fully in code is a good
> idea in the first space.  It would make names for variables,
> structures and fields unnecessarily long without contributing to
> ease of understanding an iota, and a easy-to-remember short-form or
> an abbreviation may be needed.  Using a short-form/abbreviation
> wouldn't worsen the end-user experience, and not the developer
> experience for that matter.
>
> If we choose "gc" as the short-hand, most of the change in this step
> would become unnecessary.  I also do not mind if we some other words
> or word-fragment (perhaps "maint"???) is chosen.

Yeah, writing out 'maintenance' every time in the code and in
command-line arguments is kind of a mouthful. I'm more willing to accept
that '--maintenance' is something that users would write or script
around, but 'maint' makes sense to me as a shorthand in the code.

I could go either way on calling the command-line flag '--maint',
though.

>
> > diff --git a/run-command.h b/run-command.h
> > index 191dfcdafe..d9a800e700 100644
> > --- a/run-command.h
> > +++ b/run-command.h
> > @@ -221,7 +221,7 @@ int run_hook_ve(const char *const *env, const char *name, va_list args);
> >  /*
> >   * Trigger an auto-gc
> >   */
> > -int run_auto_gc(int quiet);
> > +int run_auto_maintenance(int quiet);
> >
> >  #define RUN_COMMAND_NO_STDIN 1
> >  #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > index a66dbe0bde..9850ecde5d 100755
> > --- a/t/t5510-fetch.sh
> > +++ b/t/t5510-fetch.sh
> > @@ -919,7 +919,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
> >  		git config fetch.unpackLimit 1 &&
> >  		git config gc.autoPackLimit 1 &&
> >  		git config gc.autoDetach false &&
> > -		GIT_ASK_YESNO="$D/askyesno" git fetch >fetch.out 2>&1 &&
> > +		GIT_ASK_YESNO="$D/askyesno" git fetch --verbose >fetch.out 2>&1 &&
> >  		test_i18ngrep "Auto packing the repository" fetch.out &&
> >  		! grep "Should I try again" fetch.out
> >  	)

Thanks,
Taylor
