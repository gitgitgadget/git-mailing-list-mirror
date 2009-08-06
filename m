From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] status: show worktree status of conflicted paths
 separately
Date: Thu, 6 Aug 2009 10:53:49 -0400
Message-ID: <20090806145348.GB1970@coredump.intra.peff.net>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
 <1249463746-21538-3-git-send-email-gitster@pobox.com>
 <1249463746-21538-4-git-send-email-gitster@pobox.com>
 <1249463746-21538-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 16:54:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4Lw-00068p-Mz
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 16:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbZHFOxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 10:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbZHFOxx
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 10:53:53 -0400
Received: from peff.net ([208.65.91.99]:38681 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbZHFOxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 10:53:52 -0400
Received: (qmail 31985 invoked by uid 107); 6 Aug 2009 14:56:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 Aug 2009 10:56:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Aug 2009 10:53:49 -0400
Content-Disposition: inline
In-Reply-To: <1249463746-21538-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125075>

On Wed, Aug 05, 2009 at 02:15:45AM -0700, Junio C Hamano wrote:

> +	switch (d->stagemask >> 1) {
> +	case 1: how = "both deleted"; break;
> +	case 2: how = "added by us"; break;
> +	case 3: how = "deleted by them"; break;
> +	case 4: how = "added by them"; break;
> +	case 5: how = "deleted by us"; break;
> +	case 6: how = "both added"; break;
> +	case 7: how = "both modified"; break;
> +	}

Ugh. Can we use symbolic constants for the stagemask instead of a
bitshift and some magic numbers? I understand it's a mask and not just
an integer value, but we are clearly enumerating every possibility here.

> +	color_fprintf(s->fp, c, "%-20s: %s\n", how, one);

This produces output like:

#       both modified       : a
#       deleted by us       : b
#       deleted by them     : c

Maybe it is just me, but I think the whitespace with the colon looks
awful. You could do just:

#       both modified:        a
#       deleted by us:        b
#       deleted by them:      c

which matches the other status output, or even left-prefix the spaces:

#              both modified: a
#              deleted by us: b
#            deleted by them: c

-Peff
