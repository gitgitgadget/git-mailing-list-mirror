From: Jeff King <peff@peff.net>
Subject: Re: Problems with git am
Date: Tue, 27 Oct 2009 15:02:34 -0400
Message-ID: <20091027190234.GA19454@sigill.intra.peff.net>
References: <59976.134.134.139.70.1256602329.squirrel@clueserver.org>
 <7vvdi1bqv8.fsf@alter.siamese.dyndns.org>
 <Pine.LNX.4.64.0910261836570.15106@blackbox.fnordora.org>
 <7veiopbm9l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: alan <alan@clueserver.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2rJl-0002Nk-U5
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 20:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbZJ0TCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 15:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756629AbZJ0TCd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 15:02:33 -0400
Received: from peff.net ([208.65.91.99]:60439 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756551AbZJ0TCc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 15:02:32 -0400
Received: (qmail 3267 invoked by uid 107); 27 Oct 2009 19:06:15 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 27 Oct 2009 15:06:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2009 15:02:34 -0400
Content-Disposition: inline
In-Reply-To: <7veiopbm9l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131371>

On Mon, Oct 26, 2009 at 07:31:34PM -0700, Junio C Hamano wrote:

> alan <alan@clueserver.org> writes:
> 
> > The other question is what the proper behaviour when git-am in unable
> > to process a patch.  Under git 1.6.0, it exits with a non-zero error
> > code. Under the current git in the git repo it issues and error and
> > exits with a non-error exit code.
> 
> Hmph, that sounds like a recent regression to me.  I'll try to find time
> to look into it myself sometime tonight but no promises.

I'm having trouble reproducing, either with a totally bogus input format
or with "git log -p" output (which is what it sounds like the OP has).
Both of these tests already pass on 'next':

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 8296605..2d5e32a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -346,4 +346,17 @@ test_expect_success 'am -q is quiet' '
 	! test -s output.out
 '
 
+test_expect_success 'am properly reports error' '
+	echo excellent > bogus &&
+	test_must_fail git am bogus
+'
+
+test_expect_success 'am properly reports error (git log output)' '
+	echo more content >>file &&
+	git commit -m content file &&
+	git log -1 -p > bogus &&
+	git reset --hard HEAD^ &&
+	test_must_fail git am bogus
+'
+
 test_done
