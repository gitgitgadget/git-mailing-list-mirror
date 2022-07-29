Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A497CC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbiG2TAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbiG2TAn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:00:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318784F1A4
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:00:41 -0700 (PDT)
Received: (qmail 22109 invoked by uid 109); 29 Jul 2022 19:00:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 19:00:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27803 invoked by uid 111); 29 Jul 2022 19:00:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 15:00:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 15:00:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] revisions API: don't leak memory on argv elements
 that need free()-ing
Message-ID: <YuQuWPHK1iwuJvd4@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
 <patch-v2-6.6-3c57e126554-20220729T082919Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-6.6-3c57e126554-20220729T082919Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 10:31:08AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Add a "free_removed_argv_elements" member to "struct
> setup_revision_opt", and use it to fix several memory leaks, e.g. the
> one with a "XXX" comment added in 8a534b61241 (bisect: use argv_array
> API, 2011-09-13).

I think the mention of this "XXX" comment is a little misleading. That
comment is not talking about leaking the "--" entry. It is talking about
leaking the _entire_ strvec, because of memory-lifetime issues. And we
fixed those already in 5.

It's a small point, and the code here is fine. But if you take my
suggested replacement for 5, then it becomes even more nonsensical. ;)

-Peff
