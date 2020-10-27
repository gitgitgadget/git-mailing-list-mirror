Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6084C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 06:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842422084C
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 06:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V54Brt0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506814AbgJ0GgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 02:36:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37731 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgJ0GgR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 02:36:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id h6so209476pgk.4
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 23:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hh3TaR0LLL2JeLXcP0BL6LMvGkYVLIQMfJYuHLshjVw=;
        b=V54Brt0GA4R/Bp5SNAGowbG10Qahs+DoFOurf5LtUFpr7m+gQUdNTl5OVPu3e211L+
         Mkl54VAGu9206sHVDZlfcrrcM6CyIxfQYF/GKuupnSSWyi90zzdEYCrTTrvvUqmr9bx+
         pTyCH1Yl4y3wrNst8DYOSLxM1upYVme3yh4lkp29z7xDvbqjgZruSYvnZ2CY9lfp+tAg
         /YqUsWJ3fHX33a/ZAEdmrdmVCs4EPdh70KxEtNwH+f7B4LRtt9pBbEY1LS9eXVTN4dEx
         nc9BThZszXk3Y11l02OSYc7ovFyDKSW1oi8Q3XJmGqkyXuwCWUB3MIN6FcJ0nYS1CHUY
         dxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=hh3TaR0LLL2JeLXcP0BL6LMvGkYVLIQMfJYuHLshjVw=;
        b=EQCCnk5ubrg8MHn9cj1QnxHVYaw1t04ifxZDornQMvY+8lZgxgRpXbMbrggoRdB9Mr
         cfdQLRtxZ8Vh2a/o45F/zHxNV0vocbH1VOanbugHjseDdpT16NlkopbEAIN4fBwutPCH
         UL0sUr3MTVIMrjlWtVngiuqt6NgqDRPT2KojnMHwQGn3ZA3atos7iaLOV6QhQQAlMTig
         ej550Sng6BaIxyTk7T2ujFreYN0NGNgGvgvRaLtgqkP+gS1SAjqpa2dZpFh76fZjkfNJ
         tpwPMatpde6so+Q7SCjNrrrFxiozo6pnbxKFH6EjODIKqHDfqu45F2wWtVcOPkxbC/nN
         E60g==
X-Gm-Message-State: AOAM530FDIxAxzucZffOI7oTFTSzZOj/pAFVajUHW2DP1plU28pDYu8w
        scTuraJNfGFQkGOgJaKxpUw=
X-Google-Smtp-Source: ABdhPJz3M4D0WuQhTAe3qmXskVjZkBy/bnhnZ61CYCnYcTGoU1hQ9aZAgPjnqf2J/sMh5bBwDQbpIA==
X-Received: by 2002:a63:5a4f:: with SMTP id k15mr613514pgm.402.1603780575809;
        Mon, 26 Oct 2020 23:36:15 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:2002:1831:20d7:6573:e52:147c])
        by smtp.gmail.com with ESMTPSA id t129sm871524pfc.140.2020.10.26.23.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 23:36:15 -0700 (PDT)
Date:   Tue, 27 Oct 2020 12:03:24 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 03/10] commit-graph: consolidate fill_commit_graph_info
Message-ID: <20201027063306.GA15674@Abhishek-Arch>
Reply-To: 85blgq4lxh.fsf@gmail.com
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <18bb3318a12c859c21c8e95285d551c48d31b54b.1602079786.git.gitgitgadget@gmail.com>
 <85blgq4lxh.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85blgq4lxh.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Dr. Narębski,

On Sun, Oct 25, 2020 at 11:52:42AM +0100, Jakub Narębski wrote:
> Hi Abhishek,
> 
> In short: everything is all right, except for the now duplicated test
> names in t5000 after this commit.
> 
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > Both fill_commit_graph_info() and fill_commit_in_graph() parse
> > information present in commit data chunk. Let's simplify the
> > implementation by calling fill_commit_graph_info() within
> > fill_commit_in_graph().
> >
> > fill_commit_graph_info() used to not load committer data from commit data
> > chunk. However, with the corrected committer date, we have to load
> > committer date to calculate generation number value.
> 
> Nice writeup, however the last sentence would in my opinion read better
> in the future tense: we don't use generation number v2 yet.  For
> example:
> 
>   However, with upcoming switch to using corrected committer date as
>   generation number v2, we will have to load committer date to compute
>   generation number value anyway.
> 
> Or something like that - notice the minor addition and changes.
> 

Thanks for the change, it looks better!

> The following is slightly unrelated change, but we agreed that it would
> be better to not separate them; the need for change to the t5000 test is
> caused by the change described above.

> 
> >
> > e51217e15 (t5000: test tar files that overflow ustar headers,
> > 30-06-2016) introduced a test 'generate tar with future mtime' that
> > creates a commit with committer date of (2 ^ 36 + 1) seconds since
> > EPOCH. The CDAT chunk provides 34-bits for storing committer date, thus
> > committer time overflows into generation number (within CDAT chunk) and
> > has undefined behavior.
> >
> > The test used to pass as fill_commit_graph_info() would not set struct
> > member `date` of struct commit and loads committer date from the object
> > database, generating a tar file with the expected mtime.
> 
> I think it should be s/loads/load/, as in "would load", but I am not a
> native English speaker.
> 

That's correct - since I have used "would not set" in the first half of
sentence, the later half should follow suit too.

