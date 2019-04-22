Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D251F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 14:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfDVOta (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 10:49:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:36766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726587AbfDVOt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 10:49:29 -0400
Received: (qmail 31163 invoked by uid 109); 22 Apr 2019 14:49:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 14:49:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31658 invoked by uid 111); 22 Apr 2019 14:50:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 10:50:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 10:49:27 -0400
Date:   Mon, 22 Apr 2019 10:49:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files
Message-ID: <20190422144927.GA6519@sigill.intra.peff.net>
References: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 21, 2019 at 10:19:04PM +0900, Junio C Hamano wrote:

>    I am not fan of adding the "| sort -u" of the whole thing,
>    because there is no need to dedup the output of the $(FIND) side
>    of the alternative, but "(ls-files | sort -u) || (find)" would
>    obviously not work.  If we truly care, perhaps we should add a
>    new option to ls-files to show each path only once, unless it is
>    showing the stage number (i.e. "ls-files -s" or "ls-files -u"),
>    but this gets the problem go away without code change, hence this
>    RFC ;-)

FWIW, after reading your commit message my thoughts immediately turned
to "why can't ls-files have a mode that outputs each just once", but
then ended up at the same place as your patch: it's not that hard to
just de-dup the output.

It _could_ be a sign that other scripts besides our Makefile would
benefit from such an option, but I think I'd want to see at least one
other example before going in that direction.

So the patch itself looks good to me (though I agree that Eric's
suggestion to de-dup inside "make" is better still).

-Peff
