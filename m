Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F49C433E7
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 13:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 049A320EDD
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 13:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe8Hs5rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHaNL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHaNLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 09:11:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC02C061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 06:04:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q3so2986693pls.11
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xhecWVwTg79GsngLXXeYS8ltRCLyqTfbV4XM2b48u54=;
        b=oe8Hs5rMVbSWz+3CVpXg2TEm6oD1Bnv2QtEeywaUMMLC7/BD94MNBCRuvgyM2Du2fK
         0kMgHPjZuJr9yzoK42u9azu7p8kuMCNfA42AQjH7o4rG1CwZcpdEbn/N9h6MfmiWzgK6
         G4Gj+/VoNKrPd8xwUCr9gXPzrGxoE69DTF8pThOSiTKViMxSiVAouTmoas+izlJ6zE2m
         vuUOeFHmohHp1JC4heZp5fRfOdMQjqfNUJz7vONrBg+NuO0/AcN7zfoe1kvJ1Hnpun89
         d4O+EMhrfqEnSlLECerIb+UMS3Lc0KPMACk5xUC1H7LF07XNebwktQ5LrgtO0qlDt89H
         Gt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xhecWVwTg79GsngLXXeYS8ltRCLyqTfbV4XM2b48u54=;
        b=bdGMTpG/W4WXL6kxFDaJ285W9qcwrJJ2pzv+XGTbZz4S+8LWzK0YxiPMCprJVXHogy
         C+NeoJwVq66OPsDjiDrTB8e57pQjZ79Ks3yHNYKHvg8tVn94F/LRv31QFauuHARgggH8
         M5A1k7rFCj2XrwLaSOnhBC3iE71b5jdtZxG5Uq4OnRQiy4FdoXqkshn8dN7fhFRfS6ZJ
         OQBPlsm9ITtVp2nVSGBI2ZfTDhDfs+sICI8BYDQMM2PAhinVBcOvE0q+A56PJc5RKZTY
         02gImRWA6u1JFpZpcAtxEhx6soNr+33e1Itz1ZtEwmPlt/NZVC167s/qFg8CccNIRdDw
         JcKg==
X-Gm-Message-State: AOAM5322hKcbmRSmkiHoI1yN9HGT05nDj1S//QF0Smby33cNFDsbTL80
        1j9ubU/Um1FYBKwSa0xR0TA3vlv6gpnpVQ==
X-Google-Smtp-Source: ABdhPJwoIMF7Jppu4kXdXs7PISwx0H6bmxewRKY++64qbq6g9GcPVA6t3XuhD/uAG6q1+f0n5d6EVg==
X-Received: by 2002:a17:90b:110a:: with SMTP id gi10mr1337048pjb.206.1598879096253;
        Mon, 31 Aug 2020 06:04:56 -0700 (PDT)
Received: from konoha ([116.72.196.122])
        by smtp.gmail.com with ESMTPSA id ih11sm3596717pjb.51.2020.08.31.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 06:04:55 -0700 (PDT)
Date:   Mon, 31 Aug 2020 18:34:48 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, liu.denton@gmail.com
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from
 shell to C
Message-ID: <20200831130448.GA119147@konoha>
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
 <xmqq8se36gev.fsf@gitster.c.googlers.com>
 <20200826091502.GA29471@konoha>
 <ce151a1408291bb0991ce89459e36ee13ccdfa52.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce151a1408291bb0991ce89459e36ee13ccdfa52.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/08 01:28, Kaartic Sivaraam wrote:
> On Wed, 2020-08-26 at 14:45 +0530, Shourya Shukla wrote:
> > On 24/08 11:35, Junio C Hamano wrote:
> > > Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> > > 
> > > The shell version would error out with anything in the index, so I'd
> > > expect that a faithful conversion would not call is_directory() nor
> > > submodule_from_path() at all---it would just look path up in the_index
> > > and complains if anything is found.  For example, the quoted part in
> > > the original above is what gives the error message when I do
> > > 
> > > 	$ git submodule add ./Makefile
> > > 	'Makefile' already exists in the index.
> > > 
> > > I think.  And the above code won't trigger the "already exists" at
> > > all because 'path' is not a directory.
> > 
> > Alright. That is correct. I tried to use a multitude of functions but
> > did not find luck with any of them. The functions I tried:
> > 
> 
> It would've been nice to see the actual code you tried so that it's
> easier for others to more easily identify if you're using the wrong
> function or using the correct function in the wrong way.

