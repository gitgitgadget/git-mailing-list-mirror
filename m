From: Sam Vilain <sam@vilain.net>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported
 commit
Date: Sun, 04 Jul 2010 15:44:04 +1200
Message-ID: <1278215044.13014.33.camel@denix>
References: <20100701031819.GA12524@burratino>
	 <20100701054849.GA14972@burratino> <20100702051201.GC7209@burratino>
	 <AANLkTintWyhcx9pURSqxs3e9BBkPx9KSPPYh4UOU7kv6@mail.gmail.com>
	 <20100702154028.GB2287@burratino> <1278201760.9701.39.camel@denix>
	 <20100704003543.GA25858@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 05:43:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVG7Z-0005g8-Fe
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 05:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752Ab0GDDnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 23:43:45 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47391 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756737Ab0GDDno (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 23:43:44 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id D125E21C3E6; Sun,  4 Jul 2010 15:43:42 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 8902921C35E;
	Sun,  4 Jul 2010 15:43:38 +1200 (NZST)
In-Reply-To: <20100704003543.GA25858@burratino>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150216>

On Sat, 2010-07-03 at 19:35 -0500, Jonathan Nieder wrote:
> Sam Vilain wrote:
>=20
> > It should be very simple to implement --batch-verify as well, which=
 is
> > essentially the same thing, just only printing the header and not t=
he
> > contents.
> >=20
> > How hard do you think it would be to implement a 'rev-parse' comman=
d?
> > Perhaps you can see where this is going... :-)
>=20
> Well, I think I understand what you are saying, but it=E2=80=99s not =
quite
> like that.  fast-import is already doing a lot of work to keep track
> of this collection of objects in a pack that is not yet accessible to
> git because its index has not been written yet.
  [...]
> Or one can teach fast-import to supply exactly what we need from it,
> which is the raw content of some blobs (and perhaps trees) it has
> written to pack and not indexed yet.

Let me explain further.  If in fast-import.c:new_object, if it were to
make a struct object (see object.h), and make sure it was put in
obj_hash (see object.c, particularly create_object()), then you might
find a whole load of plumbing would magically start working and be able
to work with the new objects that you are trying to load.  Of course
there may be a couple of other functions which might need to change.
Primarily object.c:read_object, which needs to be able to check the
packfile being spooled by git fast-import.

If you did this, then to implement this feature you could in principle
just call read_sha1_file()

Sam
