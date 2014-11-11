From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] run-command: use void to declare that functions take no
 parameters
Date: Mon, 10 Nov 2014 21:54:15 -0500
Message-ID: <20141111025415.GB21328@peff.net>
References: <54612B4C.8010609@web.de>
 <xmqq7fz28yo1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Etienne Buira <etienne.buira@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 03:54:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xo1b3-0005Tl-TP
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 03:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbaKKCyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 21:54:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:38956 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751260AbaKKCyR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 21:54:17 -0500
Received: (qmail 6218 invoked by uid 102); 11 Nov 2014 02:54:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 20:54:17 -0600
Received: (qmail 14129 invoked by uid 107); 11 Nov 2014 02:54:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 21:54:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 21:54:15 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7fz28yo1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 02:43:10PM -0800, Junio C Hamano wrote:

> > Explicitly declare that git_atexit_dispatch() and git_atexit_clear()
> > take no parameters instead of leaving their parameter list empty and
> > thus unspecified.
> [...]
> 
> I was kind of surprised after running a git blame to find that this
> is a recent thing, and the same patch looked quite substandard with
> numerious style violations, and I somehow managed to let them slip
> in X-<.  Perhaps I was having a bad day or something...

I had always just assumed that -Wstrict-prototypes was part of -Wall,
but it is not (nor even part of -Wextra!). Maybe it is time to add it to
your integration-build flags. :)

Looks like we also need this on top of hv/submodule-config (still in pu,
so squashing is probably best):

diff --git a/submodule-config.h b/submodule-config.h
index 58afc83..9061e4e 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -24,6 +24,6 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name);
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
-void submodule_free();
+void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */

-Peff
