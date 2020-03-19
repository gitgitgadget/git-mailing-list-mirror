Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330D2C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8BC2070A
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgCSRPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:15:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:44160 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726912AbgCSRPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:15:03 -0400
Received: (qmail 26365 invoked by uid 109); 19 Mar 2020 17:15:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 17:15:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29213 invoked by uid 111); 19 Mar 2020 17:24:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 13:24:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 13:15:02 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        james@jramsay.com.au
Subject: Re: [RFC PATCH 1/2] list_objects_filter_options: introduce
 'list_object_filter_config_name'
Message-ID: <20200319171502.GD4075823@coredump.intra.peff.net>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <c75806d011b04f2ad7efbbec01613a2d0b1f570b.1584477196.git.me@ttaylorr.com>
 <CAPig+cTVtv+uzzpoZ-BT=F=srdt1ewvgeBAAr9R+OUCYSov65A@mail.gmail.com>
 <20200318100327.GA1227946@coredump.intra.peff.net>
 <CAPig+cTWb55K70v1MahHbTi12F5Zi6stKc1vjY2=9jSvEm7jww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTWb55K70v1MahHbTi12F5Zi6stKc1vjY2=9jSvEm7jww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 18, 2020 at 06:38:49PM -0400, Eric Sunshine wrote:

> To be clear, I wasn't questioning the code structure at all. I was
> specifically referring to the comment talking about "error" when it
> should say "warning" or "possible warning".
> 
> Moreover, normally, we use comments to highlight something in the code
> which is not obvious or straightforward, so I was questioning whether
> this comment is even helpful since the code seems reasonably clear.
> And...

OK, I agree with all that. :)

> ...if this is or will become an idiom we want in this codebase, then
> it would be silly to write an explanatory comment every place we
> employ it. Instead, a document such as CodingGuidelines would likely
> be a better fit for such knowledge.

Yeah, that makes sense. If we do use this technique, though, we'll have
to explicitly list "case" lines for the enum values which are meant to
break out to the BUG(). And there it _is_ worth commenting on "yes, we
know about this value but it is not handled here because...". Which is
what you asked for in your original message. :)

Something like:

  switch (c) {
  case LOFC_BLOB_NONE:
	return "blob:none":
  ..etc...
  case LOFC__COUNT:
	/* not a real filter type; just a marker for counting the number */
	break;
  case LOFC_DISABLED:
	/* we have no name for "no filter at all" */
	break;
  }
  BUG(...);

-Peff
