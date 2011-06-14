From: Jeff King <peff@github.com>
Subject: Re: [PATCH 2/2] archive: support gzipped tar files
Date: Tue, 14 Jun 2011 16:49:50 -0400
Message-ID: <20110614204950.GB12776@sigill.intra.peff.net>
References: <20110614181732.GA31635@sigill.intra.peff.net>
 <20110614181821.GA32685@sigill.intra.peff.net>
 <7vaadkkvew.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 22:50:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWaYk-00085i-67
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 22:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990Ab1FNUty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 16:49:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59179
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab1FNUtw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 16:49:52 -0400
Received: (qmail 30942 invoked by uid 107); 14 Jun 2011 20:50:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 16:50:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 16:49:50 -0400
Content-Disposition: inline
In-Reply-To: <7vaadkkvew.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175800>

On Tue, Jun 14, 2011 at 01:30:47PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> I didn't know it was that easy (primarily because I didn't know zlib had a
> ready-to-eat interface to do this).

Yes, though I think it may be worth doing the more flexible,
external-filters approach. See elsewhere in the thread.

> > +	if (!strcasecmp(ext, "tgz"))
> > +		return "--format=tgz";
> > +	if (!strcasecmp(ext, "gz") &&
> > +	    ext - 4 >= filename &&
> > +	    !strcasecmp(ext - 4, "tar.gz"))
> 
> Shouldn't this be
> 
> 	if (!strcasecmp(ext, "gz") && filename < ext - 5 &&
>             !strcasecmp(ext - 5, ".tar.gz"))
> 
> to exclude "hellotar.gz" and possibly ".tar.gz" ("<=" vs "<")?

Yeah, definitely. I think the right way forward is to make this less
hard-coded, to allow people to configure new filters, so this bit of
code will get rewritten in my next version. But I'll make sure it is a
little more strict on extension matching.

-Peff
