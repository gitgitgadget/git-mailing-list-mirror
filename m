From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/25] t9502: fix &&-chain breakage
Date: Fri, 20 Mar 2015 14:03:01 -0400
Message-ID: <20150320180301.GB11844@peff.net>
References: <20150320100429.GA17354@peff.net>
 <20150320101301.GO12543@peff.net>
 <550C5D73.4080901@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 19:03:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1GH-0008Tb-D7
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbbCTSDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:03:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:35973 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751157AbbCTSDE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:03:04 -0400
Received: (qmail 27299 invoked by uid 102); 20 Mar 2015 18:03:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 13:03:03 -0500
Received: (qmail 26183 invoked by uid 107); 20 Mar 2015 18:03:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 14:03:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 14:03:01 -0400
Content-Disposition: inline
In-Reply-To: <550C5D73.4080901@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265925>

On Fri, Mar 20, 2015 at 06:48:35PM +0100, Johannes Sixt wrote:

> >-cat >>gitweb_config.perl <<\EOF &&
> >-$feature{'forks'}{'default'} = [1];
> >-EOF
> >+test_expect_success 'enable forks feature' '
> >+	cat >>gitweb_config.perl <<-\EOF
> >+	$feature{'forks'}{'default'} = [1];
> >+	EOF
> >+'
> 
> This loses the single-quotes in the generated perl script, doesn't it? Most
> likely, it does not matter.

Eek, you're right. Thanks for noticing.

I agree it should not matter (it is OK in perl to use barewords as hash
keys, but it would probably be more obvious to omit them entirely, or to
just use double-quotes. I'll squash this in:

diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index a93e159..0796a43 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -147,7 +147,7 @@ test_expect_success 'forks: not skipped unless "forks" feature enabled' '
 
 test_expect_success 'enable forks feature' '
 	cat >>gitweb_config.perl <<-\EOF
-	$feature{'forks'}{'default'} = [1];
+	$feature{"forks"}{"default"} = [1];
 	EOF
 '
 

-Peff
