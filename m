Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3E61F462
	for <e@80x24.org>; Tue, 21 May 2019 02:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEUCid (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 22:38:33 -0400
Received: from thyrsus.com ([71.162.243.5]:40264 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfEUCid (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 22:38:33 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 9D1CC470485F; Mon, 20 May 2019 22:38:32 -0400 (EDT)
Date:   Mon, 20 May 2019 22:38:32 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
Message-ID: <20190521023832.GA130381@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190521013250.3506B470485F@snark.thyrsus.com>
 <20190521015703.GB32230@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521015703.GB32230@google.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com>:
> Hi!
> 
> Eric S. Raymond wrote:
> 
> > One reason I am sure of this is the SHA-1 to whatever transition.
> > We can't count on the successor hash to survive attack forever.
> > Accordingly, git's design needs to be stable against the possibility
> > of having to accommodate multiple future hash algorithms in the
> > future.
> 
> Have you read through Documentation/technical/hash-function-transition?  It
> takes the case where the new hash function is found to be weak into account.
> 
> Hope that helps,
> Jonathan

Reading now...

At first sight I think it looks pretty compatible with what I am proposing.
The goals anyway, some of the implementation tactics would change a bit.

I think it's a weakness, though, that most of it is written as though it
assumes only one hash transition will be necessary.  (This is me thinking
on long timescales again.)

Instead of having a gpgsig-sha256 field, I would change the code so all
hash cookies have an delimited optional prefix giving the hash-algorithm
type, with an absent prefix interpreted as SHA-1.

I think the idea of mapping future hashes to SHA-1s, which are then
used as fs lookup keys, is sound.  The same technique (probably the
same code!) could be used to map the otherwise uninterpreted
commit-IDs I'm proposing to lookup keys.

I should have said in my previous mail that I'm prepared to put
my coding fingers into making all this happen. I am pretty sure my
gramty manager will approve.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


