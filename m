Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E2C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjC1TGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjC1TGr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 15:06:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF6C30C5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 12:06:43 -0700 (PDT)
Received: (qmail 1512 invoked by uid 109); 28 Mar 2023 19:06:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 19:06:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 815 invoked by uid 111); 28 Mar 2023 19:06:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 15:06:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 15:06:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: [PATCH] pack-redundant: document deprecation
Message-ID: <20230328190641.GF18558@coredump.intra.peff.net>
References: <20230323204047.GA9290@coredump.intra.peff.net>
 <xmqqlejn6vb9.fsf@gitster.g>
 <ZBzBr1EAXoqBwmVo@nand.local>
 <xmqqh6ub6u1p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6ub6u1p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 02:23:46PM -0700, Junio C Hamano wrote:

> I notice that "git pack-redundant --help" does not say anything
> about its deprecation.  We probably should add one together with
> the patch in question, and then consider that the count-down timer
> has finally started.

Good thinking. Here is a patch.

-- >8 --
Subject: [PATCH] pack-redundant: document deprecation

Running the command itself has generated a warning for several versions,
which has recently been upgraded to an error. Let's also make sure the
documentation mentions what is going on. This also gives us a good spot
to explain the reasoning and recommend alternatives.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-pack-redundant.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index 99ef13839d4..13c3eb5ec96 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -11,6 +11,20 @@ SYNOPSIS
 [verse]
 'git pack-redundant' [--verbose] [--alt-odb] (--all | <pack-filename>...)
 
+WARNING
+-------
+`git pack-redundant` has been deprecated and is scheduled for removal in
+a future version of Git. Because it can only remove entire duplicate
+packs and not individual duplicate objects, it is generally not a useful
+tool for reducing repository size. You are better off using `git gc` to
+do so, which will put objects into a new pack, removing duplicates.
+
+Running `pack-redundant` without the `--i-still-use-this` flag will fail
+in this release. If you believe you have a use case for which
+`pack-redundant` is better suited and oppose this removal, please
+contact the Git mailing list at git@vger.kernel.org. More information
+about the list is available at https://git-scm.com/community.
+
 DESCRIPTION
 -----------
 This program computes which packs in your repository
-- 
2.40.0.616.gf524ec75088

