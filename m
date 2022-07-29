Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50133C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 18:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiG2S7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 14:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiG2S7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 14:59:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991317E821
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 11:59:03 -0700 (PDT)
Received: (qmail 22098 invoked by uid 109); 29 Jul 2022 18:59:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 18:59:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27775 invoked by uid 111); 29 Jul 2022 18:59:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 14:59:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 14:59:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] log: fix common "rev.pending" memory leak in "git
 show"
Message-ID: <YuQt9rKMJek0rEDx@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
 <patch-v2-4.6-54b632c1124-20220729T082919Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-4.6-54b632c1124-20220729T082919Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 10:31:06AM +0200, Ævar Arnfjörð Bjarmason wrote:

> So in addition to the now-populated &pending array, to avoid leaking
> the memory related to the one member array we've created. The
> &rev.pending was already being object_array_clear()'d by the
> release_revisions() added in f6bfea0ad01 (revisions API users: use
> release_revisions() in builtin/log.c, 2022-04-13), now we'll also
> correctly free the previous data (f6bfea0ad01 noted this memory leak
> as an outstanding TODO).

I couldn't quite parse the first sentence. But I think this explanation
is proceeding along a wrong assumption (which is the same one I had when
reviewing v1) that we are leaking the one-member array. I think this
paragraph can be replaced with something along the lines of what I
mentioned in my other reply.

-Peff
