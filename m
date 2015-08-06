From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] ./t5512-*.sh -x complaints
Date: Thu, 6 Aug 2015 01:29:41 -0400
Message-ID: <20150806052940.GA32445@sigill.intra.peff.net>
References: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
 <20150806045535.GA7014@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 07:29:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNDkV-0005Mn-7B
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 07:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbbHFF3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 01:29:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:41424 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750715AbbHFF3p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 01:29:45 -0400
Received: (qmail 21585 invoked by uid 102); 6 Aug 2015 05:29:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Aug 2015 00:29:45 -0500
Received: (qmail 2825 invoked by uid 107); 6 Aug 2015 05:29:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Aug 2015 01:29:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Aug 2015 01:29:41 -0400
Content-Disposition: inline
In-Reply-To: <20150806045535.GA7014@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275412>

On Thu, Aug 06, 2015 at 12:55:35AM -0400, Jeff King wrote:

> PS I don't recall the outcome of our last discussion on the "verbose"
>    test function. Here it makes debug output for the "grep" above more
>    readable when it fails. But it also looks weird not to have the
>    matching negative one for the final grep (which could be
>    test_must_fail in this case, but we do not usually apply that to
>    non-git commands). If you would prefer to strip out the "verbose"
>    (from here and the test just below) while squashing, I am OK with
>    that.

Here's a squashable patch for that, in case it is easier (on top of the
previous squash; I am happy to just send a re-rolled patch if you'd
prefer):

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 7756100..aadaac5 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -150,7 +150,7 @@ do
 		git config --add $configsection.hiderefs "!refs/tags/magic" &&
 		git config --add $configsection.hiderefs refs/tags/magic/one &&
 		git ls-remote . >actual &&
-		verbose grep refs/tags/magic/two actual &&
+		grep refs/tags/magic/two actual &&
 		! grep refs/tags/magic/one actual
 	'
 
@@ -160,7 +160,7 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	test_config uploadpack.hiderefs refs/tags &&
 	test_config transfer.hiderefs "!refs/tags/magic" &&
 	git ls-remote . >actual &&
-	verbose grep refs/tags/magic actual
+	grep refs/tags/magic actual
 '
 
 test_done

I think the last discussion did end up with "eh, now that we have -x it
is simpler to just use that". Of course, then I tried to _use_ -x and
found some small niggles.  So here are fixes for those:

  [1/2]: test-lib: turn off "-x" tracing during chain-lint check
  [2/2]: test-lib: disable trace when test is not verbose

-Peff
