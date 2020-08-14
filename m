Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A60C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7325F206DA
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="U1Dcr2YN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHNUF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgHNUF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:05:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DACC061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:05:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 2so9429116qkf.10
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oK4rtu2+1aFkijZtfWvsxRfUzYT1n+xXup63g3jcTvA=;
        b=U1Dcr2YNMKWoPl9E6gF9Y52uZMT4a7Irg9+5Hfx/EKQALVLwSVGuavNPukYV8TG01/
         0bpHAJVHkN2oUk4LjCB4V7e3XhocnQcVj0cS90klyuqe/AVrff+e43WFcsZj2UxE2cLE
         ghGWHRRijIeUzOnc5AFLLqZz7c8yjwFQMibxb1Vg9e/fcjQYDgfoYo+HDX3dzrL5NJNM
         m4N9NijDwD2X+6RGhBR4lVXp4USKJAqDD2lE78zP4SxZt2JCyeUq2qEcaPQaP74tq9/z
         4kP0xVgC/gVusi04Py2gf7CjWbmt0+43KduF9KC3BlO3pimaMdgFLKE4i4qpY9ccKL8R
         2/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oK4rtu2+1aFkijZtfWvsxRfUzYT1n+xXup63g3jcTvA=;
        b=FtVjDNpwvLgA/tiFvdxo0W2gwzySBpPvc8B38x2mdqCRwOAa2QPNtVvntXu4y+YrVM
         ibdvB4DqOpMhyebyQJih0z563l5qXGeCYyKfmszx7M6/0F4d+tvW3Saam9kxErDcUofG
         PFk70pV+2gKPabGUPcKFWnUmcwlwcc0XXa2xX2KtUdJt+fwPyCIC8jfuo8MXkq8f839Z
         PZQI50IoyGjBr3qxvYJf9UHr8Wf5KeFfJgtmo0H03ziJZiTrmoBJHatBXzIqIr6MNVLo
         y96RY9883MpUcSG6qtdwAwMr2fJA77WWmecAhm9vtMWTgV0P0SOzJuAlGUXzXfvWL/PT
         zK6w==
X-Gm-Message-State: AOAM5305KvXDg1kSXZweU740a9XeUlr7r/NozBrBs/Pp7kEK1kC0CV+r
        Sf4tzq0WtOzXmR9jlW7v7Pvabw==
X-Google-Smtp-Source: ABdhPJwEPlj0KyaVfQ8e9elXELp1c9wnys1vhgUMVIRfRn45i7hvvFRq4THKI/EpQWCyzGnM6bAN8g==
X-Received: by 2002:a37:b942:: with SMTP id j63mr3490551qkf.138.1597435554899;
        Fri, 14 Aug 2020 13:05:54 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3009:7f9d:1da1:7877])
        by smtp.gmail.com with ESMTPSA id d57sm11356194qte.91.2020.08.14.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:05:54 -0700 (PDT)
Date:   Fri, 14 Aug 2020 16:05:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, martin.agren@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] commit-graph: use the hash version byte
Message-ID: <20200814200552.GA30103@syl.lan>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
 <4bbfd345d16da4604dd20decda8ecb12372e4223.1597428440.git.gitgitgadget@gmail.com>
 <xmqqo8ndvyje.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8ndvyje.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 12:05:09PM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > The commit-graph format reserved a byte among the header of the file to
> > store a "hash version". During the SHA-256 work, this was not modified
> > because file formats are not necessarily intended to work across hash
> > versions. If a repository has SHA-256 as its hash algorithm, it
> > automatically up-shifts the lengths of object names in all necessary
> > formats.
> >
> > However, since we have this byte available for adjusting the version, we
> > can make the file formats more obviously incompatible instead of relying
> > on other context from the repository.
>
> Very good idea.
>
> > Update the oid_version() method in commit-graph.c to add a new value, 2,
> > for sha-256. This automatically writes the new value in a SHA-256
> > repository _and_ verifies the value is correct. This is a breaking
> > change relative to the current 'master' branch since 092b677 (Merge
> > branch 'bc/sha-256-cvs-svn-updates', 2020-08-13) but it is not breaking
> > relative to any released version of Git.
>
> That is perfectly fine.  I think any file and on-wire protocol that
> uses anything but SHA-1 without identifying what it uses is a bug.
>
> Will queue.  Thanks.

