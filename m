From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: don't try to update unfetched tracking refs
Date: Mon, 27 May 2013 11:42:52 -0400
Message-ID: <20130527154252.GB8250@sigill.intra.peff.net>
References: <9c6fd36368cd6b0fba4855be4d31106781c02f58.1369654825.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 27 17:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgzZp-0000rM-Kf
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 17:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab3E0Pm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 11:42:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:44692 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab3E0Pmz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 11:42:55 -0400
Received: (qmail 30875 invoked by uid 102); 27 May 2013 15:43:33 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 May 2013 10:43:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 May 2013 11:42:52 -0400
Content-Disposition: inline
In-Reply-To: <9c6fd36368cd6b0fba4855be4d31106781c02f58.1369654825.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225600>

On Mon, May 27, 2013 at 12:40:25PM +0100, John Keeping wrote:

> Since commit f269048 (fetch: opportunistically update tracking refs,
> 2013-05-11) we update tracking refs opportunistically when fetching
> remote branches.  However, if a refspec is given on the command line
> that does not include a configured (non-pattern) refspec a fatal error
> occurs.

I'm not sure I understand what the last sentence means. I tried to add a
test like:

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ff43e08..02e30e1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -422,6 +422,16 @@ test_expect_success 'configured fetch updates tracking' '
 	)
 '
 
+test_expect_success 'non-configured ref does not confuse tracking update' '
+	cd "$D" &&
+	git update-ref refs/odd/location HEAD &&
+	(
+		cd three &&
+		git fetch origin refs/odd/location &&
+		git rev-parse --verify FETCH_HEAD
+	)
+'
+
 test_expect_success 'pushing nonexistent branch by mistake should not segv' '
 
 	cd "$D" &&

but it does not fail with the existing code. Can you give an example
that fails?

-Peff