> >
> > However, with corrected commit date, we will load the committer date
> > from CDAT chunk (truncated to lower 34-bits to populate the generation
> > number. Thus, Git sets date and generates tar file with the truncated
> > mtime.
> >
> > The ustar format (the header format used by most modern tar programs)
> > only has room for 11 (or 12, depending om some implementations) octal
> > digits for the size and mtime of each files.
> >
> > Thus, setting a timestamp of 2 ^ 33 + 1 would overflow the 11-octal
> > digit implementations while still fitting into commit data chunk.
> >
> > Since we want to test 12-octal digit implementations of ustar as well,
> > let's modify the existing test to no longer use commit-graph file.
> 
> The description above is for me does not make it entirely clear that we
> add new test for handling possible 11-octal digit overflow nearly
> identical to the existing one, and turn off use of commit-graph file for
> test that checks handling 12-octal digit overflow.
> 

Revised the last paragraphs to:

  The ustar format (the header format used by most modern tar programs)
  only has room for 11 (or 12, depending on some implementations) octal
  digits for the size and mtime of each file.

  To test the 11-octal digit implementation, we create a future commit
  with committer date of 2^34 - 1, which overflows 11-octal digits
  without overflowing 34-bits of the Commit Data chunk.

  To test the 12-octal digit implementation, the smallest committer date
  possible is 2^36, which overflows the Commit Data chunk and thus
  commit-graph must be disabled for the test.

> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c      | 27 ++++++++++-----------------
> >  t/t5000-tar-tree.sh | 20 +++++++++++++++++++-
> >  2 files changed, 29 insertions(+), 18 deletions(-)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 94503e584b..e8362e144e 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -749,15 +749,24 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
> >  	const unsigned char *commit_data;
> >  	struct commit_graph_data *graph_data;
> >  	uint32_t lex_index;
> > +	uint64_t date_high, date_low;
> >  
> >  	while (pos < g->num_commits_in_base)
> >  		g = g->base_graph;
> >  
> > +	if (pos >= g->num_commits + g->num_commits_in_base)
> > +		die(_("invalid commit position. commit-graph is likely corrupt"));
> > +
> >  	lex_index = pos - g->num_commits_in_base;
> >  	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
> >  
> >  	graph_data = commit_graph_data_at(item);
> >  	graph_data->graph_pos = pos;
> > +
> > +	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
> > +	date_low = get_be32(commit_data + g->hash_len + 12);
> > +	item->date = (timestamp_t)((date_high << 32) | date_low);
> > +
> >  	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> >  }
> >  
> > @@ -772,38 +781,22 @@ static int fill_commit_in_graph(struct repository *r,
> >  {
> >  	uint32_t edge_value;
> >  	uint32_t *parent_data_ptr;
> > -	uint64_t date_low, date_high;
> >  	struct commit_list **pptr;
> > -	struct commit_graph_data *graph_data;
> >  	const unsigned char *commit_data;
> >  	uint32_t lex_index;
> >  
> >  	while (pos < g->num_commits_in_base)
> >  		g = g->base_graph;
> >  
> > -	if (pos >= g->num_commits + g->num_commits_in_base)
> > -		die(_("invalid commit position. commit-graph is likely corrupt"));
> > +	fill_commit_graph_info(item, g, pos);
> >  
> > -	/*
> > -	 * Store the "full" position, but then use the
> > -	 * "local" position for the rest of the calculation.
> > -	 */
> > -	graph_data = commit_graph_data_at(item);
> > -	graph_data->graph_pos = pos;
> >  	lex_index = pos - g->num_commits_in_base;
> > -
> >  	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
> >  
> >  	item->object.parsed = 1;
> >  
> >  	set_commit_tree(item, NULL);
> >  
> > -	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
> > -	date_low = get_be32(commit_data + g->hash_len + 12);
> > -	item->date = (timestamp_t)((date_high << 32) | date_low);
> > -
> > -	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> > -
> >  	pptr = &item->parents;
> >  
> >  	edge_value = get_be32(commit_data + g->hash_len);
> 
> All right, looks good for me.
> 
> Here second change begins.
> 
> > diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> > index 3ebb0d3b65..8f41cdc509 100755
> > --- a/t/t5000-tar-tree.sh
> > +++ b/t/t5000-tar-tree.sh
> > @@ -431,11 +431,29 @@ test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can read our huge size' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
> > +	rm -f .git/index &&
> > +	echo foo >file &&
> > +	git add file &&
> > +	GIT_COMMITTER_DATE="@17179869183 +0000" \
> > +		git commit -m "tempori parendum"
> > +'
> > +
> > +test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
> > +	git archive HEAD >future.tar
> > +'
> > +
> > +test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
> > +	echo 2514 >expect &&
> > +	tar_info future.tar | cut -d" " -f2 >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> 
> Everything is all right, except we now have duplicated test names.
> 
> Perhaps in the three following tests we should use 'far-far-future
> commit' and 'far future mtime' in place of current 'far-future commit'
> and 'future mtime' for tests checking handling 12-digital ditgits
> overflow, or add description how far the future is, for example
> 'far-future commit (2^11 + 1)', etc.
> 

Changed, thanks for pointing this out.

> >  test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
> >  	rm -f .git/index &&
> >  	echo content >file &&
> >  	git add file &&
> > -	GIT_COMMITTER_DATE="@68719476737 +0000" \
> > +	GIT_TEST_COMMIT_GRAPH=0 GIT_COMMITTER_DATE="@68719476737 +0000" \
> >  		git commit -m "tempori parendum"
> >  '
> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
