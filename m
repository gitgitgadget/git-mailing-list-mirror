Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495851F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 04:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfACEy7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 23:54:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:53432 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726058AbfACEy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 23:54:59 -0500
Received: (qmail 18487 invoked by uid 109); 3 Jan 2019 04:54:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 04:54:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7512 invoked by uid 111); 3 Jan 2019 04:54:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 02 Jan 2019 23:54:36 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jan 2019 23:54:57 -0500
Date:   Wed, 2 Jan 2019 23:54:57 -0500
From:   Jeff King <peff@peff.net>
To:     Erin Dahlgren <eedahlgren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] Simplify handling of setup_git_directory_gently()
 failure cases.
Message-ID: <20190103045456.GD20047@sigill.intra.peff.net>
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
 <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
 <20181218175418.GB31070@sigill.intra.peff.net>
 <CAP_Smy14j4WK-mkqdKTKue=j7YoNjfaZVCBA-7S8xwNqX2rKhQ@mail.gmail.com>
 <20181219155928.GE14802@sigill.intra.peff.net>
 <xmqqftukq66o.fsf@gitster-ct.c.googlers.com>
 <20181227162417.GA23147@sigill.intra.peff.net>
 <CAP_Smy0tMe=mq2u6OFBfYzutHvoLETOyRtFEzLVViupjMLVLrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP_Smy0tMe=mq2u6OFBfYzutHvoLETOyRtFEzLVViupjMLVLrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 03:46:10PM -0800, Erin Dahlgren wrote:

> > Heh, I should learn to cut and paste better. This should be:
> >
> >   if (!nongit_ok || !*nongit_ok)
> >
> > (which comes from the current code).
> 
> Yep, but I think we can benefit from De Morgan's law here, where:
> 
>   (!nongit_ok || !*nongit_ok) == (!(nongit_ok && *nongit_ok))
> 
> PATCH v3 (just sent) uses that transformation like this:
> 
> if (nongit_ok && *nongit_ok) {
>   ... startup_info->has_repository = 0;
> } else {
>   // !nongit_ok || !*nongit_ok
>   .. startup_info->has_repository = 1;
> }
> 
> Because IMHO (nongit_ok && *nongit_ok) is easier to read and reason
> about. Added brief comments as well.

Ah yes, that's much better.

-Peff
