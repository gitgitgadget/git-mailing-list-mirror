From: Jeff King <peff@peff.net>
Subject: Re: SSL_CTX leak?
Date: Thu, 27 Mar 2014 19:11:56 -0400
Message-ID: <20140327231156.GE32434@sigill.intra.peff.net>
References: <CACnwZYdYYO2VXRnfyVD_uEeguYcBv-eFoYfawoCESDbcBVMhgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 00:12:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTJSt-00059u-K4
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 00:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbaC0XL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 19:11:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:48869 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756045AbaC0XL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 19:11:58 -0400
Received: (qmail 5807 invoked by uid 102); 27 Mar 2014 23:11:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Mar 2014 18:11:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2014 19:11:56 -0400
Content-Disposition: inline
In-Reply-To: <CACnwZYdYYO2VXRnfyVD_uEeguYcBv-eFoYfawoCESDbcBVMhgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245337>

On Thu, Mar 27, 2014 at 10:37:07AM -0300, Thiago Farina wrote:

> Do we leak the context we allocate in imap-send.c:280 intentionally?

It was never mentioned on the mailing list when the patches came
originally, so I suspect is just an omission.

Presumably the SSL_CTX is needed by the connection that survives after
the function, but my reading of SSL_CTX_free implies that the data is
reference-counted, and the library would presumably handle it fine.

OTOH, it is probably not causing a huge problem (since we wouldn't end
up freeing it until the end of the program anyway), so I would not
personally devote to many brain cycles to figuring out how OpenSSL
handles it.

-Peff
