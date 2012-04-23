From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/10] Add three convenient format printing functions
 with \n automatically appended
Date: Mon, 23 Apr 2012 11:15:36 -0500
Message-ID: <20120423161536.GE4832@burratino>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <1335184230-8870-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:15:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMLvZ-0007j4-Ee
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab2DWQPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 12:15:45 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55283 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab2DWQPo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 12:15:44 -0400
Received: by yenl12 with SMTP id l12so6232980yen.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Oqk2GkY8weNTFgcBKar+4iw74IdyiUeBQJEg88BIkTI=;
        b=s/C1mD+F02RYUWOoQgEmNJEE/uNuyLTk/H91vQyiZDZ+7rlRdyu6oSq+4YHLGz6O/A
         f2Ea1bpIC+b3N+t8sHGppS9De8P9wmeFUlXJi1Z1nPK1F6OvwpP9suwAuxGCGi5YivAH
         XK6fYFC4xKPmcmg7aNh+8t/c+cX4BZvrfibadzoyrTEh9HqcMQNjI4I70lqd/8tJxwJd
         6lHp+CECE+NFJnLtkKjpM4zoIDgX/AgExFb3/8gYClws6XgBY+9NAWBtX/zt9ODxGYL7
         WXVTGXmpxxE2jV8vlCeR3ciY8yGGOTtqr32I9SAqr0FMT70+CqHI0oLMNh+YMMiHreTY
         HaWg==
Received: by 10.60.1.7 with SMTP id 7mr23324005oei.71.1335197743555;
        Mon, 23 Apr 2012 09:15:43 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i6sm16557565obv.5.2012.04.23.09.15.40
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 09:15:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1335184230-8870-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196137>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -464,3 +464,36 @@ void strbuf_addstr_urlencode(struct strbuf *sb, =
const char *s,
[...]
> +int printf_ln(const char *fmt, ...)
> +{
> +	int ret;
> +	va_list ap;
> +	va_start(ap, fmt);
> +	ret =3D vprintf(fmt, ap);
> +	va_end(ap);
> +	if (ret >=3D 0)
> +		ret +=3D printf("\n");

Missed a spot.  I'd do

	if (ret < 0 || putchar('\n') =3D=3D EOF)
		return -1;
	return ret + 1;

And likewise, for the fprintf version:

	if (ret < 0 || putc('\n', fp) =3D=3D EOF)
		return -1;
	return ret + 1;

Hope that helps,
Jonathan
