Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A0C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 10:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiLMKiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 05:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiLMKiF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 05:38:05 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D80B5F5E
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 02:38:02 -0800 (PST)
Received: (qmail 14286 invoked by uid 109); 13 Dec 2022 10:38:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 10:38:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3970 invoked by uid 111); 13 Dec 2022 10:38:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 05:38:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 05:38:01 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 3/4] object-file: emit corruption errors when detected
Message-ID: <Y5hWCa31OVLOU3sK@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670885252.git.jonathantanmy@google.com>
 <a229ea0b1122f55e91f98475cd7e508f4dd8501a.1670885252.git.jonathantanmy@google.com>
 <xmqqzgbsoyte.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgbsoyte.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2022 at 10:51:57AM +0900, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > diff --git a/object-file.c b/object-file.c
> > index 429e3a746d..e0cef8b906 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1422,7 +1422,9 @@ static int loose_object_info(struct repository *r,
> >  			     struct object_info *oi, int flags)
> >  {
> >  	int status = 0;
> > +	int fd;
> >  	unsigned long mapsize;
> > +	const char *path = NULL;
> 
> It may be OK to leave this uninitialized, as long as the contract of
> open_loose_object() is that a successful opening will report the path
> to the loose object file that was opened.  Because ...

Yeah, I'd agree that this initialization can be left off (and that the
NULL checks later in the function are not needed).

-Peff
