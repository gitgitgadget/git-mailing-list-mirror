From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] Introduce a performance testing framework
Date: Fri, 17 Feb 2012 02:45:43 -0500
Message-ID: <20120217074543.GA25213@sigill.intra.peff.net>
References: <cover.1329428159.git.trast@student.ethz.ch>
 <5e712370fcfe32832998c085fdf6b5a7c4e7d64b.1329428159.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 17 12:38:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyM96-0006CP-Qw
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 12:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab2BQLi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 06:38:29 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41019
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab2BQLi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 06:38:27 -0500
Received: (qmail 6051 invoked by uid 107); 17 Feb 2012 07:52:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Feb 2012 02:52:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2012 02:45:43 -0500
Content-Disposition: inline
In-Reply-To: <5e712370fcfe32832998c085fdf6b5a7c4e7d64b.1329428159.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190950>

On Thu, Feb 16, 2012 at 10:41:14PM +0100, Thomas Rast wrote:

> +	if test $eval_ret = 0 || test -n "$expecting_failure"
> +	then
> +		test_eval_ "$test_cleanup"
> +		source ./test_vars || error "failed to load updated environment"
> +	fi

"source" is a bash-ism (actually, it is a csh-ism as far as I know, but
perhaps it predates even that). The correct POSIX spelling is ".".

After tweaking this line, the suite seems to run fine for me with dash
as /bin/sh. Patch is below for your convenience.

-Peff

---
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 07e9b09..629d7d5 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -135,7 +135,7 @@ exit $ret' >&3 2>&4
 	if test $eval_ret = 0 || test -n "$expecting_failure"
 	then
 		test_eval_ "$test_cleanup"
-		source ./test_vars || error "failed to load updated environment"
+		. ./test_vars || error "failed to load updated environment"
 	fi
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
 		echo ""
