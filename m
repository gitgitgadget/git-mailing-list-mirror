Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC7F1F461
	for <e@80x24.org>; Thu, 16 May 2019 03:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEPD2k (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 23:28:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:58934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726218AbfEPD2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 23:28:40 -0400
Received: (qmail 4515 invoked by uid 109); 16 May 2019 03:28:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 03:28:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26884 invoked by uid 111); 16 May 2019 03:29:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 15 May 2019 23:29:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2019 23:28:38 -0400
Date:   Wed, 15 May 2019 23:28:38 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/2] dup() the input fd for fast-import used for remote
 helpers
Message-ID: <20190516032838.GC4596@sigill.intra.peff.net>
References: <20190516003130.racexnofe7cxra3t@glandium.org>
 <20190516003736.25544-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516003736.25544-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 09:37:35AM +0900, Mike Hommey wrote:

> When a remote helper exposes the "import" capability, stdout of the
> helper is sent to stdin of a new fast-import process. This is done by
> setting the corresponding child_process's in field to the value of the
> out field of the helper child_process.
> 
> The child_process API is defined to close the file descriptors it's
> given when calling start_command. This means when start_command is
> called for the fast-import process, its input fd (the output fd of the
> helper), is closed.
> 
> But when the transport helper is later destroyed, in disconnect_helper,
> its input and output are closed, which means close() is called with
> an invalid fd (since it was already closed as per above). Or worse, with
> a valid fd owned by something else (since fd numbers can be reused).

I think this strategy is OK, as explained in my other email.

-Peff
