Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89981F462
	for <e@80x24.org>; Wed, 22 May 2019 02:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfEVCTc (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 22:19:32 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:39288 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfEVCTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 22:19:32 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hTGqm-0008CC-2S; Wed, 22 May 2019 11:19:28 +0900
Date:   Wed, 22 May 2019 11:19:28 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com, jrnieder@google.com,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] revision: keep topo-walk free of unintersting commits
Message-ID: <20190522021928.tsmg2rij6l44xvdj@glandium.org>
References: <20190521131438.58394-1-dstolee@microsoft.com>
 <20190521135953.214701-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521135953.214701-1-dstolee@microsoft.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 09:59:53AM -0400, Derrick Stolee wrote:
> When updating the topo-order walk in b454241 (revision.c: generation-based
> topo-order algorithm, 2018-11-01), the logic was a huge rewrite of the
> walk logic. In that massive change, we accidentally included the
> UNINTERESTING commits in expand_topo_walk(). This means that a simple
> query like
> 
>     git rev-list --topo-order HEAD~1..HEAD
> 
> will expand the topo walk for all commits reachable from HEAD, and not
> just one commit.
> 
> This change should speed up these cases, but there is still a need
> for corrected commit-date for some A..B queries.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> 
> Sorry for the patch-spam, but I took a moment to check this command
> on the Git repo, and was able to reproduce the slowness. That didn't
> make sense to me, so I added some log messages to expand_topo_walk()
> and notices we were walking the UNINITERESTING commits. This is part
> of the reason the new logic is slower for A..B commands, but not the
> whole reason.
> 
> You'll want this patch as well for a test.

Both patches help, thanks.

Mike
