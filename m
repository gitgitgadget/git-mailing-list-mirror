Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6931F428
	for <e@80x24.org>; Wed,  3 Jan 2018 05:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeACF4u (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 00:56:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:51628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751036AbeACF4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 00:56:49 -0500
Received: (qmail 4221 invoked by uid 109); 3 Jan 2018 05:56:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Jan 2018 05:56:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24295 invoked by uid 111); 3 Jan 2018 05:57:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 03 Jan 2018 00:57:19 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jan 2018 00:56:47 -0500
Date:   Wed, 3 Jan 2018 00:56:47 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: fix v1 protocol tests with apache httpd < 2.4
Message-ID: <20180103055646.GA25752@sigill.intra.peff.net>
References: <20171231023234.21215-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171231023234.21215-1-tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 30, 2017 at 09:32:34PM -0500, Todd Zullinger wrote:

> The apache config used by tests was updated to use the SetEnvIf
> directive to set the Git-Protocol header in 19113a26b6 ("http: tell
> server that the client understands v1", 2017-10-16).
> 
> Setting the Git-Protocol header is restricted to httpd >= 2.4, but
> mod_setenvif and the SetEnvIf directive work with lower versions, at
> least as far back as 2.0, according to the httpd documentation:
> 
>     https://httpd.apache.org/docs/2.0/mod/mod_setenvif.html
> 
> Drop the restriction.  Tested with httpd 2.2 and 2.4.

Makes sense. I think the only way this could backfire is if somebody has
a funny build that doesn't include mod_setenvif at all. But I don't
think we can know that for sure without applying this and seeing if
anybody screams.

> I removed the version restriction entirely rather than adjust
> the version.  I believe SetEnvIf works on httpd >= 2.0.  I'm
> not sure if we aim to support anything less than httpd 2.0,
> but I'm betting not.  If that's incorrect, I can add some
> IfVersion conditions.

IIRC, anything less than 2.0 is broken already. And it's not worth
changing that, given the age (and I think there were some pretty severe
hardships in making 1.3.x, but it's been a while).

-Peff
