From: Jeff King <peff@peff.net>
Subject: Re: Install on opensolaris 2008.05
Date: Sun, 17 Aug 2008 16:03:21 -0400
Message-ID: <20080817200321.GA17785@sigill.intra.peff.net>
References: <7a675f570808170555ie640c86jb5561cc6f7b68c73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sean Brandt <sean@fuzzymagic.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 22:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUoUD-0007XP-RR
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbYHQUDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbYHQUDW
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:03:22 -0400
Received: from peff.net ([208.65.91.99]:1325 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbYHQUDW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:03:22 -0400
Received: (qmail 2174 invoked by uid 111); 17 Aug 2008 20:03:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 17 Aug 2008 16:03:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2008 16:03:21 -0400
Content-Disposition: inline
In-Reply-To: <7a675f570808170555ie640c86jb5561cc6f7b68c73@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92624>

On Sun, Aug 17, 2008 at 08:55:57AM -0400, Sean Brandt wrote:

>  I'm installing on opensolaris 2008.05 and the tests fail in
> t0002-gitfile.sh  ( test numbers 2 and 3 ) is this expected/ok?

No, it's not expected nor ok (though it there is a reasonable chance it
is a portability problem in the test script, and not a real git
breakage).

What does

  make test GIT_TEST_OPTS="-v -i"

tell you?

>                 if ! grep -qe "Invalid gitfile format" .err

Just a guess, but I think Solaris grep doesn't understand "-q".

Does the patch below help?

---
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 4db4ac4..e4970fe 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -32,7 +32,7 @@ test_expect_success 'bad setup: invalid .git file format' '
 		echo "git rev-parse accepted an invalid .git file"
 		false
 	fi &&
-	if ! grep -qe "Invalid gitfile format" .err
+	if ! grep -e "Invalid gitfile format" .err
 	then
 		echo "git rev-parse returned wrong error"
 		false
@@ -46,7 +46,7 @@ test_expect_success 'bad setup: invalid .git file path' '
 		echo "git rev-parse accepted an invalid .git file path"
 		false
 	fi &&
-	if ! grep -qe "Not a git repository" .err
+	if ! grep -e "Not a git repository" .err
 	then
 		echo "git rev-parse returned wrong error"
 		false
