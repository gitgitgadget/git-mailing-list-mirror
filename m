Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668A8C83F14
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 20:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbjH3USa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjH3US2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 16:18:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676610F4
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 13:17:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso3819981fa.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693426601; x=1694031401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rq2VBzKwDcdenNquRN3m7ZCw454/2NbMWw2bvEBKHhQ=;
        b=LApm9Gb0kqYw4q9gRByOFbQkgaUpOVH/iHFaESt2U3dwXPFt2RXxMeeQq1BaWXFr0/
         albE8DLPR6NcYkSOC9KUUMUg+I7zeE/Ww0PnLLr2QJ+Be9IRR1uMncbctCT3bXC30+x9
         StbRADx3nLWUtiNmS2yMhCBWGB33Ewlrh90LXmSssEEkH/zvxoIpvclTFZNymTuinUIM
         mOqMuU6+Xn9P/bJAmC70Jn5NQw2p1fiGlieOAD7xrvLdvw6mbCSN1E34nWzDC9pIV20I
         KzPizLmoK0UeP2teBJBs6Z4LHTeakn2sP0XFjZafkthyhZMwAAsX1RRb0LmjARPdHfZA
         WsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426601; x=1694031401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq2VBzKwDcdenNquRN3m7ZCw454/2NbMWw2bvEBKHhQ=;
        b=MBoUvm6ravCsl3Xj0juV5ayYbQPND0IODZCM/6l+4IbMXuAHFB93rYMJEYeZpqFZ+W
         oxgsv3AoIAzWhNmk9schX9MeoTs/S1n/OVjCaBQHnF3aRsM6n8Tyc2C2hGtMwmKkDqpR
         XcmoSCM5GPY9YmcHBYMCkEXllhNX2ia/GdY9V0W86gXyKQjIHS5zayNbCnOSTcSC1qvQ
         +tvjh+qUKpeKRYpg2b99uzS5LQpEZyvP76S8wAfmKXR+Jcfp/g4+DvXGLHHWGWXtgH0+
         /IJz315jYfvqxHE5FOrBrQblXT8PY2MwjZlwYHF9Nf0lhpj1+OP0x7crbtEnkK7FSBbp
         yTcg==
X-Gm-Message-State: AOJu0YxJpAJ7ZQ8FIGifsx6EhFFcOn2qEF28sHtBPvinVSaSoNWpT0/g
        RXYQ0r1MoUVQIgIa9ExtUg/UKcCFOOU=
X-Google-Smtp-Source: AGHT+IHLr+0r0Ctgd2DkVwtoyrz2t9w4hzNzlSywiXhlrP0ypTVE+741rhKR8/cViNExOv/eAlyBqw==
X-Received: by 2002:a05:6402:1287:b0:528:90d7:a1f with SMTP id w7-20020a056402128700b0052890d70a1fmr2681228edv.10.1693425740634;
        Wed, 30 Aug 2023 13:02:20 -0700 (PDT)
Received: from localhost (78-131-17-96.pool.digikabel.hu. [78.131.17.96])
        by smtp.gmail.com with ESMTPSA id n20-20020a056402515400b00525bc41b406sm7136504edd.44.2023.08.30.13.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:02:19 -0700 (PDT)
Date:   Wed, 30 Aug 2023 22:02:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 07/15] commit-graph: new filter ver. that fixes murmur3
Message-ID: <20230830200218.GA5147@szeder.dev>
References: <20230826150610.GA1928@szeder.dev>
 <20230829163124.363157-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829163124.363157-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2023 at 09:31:23AM -0700, Jonathan Tan wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
 
