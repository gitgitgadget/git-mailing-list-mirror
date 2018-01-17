Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26DCA1F404
	for <e@80x24.org>; Wed, 17 Jan 2018 00:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbeAQAcL (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 19:32:11 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36204 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeAQAcL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 19:32:11 -0500
Received: by mail-pg0-f49.google.com with SMTP id k68so2728179pga.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 16:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=msCh3DH7REoGB1T4ZCEO9dY3Rx6zAZpiPh73hrmhBAw=;
        b=HfVflXT3F/jMl+qQt+QHp7ZFyWicdMxDW0CzyNVV1k4XQ9Xa+DUXkK8WHMUWVAj26R
         3wWPUPICiMCm2FRAG62c62rZwdnIPSuBN52PPXyGjS0txqC7qbdteljX518qx8d0xGYR
         1fw0cWsfRWtf7zrQoE2Z4SYtwkNF+HBMDo1vm4Lud5TksKH3zF4U05lVN44OGpA2GTK/
         82IHWI/FrPedXIkqyLkT4C/ZNDGjU0ejLRFYfX4sZXFa0p4MvdB3EyqbPjCsc3IwNVmK
         +BBJCI0Dhyso67beweabNQjNjhkA3dBtJ2IRISDkaeA5ZbpAhXDqcy+9hNS9cJCMVzJG
         JvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=msCh3DH7REoGB1T4ZCEO9dY3Rx6zAZpiPh73hrmhBAw=;
        b=b13iYdgscg5fnbQYrSycY964hKttyPx/z/5mDu23zWlK007dlAP1h9DLJzzwuIJInW
         16wVwJX5KNVIZYC9Ewt8kTxC0D99v9gU2wiUbB4MvnkrzzAywPQJJ3uzkciuphzg9KlN
         0jt30x1sP9xqNbckm11mlQTXJC7XNLoDbpofRFn2QcmTacG8eWaLuDL+bEjG+f+HHqrZ
         B7uWU+Kk33cVO4SjNBTLPHj/gct6HTxEdbwvMKWQsrvLofh8HyV37piG9B1EWaJt9HZM
         UAbc4yhbbeUr3BlFYjxrplsFWBLgdt51gVaGT8y5+9dWaIRfWLTlB1gnnfH/5t9tMUVZ
         ZuVQ==
X-Gm-Message-State: AKGB3mLafHN4WtE3i5uRBGzWFR54PG9bTiPFPJKk/dufBkUeXllX4TB2
        piZ9HujFCfeHHhdmIlJ3sYk0HA==
X-Google-Smtp-Source: ACJfBovAP1GDoMtNEGTuExrBCKRYJ9sOYasFKtR2QaSRnMlp1MiyIYH3sSKqqURl6V/5uT7/KItcJg==
X-Received: by 10.101.96.134 with SMTP id t6mr31297901pgu.253.1516149130135;
        Tue, 16 Jan 2018 16:32:10 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id j23sm5464157pfj.42.2018.01.16.16.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jan 2018 16:32:09 -0800 (PST)
Date:   Tue, 16 Jan 2018 16:32:08 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for
 other repos
Message-ID: <20180117003208.qkjtwijmb6o3n6xn@google.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com>
 <20180116214239.GA3622@google.com>
 <CACsJy8A9AheuBK-mKy9d9m5yfSFFZ9N8=wg8FZD_C6mHHTdqXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8A9AheuBK-mKy9d9m5yfSFFZ9N8=wg8FZD_C6mHHTdqXg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/17, Duy Nguyen wrote:
> On Wed, Jan 17, 2018 at 4:42 AM, Brandon Williams <bmwill@google.com> wrote:
> > On 01/07, Thomas Gummerer wrote:
> >> read_index_from() takes a path argument for the location of the index
> >> file.  For reading the shared index in split index mode however it just
> >> ignores that path argument, and reads it from the gitdir of the current
> >> repository.
> >>
> >> This works as long as an index in the_repository is read.  Once that
> >> changes, such as when we read the index of a submodule, or of a
> >> different working tree than the current one, the gitdir of
> >> the_repository will no longer contain the appropriate shared index,
> >> and git will fail to read it.
> >>
> >> For example t3007-ls-files-recurse-submodules.sh was broken with
> >> GIT_TEST_SPLIT_INDEX set in 188dce131f ("ls-files: use repository
> >> object", 2017-06-22), and t7814-grep-recurse-submodules.sh was also
> >> broken in a similar manner, probably by introducing struct repository
> >> there, although I didn't track down the exact commit for that.
> >>
> >> be489d02d2 ("revision.c: --indexed-objects add objects from all
> >> worktrees", 2017-08-23) breaks with split index mode in a similar
> >> manner, not erroring out when it can't read the index, but instead
> >> carrying on with pruning, without taking the index of the worktree into
> >> account.
> >>
> >> Fix this by passing an additional gitdir parameter to read_index_from,
> >> to indicate where it should look for and read the shared index from.
> >>
> >> read_cache_from() defaults to using the gitdir of the_repository.  As it
> >> is mostly a convenience macro, having to pass get_git_dir() for every
> >> call seems overkill, and if necessary users can have more control by
> >> using read_index_from().
> >
> > I'm not saying we need to change this again but I got to thinking about
> > what the root cause for this bug is and I think it's a design flaw in
> > how split index is implemented.  IIUC Split index is an index extension
> > that can be enabled to limit the size of the index file that is written
> > when making changes to the index.  It breaks the index into two pieces,
> > index (which contains only changes) and sharedindex.XXXXX (which
> > contains unchanged information) where 'XXXXX' is a value found in the
> > index file.  If we don't do anything fancy then these two files live
> > next to one another in a repository's git directory at $GIT_DIR/index
> > and $GIT_DIR/sharedindex.XXXXX.  This seems to work all well and fine
> > except that this isn't always the case and the read_index_from function
> > takes this into account by enabling a caller to specify a path to where
> > the index file is located.  We can do this by specifying the index file
> > we want to use by setting GIT_INDEX_FILE.
> >
> > Being able to specify an index file via the environment is a feature
> > that has existed for a very long time (one that I personally think makes
> > things difficult because of things like additions like the sharedindex)
> > and I don't think was taken into account when introducing the split
> > index extension.
> 
> It was (partly because I did use GIT_INDEX_FILE on occasions).
> 
> > In this case if i were to specify a location of an
> > index file in my home directory '~/index' and be using the split index
> > feature then the corresponding sharedindex file would live in my
> > repository's git directory '~/project/.git/sharedindex.XXXXX'.  So the
> > sharedindex file is always located relative to the project's git
> > directory and not the index file itself, which is kind of confusing.
> > Maybe a better design would be to have the sharedindex file located
> > relative to the index file.
> 
> That adds more problems. Now when you move the index file around you
> have to move the shared index file too (think about atomic rename
> which we use in plenty of places, we can't achieve that by moving two
> files). A new dependency to $GIT_DIR is not that confusing to me, the
> index file is useless anyway if you don't have access to
> $GIT_DIR/objects. There was always the option to _not_ split the index
> when $GIT_INDEX_FILE is specified, I think I did consider that but I
> dropped it because we'd lose the performance gain by splitting.
> 
> > Anyway, some food for thought.
> >
> > --
> > Brandon Williams
> 
> 
> 
> -- 
> Duy

Thanks for giving me some more context :) makes me feel more confident
in the solution that's already been proposed.

-- 
Brandon Williams
