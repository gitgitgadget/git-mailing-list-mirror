From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] pkt-line: tighten sideband PACK check when tracing
Date: Fri, 12 Jun 2015 17:41:52 -0400
Message-ID: <20150612214152.GA26217@peff.net>
References: <20150612212526.GA25447@peff.net>
 <20150612212814.GB25757@peff.net>
 <CAGZ79kb+DBUqAy45+Bc=MTA6HuGrj9MzyODZGTvOcP_XefAu=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Augie Fackler <augie@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:42:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Wi8-0002Qw-9t
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 23:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbbFLVl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 17:41:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:45474 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755153AbbFLVlz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 17:41:55 -0400
Received: (qmail 11179 invoked by uid 102); 12 Jun 2015 21:41:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 16:41:55 -0500
Received: (qmail 18106 invoked by uid 107); 12 Jun 2015 21:41:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 17:41:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2015 17:41:52 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kb+DBUqAy45+Bc=MTA6HuGrj9MzyODZGTvOcP_XefAu=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271531>

On Fri, Jun 12, 2015 at 02:39:01PM -0700, Stefan Beller wrote:

> > -       if (starts_with(buf, "PACK") || starts_with(buf + 1, "PACK")) {
> > +       if (starts_with(buf, "PACK") || starts_with(buf, "\1PACK")) {
> 
> This answers the question on the previous patch actually, maybe the
> code could be improved to
> 
>     if (is_sidechannel(out, ...)
>         out++;
>     if (starts_with(buf, "PACK") {
>         ...

If it's not a PACK, then we don't want to skip past the side-channel
character (we show it as part of the trace).

Hopefully the end result after patch 3 reads well, as it sets an
explicit "sideband" flag.

-Peff
