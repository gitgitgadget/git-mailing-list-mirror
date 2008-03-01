From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] rename: warn user when we have turned off rename
	detection
Date: Sat, 1 Mar 2008 03:18:33 -0500
Message-ID: <20080301081832.GB31855@coredump.intra.peff.net>
References: <20080301061431.GA27301@coredump.intra.peff.net> <7vtzjq6gnv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 09:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMw3-0004OY-Ua
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 09:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbYCAISf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 03:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbYCAISf
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 03:18:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1348 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754840AbYCAISf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 03:18:35 -0500
Received: (qmail 12703 invoked by uid 111); 1 Mar 2008 08:18:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Mar 2008 03:18:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2008 03:18:33 -0500
Content-Disposition: inline
In-Reply-To: <7vtzjq6gnv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75641>

On Fri, Feb 29, 2008 at 11:35:00PM -0800, Junio C Hamano wrote:

> > +	if ((num_create > rename_limit && num_src > rename_limit) ||
> > +	    (num_create * num_src > rename_limit * rename_limit)) {
> > +		warning("too many files, skipping inexact rename detection");
> >  		goto cleanup;
> > +	}
> > 
> >  	mx = xmalloc(sizeof(*mx) * num_create * num_src);
> >  	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
> 
> This reminds me of the 6d24ad9 (Optimize rename detection for a huge diff)
> topic that reduces the above allocation greatly.  Some benching with the
> patch may prove useful to establish much higher limits, I suspect.

Actually, my timings are about the same. While the patch you mentioned
is nice for reducing the memory consumption, we still have an O(n^2)
loop.

-Peff
