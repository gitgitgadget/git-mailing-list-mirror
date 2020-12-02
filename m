Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E2EC64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 02:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD64622206
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 02:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgLBCex (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 21:34:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:48274 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgLBCex (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 21:34:53 -0500
Received: (qmail 29949 invoked by uid 109); 2 Dec 2020 02:34:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 02:34:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3137 invoked by uid 111); 2 Dec 2020 02:34:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 21:34:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 21:34:11 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] Makefile: mark git-maintenance as a builtin
Message-ID: <X8b9IyU6E92efYaO@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We normally get the list of builtin commands by expanding BUILTIN_OBJS.
But for commands which are embedded inside another's source file (e.g.,
cmd_show() in builtin/log.c), the Makefile needs to be told explicitly
about them.

Since cmd_maintenance() is inside buitin/gc.c, it should be listed
explicitly in the BUILT_INS list in the Makefile. Not doing so isn't
_too_ tragic, as it simply means we will not make a git-maintenance
symlink in libexec/git-core. Since we encourage people to use the "git
foo" form, even in scripts which have put libexec into their PATH,
nobody seems to have noticed.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't really care that much. I just happened to notice there is a
git-maintenance pattern in .gitignore which will not ever trigger.

I could actually see an argument that this is not worth doing for new
commands. The dashed forms of the other commands have worked for a long
time, so losing them would be a regression. But since git-maintenance
would never have worked, presumably everybody who cares is using the
recommended "git maintenance" form already.

So I'm happy with that direction, too, but in that case we should
probably remove the .gitignore entry. :)

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index d3a531d3c6..1e507b9de0 100644
--- a/Makefile
+++ b/Makefile
@@ -769,6 +769,7 @@ BUILT_INS += git-cherry-pick$X
 BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-init$X
+BUILT_INS += git-maintenance$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-restore$X
 BUILT_INS += git-show$X
-- 
2.29.2.894.g2dadb8c6b8
