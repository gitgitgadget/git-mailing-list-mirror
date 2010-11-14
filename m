From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 003/160] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Sun, 14 Nov 2010 15:47:32 -0600
Message-ID: <20101114214731.GA16413@burratino>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com>
 <1289747245-23263-3-git-send-email-avarab@gmail.com>
 <20101114181605.GI26459@burratino>
 <7vmxpb1ztf.fsf@alter.siamese.dyndns.org>
 <AANLkTinh_Nkxvw7Z5HU=TbJHHFRZeWgr0COJ+N96OeTd@mail.gmail.com>
 <20101114212757.GD10150@burratino>
 <AANLkTim-j6TLwz0PugZvaEf1x3hW=76vT1gALC=w3DOu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 22:48:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkQw-0002D8-FB
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757077Ab0KNVsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 16:48:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43852 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757019Ab0KNVsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:48:08 -0500
Received: by yxn35 with SMTP id 35so839133yxn.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1kUxC3C85Z77Skw54pbNBwtlLmq0zXjsO764Jmdna7I=;
        b=XKyxUxES7sWAh76REHP8zUD64xVqUEeZc7DFG5uDrJKtHzaBkr6WJLkYN0nYuCuB57
         M+NaXc9imR++B6nyjy1ZDZ28KAjenea8OFUaKszA8WO4IBkJWXEIyerFsmey/rpcmjVf
         5xhDXOPDcqF6xhqBQF1iGjom8tmO/HuU16a0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tr8HjV2RZcFBeUsMqacYWYcObjgdhpF4AikTafAps8wGTKasKQ4W25B62qD8/9tT9b
         O/ULDOZHmvy0s0gIbkEwowZ4BR8Za16nMUgdlZzTuv3Fs/gNV6nM50aav4/yIU2u6IE7
         L2d96nKdTRaY169JqObFRGStOpFBFhtM75K08=
Received: by 10.150.192.2 with SMTP id p2mr4915944ybf.73.1289771286720;
        Sun, 14 Nov 2010 13:48:06 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q31sm1821414yba.18.2010.11.14.13.48.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:48:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim-j6TLwz0PugZvaEf1x3hW=76vT1gALC=w3DOu@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161450>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This is how it currently gets compiled:
>=20
>     $ rm git-sh-i18n--envsubst sh-i18n--envsubst.o; make -j 5 all V=3D=
1
>     gcc -o sh-i18n--envsubst.o -c   -g -O2 -Wall -I.  -DHAVE_PATHS_H
> -DSHA1_HEADER=3D'<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS
> sh-i18n--envsubst.c
>     gcc  -g -O2 -Wall -I.  -DHAVE_PATHS_H
> -DSHA1_HEADER=3D'<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS -o
> git-sh-i18n--envsubst   sh-i18n--envsubst.o libgit.a xdiff/lib.a  -lz
> -lcrypto -lpthread
>=20
> I tried to remove some of those library includes. But it'll
> complain. However if I do:
>=20
>     diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
>     index 8db71b1..7d4c870 100644
>     --- a/sh-i18n--envsubst.c
>     +++ b/sh-i18n--envsubst.c
>     @@ -215 +215 @@ string_list_append (string_list_ty *slp, const ch=
ar *s)
>     -      slp->item =3D (const char **) xrealloc (slp->item, nbytes)=
;
>     +      slp->item =3D (const char **) realloc (slp->item, nbytes);
[...]
> It'll compile stand-alone with no library includes at all.

Yes, that is what $gmane/160842 is about (also see $gmane/137738 for
background).  In this case, a simple local stub xmalloc/xrealloc etc
to take care of checking for NULL seems fine, indeed.
