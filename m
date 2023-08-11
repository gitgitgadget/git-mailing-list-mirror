Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D145BEB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 15:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjHKPNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKPNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 11:13:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE3518F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:13:24 -0700 (PDT)
Received: (qmail 16699 invoked by uid 109); 11 Aug 2023 15:13:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Aug 2023 15:13:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26422 invoked by uid 111); 11 Aug 2023 15:13:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Aug 2023 11:13:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Aug 2023 11:13:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
Message-ID: <20230811151323.GF2303200@coredump.intra.peff.net>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
 <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
 <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
 <20230810004127.GD795985@coredump.intra.peff.net>
 <09f499ad-28a5-0d8b-8af6-97475bdc614b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09f499ad-28a5-0d8b-8af6-97475bdc614b@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 09:10:33PM +0200, René Scharfe wrote:

> +#define DEFINE_PARSE_OPT_CB(name)				\
> +static inline int name ## __void(const struct option *opt,	\
> +				 const char *arg, int unset)	\
> +{								\
> +	return name(opt, arg, unset, opt->value);		\
> +}								\
> +struct option

BTW, I wondered what this extra "struct option" was doing. I guess it is
there to soak up the semi-colon of:

  DEFINE_PARSE_OPT_CB(foo);

with a noop declaration. Both clever and gross. :)

-Peff
