From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with
 gettext
Date: Sat, 5 Jun 2010 13:59:26 -0500
Message-ID: <20100605185926.GA5273@progeny.tock>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
 <1275704035-6552-2-git-send-email-avarab@gmail.com>
 <20100605030059.GB2019@progeny.tock>
 <AANLkTilSJ_1STKGvat0llqYVZRI8_tQriE-hIBJPEldn@mail.gmail.com>
 <20100605033849.GB2252@progeny.tock>
 <AANLkTim3PcoLrYb46Bh3tK7Ir3v-K0EQ0czPaD5DIIOK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 20:59:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKyap-0001Ej-UZ
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 20:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab0FES73 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 14:59:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60660 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab0FES72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 14:59:28 -0400
Received: by iwn37 with SMTP id 37so2126230iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cs/P9TxGAv765jCeEM3bqbLQMwA41mptvb9WT51wIns=;
        b=qNqIyeJjy5xpvkjBz5NtiMDldtTpvIEbSzTlEv8UGb7HmKWlA9JnNpgQvXSLqVY4Bj
         8KyBrIwrQj/x+JFqG4StngCWKsNXGShAHalg/azmNXdBgjXgPnf9BueWvIvDLMs3+MUw
         5dv2ISt68cHReEx1IJLlxGoaAfxLj45OfVum8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hufmD8woexwfd5pRIpw+30qaEy64wmOcNV4MJDsavgLqdPEas5CQnjcIvcKYEBwPiS
         R8IUyEa3zt1SpNXkxGwdYNGCuugvNFAFSb3jmdGUCR0Sn8PJO0WXo+bVl9o6f9g1AuUW
         9bu0O8zAWsp+nCqrSRsmGnY/CljZ28DjA4AA4=
Received: by 10.231.169.14 with SMTP id w14mr9258518iby.45.1275764367411;
        Sat, 05 Jun 2010 11:59:27 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm11642829ibf.19.2010.06.05.11.59.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 11:59:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim3PcoLrYb46Bh3tK7Ir3v-K0EQ0czPaD5DIIOK@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148485>

Hi =C3=86var,

Thanks for trying it out.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/gettext.c
> +++ b/gettext.c
> @@ -1,11 +1,8 @@
> -#ifdef NO_GETTEXT
> -void git_setup_gettext(void) {}
> -#else
>  #include "exec_cmd.h"
>  #include <libintl.h>
>  #include <stdlib.h>
>=20
> -void git_setup_gettext(void) {
> +inline void git_setup_gettext(void) {

This should not be inline when NO_GETTEXT is unset, since other
translation units don=E2=80=99t get a chance to see the definition.

> diff --git a/gettext.h b/gettext.h
> index a99da6a..8d44808 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -1,7 +1,11 @@
>  #ifndef GETTEXT_H
>  #define GETTEXT_H
>=20
> -void git_setup_gettext(void);
> +#ifdef NO_GETTEXT
> +static inline void git_setup_gettext(void) {}
> +#else
> +inline void git_setup_gettext(void);
> +#endif

With s/^inline \(.*;\)/extern &/, to make it:

 -void git_setup_gettext(void);
 +#ifdef NO_GETTEXT
 +static inline void git_setup_gettext(void) {}
 +#else
 +extern void git_setup_gettext(void);
 +#endif

this part is exactly how I was imagining it (i.e., like might_fault()
in linux-2.6/include/linux/kernel.h and many other examples).

Thanks again.
Jonathan
