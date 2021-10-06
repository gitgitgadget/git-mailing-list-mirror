Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C446C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22B961163
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbhJFUkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:40:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:34500 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239402AbhJFUkV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:40:21 -0400
Received: (qmail 27006 invoked by uid 109); 6 Oct 2021 20:38:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Oct 2021 20:38:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2271 invoked by uid 111); 6 Oct 2021 20:38:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Oct 2021 16:38:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Oct 2021 16:38:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] object.[ch]: mark object type names for
 translation
Message-ID: <YV4JQytrc9UTa22o@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
 <patch-v2-1.2-55bde16aa23-20211004T142523Z-avarab@gmail.com>
 <YV3zZFOJd6blVGXn@coredump.intra.peff.net>
 <xmqqv92aq6m3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv92aq6m3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 06, 2021 at 12:46:12PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > They all appear to want is as a noun. So maybe this is just
> > mis-translated for Spanish. It does feel like an accident in the making,
> > though.
> 
> Probably we need pgettext().
> 
> https://www.gnu.org/software/gettext/manual/html_node/Contexts.html

Yeah, that make sense. I'm not sure how it interacts with N_(), though.
I.e., I'd expect the "context" to ride along with the original string,
but I guess it is really in the caller who's translating it. So the real
spot becomes:

  printf(_("my type is %s"), pgettext("object-type", type_name(type)));

It's a little unfortunate that every caller has to do it rather than
putting it near the source string. But I guess a type_name_human() would
solve that, too. ;)

-Peff
