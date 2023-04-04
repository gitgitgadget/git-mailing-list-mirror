Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8679C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 15:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjDDPhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjDDPhA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 11:37:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4132D49C8
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 08:36:42 -0700 (PDT)
Received: (qmail 20522 invoked by uid 109); 4 Apr 2023 15:36:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Apr 2023 15:36:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1393 invoked by uid 111); 4 Apr 2023 15:36:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Apr 2023 11:36:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Apr 2023 11:36:15 -0400
From:   Jeff King <peff@peff.net>
To:     Thorsten Otto <admin@tho-otto.de>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: "git diff" does not show a diff for newly added, binary files
Message-ID: <20230404153615.GA160693@coredump.intra.peff.net>
References: <3473764.PTxrJRyG3s@earendil>
 <8135fc7b-1953-4702-a9c4-b0f847e69887@app.fastmail.com>
 <2349908.kWcu0K8Tai@earendil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2349908.kWcu0K8Tai@earendil>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 04, 2023 at 12:39:09PM +0200, Thorsten Otto wrote:

> On Dienstag, 4. April 2023 12:17:43 CEST Kristoffer Haugsbakk wrote:
> 
> > Do you use `.gitattributes` to get these binary diffs? What does it look
> > like?
> 
> No, the repo was just created for demonstrating purposes. But when i commit 
> that last change, then do a "git --format-patch -1", i get something like
> 
> diff --git a/b b/b
> new file mode 100644
> index 
> 0000000000000000000000000000000000000000..a64a5a93fb4aef4d5f63d79cb2582731b9ac5063
> GIT binary patch
> literal 512
> NcmZQz7zHCa1ONg600961
> 
> literal 0
> HcmV?d00001
> 
> 
> I would expect "git diff" to output the same information. I don't see a reason 
> why it outputs the diff for a new text file, but not for a binary file?

The behavior you're seeing is expected.

The default for "git diff" is not to show binary patches, because they
are often gigantic, and are meaningless to human readers. You can use
"--binary" if you want to see them.

The default for "git format-patch" is different, because there the point
is to send the patch to somebody to be applied with "git am", so it's
important that all information is included.

-Peff
