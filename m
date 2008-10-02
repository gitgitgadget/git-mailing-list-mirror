From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: autonumber by default
Date: Thu, 2 Oct 2008 17:06:12 -0400
Message-ID: <20081002210611.GA29480@coredump.intra.peff.net>
References: <20081002200333.GA29303@coredump.intra.peff.net> <1222978500-5780-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 23:07:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlVOY-0000xU-RH
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 23:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbYJBVGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 17:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139AbYJBVGW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 17:06:22 -0400
Received: from peff.net ([208.65.91.99]:4630 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbYJBVGW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 17:06:22 -0400
Received: (qmail 29839 invoked by uid 111); 2 Oct 2008 21:06:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 02 Oct 2008 17:06:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Oct 2008 17:06:12 -0400
Content-Disposition: inline
In-Reply-To: <1222978500-5780-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97376>

On Thu, Oct 02, 2008 at 10:15:00PM +0200, Giuseppe Bilotta wrote:

>  Documentation/config.txt           |    5 +++--
>  Documentation/git-format-patch.txt |    9 ++++++---
>  builtin-log.c                      |    6 +++++-
>  3 files changed, 14 insertions(+), 6 deletions(-)

Thanks, the documentation updates look good to me. There are also some
updates required in t4013 (since the expected outputs for some instances
will now be numbered) and t4020 (which explicitly checks that the
default is no numbering). Probably t4020 should be modified in light of
the new default, like so:

---
 t/t4021-format-patch-numbered.sh |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 43d64bb..390af23 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -45,17 +45,22 @@ test_numbered() {
 	grep "^Subject: \[PATCH 2/2\]" $1
 }
 
-test_expect_success 'Default: no numbered' '
+test_expect_success 'single patch defaults to no numbers' '
+	git format-patch --stdout HEAD~1 >patch0.single &&
+	test_single_no_numbered patch0.single
+'
+
+test_expect_success 'multiple patch defaults to numbered' '
 
-	git format-patch --stdout HEAD~2 >patch0 &&
-	test_no_numbered patch0
+	git format-patch --stdout HEAD~2 >patch0.multiple &&
+	test_numbered patch0.multiple
 
 '
 
 test_expect_success 'Use --numbered' '
 
-	git format-patch --numbered --stdout HEAD~2 >patch1 &&
-	test_numbered patch1
+	git format-patch --numbered --stdout HEAD~1 >patch1 &&
+	test_single_numbered patch1
 
 '
 
-- 
1.6.0.2.570.g2c958
