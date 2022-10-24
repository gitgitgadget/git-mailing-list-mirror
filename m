Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7170DC67871
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 00:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJYAzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiJYAyr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 20:54:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F0B1CEC07
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:38:37 -0700 (PDT)
Received: (qmail 4512 invoked by uid 109); 24 Oct 2022 23:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Oct 2022 23:38:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11955 invoked by uid 111); 24 Oct 2022 23:38:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Oct 2022 19:38:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Oct 2022 19:38:36 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael McClimon <michael@mcclimon.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
Message-ID: <Y1ch/PKAvNbYNLY7@coredump.intra.peff.net>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
 <20221022011931.43992-3-michael@mcclimon.org>
 <221022.86eduzeiek.gmgdl@evledraar.gmail.com>
 <Y1RY38RULkqd9pBN@coredump.intra.peff.net>
 <221024.861qqxeah5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221024.861qqxeah5.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2022 at 12:57:29PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The important point/question I have is whether we can think of any such
> config variable understood by the code that uses Git.pm.

I don't think that matters. Before the CVE fix, Git.pm scripts were just
as vulnerable as all the other parts of Git. After, they were broken
because of the syntax error. Fixing the syntax error re-opened the bug
there, but as long as we close it again before releasing, we don't have
to care.

You can argue that the CVE wasn't that important for Git.pm, and thus
not that big a deal to re-open. But I think post-CVE we're making the
stronger promise that Git won't discover a repo directory with funky
ownership. And Git.pm is violating that (or would be after the syntax
fix if we don't go further).

> The only ones I can think are the "sendemail.{to,cc}Cmd" variables.

I don't think we can be that exhaustive. It's also any programs that are
called by scripts using Git.pm. But even that is not a closed set, since
we ship Git.pm for people to use in their own scripts. We don't know
what those scripts might be doing.

-Peff
