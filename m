Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F09DC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A71610CB
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhJLVTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:19:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:38068 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233422AbhJLVTk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 17:19:40 -0400
Received: (qmail 1714 invoked by uid 109); 12 Oct 2021 21:17:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 21:17:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17727 invoked by uid 111); 12 Oct 2021 21:17:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 17:17:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 17:17:37 -0400
From:   Jeff King <peff@peff.net>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Commit ae1a7eefff may have broken git behind a firewall
Message-ID: <YWX7cd5e5q84CDEv@coredump.intra.peff.net>
References: <CAMe9rOrononRUYK0HmW_tknApUV+ZJeDBwOYMa1Ax-VHXZmoJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMe9rOrononRUYK0HmW_tknApUV+ZJeDBwOYMa1Ax-VHXZmoJQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 02:03:39PM -0700, H.J. Lu wrote:

> https://github.com/git/git/commit/ae1a7eefff
> 
> may have broken git behind a firewall:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2013288
> 
> I am behind a firewall and using gitproxy:
> 
> exec socat - socks4:proxy-server-name:$1:$2

It's not the firewall; it's socat not handling half-duplex shutdown very
well (though you are right that it is related to the commit you found;
that's when Git started closing the write pipe when it's done writing).

More discussion in this thread:

  https://lore.kernel.org/git/YS1Bni+QuZBOgkUI@coredump.intra.peff.net/

(the short answer is: use "socat -t 10").

-Peff
