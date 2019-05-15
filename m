Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5FE21F461
	for <e@80x24.org>; Thu, 16 May 2019 01:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEPBqV (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:21 -0400
Received: from thyrsus.com ([71.162.243.5]:58774 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfEOXkf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 19:40:35 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id C1EC84703049; Wed, 15 May 2019 19:40:34 -0400 (EDT)
Date:   Wed, 15 May 2019 19:40:34 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Jason Pyeron <jpyeron@pdinc.us>
Cc:     git@vger.kernel.org, 'Derrick Stolee' <stolee@gmail.com>
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190515234034.GB124956@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Pyeron <jpyeron@pdinc.us>:
> If we take the below example:
> 
> committer Name <user@domain> 1557948240 -0400
> 
> and we follow the rule that:
> 
> 1. any trailing zero after the decimal point MUST be omitted
> 2. if there are no digits after the decimal point, it MUST be omitted
> 
> This would allow:
> 
> committer Name <user@domain> 1557948240 -0400
> committer Name <user@domain> 1557948240.12 -0400
> 
> but the following are never allowed:
> 
> committer Name <user@domain> 1557948240. -0400
> committer Name <user@domain> 1557948240.000000 -0400
> 
> By following these rules, all previous commits' hash are unchanged. Future commits made on the top of the second will look like old commit formats. Commits coming from "older" tools will produce valid and mergeable objects. The loss precision has frustrated us several times as well.

Yes, that's almost exactly what I came up with.  I was concerned with upward
compatibility in fast-export streams, which reposurgeon ingests and emits.

But I don't quite understand your claim that there's no format
breakage here, unless you're implying to me that timestamps are already
stored in the git file system as variable-length strings.  Do they
really never get translated into time_t?  Good news if so.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


