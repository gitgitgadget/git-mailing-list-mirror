From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame.c: fix garbled error message
Date: Mon, 12 Jan 2015 18:12:31 -0500
Message-ID: <20150112231231.GA4023@peff.net>
References: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
 <xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
 <xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:12:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAoAA-0007CA-5z
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 00:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbbALXMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 18:12:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:33502 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753624AbbALXMc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 18:12:32 -0500
Received: (qmail 12273 invoked by uid 102); 12 Jan 2015 23:12:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 17:12:32 -0600
Received: (qmail 21261 invoked by uid 107); 12 Jan 2015 23:12:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 18:12:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 18:12:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262300>

On Mon, Jan 12, 2015 at 02:55:30PM -0800, Junio C Hamano wrote:

> With the patch applied on top of 1da1e07c (or the result merged to
> 'next' for that matter), I see test breakages in many places "git
> blame" is used, e.g. t7010.  Did you run the test suite?
> 
> This is because it is perfectly normal for prepare_final() to return
> NULL.  Unconditionally running xstrdup() would of course fail.

Eek. I even thought of this possibility and checked the prepare_initial
callsite, but not the prepare_final one.

As an aside, I have often been tempted to have xstrdup silently
propagate a NULL. It would have been the right thing to do here, but
maybe there are cases where the segfault is preferable for catching a
mistake early (otherwise you might store the NULL and then segfault much
later).

-Peff
