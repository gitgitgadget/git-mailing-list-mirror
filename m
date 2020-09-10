Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EFFC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0988720719
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgIJVm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:42:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:53252 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbgIJMmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 08:42:01 -0400
Received: (qmail 20128 invoked by uid 109); 10 Sep 2020 12:41:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2020 12:41:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18481 invoked by uid 111); 10 Sep 2020 12:41:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2020 08:41:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Sep 2020 08:41:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: use write_pack_header()
Message-ID: <20200910124128.GA58063@coredump.intra.peff.net>
References: <7613ef32-f39c-ea4b-1cfc-88d255307186@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7613ef32-f39c-ea4b-1cfc-88d255307186@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 06, 2020 at 10:39:23AM +0200, René Scharfe wrote:

> Call write_pack_header() to hash and write a pack header instead of
> open-coding this function.  This gets rid of duplicate code and of the
> magic version number 2 -- which has been used here since c90be46abd
> (Changed fast-import's pack header creation to use pack.h, 2006-08-16)
> and in pack.h (again) since 29f049a0c2 (Revert "move pack creation to
> version 3", 2006-10-14).

I think this is worth doing. It locks us into using PACK_VERSION, but
that has been constant for quite a long time now. If we ever finally
have a v4 pack, I expect write_pack_header would grow a version option
and we could deal with it then. :)

-Peff
