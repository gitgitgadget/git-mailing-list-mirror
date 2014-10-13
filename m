From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] test-lib.sh: support -x option for shell-tracing
Date: Mon, 13 Oct 2014 18:33:03 -0400
Message-ID: <20141013223303.GA17045@peff.net>
References: <20141010062722.GB17481@peff.net>
 <20141010064727.GC17481@peff.net>
 <xmqqh9z71uf9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 00:33:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdoAy-0005HJ-1r
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 00:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbaJMWdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 18:33:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:58141 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751546AbaJMWdG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 18:33:06 -0400
Received: (qmail 23230 invoked by uid 102); 13 Oct 2014 22:33:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 17:33:05 -0500
Received: (qmail 29448 invoked by uid 107); 13 Oct 2014 22:33:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 18:33:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Oct 2014 18:33:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9z71uf9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 03:22:50PM -0700, Junio C Hamano wrote:

> > Rerolled patch is below. Sorry for all the emails. I'll stop looking at
> > it now to give you guys a chance to find any remaining mistakes. ;)
> 
> Does 1308 pass with this patch for you (running it without "-x")?

Hmph. It does not. I know that "make test" passed with an earlier
iteration, but I must have gotten so wrapped up in testing "make
GIT_TEST_OPTS=-x test" that I never ran a vanilla "make test" on
what I finally posted. Sorry.

> The original that expects a hardcoded line number (not relative to
> the original or something) is a bad taste, and also the test setup
> procedure is broken (see below for a fix of that breakage, which
> does not fix the breakage this patch seems to bring in anyway).

Yeah, I agree, and your patch below looks reasonable.

> But still it is disturbing to see that there is a blank line
> difference with and without this change in the file created by the
> test (i.e. the client of the code this patch touches).

This fixes it:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4dab575..059bb25 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -528,8 +528,7 @@ maybe_setup_valgrind () {
 test_eval_inner_ () {
 	eval "
 		test \"$trace\" = t && set -x
-		$*
-	"
+		$*"
 }
 
 test_eval_ () {


My patch definitely expands the snippet with an extra trailing newline.
But what I really don't understand is why that would impact the
_contents_ of the config file.

I'll dig further, but I'm about to leave the computer for dinner for a
few hours, so please don't hold your breath. :)

-Peff
