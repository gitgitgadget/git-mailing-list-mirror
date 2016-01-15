From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 11/21] revision: read --stdin with strbuf_getline()
Date: Fri, 15 Jan 2016 15:27:29 -0500
Message-ID: <20160115202729.GE11301@sigill.intra.peff.net>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-12-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:27:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKAy7-0005qV-JD
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbcAOU1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:27:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:54636 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751564AbcAOU1b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:27:31 -0500
Received: (qmail 10584 invoked by uid 102); 15 Jan 2016 20:27:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:27:31 -0500
Received: (qmail 23515 invoked by uid 107); 15 Jan 2016 20:27:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:27:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 15:27:29 -0500
Content-Disposition: inline
In-Reply-To: <1452815916-6447-12-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284210>

On Thu, Jan 14, 2016 at 03:58:26PM -0800, Junio C Hamano wrote:

> Reading with getwholeline() and manually stripping the terminating
> '\n' would leave CR at the end of the line if the input comes from
> a DOS editor.
> 
> Constrasting this with the previous few changes, one may realize
> that the way "log" family of commands read the paths with --stdin
> looks inconsistent and sloppy.  It does not allow us to C-quote a
> textual input, and it does not accept NUL-terminated records.  These
> are unfortunately way too late to fix X-<.

Unlike the previous patch, where we can reasonably expect somebody to
quote a bare CR, this actually makes it impossible to ask about "foo\r".
Well, maybe not impossible, if we strip only one CR (you could say
"foo\r\r"), but certainly a behavior change.

Given the general crappiness of this interface for files with bizarre
characters, I think we are much more likely to be doing the user a favor
by stripping CRLF than hurting them by breaking "foo\r". After all,
"foo\n" remains impossible.

-Peff
