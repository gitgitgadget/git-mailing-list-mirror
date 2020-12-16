Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C416DC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DCD25E96
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgLPSYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:24:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:34876 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730325AbgLPSXu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:23:50 -0500
Received: (qmail 23923 invoked by uid 109); 16 Dec 2020 18:23:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Dec 2020 18:23:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31843 invoked by uid 111); 16 Dec 2020 18:23:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Dec 2020 13:23:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Dec 2020 13:23:08 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, felipe.contreras@gmail.com, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 1/3] ls-refs: report unborn targets of symrefs
Message-ID: <X9pQjHrRQQqB6AFI@coredump.intra.peff.net>
References: <20201211210508.2337494-1-jonathantanmy@google.com>
 <cover.1608084282.git.jonathantanmy@google.com>
 <7f5b50c7b284f2630fe5be6455cc5d3e03b1eb70.1608084282.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f5b50c7b284f2630fe5be6455cc5d3e03b1eb70.1608084282.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 06:07:56PM -0800, Jonathan Tan wrote:

> +static int ls_refs_config(const char *var, const char *value, void *cb_data)
> +{
> +	struct ls_refs_data *data = cb_data;
> +
> +	if (!strcmp("lsrefs.unborn", var))
> +		data->allow_unborn = !strcmp(value, "allow") ||
> +			!strcmp(value, "advertise");

What's the reason we would want this to be configurable? I would think
we would just want it always on for the server, and then clients can
choose to make us of it or not (and probably not by omitting the
capability; the question is what they want to do with the information
about HEAD, but that is true whether it is unborn or not, and is
controlled by options like "clone -b").

-Peff