Yeah, that is my fault. I will tag along below.

> >     - index_path() to check if the path is in the index. For some
> >       reason, it switched to the 'default' case and return the
> >       'unsupported file type' error.
> > 
> >     - A combination of doing an OR with index_file_exists() and
> >       index_dir_exists(). Still no luck. t7406.43 fails.
> > 
> >     - Using index_name_pos() along with the above two functions. Again a
> >       failure in the same test.
> > 
> > I feel that index_name_pos() should suffice this task but it fails in
> > t7406.43. The SM is in index since 'git ls-files --error-unmatch s1'
> > does return 's1' (s1 is the submodule). What am I missing here?
> > 
> 
> You're likely missing the fact that you should call `read_cache` before
> using `index_name_pos` or the likes of it.

Alright, called it.

> For instance, the following works without issues for most cases (more
> on that below):
> 
>         if (read_cache() < 0)
>                 die(_("index file corrupt"));
> 
>         cache_pos = cache_name_pos(path, strlen(path));
>         if (cache_pos >= 0) {
>                 if (!force) {
>                         die(_("'%s' already exists in the index"),
> path);
>                 }
>                 else {
>                         struct cache_entry *ce = the_index.cache[cache_pos];
> 
>                         if (!S_ISGITLINK(ce->ce_mode))
>                                 die(_("'%s' already exists in the index and is not a "
>                                       "submodule"), path);
>                 }
>         }

I actually did this only using 'index_*()' functions. But made a very
very very silly mistake:
I did a sizeof() instead of strlen() and I did not notice this until
I saw what you did. IDK how I made this mistake.

This is what I have done finally:
---
	if (read_cache() < 0)
		die(_("index file corrupt"));

	if (!force) {
		if (cache_file_exists(path, strlen(path), ignore_case) ||
		    cache_dir_exists(path, strlen(path)))
			die(_("'%s' already exists in the index"), path);
	} else {
		int cache_pos = cache_name_pos(path, strlen(path));
		struct cache_entry *ce = the_index.cache[cache_pos];
		if (cache_pos >= 0 && !S_ISGITLINK(ce->ce_mode))
			die(_("'%s' already exists in the index and is not a "
			      "submodule"), path);
	}
---

I did not put the 'cache_pos >= 0' at the start since I thought that it
will unnecessarily increase an indentation level. Since we are using
'cache_{file,dir}_exists' in the first check and 'cache_name_pos()' in
the second, the placement of check at another indentation level would be
unnecessary. What do you think about this?

> This is more close to what the shell version did but misses one case
> which might or might not be covered by the test suite[1]. The case when
> path is a directory that has tracked contents. In the shell version we
> would get:
> 
>    $ git submodule add ../git-crypt/ builtin
>    'builtin' already exists in the index
>    $ git submodule add --force ../git-crypt/ builtin
>    'builtin' already exists in the index and is not a submodule
> 
>    In the C version with the above snippet we get:
> 
>    $ git submodule add --force ../git-crypt/ builtin
>    fatal: 'builtin' does not have a commit checked out
>    $ git submodule add ../git-crypt/ builtin
>    fatal: 'builtin' does not have a commit checked out
> 
>    That's not appropriate and should be fixed. I believe we could do
>    something with `cache_dir_exists` to fix this.
> 
> 
>    Footnote
>    ===
> 
>    [1]: If it's not covered already, it might be a good idea to add a test
>    for the above case.

Like Junio said, we do not care if it is a file or a directory of any
sorts, we will give the error if it already exists. Therefore, even if
it is an untracked or a tracked one, it should not matter to us. Hence
testing for it may not be necessary is what I feel. Why should we test
it?

