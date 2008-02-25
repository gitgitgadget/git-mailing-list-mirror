From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 08:52:42 +0100
Message-ID: <20080225075242.GD15761@auto.tuwien.ac.at>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at> <20080225030404.GL8410@spearce.org> <20080225072658.GB15761@auto.tuwien.ac.at> <7vwsotmqq2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 08:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTY9O-000848-6q
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 08:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbYBYHwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 02:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbYBYHwu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 02:52:50 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:34755 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbYBYHwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 02:52:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 21286680B59E;
	Mon, 25 Feb 2008 08:52:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q0Fky9Ukv8xr; Mon, 25 Feb 2008 08:52:43 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 0245A68018E5; Mon, 25 Feb 2008 08:52:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vwsotmqq2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75003>

On Sun, Feb 24, 2008 at 11:37:25PM -0800, Junio C Hamano wrote:
> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> So I do not have objection to OBJ_ANY (but again, this kind of
> thing needs to be explained in your commit log message), but
> giving the token the same value as OBJ_BAD may not be such a
> cool idea. =20

What about
#define OBJ_BAD -2

> After all, if the walker callback was told with
> OBJ_ANY that any type of object is Ok, it should still say
> "oops" if the given object said it actually is of type OBJ_BAD.
> E.g. in your [2/4] patch:
>=20
>         +static int mark_object(struct object *obj, int type, void *d=
ata)
>         +{
>         + ...
>         +	if (type !=3D OBJ_ANY && obj->type !=3D type) {
>         +		objerror(parent, "wrong object type in link");
>         +	}
>=20
> if you use the above #define, a tagged object that has a bad
> type will pass this check unnoticed, won't it?

No, it wouldn't, as object->type is never initialized to OBJ_BAD:
$ grep "OBJ_BAD" *.c *.h
cache.h:        OBJ_BAD =3D -1,

mfg Martin K=F6gler
