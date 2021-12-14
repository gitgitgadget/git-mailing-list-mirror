Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE67C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 13:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhLNNmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:42:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:51462 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhLNNmy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 08:42:54 -0500
Received: (qmail 13720 invoked by uid 109); 14 Dec 2021 13:42:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 13:42:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24597 invoked by uid 111); 14 Dec 2021 13:42:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 08:42:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 08:42:53 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2 4/5] range-diff.c: rename "n" to "column_count" in
 get_correspondences()
Message-ID: <YbifXSlwXfMX+Wgl@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
 <RFC-patch-v2-4.5-f8bbe1954fc-20211210T122901Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-v2-4.5-f8bbe1954fc-20211210T122901Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 01:30:41PM +0100, Ævar Arnfjörð Bjarmason wrote:

> In preparation for using the COST macro in linear-assignment.c rename
> the "n" variable, it assumes that the "n" in "a + n * b" is named
> "column_count".

OK, makes sense.

One funny thing:

> diff --git a/range-diff.c b/range-diff.c
> index b2fcc6f66e0..b2e7db2c954 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -308,13 +308,13 @@ static int diffsize(const char *a, const char *b)
>  static void get_correspondences(struct string_list *a, struct string_list *b,
>  				int creation_factor)
>  {
> -	int n = a->nr + b->nr;
> +	int column_count = st_add(a->nr, b->nr);

Assigning the result of st_add() to an int nullifies the point of using
it in the first place. :)

I suspect this was a mistake from rebasing, and you meant only to change
the name here, and leave the st_add() for the next commit when the type
changes.

> [...]

The rest looks good.

-Peff
