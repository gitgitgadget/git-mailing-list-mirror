Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA6C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 13:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhLNNji (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:39:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:51434 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhLNNji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 08:39:38 -0500
Received: (qmail 13676 invoked by uid 109); 14 Dec 2021 13:39:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 13:39:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24559 invoked by uid 111); 14 Dec 2021 13:39:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 08:39:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 08:39:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2 2/5] linear-assignment.c: split up
 compute_assignment() function
Message-ID: <YbiemFN4F0ebr796@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
 <RFC-patch-v2-2.5-2233872545e-20211210T122901Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-v2-2.5-2233872545e-20211210T122901Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 01:30:39PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Split up the the long compute_assignment() function to make it easier
> to reason about, particularly when it comes to what variables are used
> later, and which aren't.

OK, this refactor seems reasonable. I don't know enough about the
linear-assignment algorithm to know whether the names you've picked are
meaningful.

> +void compute_assignment(int column_count, int row_count,
> +			int *cost,
> +			int *column2row, int *row2column)
> +{
> +	int *v;
> +	int *free_row, free_count = 0, saved_free_count;
> +
> +	assert(column_count > 1);
> +	memset(column2row, -1, sizeof(int) * column_count);
> +	memset(row2column, -1, sizeof(int) * row_count);
> +	ALLOC_ARRAY(v, column_count);

So this is the code where we would have kept the column_count check and
zero'd column2row and row2column, had we not moved it in the previous
commit. I actually think it would fit fine here in the refactored
compute_assignment() if you had left it.

-Peff
