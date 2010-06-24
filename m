From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] msvc: Select the "fast" definition of the
 {get,put}_be32() macros
Date: Thu, 24 Jun 2010 06:21:48 -0500
Message-ID: <20100624112148.GA12485@burratino>
References: <4C2264B6.5010906@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 24 13:22:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORkVT-000627-9M
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 13:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab0FXLWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 07:22:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56016 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab0FXLV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 07:21:59 -0400
Received: by iwn41 with SMTP id 41so751506iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XV+VxWVwDwhX5ApuZwR12uWxlLQ/enefqeec1mhBi2U=;
        b=Jswua0/lnVMi5gv/B7m2pxvFi2qCkWmnFZCxcW2ZEUHMt1OaJOVF8UQslXkRhrm2lb
         OeOVf6gcwTuNshMGgGf/EJhIQ9xqcdbvXxfmXMo76RnPc1LxK+wSdE99/QOLlQsQICSh
         uAd+vbv+hwM/zv41IPU/5vTvb61wpBc7TPcCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Gy4TJJFofMOs4wW7V2xlHuntWXRmZMcB7b6exMCATigVd/hKcUgKoHH94mizmSPbUx
         yvT0hRSkLwB5HO0lKsJ7QM4AwzBUEIgbx2f0NQZmSfUMJ2PgGAjYIJ0QkN5fC9fWXgkW
         6YkZi74frBvOwkr5oMf3KXScSetuZeIvnjhIE=
Received: by 10.231.145.79 with SMTP id c15mr10674914ibv.102.1277378519417;
        Thu, 24 Jun 2010 04:21:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm17923450ibf.13.2010.06.24.04.21.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 04:21:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C2264B6.5010906@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149582>

Ramsay Jones wrote:

> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index d893475..e102856 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -70,6 +70,7 @@
>   */
> =20
>  #if defined(__i386__) || defined(__x86_64__) || \
> +    defined(_M_IX86) || defined(_M_X64) || \
>      defined(__ppc__) || defined(__ppc64__) || \
>      defined(__powerpc__) || defined(__powerpc64__) || \
>      defined(__s390__) || defined(__s390x__)

Looks good to me, for what it=E2=80=99s worth.  You might want a simila=
r
change on line 57:

=20
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__i386__) || defined(__x86_64__) || \
+	defined(_M_IX86) || defined(_M_X64)
   #define setW(x, val) (*(volatile unsigned int *)&W(x) =3D (val))

Or alternatively, it might make sense to add something like the
following to compat/mingw.h or git-compat-util.h to fix this once.

 #if defined(_M_IX86) && !defined(__i386__)
 # define __i386__
 #endif
 #if defined(_M_X64) && !defined (__x86_64__)
 # define __x86_64__
 #endif

Thanks,
Jonathan
