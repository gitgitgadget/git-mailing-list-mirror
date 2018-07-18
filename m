Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976DB1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 20:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeGRVL1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:11:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:51704 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729700AbeGRVL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:11:27 -0400
Received: (qmail 17635 invoked by uid 109); 18 Jul 2018 20:31:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 20:31:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3312 invoked by uid 111); 18 Jul 2018 20:31:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 16:31:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 16:31:52 -0400
Date:   Wed, 18 Jul 2018 16:31:52 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] add core.usereplacerefs config option
Message-ID: <20180718203152.GA26110@sigill.intra.peff.net>
References: <20180718201702.GA15306@sigill.intra.peff.net>
 <c36c1b42-3f37-b32d-08a8-2ced5d254149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c36c1b42-3f37-b32d-08a8-2ced5d254149@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 04:23:20PM -0400, Derrick Stolee wrote:

> This patch looks good to me. The only thing I saw was when I ran 'git grep
> check_replace_refs' and saw the following in environment.c:
> 
>     int check_replace_refs = 1; /* NEEDSWORK: rename to read_replace_refs */
> 
> This does help me feel confident that the case where the config value is
> missing will default to 'yes, please check replace refs', but also the
> NEEDSWORK could be something to either (1) do, or (2) remove the comment.
> Neither needs to happen as part of this patch.

Yeah, it was actually that comment that led me to Stefan's recent
c3c36d7de2 (replace-object: check_replace_refs is safe in multi repo
environment, 2018-04-11).

And ironically, back when I originally wrote this patch, it _was_ called
read_replace_refs. That changed in afc711b8e1 (rename read_replace_refs
to check_replace_refs, 2014-02-18), which was in turn picking up a
leftover from e1111cef23 (inline lookup_replace_object() calls,
2011-05-15).

Since Stefan's patch logically undoes e1111cef23, I think that's why he
put in the comment to move back to the old name.

Personally, I do not find one name any more informative than the other,
and would be happy to leave it as-is (dropping the comment).

But I'm also fine with following through on the "do". According to
c3c36d7de2, that was waiting for a calmer time in the code base. I guess
the best way to find out is to write the patch and see how terribly it
conflicts with pu. :)

> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks!

-Peff
