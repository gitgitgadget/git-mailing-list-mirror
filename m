From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git
Date: Thu, 6 Aug 2015 00:55:35 -0400
Message-ID: <20150806045535.GA7014@sigill.intra.peff.net>
References: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 06:55:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNDDV-0002b2-2F
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 06:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbbHFEzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 00:55:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:41419 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752069AbbHFEzk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 00:55:40 -0400
Received: (qmail 19767 invoked by uid 102); 6 Aug 2015 04:55:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 23:55:40 -0500
Received: (qmail 2646 invoked by uid 107); 6 Aug 2015 04:55:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Aug 2015 00:55:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Aug 2015 00:55:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275411>

On Wed, Aug 05, 2015 at 03:55:23PM -0700, Junio C Hamano wrote:

> * jk/negative-hiderefs (2015-07-28) 2 commits
>  - refs: support negative transfer.hideRefs
>  - docs/config.txt: reorder hideRefs config
> 
>  Allow negative !ref entry in multi-value transfer.hideRefs
>  configuration to say "don't hide this one".
> 
>  An update to test coming?

Thanks for reminding me. I think we just want to squash this in to the
tip commit:

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index afde495..7756100 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -150,7 +150,8 @@ do
 		git config --add $configsection.hiderefs "!refs/tags/magic" &&
 		git config --add $configsection.hiderefs refs/tags/magic/one &&
 		git ls-remote . >actual &&
-		verbose grep refs/tags/magic/two actual
+		verbose grep refs/tags/magic/two actual &&
+		! grep refs/tags/magic/one actual
 	'
 
 done

-Peff

PS I don't recall the outcome of our last discussion on the "verbose"
   test function. Here it makes debug output for the "grep" above more
   readable when it fails. But it also looks weird not to have the
   matching negative one for the final grep (which could be
   test_must_fail in this case, but we do not usually apply that to
   non-git commands). If you would prefer to strip out the "verbose"
   (from here and the test just below) while squashing, I am OK with
   that.
