From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: support temporarily preserving garbage
Date: Mon, 17 Nov 2014 16:34:42 -0500
Message-ID: <20141117213442.GD15880@peff.net>
References: <1415927805-53644-1-git-send-email-brodie@sf.io>
 <xmqqlhnd1j66.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	Bryan Turner <bturner@atlassian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 22:34:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqTwe-0003iy-VU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 22:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbaKQVep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 16:34:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:41293 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751836AbaKQVeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 16:34:44 -0500
Received: (qmail 3073 invoked by uid 102); 17 Nov 2014 21:34:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Nov 2014 15:34:44 -0600
Received: (qmail 2233 invoked by uid 107); 17 Nov 2014 21:34:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Nov 2014 16:34:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Nov 2014 16:34:42 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlhnd1j66.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 03:01:05PM -0800, Junio C Hamano wrote:

> >  23 files changed, 375 insertions(+), 7 deletions(-)
> [...]
> 
> I am not sure if this much of code churn is warranted to work around
> issues that only happen on repositories on NFS servers that do not
> keep open-but-deleted files available.  Is it an option to instead
> have a copy of repository locally off NFS?

I think it is also not sufficient. This patch seems to cover only
objects. But we assume that we can atomically rename() new versions of
files into place whenever we like without disrupting existing readers.
This is the case for ref updates (and packed-refs), as well as the index
file.  The destination end of the rename is an unlink() in disguise, and
would be susceptible to the same problems.

-Peff
