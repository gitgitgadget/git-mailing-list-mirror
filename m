Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D17AC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 13:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3544A24969
	for <git@archiver.kernel.org>; Fri,  8 May 2020 13:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgEHNGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 09:06:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:41528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728894AbgEHNGT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 09:06:19 -0400
Received: (qmail 9150 invoked by uid 109); 8 May 2020 13:06:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 May 2020 13:06:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27717 invoked by uid 111); 8 May 2020 13:06:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2020 09:06:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 May 2020 09:06:16 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] upload-pack: fix filter options scope
Message-ID: <20200508130616.GA631018@coredump.intra.peff.net>
References: <20200507095829.16894-1-chriscool@tuxfamily.org>
 <20200508080115.15616-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508080115.15616-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 08, 2020 at 10:01:15AM +0200, Christian Couder wrote:

> The changes since the previous RFC version are the following:
> 
>   - now filter_options is part of struct upload_pack_data as
>     suggested by Peff and Taylor
>   - improved commit message
>   - updated comment before the test that used to fail

Thanks, this version looks good to me.

>  static void create_pack_file(const struct object_array *have_obj,
> -			     const struct object_array *want_obj)
> +			     const struct object_array *want_obj,
> +			     struct list_objects_filter_options *filter_options)

I had hoped that stuffing it into upload_pack_data would require fewer
changes passing it around, but I guess many of these functions don't
know about upload_pack_data in the first place. Oh well. I think this is
the best we can do for now. In the long run we'd perhaps want to take
upload_pack_data there, but it wouldn't help until the v0 path also uses
that struct.

-Peff
