Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F68C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D5020722
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wvOYwxAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCVPrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:47:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35878 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgCVPrw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 11:47:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id i13so6194215pfe.3
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d2bcqV5pdEHrT73zlY8YE8O0oc12OXqkygIB6wyZ5wc=;
        b=wvOYwxAM6ZQtReNcvouepcOXH1CAUVPWwdd5HcDKrcBGo/RZnqmnw+AnjBF1z9+h3Z
         L6hoWXruPxaLSCNtPOAXl9ydPAqDKuZoz4gvMT5eBqJd7uOMSteaYWNUkAvRvEaruSwW
         eD13CkW4ldIlIIZikhBiFe+yBKwp0DpCC9rQ3NharGkkK37sqVLTF1oeUcUuTVlqbfuB
         CD5Ve91MwOiX3XkqM8gCFhDX0ZU6kzlOhOqR20U/n53OMcvtIRHpybaTDZpL8J7MIp0B
         17wYoSBsZ2RL/nlTV9S7c6d4QUAkmrkNmx5AhXqa4rkkIdbrbqErrxTPy29mnmVmrNNv
         8huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d2bcqV5pdEHrT73zlY8YE8O0oc12OXqkygIB6wyZ5wc=;
        b=jzhZZdZfNkIf/ko24VccXKRzIhPob+MGykc5oM+dqwZ3mHfaE92K9Wp8W5cvSsoFbQ
         LXcRDNFpJQRGIElVqtzveadxnx41ZNTv0iOOp26vBP9PmyewMvUK/ZVmpYhvpDWAtgfG
         N3245hbc6O+OGKXSQ1hTBmxZhis+MCQT2jo4nvwLpn66IbFAvL4jR1tWl1tcxJI34Gqd
         s+KjgRIV0as2rMr69eAwg988va55YhAl4RiFifvZH6BRHxLtpBggQ9LLnrkL3Gr0gh4L
         wD5jlriKdDh/J4o6ZvtFLE9Ad27ExVooR8hJN9JS4f3vQjbsOWCOASK4HfaLlH//HBM0
         C6sw==
X-Gm-Message-State: ANhLgQ3q2UtcW0jIkdNuVn/se156KkI3RKMY0kLLXm+HhLcvPl3YyEY8
        z+MlguQO/e/j499mTe5H2ECfZP3Y+rQ=
X-Google-Smtp-Source: ADFU+vtu0Qlfz+FwSQmI/VTvPc3rjUypUFEN8VeSOPdRHgBBjzBqe3r7nH8Qv7orgo10sbetyQzjPQ==
X-Received: by 2002:aa7:988f:: with SMTP id r15mr20505251pfl.252.1584892071507;
        Sun, 22 Mar 2020 08:47:51 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 144sm11041855pfx.184.2020.03.22.08.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 08:47:51 -0700 (PDT)
Date:   Sun, 22 Mar 2020 09:47:49 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200322154749.GB53402@syl.local>
References: <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
 <20200322002005.GA48038@syl.local>
 <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
 <20200322054916.GB578498@coredump.intra.peff.net>
 <20200322060434.GC578498@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322060434.GC578498@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 02:04:34AM -0400, Jeff King wrote:
> On Sun, Mar 22, 2020 at 01:49:16AM -0400, Jeff King wrote:
>
> > [1] I'm actually not quite sure about correctness here. It should be
> >     fine to generate a graph file without any given commit; readers will
> >     just have to load that commit the old-fashioned way. But at this
> >     phase of "commit-graph write", I think we'll already have done the
> >     close_reachable() check. What does it mean to throw away a commit at
> >     this stage? If we're the parent of another commit, then it will have
> >     trouble referring to us by a uint32_t. Will the actual writing phase
> >     barf, or will we generate an invalid graph file?
>
> It doesn't seem great. If I instrument Git like this to simulate an
> object temporarily "missing" (if it were really missing the whole repo
> would be corrupt; we're trying to see what would happen if a race causes
> us to momentarily not see it):

This is definitely a problem on either side of this patch, which is
demonstrated by the fact that you applied your changes without my patch
on top (and that my patch isn't changing anything substantial in this
area like removing the 'continue' statement).

Should we address this before moving on with my patch? I think that we
*could*, but I'd rather go forward with what we have for now, since it's
only improving the situation, and not introducing a new bug.

> diff --git a/commit-graph.c b/commit-graph.c
> index 3da52847e4..71419c2532 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1596,6 +1596,19 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
>  	}
>  }
>
> +static int pretend_commit_is_missing(const struct object_id *oid)
> +{
> +	static int initialized;
> +	static struct object_id missing;
> +	if (!initialized) {
> +		const char *x = getenv("PRETEND_COMMIT_IS_MISSING");
> +		if (x)
> +			get_oid_hex(x, &missing);
> +		initialized = 1;
> +	}
> +	return oideq(&missing, oid);
> +}
> +
>  static void merge_commit_graph(struct write_commit_graph_context *ctx,
>  			       struct commit_graph *g)
>  {
> @@ -1612,6 +1625,11 @@ static void merge_commit_graph(struct write_commit_graph_context *ctx,
>
>  		load_oid_from_graph(g, i + offset, &oid);
>
> +		if (pretend_commit_is_missing(&oid)) {
> +			warning("pretending %s is missing", oid_to_hex(&oid));
> +			continue;
> +		}
> +
>  		/* only add commits if they still exist in the repo */
>  		result = lookup_commit_reference_gently(ctx->r, &oid, 1);
>
>
> and then I make a fully-graphed repo like this:
>
>   git init repo
>   cd repo
>   for i in $(seq 10); do
>     git commit --allow-empty -m $i
>   done
>   git commit-graph write --input=reachable --split=no-merge
>
> if we pretend a parent is missing, I get a BUG():
>
>   $ git rev-parse HEAD |
>     PRETEND_COMMIT_IS_MISSING=$(git rev-parse HEAD^) \
>     git commit-graph write --stdin-commits --split=merge-all
>   warning: pretending 35e6e15c738cf2bfbe495957b2a941c2efe86dd9 is missing
>   BUG: commit-graph.c:879: missing parent 35e6e15c738cf2bfbe495957b2a941c2efe86dd9 for commit d4141fb57a9bbe26b247f23c790d63d078977833
>   Aborted
>
> So it seems like just skipping here (either with the new patch or
> without) isn't really a good strategy.
>
> -Peff
Thanks,
Taylor
