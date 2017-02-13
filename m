Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0CB31FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbdBMVFw (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:05:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:54459 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdBMVFv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:05:51 -0500
Received: (qmail 5482 invoked by uid 109); 13 Feb 2017 21:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 21:05:51 +0000
Received: (qmail 25250 invoked by uid 111); 13 Feb 2017 21:05:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 16:05:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 16:05:49 -0500
Date:   Mon, 13 Feb 2017 16:05:49 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] docs/git-submodule: fix unbalanced quote
Message-ID: <20170213210549.jns7asrvjp3lb5wc@sigill.intra.peff.net>
References: <20170213203835.vssj64tcvuq35dny@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170213203835.vssj64tcvuq35dny@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation gives an example of the submodule foreach
command that uses both backticks and single-quotes. We stick
the whole thing inside "+" markers to make it monospace, but
the inside punctuation still needs escaping. We handle the
backticks with "{backtick}", and use backslash-escaping for
the single-quotes.

But we missed the escaping on the second quote. Fortunately,
asciidoc renders this unbalanced quote as we want (showing
the quote), but asciidoctor does not. We could fix it by
adding the missing backslash.

However, let's take a step back. Even when rendered
correctly, it's hard to read a long command stuck into the
middle of a paragraph, and the important punctuation is hard
to notice. Let's instead bump it into its own single-line
code block. That makes both the source and the rendered
result more readable, and as a bonus we don't have to worry
about quoting at all.

Signed-off-by: Jeff King <peff@peff.net>
---
Not textually related to the previous fix, but obviously along the same
lines.

 Documentation/git-submodule.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 918bd1d1b..a8eb1c7ce 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -228,9 +228,12 @@ foreach::
 	the processing to terminate. This can be overridden by adding '|| :'
 	to the end of the command.
 +
-As an example, +git submodule foreach \'echo $path {backtick}git
-rev-parse HEAD{backtick}'+ will show the path and currently checked out
-commit for each submodule.
+As an example, the command below will show the path and currently
+checked out commit for each submodule:
++
+--------------
+git submodule foreach 'echo $path `git rev-parse HEAD`'
+--------------
 
 sync::
 	Synchronizes submodules' remote URL configuration setting
-- 
2.12.0.rc1.466.g70234cfd8

