From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: do not compile git with debugging symbols by
 default
Date: Thu, 22 Jan 2015 08:00:36 -0500
Message-ID: <20150122130036.GC19681@peff.net>
References: <1421931037-21368-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 14:00:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEHNK-00030d-JG
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 14:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbbAVNAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 08:00:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:37280 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751177AbbAVNAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 08:00:38 -0500
Received: (qmail 17407 invoked by uid 102); 22 Jan 2015 13:00:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 07:00:37 -0600
Received: (qmail 8944 invoked by uid 107); 22 Jan 2015 13:01:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 08:01:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2015 08:00:36 -0500
Content-Disposition: inline
In-Reply-To: <1421931037-21368-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262829>

On Thu, Jan 22, 2015 at 06:50:37PM +0600, Alexander Kuleshov wrote:

> Standard user has no need in debugging information. This patch adds
> DEBUG=1 option to compile git with debugging symbols and compile without
> it by default.

This explanation is missing why it is beneficial _not_ to have the
debugging information.

I expect the answer is "it makes the executable smaller". And that is
true, but it gets smaller still if you run "strip" on the result:

  $ make CFLAGS= >/dev/null 2>&1 && wc -c <git
  2424248

  $ make CFLAGS=-g >/dev/null 2>&1 && wc -c <git
  4500816

  $ strip git && wc -c <git
  2109200

So I am not sure who this is helping. If you are size-conscious, you
should use strip, in which case the "-g" flag does not matter (and we
even have "make strip" to help you).

Is there some other reason to avoid the debugging information?

-Peff