Great. I have nothing to add other than my 'ack' that this is a good
idea.

> > +OID_VERSION=1
> > +if [ "$GIT_DEFAULT_HASH" = "sha256" ]
> > +then
> > +	OID_VERSION=2
> > +fi
> > +
> >  test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
> >  	git init &&
> >  	mkdir A A/B A/B/C &&
> > @@ -35,7 +41,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
> >  graph_read_expect () {
> >  	NUM_CHUNKS=5
> >  	cat >expect <<- EOF
> > -	header: 43475048 1 1 $NUM_CHUNKS 0
> > +	header: 43475048 1 $OID_VERSION $NUM_CHUNKS 0
> >  	num_commits: $1
> >  	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
> >  	EOF
> > diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> > index 044cf8a3de..5b65017676 100755
> > --- a/t/t5318-commit-graph.sh
> > +++ b/t/t5318-commit-graph.sh
> > @@ -5,6 +5,12 @@ test_description='commit graph'
> >
> >  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
> >
> > +OID_VERSION=1
> > +if [ "$GIT_DEFAULT_HASH" = "sha256" ]
> > +then
> > +	OID_VERSION=2
> > +fi
> > +
> >  test_expect_success 'setup full repo' '
> >  	mkdir full &&
> >  	cd "$TRASH_DIRECTORY/full" &&
> > @@ -77,7 +83,7 @@ graph_read_expect() {
> >  		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
> >  	fi
> >  	cat >expect <<- EOF
> > -	header: 43475048 1 1 $NUM_CHUNKS 0
> > +	header: 43475048 1 $OID_VERSION $NUM_CHUNKS 0
> >  	num_commits: $1
> >  	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
> >  	EOF
> > @@ -412,6 +418,35 @@ test_expect_success 'replace-objects invalidates commit-graph' '
> >  	)
> >  '
> >
> > +test_expect_success 'warn on improper hash version' '
> > +	git init --object-format=sha1 sha1 &&
> > +	(
> > +		cd sha1 &&
> > +		test_commit 1 &&
> > +		git commit-graph write --reachable &&
> > +		mv .git/objects/info/commit-graph ../cg-sha1
> > +	) &&
> > +	git init --object-format=sha256 sha256 &&
> > +	(
> > +		cd sha256 &&
> > +		test_commit 1 &&
> > +		git commit-graph write --reachable &&
> > +		mv .git/objects/info/commit-graph ../cg-sha256
> > +	) &&
> > +	(
> > +		cd sha1 &&
> > +		mv ../cg-sha256 .git/objects/info/commit-graph &&
> > +		git log -1 2>err &&
> > +		test_i18ngrep "commit-graph hash version 2 does not match version 1" err
> > +	) &&
> > +	(
> > +		cd sha256 &&
> > +		mv ../cg-sha1 .git/objects/info/commit-graph &&
> > +		git log -1 2>err &&
> > +		test_i18ngrep "commit-graph hash version 1 does not match version 2" err
> > +	)
> > +'
> > +
> >  # the verify tests below expect the commit-graph to contain
> >  # exactly the commits reachable from the commits/8 branch.
> >  # If the file changes the set of commits in the list, then the
> > diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> > index ea28d522b8..6f1a324f4f 100755
> > --- a/t/t5324-split-commit-graph.sh
> > +++ b/t/t5324-split-commit-graph.sh
> > @@ -6,6 +6,12 @@ test_description='split commit graph'
> >  GIT_TEST_COMMIT_GRAPH=0
> >  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
> >
> > +OID_VERSION=1
> > +if [ "$GIT_DEFAULT_HASH" = "sha256" ]
> > +then
> > +	OID_VERSION=2
> > +fi
> > +
> >  test_expect_success 'setup repo' '
> >  	git init &&
> >  	git config core.commitGraph true &&
> > @@ -28,7 +34,7 @@ graph_read_expect() {
> >  		NUM_BASE=$2
> >  	fi
> >  	cat >expect <<- EOF
> > -	header: 43475048 1 1 3 $NUM_BASE
> > +	header: 43475048 1 $OID_VERSION 3 $NUM_BASE
> >  	num_commits: $1
> >  	chunks: oid_fanout oid_lookup commit_metadata
> >  	EOF
Thanks,
Taylor
