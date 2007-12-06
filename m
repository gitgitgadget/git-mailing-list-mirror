From: Jeff King <peff@peff.net>
Subject: Re: * [BUG] "git clean" does not pay attention to its parameters
Date: Wed, 5 Dec 2007 22:28:06 -0500
Message-ID: <20071206032806.GB5499@coredump.intra.peff.net>
References: <200712050654.lB56scKk000311@mi0.bluebottle.com> <7veje1zibm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@bluebottle.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 04:29:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J07QB-0007rl-6y
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 04:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbXLFD2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 22:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbXLFD2K
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 22:28:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2097 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbXLFD2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 22:28:09 -0500
Received: (qmail 27190 invoked by uid 111); 6 Dec 2007 03:28:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 05 Dec 2007 22:28:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2007 22:28:06 -0500
Content-Disposition: inline
In-Reply-To: <7veje1zibm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67226>

On Tue, Dec 04, 2007 at 11:55:41PM -0800, Junio C Hamano wrote:

> [PATCH] git-clean: Honor pathspec.
> 
> git-clean "*.rej" should attempt to look at only paths that match
> pattern "*.rej", but rewrite to C broke it.

And here is a test that fails without your patch (probably the commit
message should say "fixed in XX" once the commit id is known, or it
should be squashed in with your patch).

-- >8 --
t7300: add test for clean with wildcard pathspec

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7300-clean.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index f013c17..dfd1188 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -126,6 +126,20 @@ test_expect_success 'git-clean symbolic link' '
 
 '
 
+test_expect_success 'git-clean with wildcard' '
+
+	touch a.clean b.clean other.c &&
+	git-clean "*.clean" &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.clean &&
+	test ! -f b.clean &&
+	test -f other.c
+
+'
+
 test_expect_success 'git-clean -n' '
 
 	mkdir -p build docs &&
-- 
1.5.3.7.2099.gd6d7-dirty
