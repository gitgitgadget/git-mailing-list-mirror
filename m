Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F8AC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43461206A4
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="IG/JFynp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgEEQQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgEEQQw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:16:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161BCC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:16:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fu13so1321172pjb.5
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VLZJX7NcIxqqWuBIvw+RY77dsV4a1UH24goh9E/bAkU=;
        b=IG/JFynpZkSv3Ad3Qt36rIkArZ0PpAyAR3wRt1Uax/RadjJyZL4gTfPW6hZYzDro6O
         pnnIC36RPqch1YdFlcwPW1XZFMTZ8Dva5BwD7VFWg23QDub/oeOh9nF6+SMQqC7tUBtD
         iT2yuZDsOaofnJQ4+OBqsn+/vNs5ol7sc5K2tBkCFyINGGTR6q7C/dvXiNCMLC7nTwnJ
         tccAB3CQfYChxCdXyxRi0LRo5pFBOqA54HVEe/anw+rjpajJEOL0Jy/JJUx4rl4QZUWx
         DbTV/Gjs3WqG0d6U3hoZzQLUiiAQ1htp/FBdGAyc9Q04Do+9pFeKJnn6cfpY0ldhDVoH
         nIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VLZJX7NcIxqqWuBIvw+RY77dsV4a1UH24goh9E/bAkU=;
        b=KQq3KuwmCeaC+bBV+txlcPSCd5CFj6XSstjL9W3Rg6yTbghu3fX/Wlx7O6w4bbwxxY
         imbg1d6tPDDWy0zF80BeYjHHXCypzvimg33f6m72LaD57HSFio5sQ2fVy9GBe9PLMIad
         s3eA12EtcEYMsj6WAKQufsOF7Zw691TgxX+glLkrTdoUI5O9iGp1DkI8sW2eQlhS7C5x
         pXT+XPwWX5kTNx98HXOPEfPLiDAZnCgDtq0Iz/4TFoV2YMffpIHFG9Bg4ByI35T87GlG
         q76hLFwh/BwI0vu2cejji+ZvlQnh4YEJjt5clJqG7iLzt48+CAQYkHKFrscNQCvkPgTm
         Bfsw==
X-Gm-Message-State: AGi0PuawKizK8a/RnKvxNUmGRzv2q6zROiBMiqjDV/+xMHM7KVDfLfcB
        nAbGDNLZn+TpBM6+/oIyGpCFSw==
X-Google-Smtp-Source: APiQypIHqi0JjBQ23UaX/Zvoy8YrSRhg/IsSa4OU1ufK2vHqCHkOg4Dr4hVxJkuexGUCI2MrFAHl3w==
X-Received: by 2002:a17:902:eb43:: with SMTP id i3mr3311674pli.299.1588695411379;
        Tue, 05 May 2020 09:16:51 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 67sm2434128pfx.108.2020.05.05.09.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:16:50 -0700 (PDT)
Date:   Tue, 5 May 2020 10:16:49 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH 8/8] commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
Message-ID: <20200505161649.GG69300@syl.local>
References: <cover.1588641176.git.me@ttaylorr.com>
 <6c2d130b0cd4b6a8a541b362ae7dd44d4c282e3f.1588641176.git.me@ttaylorr.com>
 <81fb0f5e-e7e1-7541-d6c7-36828190c95b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81fb0f5e-e7e1-7541-d6c7-36828190c95b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 08:10:40AM -0400, Derrick Stolee wrote:
> On 5/4/2020 9:14 PM, Taylor Blau wrote:
> > Since 7c5c9b9c57 (commit-graph: error out on invalid commit oids in
> > 'write --stdin-commits', 2019-08-05), the commit-graph builtin dies on
> > receiving non-commit OIDs as input to '--stdin-commits'.
> >
> > This behavior can be cumbersome to work around in, say, the case of
> > piping 'git for-each-ref' to 'git commit-graph write --stdin-commits' if
> > the caller does not want to cull out non-commits themselves. In this
> > situation, it would be ideal if 'git commit-graph write' wrote the graph
> > containing the inputs that did pertain to commits, and silently ignored
> > the remainder of the input.
> >
> > Some options have been proposed to the effect of '--[no-]check-oids'
> > which would allow callers to have the commit-graph builtin do just that.
> > After some discussion, it is difficult to imagine a caller who wouldn't
> > want to pass '--no-check-oids', suggesting that we should get rid of the
> > behavior of complaining about non-commit inputs altogether.
> >
> > If callers do wish to retain this behavior, they can easily work around
> > this change by doing the following:
> >
> >     git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
> >     awk '/commit/ { print $1 }' |
> >     git commit-graph write --stdin-commits
>
> I appreciate that you included the workaround here for posterity. That
> allows anyone complaining to bisect to these instructions.

