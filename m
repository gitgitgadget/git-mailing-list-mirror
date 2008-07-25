From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 14:01:02 +0200
Message-ID: <20080725120102.GB32487@atjola.homenet>
References: <alpine.DEB.1.00.0807241821440.8986@racer> <7vy73q4jzp.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807251219530.11976@eeepc-johanness> <alpine.LFD.1.10.0807250751220.9968@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 14:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMLzx-000796-63
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 14:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYGYMBJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 08:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYGYMBI
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 08:01:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:44635 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750753AbYGYMBG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 08:01:06 -0400
Received: (qmail invoked by alias); 25 Jul 2008 12:01:04 -0000
Received: from i577BBE25.versanet.de (EHLO atjola.local) [87.123.190.37]
  by mail.gmx.net (mp030) with SMTP; 25 Jul 2008 14:01:04 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19HpOxkX0JHGAy0HdguH0qyTYWtwpbCYOb3WanKfJ
	Y4zhuM6bSMw0IB
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807250751220.9968@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90041>

On 2008.07.25 07:54:49 -0400, Nicolas Pitre wrote:
> On Fri, 25 Jul 2008, Johannes Schindelin wrote:
>=20
> > Hi,
> >=20
> > On Thu, 24 Jul 2008, Junio C Hamano wrote:
> >=20
> > > The function does not seem to use type (which the patch is also s=
etting)=20
> > > nor real_type (which the patch does not set).
> > >=20
> > > However, the code checks objects[nth].real_type all over the plac=
e in=20
> > > the code.  Doesn't the lack of real_type assignment in=20
> > > append_obj_to_pack() affect them in any way?
> >=20
> > >From staring at the code, I thought that real_type was set in=20
> > resolve_delta(), but I may be wrong.
> >=20
> > The safer thing would be to set it, but I am not quite sure if we c=
an use=20
> > "type" directly, or if type can be "delta" for an object that is us=
ed to=20
> > complete the pack, and therefore stored as a non-delta.
>=20
> Objects to complete the pack are always non delta, so the type and=20
> real_type should be the same.  However that shouldn't matter since at=
=20
> that point the object array is not walked anymore, at least not for=20
> appended objects, and therefore initializing the type at that point i=
s=20
> redundant.

Is that still true when the object has been pruned due to memory
constraints set by deltaBaseCacheLimit? AFAICT when reloading the data
for the object, we end up in get_base_data, which at least checks
obj->type.

Bj=F6rn
