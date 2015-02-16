From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] cleaner bit-setting in cmd_push
Date: Mon, 16 Feb 2015 01:10:51 -0500
Message-ID: <20150216061051.GA29895@peff.net>
References: <1424055690-32631-1-git-send-email-cxreg@pobox.com>
 <20150216052049.GA5031@peff.net>
 <20150216054550.GA24611@peff.net>
 <20150216055422.GB24611@peff.net>
 <CAPc5daU6VOmuNp3VbYgoFDXJshkC2AnRsZQQdoRMArYpezZr=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 07:11:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNEtX-0007Lo-HN
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 07:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbBPGKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 01:10:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:49390 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751695AbbBPGKy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 01:10:54 -0500
Received: (qmail 9072 invoked by uid 102); 16 Feb 2015 06:10:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:10:54 -0600
Received: (qmail 12441 invoked by uid 107); 16 Feb 2015 06:10:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 01:10:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 01:10:51 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daU6VOmuNp3VbYgoFDXJshkC2AnRsZQQdoRMArYpezZr=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263876>

On Sun, Feb 15, 2015 at 10:02:08PM -0800, Junio C Hamano wrote:

> On Sun, Feb 15, 2015 at 9:54 PM, Jeff King <peff@peff.net> wrote:
> >
> > Or alternatively, we could pull the "flags" field from cmd_push out into
> > a static global "transport_flags", and manipulate it directly from the
> > config (or if we don't like a global, pass it via the config-callback
> > void pointer; but certainly a global is more common in git for code like
> > this). Then we do not have to worry about propagating values from
> > integers into flag bits at all.
> 
> Yup, that would be my preference. The largest problem I had with the
> original change was how to ensure that future new code would not
> mistakenly set the global follow_tags _without_ letting the command
> line option parser to override it. If the config parser flips the bit in the
> same flags, it would become much less likely for future code to make
> such a mistake.

So here's my take on it (on top of the two-patch series I just sent).
Dave's patch is 3rd here, just to show its rebased form, but do not take
that as a final endorsement. I still think it could use tests, but I
will let him write them. I am just doing the cleanup in the area, none
of which needs to be his problem. :)

  [1/3]: cmd_push: set "atomic" bit directly
  [2/3]: cmd_push: pass "flags" pointer to config callback
  [3/3]: push: allow --follow-tags to be set by config push.followTags

-Peff
