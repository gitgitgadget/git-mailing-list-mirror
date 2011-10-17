From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Sun, 16 Oct 2011 22:01:03 -0400
Message-ID: <20111017020103.GA18536@sigill.intra.peff.net>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:01:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFcVr-0008VW-4y
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab1JQCBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 22:01:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33590
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469Ab1JQCBF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 22:01:05 -0400
Received: (qmail 1572 invoked by uid 107); 17 Oct 2011 02:01:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 16 Oct 2011 22:01:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Oct 2011 22:01:03 -0400
Content-Disposition: inline
In-Reply-To: <1318803076-4229-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183750>

On Mon, Oct 17, 2011 at 12:11:15AM +0200, Clemens Buchacher wrote:

> The semantics of the git daemon tests are similar to the http
> transport tests.  In fact, they are only a slightly modified copy
> of t5550, plus the newly added remote error tests.
> 
> All daemon tests will be skipped unless the environment variable
> GIT_TEST_DAEMON is set.

Thanks, it's nice to have some tests. Overall, some of the tests feel a
little silly, because the results should be exactly the same as fetching
or pushing a local repository (so the "set-head" thing, for example,
really has little to do with git-daemon). At the same time, maybe it's a
good thing to re-confirm that the results really are the same. :)

> diff --git a/t/lib-daemon.sh b/t/lib-daemon.sh
> new file mode 100644
> index 0000000..30a89ea
> --- /dev/null
> +++ b/t/lib-daemon.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +
> +if test -z "$GIT_TEST_DAEMON"
> +then
> +	skip_all="Daemon testing disabled (define GIT_TEST_DAEMON to enable)"
> +	test_done
> +fi
> +
> +LIB_DAEMON_PORT=${LIB_DAEMON_PORT-'8121'}

I assume you picked this arbitrarily to be LIB_HTTPD_PORT+10. It's fine
to have a default, but note that each of the httpd tests actually
defaults the port to their test number, so they can be run in parallel.

So that would be:

> --- /dev/null
> +++ b/t/t5570-git-daemon.sh
> @@ -0,0 +1,148 @@
> +#!/bin/sh
> +
> +test_description='test fetching over git protocol'
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-daemon.sh
> +start_daemon

LIB_DAEMON_PORT=${LIB_DAEMON_PORT-'5570'}

here.
