Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E73DC433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 12:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2760E2078B
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 12:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBuykkMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgIBMEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIBMEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 08:04:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A590C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 05:04:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so2173362plk.13
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sQ/tsba5gMJ8ZYvLA3eSMpLof1RCKOdzuviKOyEBsio=;
        b=rBuykkMvFReWfkSd6hAEYp//PnH/VW3fSPRgVIeTz/bxESzne8JHmkiK+EKQnA5pFS
         0HRZGofOVIKsDkn3hnIQqrnJW7fIz0tqDBrVDOh61FoL3N3i+HNT/Y9bJWVEV7CtEhLA
         nhfaqIOo7UU42IM3e6prl8usdWnaRkaGRlXZTzNCAvbq4ilicRxdoZheq6DAJJOZdh7l
         VfaXEnDpsX2mXHtv064AmCfckbJ6WOVgkvFcM/lAOh8WdmPaXyKv1EUy+Dl/8G+ubfoo
         fVu7sVsAwIXEGIzWqi8roUafVs6jLmQFvW3BqjnwxWxyPNYFTC0IZc0+sOAFQ+Qv24uy
         PfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sQ/tsba5gMJ8ZYvLA3eSMpLof1RCKOdzuviKOyEBsio=;
        b=UJA2NfXAUY8vjToaC43ozX8+qdrsAs5TWPdEkg57Swmy8JqKDnnLJnoQJxRoXfL1Th
         Ctm9OK7w1e8jvp1p/XZq08rA0Q5EzpwHoC/SjCuBWMMyIhHy/rpw6hL8FkfXfEKCHxLS
         SZOetHhKxBE3U9E1kjZ3GsHoc4b4k0v97nw4PGF1MWivgDcD8kEDbXj3vB46Q5Rn+/iI
         X56+g/SWq+eTcqgRzR4uQ5oVMyrkMTmkgKxRNI6wd174g9jBzAkAXraCVA+uTVKIoa53
         LVS85VczV/Q7AJCpGaFz2d7Z+ECu+FWd9SoIi2rrVCuTTuiuZ7QpeaonnoENgZBckbvK
         jekA==
X-Gm-Message-State: AOAM531MLgI8HPJjqe4C0Tsh9/eAcWw3Kp9NFkOEwtVHaVYLJmDeY8jz
        fvdNWRTxBWWqKvw3NQGrtb+bd6EzPRk7Jw==
X-Google-Smtp-Source: ABdhPJxf5OBQXZ23COWQ+7zqWN+O+uibWXqJIU2exCt3onEW9EUQLAEWAFWae270NFRUzA9eW6y/Cw==
X-Received: by 2002:a17:902:d68f:: with SMTP id v15mr1039233ply.251.1599048269386;
        Wed, 02 Sep 2020 05:04:29 -0700 (PDT)
Received: from konoha ([27.5.26.254])
        by smtp.gmail.com with ESMTPSA id v12sm5406645pgk.81.2020.09.02.05.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 05:04:28 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:34:22 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, liu.denton@gmail.com
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from
 shell to C
Message-ID: <20200902120422.GA28650@konoha>
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
 <xmqq8se36gev.fsf@gitster.c.googlers.com>
 <20200826091502.GA29471@konoha>
 <ce151a1408291bb0991ce89459e36ee13ccdfa52.camel@gmail.com>
 <20200831130448.GA119147@konoha>
 <31e40c63bbac03d261ac6f46a0d2f6ae90a21038.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e40c63bbac03d261ac6f46a0d2f6ae90a21038.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09 02:05, Kaartic Sivaraam wrote:
