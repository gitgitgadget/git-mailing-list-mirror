Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87C6C77B73
	for <git@archiver.kernel.org>; Fri,  5 May 2023 01:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjEEBqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 21:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEEBqN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 21:46:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6593C2
        for <git@vger.kernel.org>; Thu,  4 May 2023 18:46:12 -0700 (PDT)
Received: (qmail 28144 invoked by uid 109); 5 May 2023 01:46:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 May 2023 01:46:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13732 invoked by uid 111); 5 May 2023 01:46:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 May 2023 21:46:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 May 2023 21:46:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: doc-diff: specify date
Message-ID: <20230505014610.GA2366370@coredump.intra.peff.net>
References: <20230503232349.59997-1-felipe.contreras@gmail.com>
 <xmqq8re3inn4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8re3inn4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 04, 2023 at 06:15:59PM -0700, Junio C Hamano wrote:

> > diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> > index 1694300e50..554a78a12d 100755
> > --- a/Documentation/doc-diff
> > +++ b/Documentation/doc-diff
> > @@ -153,6 +153,7 @@ render_tree () {
> >  		make -j$parallel -C "$tmp/worktree" \
> >  			$makemanflags \
> >  			GIT_VERSION=omitted \
> > +			GIT_DATE=1970-01-01 \
> >  			SOURCE_DATE_EPOCH=0 \
> >  			DESTDIR="$tmp/installed/$dname+" \
> >  			install-man &&
> 
> I wonder what the existing SOURCE_DATE_EPOCH was trying to do there,
> though.

It used to be necessary so that we had a reproducible build. Otherwise,
asciidoc uses the mtime of the file, and diffing two versions would have
tons of uninteresting date-differences.

After 28fde3a1 I doubt it is necessary, as the header uses $GIT_DATE
instead (it's possible the mtime may be used elsewhere, but I didn't see
any spot after grepping a built xml file. And at any rate, if it does
not produce a visible difference, that is enough for doc-diff).

-Peff
