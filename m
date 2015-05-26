From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] http-backend: spool ref negotiation requests to
 buffer
Date: Mon, 25 May 2015 22:24:01 -0400
Message-ID: <20150526022401.GA1725@peff.net>
References: <20150520073526.GA16784@peff.net>
 <20150520073709.GC9818@peff.net>
 <CAMwyc-Tn+Sw67z9zTPsPU7SQP7PDzJhoJn30utQ0OWhKe_xbuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Tue May 26 04:24:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx4XJ-0006YT-U3
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 04:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbbEZCYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 22:24:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:35887 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751232AbbEZCYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 22:24:04 -0400
Received: (qmail 24946 invoked by uid 102); 26 May 2015 02:24:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 May 2015 21:24:04 -0500
Received: (qmail 14473 invoked by uid 107); 26 May 2015 02:24:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 May 2015 22:24:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2015 22:24:01 -0400
Content-Disposition: inline
In-Reply-To: <CAMwyc-Tn+Sw67z9zTPsPU7SQP7PDzJhoJn30utQ0OWhKe_xbuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269922>

On Mon, May 25, 2015 at 10:07:50PM -0400, Konstantin Ryabitsev wrote:

> On 20 May 2015 at 03:37, Jeff King <peff@peff.net> wrote:
> > +               /* partial read from read_in_full means we hit EOF */
> > +               len += cnt;
> > +               if (len < alloc) {
> > +                       *out = buf;
> > +                       warning("request size was %lu", (unsigned long)len);
> > +                       return len;
> > +               }
> 
> Jeff:
> 
> This patch appears to work well -- the only complaint I have is that I
> now have "warning: request size was NNN" all over my error logs. :) Is
> it supposed to convey an actual warning message, or is it merely a
> debug statement?

Whoops, yeah, it was just for debugging. I missed that one when sending
out the patch.

Junio, the squashable patch is below (on jk/http-backend-deadlock-2.2),
and it looks like nothing has hit "next" yet. But you did do some
up-merging of the topic. Let me know if you would prefer to just have a
patch on top.

diff --git a/http-backend.c b/http-backend.c
index d1333b8..6bf139b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -295,7 +295,6 @@ static ssize_t read_request(int fd, unsigned char **out)
 		len += cnt;
 		if (len < alloc) {
 			*out = buf;
-			warning("request size was %lu", (unsigned long)len);
 			return len;
 		}
 

-Peff