> > > +test_expect_success 'version 2 changed-path used when version 2 requested' '
> > > +	(
> > > +		cd highbit2 &&
> > > +		test_bloom_filters_used "-- $CENT"
> > 
> > This test_bloom_filter_used helper runs two pathspec-limited 'git log'
> > invocations, one with disabled and the other with enabled
> > commit-graph, and thus with disabled and enabled modified path Bloom
> > filters, and compares their output.
> > 
> > One of the flaws of the current modified path Bloom filters
> > implementation is that it doesn't check Bloom filters for root
> > commits.
> > 
> > In several of the above test cases test_bloom_filters_used is invoked
> > in a repository with only a root commit, so they don't check that
> > the output is the same with and without Bloom filters.
> 
> Ah...you are right. Indeed, when I flip one of the tests from
> test_bloom_filters_used to _not_, the test still passes. I'll change
> the tests.

I'd prefer to leave the test cases unchanged, and make the revision
walking machinery look at Bloom filters even for root commits, because
this is an annoying and recurring testing issue.  I remember it
annoyed me back then, when I wanted to reproduce a couple of bugs that
I knew were there, but my initial test cases didn't fail because the
Bloom filter of the root commit was ignored; Derrick overlooked this
in b16a8277644, you overlooked it now, and none of the reviewers then
and now caught it, either.

> > The string "split" occurs twice in this patch series, but only in
> > patch hunk contexts, and it doesn't occur at all in the previous long
> > thread about the original patch series.
> > 
> > Unfortunately, split commit-graphs weren't really considered in the
> > design of the modified path Bloom filters feature, and layers with
> > different Bloom filter settings weren't considered at all.  I've
> > reported it back then, but the fixes so far were incomplete, and e.g.
> > the test cases shown in
> > 
> >   https://public-inbox.org/git/20201015132147.GB24954@szeder.dev/
> > 
> > still fail.
> > 
> > Since the interaction of different versions and split commit-graphs
> > was neither mentioned in any of the commit messages nor discussed
> > during the previous rounds, and there isn't any test case excercising
> > it, and since the Bloom filter version information is stored in the
> > same 'g->bloom_filter_settings' structure as the number of hashes, I'm
> > afraid (though haven't actually checked) that handling commit-graph
> > layers with different Bloom filter versions is prone to the same
> > issues as well.
> 
> My original design (up to patch 7 in this patch set) defends against
> this by taking the very first version detected and rejecting every
> other version, and Taylor's subsequent design reads every version, but
> annotates filters with its version. So I think we're covered.

In the meantime I adapted the test cases from the above linked message
to write commit-graph layers with different Bloom filter versions, and
it does fail, because commits from the bottom commit-graph layer are
omitted from the revision walk's output.  And the test case doesn't
even need a middle layer without modified path Bloom filters to "hide"
the different version in the bottom layer.  Merging the layers seems
to work, though.

Besides fixing this issue, I think that the interaction of different
Bloom filter versions and split commit-graphs needs to be thoroughly
covered with test cases and discussed in the commit messages before
this series could be considered good for merging.


diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 48f8109a66..55f67e5110 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -586,4 +586,40 @@ test_expect_success 'when writing commit graph, reuse changed-path of another ve
 	test_filter_upgraded 1 trace2.txt
 '
 
+test_expect_success 'split commit graph vs changed paths breakage - setup' '
+	git init split-breakage &&
+	(
+		cd split-breakage &&
+		git commit --allow-empty -m "Bloom filters are written but still ignored for root commits :(" &&
+		for i in 1 2 3
+		do
+			echo $i >$CENT &&
+			git add $CENT &&
+			git commit -m "$i" || return 1
+		done &&
+		git log --oneline -- $CENT >expect
+	)
+'
+
+test_expect_failure 'split commit graph vs changed paths breakage - split' '
+	(
+		cd split-breakage &&
+
+		# Compute v1 Bloom filters for the commits at the bottom.
+		git rev-parse HEAD^ | git commit-graph write --stdin-commits --changed-paths --split &&
+		# Compute v2 Bloom filters for the rest of the commits at the top.
+		git rev-parse HEAD | git -c commitgraph.changedPathsVersion=2 commit-graph write --stdin-commits --changed-paths --split=no-merge &&
+
+		# Just to make sure that there are as many graph layers as I
+		# think there should be.
+		test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain &&
+
+		# This checks Bloom filters using version information in the
+		# top layer, thus misses commits modifying the file in the
+		# bottom commit-graph layer.
+		git log --oneline -- $CENT >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

It fails with:

  + cd split-breakage
  + git rev-parse HEAD^
  + git commit-graph write --stdin-commits --changed-paths --split
  + git rev-parse HEAD
  + git -c commitgraph.changedPathsVersion=2 commit-graph write --stdin-commits --changed-paths --split=no-merge
  + test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain
  + git log --oneline -- ¢
  + test_cmp expect actual
  --- expect      2023-08-30 19:07:59.882066827 +0000
  +++ actual      2023-08-30 19:07:59.894067148 +0000
  @@ -1,3 +1 @@
   1db2248 3
  -cfcc97f 2
  -bd9c2c8 1
  error: last command exited with $?=1

