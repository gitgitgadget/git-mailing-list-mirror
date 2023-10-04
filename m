Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C13E7C4C6
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 14:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjJDOrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 10:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjJDOrj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 10:47:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D69C1
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 07:47:36 -0700 (PDT)
Received: (qmail 7659 invoked by uid 109); 4 Oct 2023 14:47:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Oct 2023 14:47:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5603 invoked by uid 111); 4 Oct 2023 14:47:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Oct 2023 10:47:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Oct 2023 10:47:34 -0400
From:   Jeff King <peff@peff.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org
Subject: Re: Is SANITIZE=leak make test unreliable for anyone else?
Message-ID: <20231004144734.GA1143669@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
 <878r8j2mu1.fsf@email.froward.int.ebiederm.org>
 <20231004132132.GC607079@coredump.intra.peff.net>
 <871qea31xf.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871qea31xf.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2023 at 09:19:40AM -0500, Eric W. Biederman wrote:

> What I see on a random failure looks like:
> 
> > make -C t/ all
> > make[1]: Entering directory '/home/user/projects/git/git/t'
> > rm -f -r 'test-results'
> > GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT && make aggregate-results-and-cleanup
> > make[2]: Entering directory '/home/user/projects/git/git/t'
> > *** t0000-basic.sh ***
> > Segmentation fault
> > error: test_bool_env requires bool values both for $GIT_TEST_PASSING_SANITIZE_LEAK and for the default fallback
> 
> Which doesn't sound like anything you have described so I am guessing it
> is something with my environment I need to track down.

No, that seems different entirely. You'll have to figure out which
program is segfaulting and why (if you can see it in a script besides
t0000 you're probably better off, as that one is a maze of
tests-within-tests, since it is testing the test-harness itself).

Although the "error" you see maybe implies that it is failing early on
in test-lib.sh, when we are calling "test-tool env-helper". If that is
segfaulting there is probably something very wrong with your build.

-Peff
