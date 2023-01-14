Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3ABC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 17:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjANRRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 12:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjANRRa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 12:17:30 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFD2B775
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 09:17:28 -0800 (PST)
Received: (qmail 30066 invoked by uid 109); 14 Jan 2023 17:17:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Jan 2023 17:17:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12010 invoked by uid 111); 14 Jan 2023 17:17:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Jan 2023 12:17:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 14 Jan 2023 12:17:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2] ci: do not die on deprecated-declarations warning
Message-ID: <Y8Ljp7yEWTUd92w8@coredump.intra.peff.net>
References: <xmqqv8l9n5fj.fsf@gitster.g>
 <xmqq7cxpkpjp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cxpkpjp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2023 at 09:13:14AM -0800, Junio C Hamano wrote:

> +# Libraries deprecate symbols while retaining them for a long time to
> +# keep software working with both older and newer versions of them.
> +# Getting warnings does help the developers' awareness, but we cannot
> +# afford to update too aggressively.  E.g. CURLOPT_REDIR_PROTOCOLS_STR
> +# is only available in 7.85.0 that deprecates CURLOPT_REDIR_PROTOCOLS
> +# but we cannot rewrite the uses of the latter with the former until
> +# 7.85.0, which was released in August 2022, becomes ubiquitous.
> +DEVELOPER_CFLAGS += -DCURL_DISABLE_DEPRECATION

This seems like a reasonable middle ground to me.

Though we could perhaps even just add it to the main Makefile, and
always pass it. People who aren't using DEVELOPER=1 might be annoyed by
the warnings (and might even be using -Werror themselves!).

-Peff
