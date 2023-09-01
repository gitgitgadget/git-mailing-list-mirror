Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE81CA0FE8
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 20:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244871AbjIAUkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 16:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjIAUkL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 16:40:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97028E7E
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 13:40:07 -0700 (PDT)
Received: (qmail 30981 invoked by uid 109); 1 Sep 2023 20:40:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Sep 2023 20:40:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23584 invoked by uid 111); 1 Sep 2023 20:40:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Sep 2023 16:40:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Sep 2023 16:40:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: sort numerically when ":size" is used
Message-ID: <20230901204006.GA1960498@coredump.intra.peff.net>
References: <20230901142624.12063-1-five231003@gmail.com>
 <xmqqa5u5rgis.fsf@gitster.g>
 <20230901174540.GB1947546@coredump.intra.peff.net>
 <xmqqr0nhpyf3.fsf@gitster.g>
 <20230901183206.GA1952051@coredump.intra.peff.net>
 <ZPI0e1XzZrDV2fJk@five231003>
 <xmqqcyz1psnb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyz1psnb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2023 at 01:04:08PM -0700, Junio C Hamano wrote:

> In any case, it was very good that you noticed we do not sort
> numerically when sorting by size (I guess our sort by timestamp
> weren't affected only because we have been lucky?).  Thanks for
> starting this topic.

I think the date code works as expected, and by design. It's just that
the code is a little confusing. :) Something like %(committerdate) gets
a used_atom with FIELD_TIME, and the "grab" function sets v->value to
the unix-epoch timestamp. And then the comparison function uses
v->value, since it's not FIELD_STR.

It's a little hard to follow the code that fills in v->value, but the
call stack is roughly grab_values() -> grab_person() -> grab_date().

-Peff