> On Mon, 2020-08-31 at 18:34 +0530, Shourya Shukla wrote:
> > On 31/08 01:28, Kaartic Sivaraam wrote:
> > 
> > This is what I have done finally:
> > ---
> > 	if (read_cache() < 0)
> > 		die(_("index file corrupt"));
> > 
> > 	if (!force) {
> > 		if (cache_file_exists(path, strlen(path), ignore_case) ||
> > 		    cache_dir_exists(path, strlen(path)))
> > 			die(_("'%s' already exists in the index"), path);
> > 	} else {
> > 		int cache_pos = cache_name_pos(path, strlen(path));
> > 		struct cache_entry *ce = the_index.cache[cache_pos];
> > 		if (cache_pos >= 0 && !S_ISGITLINK(ce->ce_mode))
> > 			die(_("'%s' already exists in the index and is not a "
> > 			      "submodule"), path);
> > 	}
> > ---
> > 
> > I did not put the 'cache_pos >= 0' at the start since I thought that it
> > will unnecessarily increase an indentation level. Since we are using
> > 'cache_{file,dir}_exists' in the first check and 'cache_name_pos()' in
> > the second, the placement of check at another indentation level would be
> > unnecessary. What do you think about this?
> > 
> 
> Interestingly. 'cache_dir_exists' seems to work as expected only when
> the global ignore_case whose value seems to depend on core.ignorecase.
> So, we can't just rely on 'cache_dir_exists to identify a directory
> that has tracked contents. Apparently, the 'directory_exists_in_index'
> in 'dir.c' seems to have the code that we want here (which is also the
> only user of 'index_dir_exists'; the function for which
> 'cache_dir_exists' is a convenience wrapper.

I think both 'cache_{dir,file}_exists()' depend on 'core.ignorecase'
though I am not able to confirm this for 'cache_dir_exists()'. Where
exactly does this happen for the function? The function you mention
seems perfect to me, though, we will also have to make the enum
'exist_status' visible. Will that be fine? The final output will be:
---
	if (!force) {
		if (directory_exists_in_index(&the_index, path, strlen(path)))
			die(_("'%s' already exists in the index"), path);
	} else {
		int cache_pos = cache_name_pos(path, strlen(path));
		struct cache_entry *ce = the_index.cache[cache_pos];
		if (cache_pos >= 0 && !S_ISGITLINK(ce->ce_mode))
			die(_("'%s' already exists in the index and is not a "
			      "submodule"), path);
	}
---


And obviously an extra commit changing the visibility of the function
and the enum.
 
> > > This is more close to what the shell version did but misses one case
> > > which might or might not be covered by the test suite[1]. The case when
> > > path is a directory that has tracked contents. In the shell version we
> > > would get:
> > > 
> > >    $ git submodule add ../git-crypt/ builtin
> > >    'builtin' already exists in the index
> > >    $ git submodule add --force ../git-crypt/ builtin
> > >    'builtin' already exists in the index and is not a submodule
> > > 
> > >    In the C version with the above snippet we get:
> > > 
> > >    $ git submodule add --force ../git-crypt/ builtin
> > >    fatal: 'builtin' does not have a commit checked out
> > >    $ git submodule add ../git-crypt/ builtin
> > >    fatal: 'builtin' does not have a commit checked out
> > > 
> > >    That's not appropriate and should be fixed. I believe we could do
> > >    something with `cache_dir_exists` to fix this.
> > > 
> > > 
> > >    Footnote
> > >    ===
> > > 
> > >    [1]: If it's not covered already, it might be a good idea to add a test
> > >    for the above case.
> > 
> > Like Junio said, we do not care if it is a file or a directory of any
> > sorts, we will give the error if it already exists. Therefore, even if
> > it is an untracked or a tracked one, it should not matter to us. Hence
> > testing for it may not be necessary is what I feel. Why should we test
> > it?
> 
> I'm guessing you misunderstood. A few things:
> 
> - We only care about tracked contents for the case in hand.
> 
> - Identifying whether a given path corresponds to a directory
>   which has tracked contents is tricky. Neither 'cache_name_pos'
>   nor 'cache_file_exists' handle this. 'cache_dir_exists' is also
>   not very useful as mentioned above.
> 
> So, we do have to take care when handling that case as Junio pointed
> out.

I still do not understand this case. Let's say this was our
superproject:

.gitmodules .git/ a.txt dir1/

And we did:
    $ git submodule add <url> dir1/

Now, at this point, how does it matter if 'dir1/' has tracked content or
not right? A directory exists with that name and now we do not add the
SM to that path.

