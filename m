From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote
	HEADs
Date: Sun, 15 Feb 2009 00:34:13 -0500
Message-ID: <20090215053412.GA14230@coredump.intra.peff.net>
References: <20090214034345.GB24545@coredump.intra.peff.net> <1234607430-5403-1-git-send-email-jaysoffian@gmail.com> <20090215052740.GA11522@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 06:35:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYZfQ-0008N4-4x
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 06:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbZBOFeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 00:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbZBOFeP
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 00:34:15 -0500
Received: from peff.net ([208.65.91.99]:46783 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbZBOFeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 00:34:15 -0500
Received: (qmail 5139 invoked by uid 107); 15 Feb 2009 05:34:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 00:34:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 00:34:13 -0500
Content-Disposition: inline
In-Reply-To: <20090215052740.GA11522@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109963>

On Sun, Feb 15, 2009 at 12:27:40AM -0500, Jeff King wrote:

> On Sat, Feb 14, 2009 at 05:30:30AM -0500, Jay Soffian wrote:
> 
> > +test_expect_success 'set-head --auto fails w/multiple HEADs' '
> > +	(cd test &&
> > +	 test_must_fail git remote set-head --auto two >& output &&
> > +	test_cmp expect output)
> 
> I missed it before, but there is a typo in this test (>&) that causes it
> to barf.

Actually, it should be "> output 2>&1" to pick up the error message we
are expecting.  Squashable diff is below.

The test script actually passes for me now.

---
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 49f99e9..f0be105 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -231,7 +231,7 @@ EOF
 
 test_expect_success 'set-head --auto fails w/multiple HEADs' '
 	(cd test &&
-	 test_must_fail git remote set-head --auto two >& output &&
+	 test_must_fail git remote set-head --auto two > output 2>&1 &&
 	test_cmp expect output)
 '
 
