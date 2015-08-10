From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pager_in_use: make sure output is still going to
 pager
Date: Mon, 10 Aug 2015 13:24:49 -0400
Message-ID: <20150810172448.GA20168@sigill.intra.peff.net>
References: <20150810051901.GA9262@sigill.intra.peff.net>
 <20150810052353.GB15441@sigill.intra.peff.net>
 <98d092607588cb5c98e7a2deb2163f94@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Per Cederqvist <cederp@opera.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 19:24:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOqol-00066b-7x
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 19:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbbHJRYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 13:24:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:43137 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753178AbbHJRYy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 13:24:54 -0400
Received: (qmail 31042 invoked by uid 102); 10 Aug 2015 17:24:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 12:24:54 -0500
Received: (qmail 7393 invoked by uid 107); 10 Aug 2015 17:25:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 13:25:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 13:24:49 -0400
Content-Disposition: inline
In-Reply-To: <98d092607588cb5c98e7a2deb2163f94@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275637>

On Mon, Aug 10, 2015 at 06:38:10PM +0200, Johannes Schindelin wrote:

> > +const char *pipe_id_get(int fd)
> > +{
> > +	static struct strbuf id = STRBUF_INIT;
> > +	struct stat st;
> > +
> > +	if (fstat(fd, &st) < 0 || !S_ISFIFO(st.st_mode))
> > +		return NULL;
> 
> Just a quick note: it seems that this check is not really working on
> Windows. I tested this by running this test case manually (because TTY
> is not set on Windows):

Yeah, I'm not too surprised. I'm guessing your st_ino for pipes are all
just the same or something. Or maybe S_ISFIFO doesn't pass (we don't
technically need it, I don't think, and could just drop that check).

Anyway, I had planned that we would need to stick a big "#ifdef WINDOWS"
around these two functions.

> I hope to find some time tomorrow to figure out some workaround that
> makes this work on Windows.

Cool. I can't comment on Windows-specific stuff, but I'm happy to review
the rest of it. :)

-Peff
