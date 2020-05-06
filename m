Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB18BC47247
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9341E206A5
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="pIcZsJCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgEFAHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 20:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgEFAHN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 20:07:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125CFC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 17:07:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x77so115180pfc.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mh7Fn0Pue6QzDB1mrp28/zrYS86ghFCIkh3fSSS/6wo=;
        b=pIcZsJCLawi2BfEJWGDiTueirH8ocQOi5EBcSAdXsSdRndChYypMc/IB9XPGHPqf9R
         xDJS/TmMVe4z1k1SX3p2F/Eau7zXBpq7Fah8Nd/am/lFI2KiPcv17dW783fndFi3BYqG
         wZJAP028mZ6aF5DAmSCWX++yn3q+ngkSwNUOyHhCXFz/7olhF/eLGWCTLPslEncQrYOo
         ignc0nWtegsnFXgGAi/X/4rPWR8f1cOAAC6KawGisRAPCqOpk1+LtM0G6dv0kpjlMPvq
         yfDMor+tyzIuNd4DF+M7AKmaGprP9XKw+j28ZdLckjorIshci0VGej67Nuoqs4wzlzQ6
         C+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mh7Fn0Pue6QzDB1mrp28/zrYS86ghFCIkh3fSSS/6wo=;
        b=e7sgpEtcGNOZQxpNz9nUL16WfYY2GOUoCBD7xDanr1eY2rV1gnEJ5J6vqkZSx10spz
         QdcG1IV+76bvY7aEGNNGNQKR5+5Lr9Vev4CHotZBkx+GOXayvKjiIymf18ZE4xKt1DLH
         1rMqOjVN/UwwHsNKMsxJkOJ5aQIsFbJpwLwBJWX5x0p1owHG7uEcCR/obBSfVb8UbzqB
         drh73JRCegePHLIJqHdp+c+TXfRDKCcU89Jp/QeiaiotNDVqmJNc4URMPHq5W+OfgQGL
         yG1d56ECoPUV7PPYQ9FA5GQqh18J8xPTj4r6lIo0iNy+FLL/SQ5qyQfQBvKQ5FeR0fzq
         qanQ==
X-Gm-Message-State: AGi0PuaI6IANC0UiSU9O3JRNhO+HguBx6qlVUGY83H25bkuS6YgwRMpp
        dWLHoEO4y1HpvfNo+xvoiuWPC0jegBs=
X-Google-Smtp-Source: APiQypIaskt4ULp1fNXtV4vyYTmdjcb7S6riD/adwkrpw0wywjV3Dpo+GWeUpZVuQPoimQNjj+3WvQ==
X-Received: by 2002:a63:dc41:: with SMTP id f1mr5079168pgj.348.1588723632060;
        Tue, 05 May 2020 17:07:12 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g9sm211979pgj.89.2020.05.05.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:07:11 -0700 (PDT)
Date:   Tue, 5 May 2020 18:07:09 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 0/8] commit-graph: drop CHECK_OIDS, peel in callers
Message-ID: <cover.1588723543.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's a small re-roll of my series to move peeling outside of the
commit-graph internals, and drop the CHECK_OIDS flag. This re-roll was
promised in [1], and only updates the messages used in the new progress
meters. For convenience, a range-diff from v1 is included below.

Thanks in advance for another review.

[1]: https://lore.kernel.org/git/20200505161649.GG69300@syl.local/

Taylor Blau (8):
  commit-graph.c: extract 'refs_cb_data'
  commit-graph.c: show progress of finding reachable commits
  commit-graph.c: peel refs in 'add_ref_to_set'
  builtin/commit-graph.c: extract 'read_one_commit()'
  builtin/commit-graph.c: dereference tags in builtin
  commit-graph.c: simplify 'fill_oids_from_commits'
  t5318: reorder test below 'graph_read_expect'
  commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag

 Documentation/git-commit-graph.txt |  6 ++-
 builtin/commit-graph.c             | 73 ++++++++++++++++++++----------
 commit-graph.c                     | 61 +++++++++++--------------
 commit-graph.h                     | 10 ++--
 t/t5318-commit-graph.sh            | 25 ++++++----
 5 files changed, 98 insertions(+), 77 deletions(-)

Range-diff against v1:
1:  5bdbeaf374 ! 1:  cb56a9a73b commit-graph.c: show progress of finding reachable commits
    @@ commit-graph.c: int write_commit_graph_reachable(struct object_directory *odb,
      	data.commits = &commits;
     +	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
     +		data.progress = start_delayed_progress(
    -+			_("Finding reachable commits"), 0);
    ++			_("Collecting referenced commits"), 0);

      	for_each_ref(add_ref_to_set, &data);
      	result = write_commit_graph(odb, NULL, &commits,
2:  5ff56feab5 = 2:  85c388a077 commit-graph.c: peel refs in 'add_ref_to_set'
3:  9ae8745dc0 = 3:  cef441b465 builtin/commit-graph.c: extract 'read_one_commit()'
4:  513a634f14 ! 4:  d449d83ce2 builtin/commit-graph.c: dereference tags in builtin
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
     +			if (opts.progress)
     +				progress = start_delayed_progress(
    -+					_("Analyzing commits from stdin"), 0);
    ++					_("Collecting commits from input"), 0);
      		}

      		while (strbuf_getline(&buf, stdin) != EOF) {
5:  7e9d8c1f1a = 5:  61887870c7 commit-graph.c: simplify 'fill_oids_from_commits'
6:  f2f018b54c = 6:  e393b16097 t5318: reorder test below 'graph_read_expect'
7:  6c2d130b0c ! 7:  ad373f05ff commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
     -			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
      			if (opts.progress)
      				progress = start_delayed_progress(
    - 					_("Analyzing commits from stdin"), 0);
    + 					_("Collecting commits from input"), 0);

      ## commit-graph.c ##
     @@ commit-graph.c: struct write_commit_graph_context {
--
2.26.0.113.ge9739cdccc
