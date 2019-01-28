Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738131F453
	for <e@80x24.org>; Mon, 28 Jan 2019 17:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfA1RQe (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 12:16:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:51484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731044AbfA1QGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 11:06:23 -0500
Received: (qmail 2576 invoked by uid 109); 28 Jan 2019 16:06:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Jan 2019 16:06:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26430 invoked by uid 111); 28 Jan 2019 16:06:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 Jan 2019 11:06:28 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2019 11:06:20 -0500
Date:   Mon, 28 Jan 2019 11:06:20 -0500
From:   Jeff King <peff@peff.net>
To:     Sergey Lukashev <lukashev.s@ya.ru>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: unclear docs
Message-ID: <20190128160620.GA23588@sigill.intra.peff.net>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 12:58:58PM +0300, Sergey Lukashev wrote:

> Could somebody please explain what 'core.autocrlf overrides core.eol'
> means given that we have the following statement in core.eol docs:
> "Sets the line ending type to use in the working directory for files
> that have the text property set when core.autocrlf is false".
> 
> I would like to know which line endings I'm supposed to get in the
> working tree if I have core.autocrlf=false and '* text=auto' in
> .gitattributes on windows. I get CRLFs  which is consistent with the
> last quote but I don't understand what 'core.autocrlf overrides
> core.eol' means in this case.

I think it means:

  - if core.autocrlf is false (the default), then the text attribute and
    core.eol are used

  - if core.autocrlf is true, then that overrides the whole
    attribute/eol system

This unfortunate complexity is due to historical reasons (the
much-simpler autocrlf came first, and we had to maintain compatibility
with it). I agree the wording in the documentation is pretty vague.

Perhaps the patch below makes it more clear (I similarly looked at the
definitions of core.autocrlf and core.eol, but they make the distinction
that autocrlf only matters when "true").

-- >8 --
Subject: [PATCH] doc/gitattributes: clarify "autocrlf overrides eol"

We only override core.eol with core.autocrlf when the latter is set to
"true" (otherwise, core.eol would never do anything!). Let's make this
more clear, and point the reader to the git-config definitions, which
discuss this in more detail.

Noticed-by: Sergey Lukashev <lukashev.s@ya.ru>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitattributes.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b8392fc330..0ce8740e44 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -124,7 +124,8 @@ text file is normalized, its line endings are converted to LF in the
 repository.  To control what line ending style is used in the working
 directory, use the `eol` attribute for a single file and the
 `core.eol` configuration variable for all text files.
-Note that `core.autocrlf` overrides `core.eol`
+Note that setting `core.autocrlf` to `true` overrides `core.eol` (see
+the definitions of those options in linkgit:git-config[1]).
 
 Set::
 
-- 
2.20.1.845.g57b86ca485

