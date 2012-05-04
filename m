From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] http: handle proxy proactive authentication
Date: Fri, 4 May 2012 06:51:07 -0400
Message-ID: <20120504105106.GA24933@sigill.intra.peff.net>
References: <4FA2B4DA.60908@seap.minhap.es>
 <20120504071632.GB21895@sigill.intra.peff.net>
 <4FA3B92E.3000200@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 04 12:51:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQG6W-0006Zu-C2
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 12:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab2EDKvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 06:51:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57775
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754910Ab2EDKvL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 06:51:11 -0400
Received: (qmail 18441 invoked by uid 107); 4 May 2012 10:51:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 06:51:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 06:51:07 -0400
Content-Disposition: inline
In-Reply-To: <4FA3B92E.3000200@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197015>

On Fri, May 04, 2012 at 01:10:38PM +0200, Nelson Benitez Leon wrote:

> > When you parse the URL via credential_from_url, the components you get
> > will have any URL-encoding removed. So when you regenerate the URL in
> > the proxyhost variable, you would need to re-encode.
> 
> Can a hostname has url-encoded parts? I thought that was only for the
> request uri (/somedir/somefile.php) or the query string ('?var1=val'),
> I'm only using the hostname here as a proxy server never has more than
> that, apart from the port number.

Hmm. It can have URL-encoded parts (so we must decode when parsing), but
the more important question is whether the decoded version can have
parts that _need_ to be URL-encoded.  And I think the answer is no,
after double-checking the RFCs (i.e., hostnames cannot contain any of the URL
reserved characters). So quoting would be a no-op, and we can skip it.

Anyway, your later patch ends up removing this chunk of code, so I think
we can forget the issue entirely.

-Peff
