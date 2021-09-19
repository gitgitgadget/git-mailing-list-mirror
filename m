Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9349CC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCAF60F92
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhISCSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 22:18:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:50526 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232448AbhISCSy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 22:18:54 -0400
Received: (qmail 17774 invoked by uid 109); 19 Sep 2021 02:17:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Sep 2021 02:17:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3242 invoked by uid 111); 19 Sep 2021 02:17:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Sep 2021 22:17:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 18 Sep 2021 22:17:28 -0400
From:   Jeff King <peff@peff.net>
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 3/4] difftool: use a strbuf to create the tmpdir path
Message-ID: <YUaduDIYoW8Fo+5s@coredump.intra.peff.net>
References: <20210919015729.98323-1-davvid@gmail.com>
 <20210919015729.98323-3-davvid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210919015729.98323-3-davvid@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 18, 2021 at 06:57:28PM -0700, David Aguilar wrote:

> +	/* Remove trailing slashes when $TMPDIR ends in '/'. */
> +	while (tmpdir.len > 0 && tmpdir.buf[tmpdir.len - 1] == '/') {
> +		strbuf_setlen(&tmpdir, tmpdir.len - 1);
> +	}
> +	strbuf_addstr(&tmpdir, "/git-difftool.XXXXXX");

It sounds like this should remove any directory separator (so on
Windows, it should also drop backslashes). You can use is_dir_sep() for
that, but better still, you can then do:

  strbuf_trim_trailing_dir_sep(&tmpdir);

-Peff
