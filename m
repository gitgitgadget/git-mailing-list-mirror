Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C96A1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 06:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeKBPyA (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:54:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:37758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727859AbeKBPyA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:54:00 -0400
Received: (qmail 29905 invoked by uid 109); 2 Nov 2018 06:47:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 06:47:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1086 invoked by uid 111); 2 Nov 2018 06:47:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 02:47:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 02:47:52 -0400
Date:   Fri, 2 Nov 2018 02:47:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 5/8] push: add an advice on unqualified <dst> push
Message-ID: <20181102064751.GJ31216@sigill.intra.peff.net>
References: <20181026192734.9609-1-avarab@gmail.com>
 <20181026230741.23321-6-avarab@gmail.com>
 <xmqqva5l49np.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqva5l49np.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 02:14:02PM +0900, Junio C Hamano wrote:

> Any failure in the &&-chain (or the last grep) would not terminate
> the for loop, so for the purpose of determining the success of this
> test_expect_success, the last "blob" iteration is the only thing
> that matters.
> 
> Which is probably not what you want.  If testing all of these is
> important, then you can do this:
> 
> 	(
> 		exit_with=true &&
> 		for type in ...
> 		do
> 			... many ... &&
> 			... many ... &&
> 			... tests ... ||
> 			exit_with=false
> 		done
> 		$exit_with
> 	)
> 
> or just say "|| exit" and leave the loop (and the subprocess running
> it) early on the first failure.

You can skip the subshell and just "|| return 1" from the chain inside
the loop. We run the test snippets inside an extra layer of
function-call exactly to allow that.

-Peff
