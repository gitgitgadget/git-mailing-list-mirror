Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D73CA0FE0
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 22:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbjHaWbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 18:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347691AbjHaWbP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 18:31:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F23D10C0
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 15:31:11 -0700 (PDT)
Received: (qmail 26199 invoked by uid 109); 31 Aug 2023 22:31:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 22:31:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12340 invoked by uid 111); 31 Aug 2023 22:31:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 18:31:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 18:31:09 -0400
From:   Jeff King <peff@peff.net>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Oswald Buddenhagen' <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 10/10] lower core.maxTreeDepth default to 2048
Message-ID: <20230831223109.GA952036@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
 <20230831062320.GJ3185325@coredump.intra.peff.net>
 <ZPBt6VYAWHJhv3N2@ugly>
 <20230831174215.GA3208283@coredump.intra.peff.net>
 <xmqq7cpaudke.fsf@gitster.g>
 <096e01d9dc56$6d9f12a0$48dd37e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <096e01d9dc56$6d9f12a0$48dd37e0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 05:59:28PM -0400, rsbecker@nexbridge.com wrote:

> I have been trying to figure out the implications of this and went down the
> wrong rabbit hole. Are we taking about the tree depth of the underlying
> Merkel Tree (no) or the tree-ish thing representing the file system
> (apparently yes). In this case, a practical depth of 2048 hits the exact max
> path size on the NonStop platform, so I have no issue there. My concern is
> one of terminology. My assumption of what maxTreeDepth meant, from other
> terminology used in git, seemed (wrongly) to align with the use of --depth=n
> where n<maxTreeDepth parameters for commands like fetch. From a user
> intuition (arguably, if I have any here) is that the parameter should be
> more of a path nomenclature, like maxPathHeight or maxHierarchyHeight rather
> than what is currently in flight. Just my opinion and I'm fine no matter
> which way.

The documentation from the patch is:

  +core.maxTreeDepth::
  +       The maximum depth Git is willing to recurse while traversing a
  +       tree (e.g., "a/b/cde/f" has a depth of 4). This is a fail-safe
  +       to allow Git to abort cleanly, and should not generally need to
  +       be adjusted. The default is 4096.

Does reading that answer your question and make the meaning clear? If
not, can you suggest any changes?

I'd like to stick with "depth" here as it's commonly used in other
places to mean the same thing (e.g., git-grep's --max-depth option).

I also think this is something that most people will remain completely
oblivious to, as you'd only hit it for absurd cases.

-Peff
