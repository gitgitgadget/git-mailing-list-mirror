Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74102C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjC3SZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjC3SZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 14:25:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBF35FEB
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:25:03 -0700 (PDT)
Received: (qmail 30030 invoked by uid 109); 30 Mar 2023 18:25:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Mar 2023 18:25:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19950 invoked by uid 111); 30 Mar 2023 18:25:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Mar 2023 14:25:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Mar 2023 14:25:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
Message-ID: <20230330182502.GB3286761@coredump.intra.peff.net>
References: <20230330112133.4437-1-oystwa@gmail.com>
 <20230330112133.4437-3-oystwa@gmail.com>
 <xmqqilei1bgk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilei1bgk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 08:54:35AM -0700, Junio C Hamano wrote:

>  * now we care if output is empty anyway, perhaps we can optimize
>    out fwrite() too, perhaps with something like
> 
> 	if (output.len || !omit_empty)
> 		printf("%.*s\n", output.len, output.buf);
> 
>    perhaps?
> 
> I am not sure about the latter, but we tend to use "%.*s" liberally
> when we could use fwrite() in our codebase for brevity, so ...

I think it would be a mistake here, as you can use "%00" in the format
to include a NUL in the output.

(The rest of your review seemed quite sensible to me, and I like the
idea of the omit-empty option in general).

-Peff
