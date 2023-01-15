Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551BCC678D6
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 23:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjAOXNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 18:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjAOXNH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 18:13:07 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B131B571
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 15:13:05 -0800 (PST)
Received: (qmail 9227 invoked by uid 109); 15 Jan 2023 23:13:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Jan 2023 23:13:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25046 invoked by uid 111); 15 Jan 2023 23:13:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Jan 2023 18:13:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Jan 2023 18:13:03 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
Message-ID: <Y8SIf8AyGrNflBA7@coredump.intra.peff.net>
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
 <Y8RduNqadAfaOgs1@coredump.intra.peff.net>
 <c77892ba-e5cd-1192-ceba-d49edcb95da8@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c77892ba-e5cd-1192-ceba-d49edcb95da8@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 08:54:59PM +0000, Ramsay Jones wrote:

> > -	curl_easy_setopt(curl, CURLOPT_PUT, 1);
> > +	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
> 
> My version of this patch had '1L' rather than just '1' - but it
> doesn't really matter (and was probably because all the curl
> examples did so!).

Yeah, I think it probably ought to be 1L because it's going to a
variadic function (and it's been a while, but I think the regular
integer promotions make small things into int, but not into long).

So I don't mind fixing it, but I think we'd want it in a separate patch,
since it's orthogonal to what's happening here.

-Peff
