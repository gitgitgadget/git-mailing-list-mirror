From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Support stdio access to lockfiles
Date: Wed, 1 Oct 2014 08:52:15 -0400
Message-ID: <20141001125214.GC10772@peff.net>
References: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 01 14:52:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZJOG-0006N3-1f
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 14:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbaJAMwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 08:52:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:53662 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751208AbaJAMwP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 08:52:15 -0400
Received: (qmail 22340 invoked by uid 102); 1 Oct 2014 12:52:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 07:52:15 -0500
Received: (qmail 26549 invoked by uid 107); 1 Oct 2014 12:52:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 08:52:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2014 08:52:15 -0400
Content-Disposition: inline
In-Reply-To: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257748>

On Wed, Oct 01, 2014 at 01:14:46PM +0200, Michael Haggerty wrote:

> This series applies on top of the series "Lockfile correctness and
> refactoring" (Junio's branch mh/lockfile).
> 
> There are already two callers that write to lockfiles using stdio. But
> they currently need intimate knowledge of the lockfile implementation
> to work correctly; for example, they have to call fclose() themselves
> and set lk->fd to -1 to prevent the file from being closed again. This
> is awkward and error-prone.

I think it's also wrong on systems where you cannot delete an open file.
A signal or atexit handler will not be able to close the file (since it
does not know the fd), and the unlink() will fail. IIRC, either cygwin
or msysgit (or both?) is such a platform.

> Michael Haggerty (3):
>   fdopen_lock_file(): access a lockfile using stdio
>   dump_marks(): reimplement using fdopen_lock_file()
>   commit_packed_refs(): reimplement using fdopen_lock_file()

I had a few minor comments on the first patch, but I would also be OK
with it going in as-is. The other two looked fine to me. Thanks for
working on this.

-Peff
