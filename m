Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615D8C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 17:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbiHCRcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiHCRcT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 13:32:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C6D1DA75
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 10:32:17 -0700 (PDT)
Received: (qmail 8341 invoked by uid 109); 3 Aug 2022 17:32:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Aug 2022 17:32:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13234 invoked by uid 111); 3 Aug 2022 17:32:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Aug 2022 13:32:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Aug 2022 13:32:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/6] log: refactor "rev.pending" code in cmd_show()
Message-ID: <YuqxIFkw64zcv+3c@coredump.intra.peff.net>
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
 <patch-v3-4.6-fd474666e7c-20220802T152925Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-4.6-fd474666e7c-20220802T152925Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 02, 2022 at 05:33:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

>  * We don't need the "count" and "objects" variables introduced in
>    5d7eeee2ac6 (git-show: grok blobs, trees and tags, too, 2006-12-14).
> 
>    They were originally added since we'd clobber rev.pending in the
>    loop without restoring it. Since the preceding commit we are
>    restoring it when we handle OBJ_COMMIT, so the main for-loop can
>    refer to "rev.pending" didrectly.

I think this is accurate, though it does feel a bit weird that we are
iterating over rev.pending, and we clobber and restore it mid-loop.

It's correct because of the restore, but I think that's why my gut
feeling favored the earlier approach to completely dissociate the
iteration variables from "rev.pending" before the loop even starts.

That said, it seems like we're spending a lot more time going back and
forth on this topic than it is really worth, so I can live with any of
the versions.

-Peff