Well, now that I linked provided a link to [2] in the cover letter,
you'll see that it was Peff's suggestion ;).

But, I wrote something similar to this in one of GitHub's
post-processing jobs before we had this series, so I think I can take
some of the credit!

> > To make it so that valid OIDs that refer to non-existent objects are
> > indeed an error after loosening the error handling, perform an extra
> > lookup to make sure that object indeed exists before sending it to the
> > commit-graph internals.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  Documentation/git-commit-graph.txt |  6 ++++--
> >  builtin/commit-graph.c             | 10 +++++-----
> >  commit-graph.c                     |  2 --
> >  commit-graph.h                     | 10 ++++------
> >  t/t5318-commit-graph.sh            | 15 +++++++++++----
> >  5 files changed, 24 insertions(+), 19 deletions(-)
> >
> > diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> > index 53a650225a..fcac7d12e1 100644
> > --- a/Documentation/git-commit-graph.txt
> > +++ b/Documentation/git-commit-graph.txt
> > @@ -47,8 +47,10 @@ with `--stdin-commits` or `--reachable`.)
> >  +
> >  With the `--stdin-commits` option, generate the new commit graph by
> >  walking commits starting at the commits specified in stdin as a list
> > -of OIDs in hex, one OID per line. (Cannot be combined with
> > -`--stdin-packs` or `--reachable`.)
> > +of OIDs in hex, one OID per line. OIDs that resolve to non-commits
> > +(either directly, or by peeling tags) are silently ignored. OIDs that
> > +are malformed, or do not exist generate an error. (Cannot be combined
> > +with `--stdin-packs` or `--reachable`.)
> >  +
> >  With the `--reachable` option, generate the new commit graph by walking
> >  commits starting at all refs. (Cannot be combined with `--stdin-commits`
> > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> > index 9eec68572f..3637d079fb 100644
> > --- a/builtin/commit-graph.c
> > +++ b/builtin/commit-graph.c
> > @@ -153,13 +153,14 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
> >
> >  	display_progress(progress, oidset_size(commits) + 1);
> >
> > +	if (oid_object_info(the_repository, &oid, NULL) < 0) {
> > +		error(_("object %s does not exist"), hash);
> > +		return 1;
> > +	}
> > +
>
> If we get a non-existent object, then this will cause us to fail
> the command, right?
>
> > diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> > index 89020d3d44..74f93f0a17 100755
> > --- a/t/t5318-commit-graph.sh
> > +++ b/t/t5318-commit-graph.sh
> > @@ -84,11 +84,18 @@ graph_read_expect() {
> >
> >  test_expect_success 'exit with correct error on bad input to --stdin-commits' '
> >  	cd "$TRASH_DIRECTORY/full" &&
> > -	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
> > +	# invalid, non-hex OID
> > +	echo HEAD >in &&
> > +	test_expect_code 1 git commit-graph write --stdin-commits <in 2>stderr &&
> >  	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
> > -	# valid tree OID, but not a commit OID
> > -	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
> > -	test_i18ngrep "invalid commit object id" stderr
> > +	# non-existent OID
> > +	echo $ZERO_OID >in &&
> > +	test_expect_code 1 git commit-graph write --stdin-commits <in 2>stderr &&
> > +	test_i18ngrep "does not exist" stderr &&
>
> And here you verify that it fails at that point. Excellent!
>
> > +	# valid commit and tree OID
> > +	git rev-parse HEAD HEAD^{tree} >in &&
> > +	git commit-graph write --stdin-commits <in &&
> > +	graph_read_expect 3
> >  '
>
> This is an excellent series! Thanks.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks for your review. I applied your suggested changes locally (which
came down to tweaking the progress meter's messages in the 2nd and 5th
patches), but I'll sit on them for a day or so to make sure that nobody
else has any thoughts before sending a v2.

Thanks,
Taylor
