From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] convert: Stream from fd to required clean filter
 instead of mmap
Date: Tue, 19 Aug 2014 03:53:45 -0400
Message-ID: <20140819075345.GA7712@peff.net>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de>
 <1407303134-16635-3-git-send-email-prohaska@zib.de>
 <20140816102703.GD7857@serenity.lan>
 <FA3F1197-25C5-42E4-9418-1C821D430819@zib.de>
 <20140817072746.GD23808@peff.net>
 <C1695CEB-B278-422A-90D6-C3EAD8B6638C@zib.de>
 <CACsJy8BUBfQeny4iu6nZ+pCy84_=8EEfEHY3pWLpx_1PLCwC5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:53:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJeEu-0006UZ-6f
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 09:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbaHSHxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 03:53:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:54722 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750789AbaHSHxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 03:53:47 -0400
Received: (qmail 20463 invoked by uid 102); 19 Aug 2014 07:53:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Aug 2014 02:53:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2014 03:53:45 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BUBfQeny4iu6nZ+pCy84_=8EEfEHY3pWLpx_1PLCwC5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255446>

On Sun, Aug 17, 2014 at 06:33:54PM +0700, Duy Nguyen wrote:

> > For files >2GB on a 32-bit system (e.g. msysgit), filtering with the
> > previous code always failed.  Now it works.  I created the patch to
> > change git from 'fundamentally doesn't handle this' to 'works as
> > expected'.
> 
> I deal with similar problem and added $GIT_ALLOC_LIMIT to test large
> blob code. Maybe we could add $GIT_MMAP_LIMIT? I don't suppose we call
> xmmap/xmalloc so often that the extra test would slow git down.

Yeah, I think I'd prefer that approach. We should mmap _way_ less than
we malloc, and I do not think the malloc check has caused any problems.

-Peff
