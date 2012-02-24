From: Ian Kumlien <pomac@vapor.com>
Subject: Re: [PATCH 2/2] index-pack: reduce memory usage when the pack has
 large blobs
Date: Fri, 24 Feb 2012 16:37:53 +0100
Message-ID: <20120224153753.GG9526@pomac.netswarm.net>
References: <1330086201-13916-1-git-send-email-pclouds@gmail.com>
 <1330086201-13916-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 16:38:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0xDk-0002jj-SD
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 16:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527Ab2BXPiA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 10:38:00 -0500
Received: from mail.vapor.com ([83.220.149.2]:39028 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755926Ab2BXPh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 10:37:59 -0500
Received: from twilight.demius.net (c-387a71d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.122.56])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id 78A4240C674;
	Fri, 24 Feb 2012 16:37:53 +0100 (CET)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 574AB8E06C1; Fri, 24 Feb 2012 16:37:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1330086201-13916-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191439>

On Fri, Feb 24, 2012 at 07:23:21PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> This command unpacks every non-delta objects in order to:
>=20
> 1. calculate sha-1
> 2. do byte-to-byte sha-1 collision test if we happen to have objects
>    with the same sha-1
> 3. validate object content in strict mode
>=20
> All this requires the entire object to stay in memory, a bad news for
> giant blobs. This patch lowers memory consumption by not saving the
> object in memory whenever possible, calculating SHA-1 while unpacking
> the object.
>=20
> This patch assumes that the collision test is rarely needed. The
> collision test will be done later in second pass if necessary, which
> puts the entire object back to memory again (We could even do the
> collision test without putting the entire object back in memory, by
> comparing as we unpack it).
>=20
> In strict mode, it always keeps non-blob objects in memory for
> validation (blobs do not need data validation). "--strict --verify"
> also keeps blobs in memory.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

=46inally, reapplied the patches and so on:
remote: Counting objects: 1425, done.
remote: Compressing objects: 100% (617/617), done.
remote: Total 1425 (delta 790), reused 1425 (delta 790)
Receiving objects: 100% (1425/1425), 56.06 MiB | 3.97 MiB/s, done.
Resolving deltas: 100% (790/790), done.

real	1m57.742s
user	0m29.950s
sys	0m6.308s

*YAY*

I wonder how the hell i could have missed several parts of the patch =3D=
(

But there seems to be some issue in gerrit 2.1.8, will have to check
against a newer gerrit to verify if it's still a problem.

=46YI - it seems to hang doing nothing.

As for your patches:
Tested-by: Ian Kumlien <pomac@vapor.com>

;)
