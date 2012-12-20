From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 23:11:41 -0500
Message-ID: <20121220041141.GA23798@sigill.intra.peff.net>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <CACsJy8BB3=3ZHD5Ua9M-0+98JVigHBBuo07gBSgEwanvB0zBSA@mail.gmail.com>
 <20121220031327.GB9917@sigill.intra.peff.net>
 <7vehil7557.fsf@alter.siamese.dyndns.org>
 <20121220035543.GA14965@sigill.intra.peff.net>
 <20121220040602.GA15172@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 05:12:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlXUK-0001D2-3q
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 05:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab2LTELq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 23:11:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59290 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161Ab2LTELp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 23:11:45 -0500
Received: (qmail 6846 invoked by uid 107); 20 Dec 2012 04:12:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 23:12:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 23:11:41 -0500
Content-Disposition: inline
In-Reply-To: <20121220040602.GA15172@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211877>

On Wed, Dec 19, 2012 at 11:06:02PM -0500, Jeff King wrote:

> > I don't think we can make a change in simple_length. It gets used not
> > only for pathspecs, but also for parsing exclude patterns, which I do
> > not think should be affected by this option.
> 
> Our test suite wouldn't catch such a misfeature, of course, because the
> feature is not turned on by default. But I found it instructive to run
> all of the tests with GIT_LITERAL_PATHSPECS on. There are failures, of
> course, but by inspecting each failure you can see that it is an
> intended effect of the patch (i.e., each tries to use a wildcard
> pathspec, which no longer works).
> 
> When you suggested changing common_prefix, I ran such a test both with
> and without the change[1] and confirmed that it did not change the set
> of failure sites. I did not try it, but I suspect running such a test
> with the tip of pu would reveal new failures in the .gitignore tests.

I just tried it, and indeed, running the test suite with this patch:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 256f1c6..1c43593 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -102,6 +102,9 @@ export EDITOR
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
+GIT_LITERAL_PATHSPECS=1
+export GIT_LITERAL_PATHSPECS
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||


produces many more failures on "pu" than it does on jk/pathspec-literal.

-Peff
