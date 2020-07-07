Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABFBC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF912065D
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wG8spo7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgGGPRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgGGPRi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 11:17:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4DC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 08:17:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so38456237qko.7
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ckuIuKyyfxKaWqfxzHAmG46pdRyS+dASuCj4BQScpA=;
        b=wG8spo7ciSkdwkhWINa3ZelhUGO+Ox3wBrmcczIl0mxrE+S2zh8MHmhvpSWkchaHNt
         EDJwsLCa8W/8Pq7DLREGfSlP3qAAx9sa81MB032ls5GXb39Mx7tFlhWDWjtwqpxDq20F
         kp8ayj0KD8oMxADSvnhHr4tvQPKdlxe9mnE2psBEOsGZdCKkDuTj0gDBqtvZae9jIEDg
         uyZ165pb/xbDfBkS/1CD4kI31b8RPg6Ry2DMnvrLKmZPNvD7Miq68M6X9IMpg/4n4zXi
         jV+SqCMJA/IWfgIJz49Lg3N3k99XD0TchbppjWTT/2bu/yIOvjHr+NppQfly6VndwSRg
         GwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ckuIuKyyfxKaWqfxzHAmG46pdRyS+dASuCj4BQScpA=;
        b=CBUW1NUabvDeZinSIjJoe/k0u2YD1M8VFGE17TwtweqclPpoSW+LM8n3ZF+B9wsuFB
         kevdEJ2eVrzoP4ZTsteNLDTr9pQXTPSUKIcXnuTck4ARrSG/RyTFww0trld5o4y1RnP4
         nIewmC+CNi1RNiePZxgQbaTsFuvK0Vl5Ip03YDP5M5qyFWOk/lfKRBUnlVSQloCDEtx5
         wt0fDuRzqIHEhmWjvtPiqfubwhbrrZpKnGbbWntiV7L86p6pAtigiweO7ZT/zjgO6v6c
         B0jADzknzT6UjM6HQeUjBAL/fllkdhnZhTGOT6mtSjK8yk3rc6UNFq47Rvgbm0hE1ejt
         pF3g==
X-Gm-Message-State: AOAM532D729Y1YM/RtU/119pMDc0BSlyfEBG5WnKxQqObjIMqy1fOSsA
        NSQiU1Pvpm+mGUF1c4NoTnB3fQ==
X-Google-Smtp-Source: ABdhPJw2l9icpMJZR31NIz/IpkrWWxut1Z8ZNyw+zxFeEQ0PkNNJOsPMTjIhEUllQjl3GFO+uiuO1w==
X-Received: by 2002:a37:dcc:: with SMTP id 195mr50991494qkn.251.1594135057694;
        Tue, 07 Jul 2020 08:17:37 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:cc04:7df5:37b0:651d])
        by smtp.gmail.com with ESMTPSA id x34sm18159039qtd.44.2020.07.07.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:17:36 -0700 (PDT)
Date:   Tue, 7 Jul 2020 11:17:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] experimental: default to fetch.writeCommitGraph=false
Message-ID: <20200707151735.GA27992@syl.lan>
References: <20200707062039.GC784740@google.com>
 <xmqq8sfv745r.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sfv745r.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Jul 07, 2020 at 08:09:36AM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> > The fetch.writeCommitGraph feature makes fetches write out a commit
>
> > In other words:
> >
> > - this patch only affects behavior with feature.experimental=true
> >
> > - it makes feature.experimental match the configuration Google has
> >   been using for the last few months, meaning it would leave users in
> >   a better tested state than without it
> >
> > - this should improve testing for other features guarded by
> >   feature.experimental, by making feature.experimental safer to use
>
>
> In other words, fetch.writeCommitGraph in its current form is too
> broken to be recommended even for brave souls with "experimental"
> bit on.
>
> I wonder if we perhaps wnat to add to the documentation for
> writeCommitGraph configuration that its use is currently not
> recommended in a shallow clone or something (I know it is not
> a problem just to use it with shallow but the breakage needs
> to involve unshallowing, but by definition those who do not
> use shallow would not hit the unshallowing bug, so...).

I think this is a good direction if you don't want to take the patch I
sent in [1] for v2.28.0. If you do, though, I don't think that this
would be necessary.

> > Reported-by: Jay Conrod <jayconrod@google.com>
> > Helped-by: Taylor Blau <me@ttaylorr.com>
> > Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> > ---
> > I realize this is late to send.  That said, as described above, I
> > think it's a good way to buy time by minimizing user exposure to
> > fetch.writeCommitGraph=true until a fix for it is well cooked.
> >
> > In other words, I'd like to see this patch in Git 2.28-rc0.
>
> Yes, I do, too.
>
> Thanks.
>
> > diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> > index b1a9b1461d3..b20394038d1 100644
> > --- a/Documentation/config/fetch.txt
> > +++ b/Documentation/config/fetch.txt
> > @@ -90,5 +90,4 @@ fetch.writeCommitGraph::
> >  	the existing commit-graph file(s). Occasionally, these files will
> >  	merge and the write may take longer. Having an updated commit-graph
> >  	file helps performance of many Git commands, including `git merge-base`,
> > -	`git push -f`, and `git log --graph`. Defaults to false, unless
> > -	`feature.experimental` is true.
> > +	`git push -f`, and `git log --graph`. Defaults to false.
> > diff --git a/repo-settings.c b/repo-settings.c
> > index dc6817daa95..0918408b344 100644
> > --- a/repo-settings.c
> > +++ b/repo-settings.c
> > @@ -51,14 +51,14 @@ void prepare_repo_settings(struct repository *r)
> >  		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
> >  		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
> >  	}
> > +
> >  	if (!repo_config_get_bool(r, "fetch.writecommitgraph", &value))
> >  		r->settings.fetch_write_commit_graph = value;
> > -	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
> > -		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
> > -		UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);
> > -	}
> >  	UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 0);
> >
> > +	if (!repo_config_get_bool(r, "feature.experimental", &value) && value)
> > +		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
> > +
> >  	/* Hack for test programs like test-dump-untracked-cache */
> >  	if (ignore_untracked_cache_config)
> >  		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20200707144338.GA26342@syl.lan/T/#t
