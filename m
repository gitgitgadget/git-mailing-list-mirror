Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41F2C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 23:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjC2XYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjC2XYB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 19:24:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A725B90
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 16:23:48 -0700 (PDT)
Received: (qmail 17199 invoked by uid 109); 29 Mar 2023 23:23:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Mar 2023 23:23:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12441 invoked by uid 111); 29 Mar 2023 23:23:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Mar 2023 19:23:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Mar 2023 19:23:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stanislav M <stanislav.malishevskiy@gmail.com>,
        Stanislav Malishevskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey
 types.
Message-ID: <20230329232347.GB2314218@coredump.intra.peff.net>
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
 <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
 <xmqqlejrmj4y.fsf@gitster.g>
 <20230321172223.GA3119834@coredump.intra.peff.net>
 <xmqqjzzahufj.fsf@gitster.g>
 <CAEpdKf=pMcMn6q0wGGcrFN1yi1duguSNLDkqhDmvMBeKQ--yuA@mail.gmail.com>
 <20230323180159.GA1015351@coredump.intra.peff.net>
 <CAEpdKfm0S4tkLz8DMnkJmhMmJk8Cj1tUm7NbMe7kpATq0bkxCw@mail.gmail.com>
 <xmqqfs9n9yp4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs9n9yp4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 11:53:11AM -0700, Junio C Hamano wrote:

> > In my opinion they need the same set of tests which is used as usual
> > for https. But use the right certificate and key.
> > But I don't have any idea how to do that with hardware usb eToken in my case.
> 
> OK, so where does this put us, with respect to the change?  We have
> some behaviour change that we do not know how to test?  How would we
> know when we break it in the future?  It is not like the new feature
> is not useful enough that nobody would care if it gets broken by
> accident or anything like that, so...?
> 
> At least perhaps we can throw bogus strings in the environment and
> make sure cURL library gives complaints, or something?

I would be OK taking the patches without any further tests. It is not
really making anything worse in the sense that we already do not test
any of the client-cert stuff.

If we can cheaply add some tests that at least exercise the code and
hand off to curl, that is better than nothing, I guess.

I think the ideal would be a new t5565 that sets LIB_HTTPD_SSL
unconditionally and actually tests various client-cert formats and
requests using a made-on-the-fly cert. But I don't want to hold up a
patch we otherwise think is OK on the basis of long-term technical debt
we already have.

-Peff
