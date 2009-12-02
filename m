From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 2 Dec 2009 14:39:02 -0500
Message-ID: <20091202193902.GE30778@coredump.intra.peff.net>
References: <7vskbuwhmy.fsf@alter.siamese.dyndns.org>
 <20091202055632.GD31244@Knoppix>
 <7vy6llnar5.fsf@alter.siamese.dyndns.org>
 <20091202160446.GA32667@Knoppix>
 <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
 <fabb9a1e0912021006x2905578bo16dbcaedc0d97bc6@mail.gmail.com>
 <7vk4x5fcbf.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0912021050r4fd96ed4rf863917a965a42fb@mail.gmail.com>
 <7v3a3tfbsx.fsf@alter.siamese.dyndns.org>
 <7vy6lldwyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:39:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFv2a-00089N-3t
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329AbZLBTi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbZLBTi4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:38:56 -0500
Received: from peff.net ([208.65.91.99]:57453 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753696AbZLBTiz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:38:55 -0500
Received: (qmail 27412 invoked by uid 107); 2 Dec 2009 19:43:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Dec 2009 14:43:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2009 14:39:02 -0500
Content-Disposition: inline
In-Reply-To: <7vy6lldwyo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134389>

On Wed, Dec 02, 2009 at 10:58:39AM -0800, Junio C Hamano wrote:

> After all my main objection is against closing the door to others by one
> particular implementation squating on "remote-http" name and refusing the
> use of that nice, authoritative-sounding name by others.

I would think that it would be useful to use the "remote-http" name as
the extra level of indirection (as a symlink, hardlink, or wrapper
script to remote-curl). Then you could have competing first-class
implementations that would be easy for the user (or package manager) to
switch between.

For example, Debian contains versions of curl built against gnutls and
against openssl. Right now the debian git package requires the gnutls
version. But let's say they ship two packages: git-http-curl-openssl and
git-http-curl-gnutls. Then you can install whichever you prefer, and the
package will contain the file "git-remote-http" pointing to
"git-remote-curl-$whatever".

And yes, if you think about it, this particular situation already works
with a hard-coded "git-remote-curl", since both are built on top of
curl, and that makes a reasonable name. But now extend it to "you don't
want to use curl, but rather some other http library". I don't think we
have any interest in providing a non-curl version as part of git itself,
but it provides a hook should somebody want to write their own http
handler (either using a different library, or maybe a wrapper that does
caching, or whatever).

Just my two cents. I don't plan on writing any such third-party remote
handlers, but it seems simple enough to leave the door open.

-Peff
