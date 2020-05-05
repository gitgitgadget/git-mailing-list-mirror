Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81ADC47257
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23BE2078D
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="R5ezFSCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgEEQN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgEEQN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:13:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAF9C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:13:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hi11so1373763pjb.3
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XjTYRMupdoMEHBv/lt6voBwnF7cdFXCgbMqFQ+SookU=;
        b=R5ezFSCldT6lWMOnUA13UQBe4V05ol7skxs9eLO7uisb1LpBxxHRbfd+o3Nwn28Din
         qnntOk2Tt+4Mm819ksdD6ycnbkq9l0WZe2vCmwwVucpnX9EyY7uKXpqFGb5hXGSPV96N
         yKrlfui4gWxJkEMCEGdyrJqVSiZ6Qn6trsyaXvwXDtJTpLSz3m8SO2HD9FRra1NqiuBV
         Tc98lHpWhlSou3WnYPOtFLjy5JAZeRV3aLAFdbNipD24EhGLbMyXC6B54Ofn3mSaHzhm
         OcbdJPN1I2kiEKzyPbqU7Xl3ExevydSE6o/+JkOGnPLLdbslJet+bmxbYIJL8arkzhoP
         4ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XjTYRMupdoMEHBv/lt6voBwnF7cdFXCgbMqFQ+SookU=;
        b=A+WImAfb6TC6Z1M4bgVF8WN4iNM49E37BUSZ4SDqygyPmURavAGB510nFjFoSod542
         toEhMJYlyxDZGIsWuxAWqrCeFl46oYgWYfpESV0b8felXNlKRjvrU4gsxhrxb+wQQjPp
         4qDW6aJ90D9Fnn0x5sHQOP7n5q8Uvl7hvaZ6HrnFPwoxnh9G2ks30g1nZVkWrQXxxmYX
         LjPMP/V/5e9bqLLc6+I1+H07wH0JV7CkUdSu6s5V6XlETL1v2Q0nX0UAqJdEirPFLf6v
         JBbXSlhIY/9jTkgGwIkhkEMC3g5jwjw82J1XMVnDNXlfhUbiDINuWJxiqAtR9w+ZuZr7
         QBrg==
X-Gm-Message-State: AGi0PuaVd9bic83ftV3BlusaD33U4QA3+/hR2QA+Z/volqIt8dSTFBxT
        rO4XlQI3cmoZDfyv7gLQ4mWbrg==
X-Google-Smtp-Source: APiQypLdQuf0q8YHyQTTDriFeva3iCIBS6E0oNJCrMMRL18yJYNeTeDA8ZmejqTAMziMRsxks8nAyA==
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr3958016pjk.58.1588695205323;
        Tue, 05 May 2020 09:13:25 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o11sm1772711pgp.62.2020.05.05.09.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:13:24 -0700 (PDT)
Date:   Tue, 5 May 2020 10:13:23 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH 2/8] commit-graph.c: show progress of finding reachable
 commits
Message-ID: <20200505161323.GE69300@syl.local>
References: <cover.1588641176.git.me@ttaylorr.com>
 <5bdbeaf374b6050670f800fcdd3b54ddd0750754.1588641176.git.me@ttaylorr.com>
 <b8f393fa-fec8-205e-0987-f4f6ff9b3531@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8f393fa-fec8-205e-0987-f4f6ff9b3531@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 07:50:50AM -0400, Derrick Stolee wrote:
> On 5/4/2020 9:13 PM, Taylor Blau wrote:
> > When 'git commit-graph write --reachable' is invoked, the commit-graph
> > machinery calls 'for_each_ref()' to discover the set of reachable
> > commits.
> >
> > Right now the 'add_ref_to_set' callback is not doing anything other than
> > adding an OID to the set of known-reachable OIDs. In a subsequent
> > commit, 'add_ref_to_set' will presumptively peel references. This
> > operation should be fast for repositories with an up-to-date
> > '$GIT_DIR/packed-refs', but may be slow in the general case.
> >
> > So that it doesn't appear that 'git commit-graph write' is idling with
> > '--reachable' in the slow case, add a progress meter to provide some
> > output in the meantime.
> >
> > In general, we don't expect a progress meter to appear at all, since
> > peeling references with a 'packed-refs' file is quick. If it's slow and
> > we do show a progress meter, the subsequent 'fill_oids_from_commits()'
> > will be fast, since all of the calls to
> > 'lookup_commit_reference_gently()' will be no-ops.
> >
> > Both progress meters are delayed, so it is unlikely that more than one
> > will appear. In either case, this intermediate state will go away in a
> > handful of patches, at which point there will be at most one progress
> > meter.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  commit-graph.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 00da281f39..8f61256b0a 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -1320,6 +1320,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
> >
> >  struct refs_cb_data {
> >  	struct oidset *commits;
> > +	struct progress *progress;
> >  };
> >
> >  static int add_ref_to_set(const char *refname,
> > @@ -1328,6 +1329,8 @@ static int add_ref_to_set(const char *refname,
> >  {
> >  	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
> >
> > +	display_progress(data->progress, oidset_size(data->commits) + 1);
> > +
> >  	oidset_insert(data->commits, oid);
> >  	return 0;
> >  }
> > @@ -1342,12 +1345,17 @@ int write_commit_graph_reachable(struct object_directory *odb,
> >
> >  	memset(&data, 0, sizeof(data));
> >  	data.commits = &commits;
> > +	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
> > +		data.progress = start_delayed_progress(
> > +			_("Finding reachable commits"), 0);
>
> Is this the right phrase to use? This seems too close to the progress
> indicator "Expanding reachable commits in commit graph" which is walking
> commits.
>
> An alternative could be: "Collecting referenced commits"

That's a great suggestion. I'll apply that locally. For what it's worth,
I don't feel that strongly about it either, but it's not hard to change
;).

> Outside of this string, I have no complaints. I also don't feel too
> strongly about the string, either.
>
> Thanks,
> -Stolee

Thanks,
Taylor
