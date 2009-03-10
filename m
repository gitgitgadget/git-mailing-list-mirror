From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFH Patch 2/2] http_init(): Fix config file parsing
Date: Mon, 9 Mar 2009 23:05:53 -0400
Message-ID: <76718490903092005n66bca743t67eb7f0ff830d9d7@mail.gmail.com>
References: <7vfxhmce67.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 04:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgsLy-0001Gh-LN
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 04:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbZCJDF4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 23:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbZCJDF4
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 23:05:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:13977 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbZCJDFz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 23:05:55 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1980665rvb.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 20:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wcSDHNmYPxRjasu90eTsuIpyMl8/kzNObCVJ2d46wAI=;
        b=QF5nOi5xbar+B4CqLV+5HClry9jyhQHhEiHKynKrlGVcRXus992cBVJTLGCh7GarSA
         0MCA4lHIBrD+amB6d+hzsnDm+0rxcRi4dlT++svYkiWF4H8o6aCEeR4Ddm9A5cxmTT30
         HKZ3AAsvE0Q5NqgRpUqSnMGm9MurO4axFgpA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Xo93+mCtwRA7gSfx6rvVqaNJCgvK0DyI1si7tvSzeJrutLs4ZvOAun7k71hDqoBnYe
         oqaJpj+hpUZw0B5hO7Bsx4wO1i0fstbs2To/aU2WqvqqWaGQe4EfmHsnhrqa2a95RuHh
         m3cfvCEn3qjVHj4UcyExpLVVPJV2UzuXMXr8A=
Received: by 10.141.115.20 with SMTP id s20mr3440343rvm.255.1236654353327; 
	Mon, 09 Mar 2009 20:05:53 -0700 (PDT)
In-Reply-To: <7vfxhmce67.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112776>

On Mon, Mar 9, 2009 at 10:19 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C2=A0* This is what I need help from people who actually do use http=
 transport
> =C2=A0 and extra set of eyeballs to spot silly mistakes.

It looks sane to me.

> @@ -241,14 +221,18 @@ void http_init(struct remote *remote)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (getenv("GIT_SSL_NO_VERIFY"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curl_ssl_verif=
y =3D 0;
>
> - =C2=A0 =C2=A0 =C2=A0 ssl_cert =3D getenv("GIT_SSL_CERT");
> + =C2=A0 =C2=A0 =C2=A0 if (getenv("GIT_SSL_CERT"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssl_cert =3D geten=
v("GIT_SSL_CERT");
> =C2=A0#if LIBCURL_VERSION_NUM >=3D 0x070902
> - =C2=A0 =C2=A0 =C2=A0 ssl_key =3D getenv("GIT_SSL_KEY");
> + =C2=A0 =C2=A0 =C2=A0 if (getenv("GIT_SSL_KEY"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssl_key =3D getenv=
("GIT_SSL_KEY");
> =C2=A0#endif
> =C2=A0#if LIBCURL_VERSION_NUM >=3D 0x070908
> - =C2=A0 =C2=A0 =C2=A0 ssl_capath =3D getenv("GIT_SSL_CAPATH");
> + =C2=A0 =C2=A0 =C2=A0 if (getenv("GIT_SSL_CAPATH"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssl_capath =3D get=
env("GIT_SSL_CAPATH");
> =C2=A0#endif
> - =C2=A0 =C2=A0 =C2=A0 ssl_cainfo =3D getenv("GIT_SSL_CAINFO");
> + =C2=A0 =C2=A0 =C2=A0 if (getenv("GIT_SSL_CAINFO"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssl_cainfo =3D get=
env("GIT_SSL_CAINFO");

Would these be a little cleaner with a temporary variable. e.g.

char *value;

if ((value =3D getenv("GIT_SSL_CERT")))
    ssl_cert =3D value;


j.
