Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF10C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 09:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ABAE20786
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 09:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ5zIB3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHZJP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgHZJP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 05:15:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09290C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 02:15:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so751648pgf.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6XKKcqZmq/P9vEq2VrqAB1hBrOhZysuESBZaR9tzk+o=;
        b=cZ5zIB3AyIhCMdD0eNFvtZlEn5mBdJSQ7kj0eEYZm8MaWA7FZDXNM6Ef1yGXpkYk1I
         mVXRlpxOjG6+gB6jnrfihgT/qTFlocJJEJ9X93uqdDwxRPd9gP0R7XrMgljgFZnIdbHi
         CnjoF/G2254ezwKiaou5ZNvP/Jk6vKrynvy4fIfoqLemlF6n4qirX6yJxYZbqbuxOB/3
         wUwGfHpO9+Z1/RgotnMX9EZMeSjbVMEOvUoUJNn0+evGIoUH6a87nIUuKx1H5RPq1hta
         esMikKM1/zaOKprxrGKVUhQjFQEi3skDr2+Qc9CBOkkhWkV3hl5V4m6tGRj4eAlELj8q
         hk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XKKcqZmq/P9vEq2VrqAB1hBrOhZysuESBZaR9tzk+o=;
        b=coV2P4ymm5AdnEBNK745I2tv9otJvbq8o+kZ4n6Ajp/Q8U4qE3mAogIZgvMdF7gYmh
         u0o28IkfAJBgpM9990STV58ZlY8tl1qEBiG6k2redF3DeYWJaVZag0+B+bnPfEnI6/QJ
         vVKEgFoXEhJk0ztQ9EdlRzHWYpsD1KhZaquNs+JQ/sOuJSZ9+a+mHtlRTrp5ede8vzfV
         zNHhHW6hdsVSoZ67WxE2TQ67Jsu6f4eeeuXf6juEXOa0cZ2qJbRTJiU3EviCe1B8GeFU
         neGLusmRW9bjPX2bP5OA/80QbujUM9M52T//WVkvQAQHRAsBcAY6ox0+pWzbKhVzVdj5
         jFkg==
X-Gm-Message-State: AOAM532AvCmHMdDc6f1cfZwJ9eL59VwlM9hojRt+AZ2b+qQvnqW4RGbN
        5E7C8VhzTLyJr347Lit632Q=
X-Google-Smtp-Source: ABdhPJwKK1UzKR0F3pspORlGkDFV7WXtXFgKfmF06nK2B6wxWWTavfMDkkZTy97apRMsoklqpSqLpQ==
X-Received: by 2002:a63:c30e:: with SMTP id c14mr9670728pgd.225.1598433346431;
        Wed, 26 Aug 2020 02:15:46 -0700 (PDT)
Received: from konoha ([106.210.38.198])
        by smtp.gmail.com with ESMTPSA id s6sm1511519pju.51.2020.08.26.02.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:15:45 -0700 (PDT)
Date:   Wed, 26 Aug 2020 14:45:02 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, liu.denton@gmail.com,
        kaartic.sivaraam@gmail.com
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from
 shell to C
Message-ID: <20200826091502.GA29471@konoha>
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
 <xmqq8se36gev.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8se36gev.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08 11:35, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > 	if test -z "$force"
> > 	then
> > 		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
> > 		die "$(eval_gettext "'\$sm_path' already exists in the index")"
> > 	else
> > 		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
> > 		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
> > 	fi
> 
> Hmph.  So,
> 
>  - if we are not being 'force'd, we see if there is anything in the
>    index for the path and error out, whether it is a gitlink or not.
> 
>  - if there is 'force' option, we see what the given path is in the
>    index, and if it is already a gitlink, then die.  That sort of
>    makes sense, as long as the remainder of the code deals with the
>    path that is not a submodule in a sensible way.
> 
> > This is what I have done in C:
> >
> > 	if (!force) {
> > 		if (is_directory(path) && submodule_from_path(the_repository, &null_oid, path))
> > 			die(_("'%s' already exists in the index"), path);
> 
> The shell version would error out with anything in the index, so I'd
> expect that a faithful conversion would not call is_directory() nor
> submodule_from_path() at all---it would just look path up in the_index
> and complains if anything is found.  For example, the quoted part in
> the original above is what gives the error message when I do
> 
> 	$ git submodule add ./Makefile
> 	'Makefile' already exists in the index.
> 
> I think.  And the above code won't trigger the "already exists" at
> all because 'path' is not a directory.

Alright. That is correct. I tried to use a multitude of functions but
did not find luck with any of them. The functions I tried:

    - index_path() to check if the path is in the index. For some
      reason, it switched to the 'default' case and return the
      'unsupported file type' error.

    - A combination of doing an OR with index_file_exists() and
      index_dir_exists(). Still no luck. t7406.43 fails.

    - Using index_name_pos() along with the above two functions. Again a
      failure in the same test.

I feel that index_name_pos() should suffice this task but it fails in
t7406.43. The SM is in index since 'git ls-files --error-unmatch s1'
does return 's1' (s1 is the submodule). What am I missing here?

> > 	} else {
> > 		int err;
> > 		if (index_name_pos(&the_index, path, strlen(path)) >= 0 &&
> > 		    !is_submodule_populated_gently(path, &err))
> > 			die(_("'%s' already exists in the index and is not a "
> > 			      "submodule"), path);
>
> Likewise.  The above does much more than the original.
>
> The original was checking if the found cache entry has 160000 mode
> bit, so the second test would not be is_submodule_populated_gently()
> but more like !S_ISGITLINK(ce->ce_mode)

Using this results in failure of t7506.[33-40]. I implemented this in
two ways:

    1. Use stat() to initialise the stat st corresponding to the 'path'.
       Then do a '!S_ISGITLINK(st.st_mode)'.

    2. Run a for loop:
		for (i = 0; i < active_nr; i++) {
		const struct cache_entry *ce = active_cache[i];

		if (index_name_pos(&the_index, path, strlen(path)) >= 0 &&
		    !S_ISGITLINK(ce->ce_mode))
			die(_("'%s' already exists in the index and is not a "
			      "submodule"), path);
        }

        Still the tests failed. What is meant by 'active_nr' BTW? I am
        not aware of this term.

Where am I going wrong for both the if-cases?

