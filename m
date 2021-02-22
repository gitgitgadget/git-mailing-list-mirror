Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CCCC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBC464E4A
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhBVXI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:08:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:40822 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhBVXI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 18:08:57 -0500
Received: (qmail 22141 invoked by uid 109); 22 Feb 2021 23:08:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Feb 2021 23:08:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18843 invoked by uid 111); 22 Feb 2021 23:08:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Feb 2021 18:08:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Feb 2021 18:08:16 -0500
From:   Jeff King <peff@peff.net>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] docs/format-patch: mention handling of merges
Message-ID: <YDQ5YIeXGiR5nvLH@coredump.intra.peff.net>
References: <20210222211621.0C5D.409509F4@e16-tech.com>
 <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 05:57:50PM -0500, Jeff King wrote:

> This is expected. Format-patch omits merge commits entirely, as they
> can't be formatted as a simple diff that can be applied.

We don't seem to advertise this very well in the documentation.

I think we should at least do something like the patch below. I do have
a dream that one day we'll be able to represent conflict resolutions
over email, but we're not there yet.

Likewise, it might be reasonable format-patch to issue a warning() when
it is ignoring a merge. Or maybe some people would find that annoying
(e.g., because they don't care about back-merges from upstream that
happened during the development of a topic).

But I think this documentation change is easy and hopefully
uncontroversial.

-- >8 --
Subject: [PATCH] docs/format-patch: mention handling of merges

Format-patch doesn't have a way to format merges in a way that can be
applied by git-am (or any other tool), and so it just omits them.
However, this may be a surprising implication for users who are not well
versed in how the tool works. Let's add a note to the documentation
making this more clear.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-format-patch.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf2210..33649098ce 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -36,7 +36,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Prepare each commit with its patch in
+Prepare each non-merge commit with its patch in
 one file per commit, formatted to resemble UNIX mailbox format.
 The output of this command is convenient for e-mail submission or
 for use with 'git am'.
@@ -718,6 +718,13 @@ use it only when you know the recipient uses Git to apply your patch.
 $ git format-patch -3
 ------------
 
+CAVEATS
+-------
+
+Note that `format-patch` cannot represent commits with more than one
+parent (i.e., merges) and will silently omit them entirely from its
+output, even if they are part of the requested range.
+
 SEE ALSO
 --------
 linkgit:git-am[1], linkgit:git-send-email[1]
-- 
2.30.1.1033.gd525307ce1

