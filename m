From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 06/13] credential: apply helper config
Date: Tue, 6 Dec 2011 19:49:55 -0500
Message-ID: <20111207004955.GA30288@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <20111206062247.GF29233@sigill.intra.peff.net>
 <7vsjkxckwk.fsf@alter.siamese.dyndns.org>
 <20111207004511.GA28370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 01:50:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY5hz-0003e2-1N
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 01:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557Ab1LGAt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 19:49:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41580
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755184Ab1LGAt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 19:49:57 -0500
Received: (qmail 10330 invoked by uid 107); 7 Dec 2011 00:56:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 19:56:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 19:49:55 -0500
Content-Disposition: inline
In-Reply-To: <20111207004511.GA28370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186410>

On Tue, Dec 06, 2011 at 07:45:11PM -0500, Jeff King wrote:

> On Tue, Dec 06, 2011 at 03:58:35PM -0800, Junio C Hamano wrote:
> 
> > > +test_expect_success 'respect configured credentials' '
> > > +	test_config credential.helper "$HELPER" &&
> > > +	check fill <<-\EOF
> > > +	--
> > > +	username=foo
> > > +	password=bar
> > > +	--
> > > +	EOF
> > > +'
> > 
> > Hmm, why do I get ask-ass-{username,password} from this one?
> 
> Ugh. Because apparently one of my re-roll tweaks from patch 03 regressed
> this. Sorry, I should have been more careful about running the full
> suite, not just the tests in the commits I tweaked.
> 
> Let me investigate and get back to you.

Brown paper bag time.

This needs squashed in, due to the changes in patch 03/13:

---
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index e3f61f4..42d0f5b 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -192,7 +192,7 @@ test_expect_success 'internal getpass does not ask for known username' '
 	EOF
 '
 
-HELPER="f() {
+HELPER="!f() {
 		cat >/dev/null
 		echo username=foo
 		echo password=bar
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 21e2f5d..c59908f 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -102,7 +102,7 @@ test_expect_success 'http auth can request both user and pass' '
 '
 
 test_expect_success 'http auth respects credential helper config' '
-	test_config_global credential.helper "f() {
+	test_config_global credential.helper "!f() {
 		cat >/dev/null
 		echo username=user@host
 		echo password=user@host
