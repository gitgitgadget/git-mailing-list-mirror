From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] git-archive: convert archive entries like checkouts do
Date: Fri, 18 May 2007 18:27:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705181826220.18541@iabervon.org>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>
 <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de>
 <200705171928.34927.johan@herland.net> <464E2425.2030904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-2038418110-1179527269=:18541"
Cc: Junio C Hamano <junkio@cox.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat May 19 00:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpAvi-0004MI-Bc
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323AbXERW1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755435AbXERW1v
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:27:51 -0400
Received: from iabervon.org ([66.92.72.58]:1433 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323AbXERW1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:27:51 -0400
Received: (qmail 1874 invoked by uid 1000); 18 May 2007 22:27:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 May 2007 22:27:49 -0000
In-Reply-To: <464E2425.2030904@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47669>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-2038418110-1179527269=:18541
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 19 May 2007, Ren=E9 Scharfe wrote:

> diff --git a/archive-tar.c b/archive-tar.c
> index 56ff356..eb0abc7 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -83,11 +83,12 @@ static void strbuf_append_string(struct strbuf *sb, c=
onst char *s)
>  =09int slen =3D strlen(s);
>  =09int total =3D sb->len + slen;
>  =09if (total > sb->alloc) {
> -=09=09sb->buf =3D xrealloc(sb->buf, total);
> -=09=09sb->alloc =3D total;
> +=09=09sb->buf =3D xrealloc(sb->buf, total + 1);
> +=09=09sb->alloc =3D total + 1;

Conditional needs a "+ 1", too.

>  =09}
>  =09memcpy(sb->buf + sb->len, s, slen);
>  =09sb->len =3D total;
> +=09sb->buf[total] =3D '\0';
>  }
> =20
>  /*
> @@ -272,18 +273,19 @@ static int write_tar_entry(const unsigned char *sha=
1,
>  =09}
>  =09if (path.alloc < baselen + filenamelen) {
>  =09=09free(path.buf);
> -=09=09path.buf =3D xmalloc(baselen + filenamelen);
> -=09=09path.alloc =3D baselen + filenamelen;
> +=09=09path.buf =3D xmalloc(baselen + filenamelen + 1);
> +=09=09path.alloc =3D baselen + filenamelen + 1;

Same here.

=09-Daniel
*This .sig left intentionally blank*
--1547844168-2038418110-1179527269=:18541--
