Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA81C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2293E2067C
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="of8lzyvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKWXS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:18:27 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:38306 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKWXS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606173507; x=1637709507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yGnoBEuYd6OctBdLhFF7AxpMClMMvLsKQ50i4kYAuw0=;
  b=of8lzyvjxNFkbwBh5Qkhp1UjIquAUttFXBEleRgGFjHoAlW91L3tgvR/
   ti1t4ExnnwDUZtJxvPVC0LAM5e7vohzxp5S3gu2A+6j0XiiPj6VwVSgXG
   bS2Hx9+EZuaSoSl6yzZ5Qj4HAVj4WBzW7m5MIDW6V6hVWyqgHmYddOdWN
   M=;
X-IronPort-AV: E=Sophos;i="5.78,364,1599523200"; 
   d="scan'208";a="90189642"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Nov 2020 23:18:20 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 2FCDCA1769;
        Mon, 23 Nov 2020 23:18:19 +0000 (UTC)
Received: from EX13D06UEA003.ant.amazon.com (10.43.61.20) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Nov 2020 23:18:18 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D06UEA003.ant.amazon.com (10.43.61.20) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Nov 2020 23:18:18 +0000
Received: from dev-dsk-gerardu-1d-54592b62.us-east-1.amazon.com
 (10.200.254.64) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 23 Nov 2020 23:18:18 +0000
Received: by dev-dsk-gerardu-1d-54592b62.us-east-1.amazon.com (Postfix, from userid 5408343)
        id B71C14A9; Mon, 23 Nov 2020 23:18:18 +0000 (UTC)
Date:   Mon, 23 Nov 2020 23:18:18 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
CC:     Matheus Tavares <matheus.bernardino@usp.br>, <git@vger.kernel.org>
Subject: Re: RFC: auto-enabling parallel-checkout on NFS
Message-ID: <20201123231817.GA28189@dev-dsk-gerardu-1d-54592b62.us-east-1.amazon.com>
References: <9c999e38-34db-84bb-3a91-ae2a62b964b5@jeffhostetler.com>
 <20201119040117.67914-1-matheus.bernardino@usp.br>
 <212a2def-6811-b6e4-0550-ecae2fe0c02c@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <212a2def-6811-b6e4-0550-ecae2fe0c02c@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Thu, Nov 19, 2020 at 09:04:34AM -0500, Jeff Hostetler wrote:

> On 11/18/20 11:01 PM, Matheus Tavares wrote:
> >
> >On Mon, Nov 16, 2020 at 12:19 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> >>
> >>I can't really speak to NFS performance, but I have to wonder if there's
> >>not something else affecting the results -- 4 and/or 8 core results are
> >>better than 16+ results in some columns.  And we get diminishing returns
> >>after ~16.
> >
> >Yeah, that's a good point. I'm not sure yet what's causing the
> >diminishing returns, but Geert and I are investigating. Maybe we are
> >hitting some limit for parallelism in this scenario.
> 
> I seem to recall back when I was working on this problem that
> the unzip of each blob was a major pain point.  Combine this
> long delta-chains and each worker would need multiple rounds of
> read/memmap, unzip, and de-delta before it had the complete blob
> and could then smudge and write.

I think that there are two cases here:

1) (CPU bound case) On local machines with multiple cores and SSD disks,
   checkout is CPU bound and the parallel checkout works because the unzipping
   can now run on multiple CPUs in parallel. Shorter chains would use less CPU
   time and we'd see a smilar benefit on both paralell and sequential checkout.

2) (IO bound case) On networked file systems, file system IO is pretty much
   always the bottleneck for git and similar applications that use small files.
   On NFS calling open() is always a round trip, and so is close() (in the
   absence of delegations and O_CREAT). The latency of these calls depends on
   the NFS server and network distance, but 1ms is a reasonable order of
   magnitude when thinking about this. Beause this 1ms is a lot more than the
   typical CPU time to process a single blob, checkout will be IO bound.
   Parallel checkout works by allowing the application to maintain an IO depth
   > 1 for these workloads, which amortizes the network latency over multiple
   requests.

Regarding the diminishing returns: I did some initial analysis of Mattheus'
code and I'm not sure yet. I see the code achieving a high IO depth in our
server logs, which would indicate that the diminishing returns are caused by
file system contention. This would have to be some kind of general contention
since it happens both on NFS and EFS. I will do a deeper investigation on this
and will report what I find.

Best regards,
Geert
