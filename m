Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F43C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B047161026
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhIJODq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:03:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:43840 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231963AbhIJODp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:03:45 -0400
Received: (qmail 5746 invoked by uid 109); 10 Sep 2021 14:02:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:02:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25273 invoked by uid 111); 10 Sep 2021 14:02:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:02:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:02:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
Message-ID: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
 <YTOW352xtsbvJcKy@coredump.intra.peff.net>
 <20210907211128.mauwgxupbredgx7w@meerkat.local>
 <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
 <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
 <xmqqee9x1wvh.fsf@gitster.g>
 <xmqqa6kl1wjs.fsf@gitster.g>
 <YTtECuP2/A6+EI4J@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTtECuP2/A6+EI4J@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 07:39:54AM -0400, Jeff King wrote:

> I'll re-roll with that change, plus some documentation changes adapted
> to this new approach.

Here's what I came up with. I think this should replace both
jk/http-backend-handle-proto-header and kr/doc-webserver-config-for-v2.
The latter does give some specific nginx tips which I didn't carry over,
but they shouldn't be necessary after the change in http-backend. If we
do want to include them, they can be mentioned as optional if we later
add an nginx example config to the http-backend manpage.

  [1/5]: t5551: test v2-to-v0 http protocol fallback
  [2/5]: http-backend: handle HTTP_GIT_PROTOCOL CGI variable
  [3/5]: docs/http-backend: mention v2 protocol
  [4/5]: docs/git: discuss server-side config for GIT_PROTOCOL
  [5/5]: docs/protocol-v2: point readers transport config discussion

 Documentation/git-http-backend.txt      | 26 ++++++++++++++++++++++++-
 Documentation/git-upload-pack.txt       |  8 ++++++++
 Documentation/git.txt                   | 15 ++++++++++++++
 Documentation/technical/protocol-v2.txt |  8 +++++++-
 http-backend.c                          |  4 ++++
 t/lib-httpd/apache.conf                 |  7 +++++--
 t/t5551-http-fetch-smart.sh             |  9 +++++++++
 7 files changed, 73 insertions(+), 4 deletions(-)

-Peff
