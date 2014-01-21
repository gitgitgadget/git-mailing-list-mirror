From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 21 Jan 2014 00:30:26 -0500
Message-ID: <20140121053026.GC5878@sigill.intra.peff.net>
References: <20140117041430.GB19551@sigill.intra.peff.net>
 <20140117042153.GB23443@sigill.intra.peff.net>
 <398F146D-72F1-44CD-B205-729665FD8765@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Yuri <yuri@rawbw.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 06:30:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Tuy-0004lv-2W
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 06:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbaAUFa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 00:30:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:36066 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbaAUFa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 00:30:28 -0500
Received: (qmail 6255 invoked by uid 102); 21 Jan 2014 05:30:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 23:30:28 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jan 2014 00:30:26 -0500
Content-Disposition: inline
In-Reply-To: <398F146D-72F1-44CD-B205-729665FD8765@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240744>

On Thu, Jan 16, 2014 at 11:26:50PM -0800, Kyle J. McKay wrote:

> >--- a/pager.c
> >+++ b/pager.c
> >@@ -87,6 +87,10 @@ void setup_pager(void)
> >		argv_array_push(&env, "LESS=FRSX");
> >	if (!getenv("LV"))
> >		argv_array_push(&env, "LV=-c");
> >+#ifdef PAGER_MORE_UNDERSTANDS_R
> >+	if (!getenv("MORE"))
> >+		argv_array_push(&env, "MORE=R");
> >+#endif
> 
> How about adding a leading "-" to both the LESS and MORE settings?
> Since you're in there patching... :)

I do not have any problem with that, but would very much prefer it as a
separate patch, in case there are any fallouts.

> And while the less man page does not have that wording, it does show
> this:
> 
>   LESS="-options"; export LESS
> 
> and this:
> 
>   LESS="-Dn9.1$-Ds4.1"

Ugh. Having just read the LESS discussion, it makes me wonder if the

  strchr(getenv("LESS"), 'R')

check I add elsewhere in the series is sufficient. I suspect in practice
it is good enough, but I would not be surprised if there is a way to
fool it with a sufficiently complex LESS variable. Maybe we should just
assume it is enough, and people with crazy LESS settings can set
color.pager as appropriate?
