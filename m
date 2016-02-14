From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-curl: Include curl_errorstr on SSL setup failures
Date: Sun, 14 Feb 2016 11:50:48 -0500
Message-ID: <20160214165048.GA10219@sigill.intra.peff.net>
References: <1455413974-25147-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:50:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUzst-0005JV-K9
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 17:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbcBNQuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 11:50:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:41841 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751658AbcBNQuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 11:50:51 -0500
Received: (qmail 15211 invoked by uid 102); 14 Feb 2016 16:50:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Feb 2016 11:50:50 -0500
Received: (qmail 1463 invoked by uid 107); 14 Feb 2016 16:50:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Feb 2016 11:50:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2016 11:50:48 -0500
Content-Disposition: inline
In-Reply-To: <1455413974-25147-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286157>

On Sat, Feb 13, 2016 at 05:39:34PM -0800, Shawn Pearce wrote:

> For curl error 35 (CURLE_SSL_CONNECT_ERROR) users need the
> additional text stored in CURLOPT_ERRORBUFFER to debug why
> the connection did not start. This is curl_errorstr inside
> of http.c, so include that in the message if it is non-empty.

I think this is an all-around improvement. GitHub sometimes get support
requests for result=18 on a git-push, which is curl's code for "I dunno,
the remote end hung up". Having a human-readable message may make things
less confusing.

Unfortunately I cannot seem to create the problem at will to confirm
that it kicks in in this case[1], but it seems like it should just based on
reading your patch.

-Peff

[1] I tried inserting "exit(0)" in various places of receive-pack, and
    it seems make the protocol deadlock. Yikes.
