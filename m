From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: fix options '-o' and '--origin' to be
	recognised again
Date: Wed, 19 Dec 2007 10:43:50 -0500
Message-ID: <20071219154350.GC13942@coredump.intra.peff.net>
References: <20071219091515.GA20707@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 16:44:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J515l-0005nT-3n
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 16:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbXLSPnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 10:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbXLSPnx
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 10:43:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1660 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753953AbXLSPnx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 10:43:53 -0500
Received: (qmail 32037 invoked by uid 111); 19 Dec 2007 15:43:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 19 Dec 2007 10:43:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2007 10:43:50 -0500
Content-Disposition: inline
In-Reply-To: <20071219091515.GA20707@fiberbit.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68917>

On Wed, Dec 19, 2007 at 10:15:15AM +0100, Marco Roeland wrote:

>  This is a regression in 'next', introduced on Nov 4th by commit 94362599
>  "Migrate git-clone to use git-rev-parse --parseopt". Added Kristian as
>  he works on the builtin version; perhaps nice for a test case (!).

Here is a test case that catches this regression. It can perhaps be
expanded by Kristian to test other options, but is probably worth adding
now as a basic sanity check.

I put the test in 5702. There seems to be a '5600' clone test, as well,
which perhaps should be in the 57?? series.

-- >8 --
test "git clone -o"

This tests a recently fixed regression in which "git clone
-o" didn't work at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5702-clone-options.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100755 t/t5702-clone-options.sh

diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
new file mode 100755
index 0000000..328e4d9
--- /dev/null
+++ b/t/t5702-clone-options.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description='basic clone options'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	mkdir parent &&
+	(cd parent && git init &&
+	 echo one >file && git add file &&
+	 git commit -m one)
+
+'
+
+test_expect_success 'clone -o' '
+
+	git clone -o foo parent clone-o &&
+	(cd clone-o && git rev-parse --verify refs/remotes/foo/master)
+
+'
+
+test_done
-- 
1.5.4.rc0.1162.gaa83ae
