Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEB6C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA5320652
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLJU1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:27:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:43798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725999AbfLJU1e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:27:34 -0500
Received: (qmail 32099 invoked by uid 109); 10 Dec 2019 20:27:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Dec 2019 20:27:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1987 invoked by uid 111); 10 Dec 2019 20:31:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Dec 2019 15:31:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Dec 2019 15:27:32 -0500
From:   Jeff King <peff@peff.net>
To:     "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative
 objects
Message-ID: <20191210202732.GA11733@coredump.intra.peff.net>
References: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
 <20191127123211.GG22221@sigill.intra.peff.net>
 <20191204035522.GC214771@google.com>
 <20191204040544.GA11502@sigill.intra.peff.net>
 <CH2PR11MB4294C33B1CC956D5BF6AAB81CF5B0@CH2PR11MB4294.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH2PR11MB4294C33B1CC956D5BF6AAB81CF5B0@CH2PR11MB4294.namprd11.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 04:16:40PM +0000, Patrick Marlier (pamarlie) wrote:

> > From: Jeff King <peff@peff.net>
> > I'll be curious to see real-world numbers from Patrick's case).
> 
> Here the real-world case (40 pushes)
> 
> released
> average 00:08:35.54
> median 00:07:37.88
> max 00:15:30.26
> 
> patched
> average 00:06:45.67
> median 00:05:39.57
> max 00:16:15.46
> 
> Note our production is using 2.19 so I back-ported the patch (need to
> include 2 other patches).

You may see much better performance if you move to 2.21 or higher, or
backport the topic from 3b2f8a02fa (Merge branch 'jk/loose-object-cache',
2019-01-04). That would cause most of your negative lookups to not touch
the filesystem at all.

-Peff
