From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Tue, 12 Feb 2008 20:04:11 +0100
Message-ID: <20080212190411.GA23837@auto.tuwien.ac.at>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 20:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP0R2-0000Ny-UM
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 20:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762047AbYBLTEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 14:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761791AbYBLTEP
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 14:04:15 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:50066 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761022AbYBLTEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 14:04:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D8951680BF77;
	Tue, 12 Feb 2008 20:04:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M9kxaGfj2POC; Tue, 12 Feb 2008 20:04:11 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id B07C9680BF6C; Tue, 12 Feb 2008 20:04:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802120937330.2732@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73683>

On Tue, Feb 12, 2008 at 11:02:06AM -0500, Nicolas Pitre wrote:
> I think this is a good idea to always have some sanity checks on any=20
> incoming objects so to make sure they're well formed and valid before=
=20
> giving them a SHA1 value, and bail out as soon as any error is found.=
 =20
> From my understanding that's what your patch is doing, right? (sorry =
I=20
> can't find them in my mailbox anymore).=20

Yes. (=3D>http://marc.info/?l=3Dgit&m=3D120266631524947&w=3D2)

>  This can be done as objects are=20
> coming in just fine and requires no extra memory, and I would say thi=
s=20
> should be done unconditionally all the time.  After all, the Git=20
> coherency model is based on the SHA1 checksuming, and therefore it is=
 a=20
> good idea to never validate any malformed objects with a SHA1.  So I'=
m=20
> all in favor of such validation always performed in index-pack and=20
> unpack-objects.

We will need some additional memory for struct blob/tree/tag/commit
even for this check.

I'll start reworking my patches.

> As to making sure those objects are well connected... well this is a=20
> technically different issue entirely, and I wonder if a special mode =
to=20
> fsck might not be a better solution.  For example, fsck could be made=
 to=20
> validate object connectivity, starting from the new ref(s), and stopp=
ing=20
> object walking as soon as a reference to an object not included in th=
e=20
> newly received pack is encountered.  This could be run from some hook=
 to=20
> decide whether or not to update the new refs, and to delete the pack=20
> otherwise.

Do you really think, that this will need less memory? fsck loads first
all objects and then verifies their connections.

mfg Martin K=F6gler
