From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git+http:// proof-of-concept (not using CONNECT)
Date: Fri, 3 Jul 2009 13:28:39 -0700
Message-ID: <20090703202839.GB12072@dcvr.yhbt.net>
References: <20090702085440.GC11119@dcvr.yhbt.net> <85647ef50907020252u41e36187jaacacad3d8a10f75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 22:28:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMpNL-0006LK-KX
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 22:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860AbZGCU2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jul 2009 16:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756725AbZGCU2j
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 16:28:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54770 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755878AbZGCU2i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 16:28:38 -0400
Received: from localhost (user-118bg3p.cable.mindspring.com [66.133.192.121])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 021921F84E;
	Fri,  3 Jul 2009 20:28:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <85647ef50907020252u41e36187jaacacad3d8a10f75@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122708>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> On Thu, Jul 2, 2009 at 12:54 PM, Eric Wong<normalperson@yhbt.net> wro=
te:
> > This doesn't work in the face of most HTTP-aware proxies[1], so it
> > probably doesn't help those who have trouble accessing git:// serve=
rs in
> > the first place... =A0However, this could potentially be useful in =
places
> > where a proxy providing CONNECT is not available.
> >
> The current lore is that to work with http proxies two separate
> streams are needed,
> one for input and one for outputs.
>=20
> This technique is described at
> http://xmpp.org/extensions/xep-0124.html#technique
> and other places.

Actually, the problem with my approach here is that any HTTP proxies ar=
e
free to rewrite chunked requests/responses to non-chunked ones (for
compression, ssl, or even performance reasons).  That and my approach
requires both the client and server to be simutaneously sending and
receiving responses in full-duplex channel which makes it impossible to
work without chunking.  IOW, there's no chance any HTTP proxy that
dechunks or queues/coalesces chunked requests/responses can work with
my approach.

The big upside is that only one HTTP request is needed for a full clone=
,
making this the most efficient way of using git over HTTP so far :)

--=20
Eric Wong
