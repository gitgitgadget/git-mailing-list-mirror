From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] docs: minor tweaks to credentials API
Date: Wed, 14 Sep 2011 15:17:45 -0400
Message-ID: <20110914191745.GA28267@sigill.intra.peff.net>
References: <20110914191704.GA23201@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Brian Gernhardt <benji@silverinsanity.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 21:17:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uxz-00037I-Sr
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 21:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712Ab1INTRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 15:17:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36143
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932543Ab1INTRr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 15:17:47 -0400
Received: (qmail 13666 invoked by uid 107); 14 Sep 2011 19:18:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 15:18:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 15:17:45 -0400
Content-Disposition: inline
In-Reply-To: <20110914191704.GA23201@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181389>

These are in response to Junio's comments:

  1. Clarify how credential rejection works (first we call
     helpers, then we clear fields, so helpers get fields).

  2. Clarify quoting of keys/values returned from helpers.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-credentials.txt |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 335a007..b2eb24c 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -48,10 +48,11 @@ Functions
 `credential_reject`::
 
 	Inform the credential subsystem that the provided credentials
-	have been rejected. This will clear the username and password
-	fields in `struct credential`, as well as notify any helpers of
-	the rejection (which may, for example, purge the invalid
-	credentials from storage).
+	have been rejected. This will notify any helpers of the
+	rejection (which allows them to, for example, purge the invalid
+	credentials from storage), and then clear the username and
+	password fields in `struct credential`. It can then be
+	`credential_fill`-ed again.
 
 `credential_getpass`::
 
@@ -98,8 +99,11 @@ command line:
 
 The helper should produce a list of items on stdout, each followed by a
 newline character. Each item should consist of a key-value pair, separated
-by an `=` (equals) sign. The value may contain any bytes except a
-newline. When reading the response, git understands the following keys:
+by an `=` (equals) sign. The key can contain any bytes except `=` or
+newline. The value may contain any bytes except a newline. In both
+cases, all bytes are treated as-is (i.e., there is no quoting, and one
+cannot transmit a value with newline in it). When reading the response,
+git understands the following keys:
 
 `username`::
 
-- 
1.7.6.252.ge9c18
