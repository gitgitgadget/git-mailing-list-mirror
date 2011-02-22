From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] diff: don't retrieve binary blobs for diffstat
Date: Tue, 22 Feb 2011 10:37:29 -0500
Message-ID: <20110222153729.GA27178@sigill.intra.peff.net>
References: <20110219080307.GA18039@sigill.intra.peff.net>
 <20110219081631.GB18056@sigill.intra.peff.net>
 <7v62sdhsjy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 16:37:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PruIz-00082D-Ck
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 16:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab1BVPhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 10:37:32 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33668 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754079Ab1BVPhc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 10:37:32 -0500
Received: (qmail 2095 invoked by uid 111); 22 Feb 2011 15:37:31 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 22 Feb 2011 15:37:31 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Feb 2011 10:37:29 -0500
Content-Disposition: inline
In-Reply-To: <7v62sdhsjy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167555>

On Mon, Feb 21, 2011 at 03:33:05PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We only need the size, which is much cheaper to get,
> > especially if it is a big binary file.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> Nice ;-)  Do we want a test or two for 1/2 by the way?

Yeah, it's probably a good idea. Can you squash this in, or should I
resend?

---
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index 7e7b307..7d7470f 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -44,6 +44,13 @@ test_expect_success 'rewrite diff can show binary patch' '
 	grep "GIT binary patch" diff
 '
 
+test_expect_success 'rewrite diff --stat shows binary changes' '
+	git diff -B --stat --summary >diff &&
+	grep "Bin" diff &&
+	grep "0 insertions.*0 deletions" diff &&
+	grep " rewrite file" diff
+'
+
 {
 	echo "#!$SHELL_PATH"
 	cat <<'EOF'
