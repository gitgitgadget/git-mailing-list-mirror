Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B641DC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 11:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0522083B
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 11:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgFSL7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:59:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:37064 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732226AbgFSL7B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 07:59:01 -0400
Received: (qmail 2173 invoked by uid 109); 19 Jun 2020 11:59:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Jun 2020 11:59:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13886 invoked by uid 111); 19 Jun 2020 11:59:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jun 2020 07:59:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Jun 2020 07:58:59 -0400
From:   Jeff King <peff@peff.net>
To:     "Paul S. Strauss" <pss@acm.org>
Cc:     git@vger.kernel.org
Subject: Re: git config not following include paths by default
Message-ID: <20200619115859.GA1835585@coredump.intra.peff.net>
References: <6aab7843-7ece-5499-c074-a5fa8ef68beb@acm.org>
 <b9f47155-e6ef-5868-898d-f5a703e2fd94@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9f47155-e6ef-5868-898d-f5a703e2fd94@acm.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 01:40:11PM -0700, Paul S. Strauss wrote:

> The problem is related to my having GIT_CONFIG set to a file other than
> ~/.gitconfig - when I unset GIT_CONFIG and copied my config file to
> ~/.gitconfig, the include worked as expected.

That's working as designed. From git-config(1):

   --[no-]includes
       Respect include.* directives in config files when looking up
       values. Defaults to off when a specific file is given (e.g.,
       using --file, --global, etc) and on when searching all config
       files.

The reasons for that are historical. Includes were added much later, and
you would probably not want "git config --file=.gitmodules" against an
untrusted input to be able to include from anywhere on your filesystem.

$GIT_CONFIG works the same way (as it's equivalent to using --file).  We
generally discourage the use of the environment variable (and its
existence is yet another historical compatibility thing). If you tell us
more about what you're trying to accomplish with it, we might be able to
suggest a better solution.

-Peff
