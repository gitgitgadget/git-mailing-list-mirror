From: Jeff King <peff@peff.net>
Subject: Re: git rev-list %an, %ae, %at bug in v1.7.10.1 and beyond
Date: Tue, 22 May 2012 00:35:09 -0400
Message-ID: <20120522043509.GB6859@sigill.intra.peff.net>
References: <CAGyf7-G3nNTTP1bKdd9HLKEn-8+LoxCeY2R08x9gKZwS0L_N6g@mail.gmail.com>
 <20120522043221.GA6859@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue May 22 06:35:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWgoY-0007Hy-Ft
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 06:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313Ab2EVEfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 00:35:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51432
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011Ab2EVEfM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 00:35:12 -0400
Received: (qmail 12196 invoked by uid 107); 22 May 2012 04:35:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 00:35:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 00:35:09 -0400
Content-Disposition: inline
In-Reply-To: <20120522043221.GA6859@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198171>

On Tue, May 22, 2012 at 12:32:21AM -0400, Jeff King wrote:

> I'm not too surprised this is broken (in fact, I'm surprised it ever
> really worked). UTF-16, especially representing pure ascii characters,
> will have embedded NULs. Most of the code assumes that things like names
> and emails are NUL-terminated and ascii-compatible (so ascii, or some
> ascii-superset encoding like utf8, iso8859-1, etc). You can store a
> commit message (and name) in utf-16 if you tell git that you are doing
> so, but we should be re-encoding it before handling it.

Actually, I take that back. I think storing in utf-16 would probably
fail. We need to use ascii to even read the headers to get to the
encoding header to realize that it is in utf-16. So I believe we really
do only support ascii-superset encodings.

-Peff
