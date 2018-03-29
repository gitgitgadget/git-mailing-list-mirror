Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1D71F404
	for <e@80x24.org>; Thu, 29 Mar 2018 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeC2VzF (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 17:55:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:48090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751187AbeC2VzE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 17:55:04 -0400
Received: (qmail 30087 invoked by uid 109); 29 Mar 2018 21:55:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 21:55:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22982 invoked by uid 111); 29 Mar 2018 21:56:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 17:56:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 17:55:02 -0400
Date:   Thu, 29 Mar 2018 17:55:02 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC/PATCH] upload-pack: disable object filtering when disabled
 by config
Message-ID: <20180329215502.GK2939@sigill.intra.peff.net>
References: <20180328203303.GA260688@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328203303.GA260688@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 01:33:03PM -0700, Jonathan Nieder wrote:

> When upload-pack gained partial clone support (v2.17.0-rc0~132^2~12,
> 2017-12-08), it was guarded by the uploadpack.allowFilter config item
> to allow server operators to control when they start supporting it.
> 
> That config item didn't go far enough, though: it controls whether the
> 'filter' capability is advertised, but if a (custom) client ignores
> the capability advertisement and passes a filter specification anyway,
> the server would handle that despite allowFilter being false.
> 
> This is particularly significant if a security bug is discovered in
> this new experimental partial clone code.  Installations without
> uploadpack.allowFilter ought not to be affected since they don't
> intend to support partial clone, but they would be swept up into being
> vulnerable.
> 
> Simplify and limit the attack surface by making uploadpack.allowFilter
> disable the feature, not just the advertisement of it.

Great catch. If I understand correctly, this is an issue in the 2.17.0
release candidates. Is this worth delaying the release?

It's a funny situation. The presence of a security bug is theoretical
here, so nobody _should_ need to care, and this is just hardening. But
it does make me a little nervous, given the experimental-ness of the new
feature.

-Peff
