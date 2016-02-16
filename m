From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 14:22:32 -0500
Message-ID: <20160216192231.GA16567@sigill.intra.peff.net>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
 <1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 20:22:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVlCo-0004zl-O9
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 20:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbcBPTWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 14:22:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:43478 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755027AbcBPTWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 14:22:34 -0500
Received: (qmail 30404 invoked by uid 102); 16 Feb 2016 19:22:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 14:22:34 -0500
Received: (qmail 29600 invoked by uid 107); 16 Feb 2016 19:22:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 14:22:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 14:22:32 -0500
Content-Disposition: inline
In-Reply-To: <1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286425>

On Wed, Feb 17, 2016 at 12:30:05AM +0530, Karthik Nayak wrote:

> Use the newly introduced strbuf_split_str_omit_term() rather than
> using strbuf_split_str() and manually removing the ',' terminator.
> 
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Did you consider just using string_list_split for this? AFAICT, you
don't care about the results being strbufs themselves, and it would do
what you want without having to bother with patch 1. The result would
look something like the patch below.

Sorry to waltz into a review of v5 with a suggestion to throw out all
the work done in previous iterations. :-/ I just think the strbuf_split
interface is kind of clunky and I'd be happy if we could slowly get rid
of it rather than growing it. Maybe that's not realistic, though (some
of the callsites _do_ want to do things like strbuf_trim() after
splitting).

-Peff
