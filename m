From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 16:40:47 -0400
Message-ID: <20110825204047.GA9948@sigill.intra.peff.net>
References: <20110825200001.GA6165@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 22:40:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwgjP-0002DD-VL
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 22:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476Ab1HYUkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 16:40:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39913
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab1HYUku (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 16:40:50 -0400
Received: (qmail 18852 invoked by uid 107); 25 Aug 2011 20:41:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 16:41:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 16:40:47 -0400
Content-Disposition: inline
In-Reply-To: <20110825200001.GA6165@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180113>

We already provide sane hunk-header patterns for specific
languages. However, the user has to manually map common
extensions to use them. It's not that hard to do, but it's
an extra step that the user might not even know is an
option. Let's be nice and do it automatically.

Signed-off-by: Jeff King <peff@peff.net>
---
I tried to think of negative side effects.

The userdiff drivers we have are pretty conservative; they just specify
hunk headers. So if you have a binary file named "foo.c", we still do
the regular binary detection.

If you have any matching attribute line in your own files, it should
override. So:

  foo/* -diff

will still mark foo/bar.c as binary, even with this change.

Can anyone think of other possible side effects?

Also, any other extensions that would go into such a list? I have no
idea what the common extension is for something like pascal or csharp.

 attr.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/attr.c b/attr.c
index da29c8e..5118a14 100644
--- a/attr.c
+++ b/attr.c
@@ -294,6 +294,18 @@ static void free_attr_elem(struct attr_stack *e)
 
 static const char *builtin_attr[] = {
 	"[attr]binary -diff -text",
+	"*.html diff=html",
+	"*.java diff=java",
+	"*.perl diff=perl",
+	"*.pl diff=perl",
+	"*.php diff=php",
+	"*.py diff=python",
+	"*.rb diff=ruby",
+	"*.bib diff=bibtex",
+	"*.tex diff=tex",
+	"*.c diff=cpp",
+	"*.cc diff=cpp",
+	"*.cxx diff=cpp",
 	NULL,
 };
 
-- 
1.7.6.10.g62f04
