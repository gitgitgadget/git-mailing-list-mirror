From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] cat-file --batch-check performance improvements
Date: Fri, 12 Jul 2013 16:12:54 -0400
Message-ID: <20130712201254.GA5276@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
 <7vy59blmjt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 22:13:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxjiA-0003Hc-Fl
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 22:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329Ab3GLUM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 16:12:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:42030 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965269Ab3GLUM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 16:12:58 -0400
Received: (qmail 24251 invoked by uid 102); 12 Jul 2013 20:14:16 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 15:14:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 16:12:54 -0400
Content-Disposition: inline
In-Reply-To: <7vy59blmjt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230248>

On Fri, Jul 12, 2013 at 10:23:34AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The results for running (in linux.git):
> >
> >   $ git rev-list --objects --all >objects
> >   $ git cat-file --batch-check='%(objectsize:disk)' <objects >/dev/null
> 
> I can see how these patches are very logical avenue to grab only
> on-disk footprint for large number of objects, but among the type,
> payload size and on-disk footprint, I find it highly narrow niche
> that a real user or script is interested _only_ in on-disk footprint
> without even worrying about the type of object.

Yeah, I agree it is a bit of a niche. However, there are other code
paths that might want only the size and not the type (e.g., we already
know the object is a blob, but want to know size before deciding how to
handle diff). But in general, I doubt the performance impact is a big
deal there. It's only measurable when you're doing millions of objects.

-Peff
