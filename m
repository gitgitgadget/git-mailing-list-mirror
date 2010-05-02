From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] pretty.c: add %O format specifier to
 format_commit_one()
Date: Sun, 2 May 2010 00:55:52 -0400
Message-ID: <20100502045552.GC14776@coredump.intra.peff.net>
References: <1272711401-29005-1-git-send-email-ash@koowaldah.org>
 <7vsk6b5yms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Shishkin <ash@koowaldah.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 06:56:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8RDx-0006bL-Kq
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 06:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab0EBEzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 00:55:55 -0400
Received: from peff.net ([208.65.91.99]:40373 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508Ab0EBEzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 00:55:54 -0400
Received: (qmail 3630 invoked by uid 107); 2 May 2010 04:56:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 02 May 2010 00:56:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 May 2010 00:55:52 -0400
Content-Disposition: inline
In-Reply-To: <7vsk6b5yms.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146133>

On Sat, May 01, 2010 at 10:18:35AM -0700, Junio C Hamano wrote:

> Alexander Shishkin <ash@koowaldah.org> writes:
> 
> > This specifier represents the number of each commit in the output
> > stream.
> 
> I don't like this.  What does such a number _mean_ in a non-linear
> history?
> 
> Also the next person who sees this will inevitably ask for %TOTAL to so
> that the output can say [N/M], but that would mean the list has to be
> limited and we cannot stream the output anymore.

Hmph. I started on a patch a while ago (but never finished) that would
allow an [N/M] output. My intent was to allow pretty-format specifiers
for generating cover letters[1].

Of course you can't stream when asking for %TOTAL, but that is already
the case with format-patch, which does such a calculation when numbering
patch subjects. We could use userformat_find_requirements to do the
lookup when needed, and then only formats which use the placeholder
would have to pay the penalty.

-Peff

[1] These days I do:

  git format-patch --stdout "$@" |
    sed -ne 's/^Subject: //p' |
    sed -e 's/\[PATCH /[/' \
        -e 's/]/]:/' \
        -e 's/^/  /'

and pull the result into a cover letter that I write manually.
