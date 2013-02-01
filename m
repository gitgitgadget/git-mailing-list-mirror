From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Fri, 1 Feb 2013 04:21:05 -0500
Message-ID: <20130201092105.GD30644@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <7vy5fbq48t.fsf@alter.siamese.dyndns.org>
 <7vtxpzq2uv.fsf@alter.siamese.dyndns.org>
 <20130130071209.GD11147@sigill.intra.peff.net>
 <7vk3qvm962.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 10:21:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1CoP-000198-1E
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 10:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913Ab3BAJVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 04:21:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55326 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755828Ab3BAJVI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 04:21:08 -0500
Received: (qmail 19729 invoked by uid 107); 1 Feb 2013 09:22:32 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 04:22:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 04:21:05 -0500
Content-Disposition: inline
In-Reply-To: <7vk3qvm962.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215224>

On Tue, Jan 29, 2013 at 11:17:41PM -0800, Junio C Hamano wrote:

> > True, but it is even less headache if the file is totally separate and
> > optional.
> 
> Once you start thinking about using an offset to some list of SHA-1,
> perhaps?  A section inside the same file can never go out of sync.

Yes, having a data dependency is important. It is unavoidable to have a
dependency on the packfile, though (and that is why the index and the
metapacks embed the sha1 of the packfile). If the offsets used are
packfile offsets, then that is sufficient.

If the offsets are from the index, then yes, putting it in the same file
is one way to keep them tied together. Another way is to do the same
sha1 verification, except to embed the sha1 of the index in the
metapack.

So I certainly consider putting the dependency-handling to be a point in
favor of the same file, but I'd weight it against other points (headache
of bumping index version, performance of both types, etc).

> Also a longer-term advantage is that you can teach index-pack to do
> this.

I think that is roughly the same amount of difficulty to do whether they
are in the same file or not.

-Peff
