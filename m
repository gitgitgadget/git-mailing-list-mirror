From: Jeff King <peff@peff.net>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Sat, 29 Dec 2012 00:07:07 -0500
Message-ID: <20121229050707.GA14475@sigill.intra.peff.net>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net>
 <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 06:07:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Toodv-0007nT-Vk
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 06:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070Ab2L2FHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 00:07:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38469 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab2L2FHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 00:07:11 -0500
Received: (qmail 26981 invoked by uid 107); 29 Dec 2012 05:08:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 00:08:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 00:07:07 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212289>

On Sat, Dec 29, 2012 at 11:34:09AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Sat, Dec 29, 2012 at 7:41 AM, Jeff King <peff@peff.net> wrote:
> > I wonder if we could do even better, though. For a traversal, we only
> > need to look at the commit header. We could potentially do a progressive
> > inflate and stop before getting to the commit message (which is the bulk
> > of the data, and the part that is most likely to benefit from
> > compression).
> 
> Commit cache should solve this efficiently as it also eliminates
> parsing cost. We discussed this last time as a side topic of the
> reachability bitmap feature.

I agree that a commit cache would solve this (though it can not help the
tree traversal). But just dropping the compression (or doing partial
decompression when we only care about the beginning part) is way less
code and complexity. There's no cache to manage.

-Peff
