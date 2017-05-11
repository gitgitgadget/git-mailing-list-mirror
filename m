Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523CD2018D
	for <e@80x24.org>; Thu, 11 May 2017 17:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755898AbdEKRA4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:00:56 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36243 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755720AbdEKRAy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:00:54 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so16712676pfg.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hDEKwyvggY57Bvisk2EltEBMiIR+8RtK4FuSuHXE4ks=;
        b=a6mYljjocKkpkyjGBvN0NRoET+Y4nUkCmJwEgiB3tLsdtJmFwhYjZg6ktufoShn9D+
         caBCq57s7HUVmMDJDS+Yja3E1bJFa85IP97RjuQQ4fL8W5Mhcg96QddbFD6aNMU2Tj9B
         7VC8jKPNj1Kn5hwJEnOFJn2fIScttB3g9OuAiMGIvp8+djKS0EYp419ywCeNnLzKd5KA
         /GLL7qVsqTgIwRqe2B2bzvR0arV224CW3UWXz3L8TVDisX6gJRca1HF1n8/u5YVAfNyp
         dyastI/Y3xam/yhACedkyMmDYANgcPTOq3U9xwAsHN+yW8E2e7gjH8EoqFlKav+Y7EKn
         c6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDEKwyvggY57Bvisk2EltEBMiIR+8RtK4FuSuHXE4ks=;
        b=jT+42phfLIVmN2WrCsQLrPFyCHe5/5lMq1KmtF0LhpogPyRAKehOWFFUU7gYXCHBTc
         QFmH9DVb/a0b2jwyGIwqQY8qi1SVoMrU5h1YHFpqLe4pih3N5S8e3nwZQzTaehgl8jZh
         7494YEg5n1/pXquo9/YbLethYbT/kT07sKT2QJkqQXNY+xA2TvYdRKcmZ/rBHi7tPGSk
         d8Y4MCNF6BDPjNAOT76Cv4qsN8ljkOpZp3LPjRQtSHcoHsDogYEHArWQ/kmfQ26gIO7K
         mZmU8aG9jSKoImxkNpFc089EHRnhnAsy6sGVpUR3l/wafY1FCprJhMDJi4fsQBp/KdSf
         jXgQ==
X-Gm-Message-State: AODbwcD+gVwrQASG4+4KX9Bj3gNYs2XxefRl4Du3n/ENq+xA1KXdIoH0
        4nBP9F2uQysdtZhk
X-Received: by 10.98.69.193 with SMTP id n62mr118552pfi.216.1494522053280;
        Thu, 11 May 2017 10:00:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id q28sm1150936pgc.0.2017.05.11.10.00.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 10:00:52 -0700 (PDT)
Date:   Thu, 11 May 2017 10:00:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, spearce@spearce.org
Subject: Re: [PATCH v3] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170511170050.GA83655@google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170510221157.8971-1-jonathantanmy@google.com>
 <20170511100553.ptyazchujgdfxotl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511100553.ptyazchujgdfxotl@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Jeff King wrote:
> On Wed, May 10, 2017 at 03:11:57PM -0700, Jonathan Tan wrote:
> 
> > fetch-pack, when fetching a literal SHA-1 from a server that is not
> > configured with uploadpack.allowtipsha1inwant (or similar), always
> > returns an error message of the form "Server does not allow request for
> > unadvertised object %s". However, it is sometimes the case that such
> > object is advertised. This situation would occur, for example, if a user
> > or a script was provided a SHA-1 instead of a branch or tag name for
> > fetching, and wanted to invoke "git fetch" or "git fetch-pack" using
> > that SHA-1.
> > 
> > Teach fetch-pack to also check the SHA-1s of the refs in the received
> > ref advertisement if a literal SHA-1 was given by the user.
> 
> Stepping back a bit, what does this mean for a world where we implement
> protocol extensions to let the client specify a set of refspecs to limit
> the advertisement?
> 
> If we give the server our usual set of fetch refspecs, then we might
> fail to fulfill a request that would have been advertised outside of
> that set. And the behavior is confusing and non-transparent to the user.
> I don't think that really makes sense, though; the advertisement we ask
> for from the server should include only the bits we're interested in for
> _this_ fetch.
> 
> If we tell the server "we are interested in abcd1234", then it's not
> going to find any matching ref by name, obviously. So should servers
> then treat 40-hex names in the incoming refspecs as a request to show
> any names which have a matching sha1? That works against any server-side
> optimizations to avoid looking at the complete set of refs, but it would
> only have to kick in when the user actually specified a single SHA-1
> (and even then only when allowAnySHA1 isn't on). So that's probably
> workable.
> 
> None of this is your problem now either way; the advertisement-limiting
> extension is still vaporware, albeit one we've discussed a lot. I just
> wanted to make sure we weren't painting ourselves into any corners. And
> I think this case could probably be handled.

I can't remember, is there any reason why it is still vaporware? As in
what is holding us back from doing the advertisement-limiting (or doing
away with the initial ref  advertisement)?

-- 
Brandon Williams
