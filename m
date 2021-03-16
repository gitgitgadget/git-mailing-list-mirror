Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053D3C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60AA64F90
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhCPV3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:29:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:38920 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhCPV2n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:28:43 -0400
Received: (qmail 21460 invoked by uid 109); 16 Mar 2021 21:28:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Mar 2021 21:28:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2127 invoked by uid 111); 16 Mar 2021 21:28:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Mar 2021 17:28:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Mar 2021 17:28:41 -0400
From:   Jeff King <peff@peff.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eli Schwartz <eschwartz@archlinux.org>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
Message-ID: <YFEjCU1jgrsPIhvk@coredump.intra.peff.net>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga>
 <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga>
 <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
 <C9YUBUYH7PWU.3PHDZR2YCUEOX@taiga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C9YUBUYH7PWU.3PHDZR2YCUEOX@taiga>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 10:21:13AM -0400, Drew DeVault wrote:

> > It's difficult enough to handle parsing of SSH specifications and
> > distinguish them uniformly from Windows paths (think of an alias named
> > "c"), so I'd prefer we didn't add additional complexity to handle this
> > case.
> 
> There's no additional complexity here: git remotes are URIs, and any
> implementation which parses them as such already deals with this case
> correctly. Any implementation which doesn't may face all kinds of
> problems as a consequence: SSH without a user specified, HTTPS with
> Basic auth in the URI username/password fields (or just the password,
> which is also allowed), and so on. Any sane and correct implementation
> is pulling in a URI parser here, and if not, I don't think it's fair for
> git to constrain itself in order to work around some other project's
> bugs.

Git remotes are most definitely not just URIs. Some valid remotes are:
".", "foo", "/tmp/foo", "c:\foo", "example.com:foo". The parser inside
Git has rules to distinguish these from actual rfc3986-compliant URIs.

Now I don't know much about the parsing code in, say, git-lfs, or how
much of pain it would be to add a new scheme for something that _does_
conform to rfc3986. But it's not necessarily as easy as "you should be
using a compliant URI parser".

-Peff
