From: Jeff King <peff@peff.net>
Subject: Re: implement a stable 'Last updated' in Documentation
Date: Fri, 30 Jan 2015 10:07:58 -0500
Message-ID: <20150130150758.GA3683@peff.net>
References: <20150126172409.GA15204@aepfle.de>
 <xmqqd25zkeg7.fsf@gitster.dls.corp.google.com>
 <20150128080214.GA18851@aepfle.de>
 <xmqqbnlif6t9.fsf@gitster.dls.corp.google.com>
 <54CB5770.8030503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Olaf Hering <olaf@aepfle.de>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 16:08:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHDB3-0005vQ-Gl
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 16:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762415AbbA3PIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 10:08:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:43307 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762367AbbA3PID (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 10:08:03 -0500
Received: (qmail 22586 invoked by uid 102); 30 Jan 2015 15:08:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 09:08:02 -0600
Received: (qmail 24702 invoked by uid 107); 30 Jan 2015 15:08:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 10:08:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2015 10:07:58 -0500
Content-Disposition: inline
In-Reply-To: <54CB5770.8030503@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263177>

On Fri, Jan 30, 2015 at 11:05:36AM +0100, Michael J Gruber wrote:

> It's a shame one can't simply replace the [footer-text] template which
> asciidoc insists on.
> 
> It turns out asciidoc 8.6.9-3 and later will habe a knob to turn:
> 
> https://github.com/asciidoc/asciidoc/pull/9
> 
> I'll try and get my hands on it to see whether we can simply use that.
> I'm wondering though which is more useful - the version of the tree the
> doc is processed from, or the version of the last commit changing the
> corresponding doc source file. The first one changes even when the doc
> source is unchanged (but is stable between reruns, of course).

I have 8.6.9-3 installed (it is part of Debian testing/unstable now),
and confirmed that:

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 2c16c53..10c777e 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -21,6 +21,7 @@ tilde=&#126;
 apostrophe=&#39;
 backtick=&#96;
 litdd=&#45;&#45;
+footer-style=none
 
 ifdef::backend-docbook[]
 [linkgit-inlinemacro]

drops the "last-updated" footer.

But note that this only affects the generated HTML. The manpages still
get the date in their footer. But this isn't an asciidoc-ism at all;
it's added by docbook when converting the xml to roff. I'm sure there is
a way to tweak that, too, but looking at docbook gives me nightmares.

-Peff
