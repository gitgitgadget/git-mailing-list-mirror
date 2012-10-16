From: Jeff King <peff@peff.net>
Subject: Re: push race
Date: Tue, 16 Oct 2012 13:02:33 -0400
Message-ID: <20121016170232.GA27243@sigill.intra.peff.net>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com>
 <20121015185608.GC31658@sigill.intra.peff.net>
 <CAJo=hJu=eqgUhJvvpMLJ05AT6o+nVUDcm+tHV8en8OCX2-2qgA@mail.gmail.com>
 <20121016045118.GA21359@sigill.intra.peff.net>
 <CACsJy8AJVAoUHft6+rdOjWCpLWWj3m0NgvFd9pToQRQ5uD8_gg@mail.gmail.com>
 <20121016053750.GA22281@sigill.intra.peff.net>
 <CACsJy8D14sv5=+5zfiwgYCb7OoEqvQoVQ0ObAeWtUUSjRAgBeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, marcnarc@xiplink.com,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:02:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOAXa-0002nq-Pn
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab2JPRCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:02:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55086 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753912Ab2JPRCj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 13:02:39 -0400
Received: (qmail 17173 invoked by uid 107); 16 Oct 2012 17:03:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Oct 2012 13:03:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2012 13:02:33 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8D14sv5=+5zfiwgYCb7OoEqvQoVQ0ObAeWtUUSjRAgBeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207848>

On Tue, Oct 16, 2012 at 05:45:12PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Oct 16, 2012 at 12:37 PM, Jeff King <peff@peff.net> wrote:
> > I suspect a site that is heavy on alternates is invoking the index-pack
> > code path more frequently than necessary (e.g., history gets pushed to
> > one forked repo, then when it goes to the next one, we may not share the
> > ref that tells the client we already have the object and receive it a
> > second time).
> 
> I suppose we could do the way unpack-objects does: prefer present
> objects and drop the new identical ones, no memcmp. Objects that are
> not bases, or are ref-delta bases, can be safely dropped. ofs-delta
> bases may lead to rewriting the pack. Do-able but not sure it's worth
> the effort.

Yeah, I think that complexity is why we don't do it currently. We are
pretty alternates-heavy at GitHub, and we have not noticed a performance
impact. So I think it is probably not worth worrying about.

-Peff
