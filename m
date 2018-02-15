Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0811F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754747AbeBOFwB (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:52:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:53410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753412AbeBOFwB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:52:01 -0500
Received: (qmail 2479 invoked by uid 109); 15 Feb 2018 05:52:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:52:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7360 invoked by uid 111); 15 Feb 2018 05:52:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:52:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:51:58 -0500
Date:   Thu, 15 Feb 2018 00:51:58 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 15/23] cat-file: move skip_object_info into ref-filter
Message-ID: <20180215055158.GM18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f435c-80fa0ef3-afaf-45b7-84a7-28e2bb66f320-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f435c-80fa0ef3-afaf-45b7-84a7-28e2bb66f320-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Move logic related to skip_object_info into ref-filter,
> so that cat-file does not use that field at all.

I think this is going the wrong way. ref-filter should always do as
little work as possible to fulfill the request. So it should skip the
object_info call whenever it can. And then any callers who want to make
sure that the object exists can do so (as long as the formatting code
tells them whether it looked up the object or not).

And then ref-filter doesn't have to know about this skip_object_info
flag at all.

-Peff
