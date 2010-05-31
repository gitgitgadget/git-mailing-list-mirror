From: Albert Dvornik <dvornik+git@gmail.com>
Subject: Re: [PATCH v2] compat: Add another rudimentary poll() emulation
Date: Mon, 31 May 2010 08:12:01 -0400
Message-ID: <AANLkTinNHDZD-9uQjWr8N97tgP1SP9angXlXMUUc673x@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
	<20100530003718.GA27024@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, Jonathan Callen <abcd@gentoo.org>,
	git@vger.kernel.org, mduft@gentoo.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>,
	Marko Kreen <markokr@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 14:12:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ3ql-00062I-Ve
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 14:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748Ab0EaMMG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 08:12:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35963 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0EaMMF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 08:12:05 -0400
Received: by vws9 with SMTP id 9so652980vws.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=c0fp2Nsxn4FKQnCZde/5y+cIm5pLlaslRRdgJFiFwG0=;
        b=QSpg6CkYwQU5IVCvEQ9fW/E8w65ia3xC8O01loS9Ho/bnnqB8lMMLPp4LOGpY+Ybg6
         mxJ7TOHZsE9sI293QdwTjHBmTT6ghwKPIWZ21l2YYwuWMHxzbzsF72EMd+ikoV58lRPp
         zxdeKtxffXtziPCImUTcEcaUjHLaGcO8r3GRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=c8QrMnucrfZTGBaBzhXncq0aZY4Y8JTIPFlrHCH+/+qWkmXxr7Sq4ZoDMkQlbUis9H
         KWHh/hXpQbXqkWsnqnJQ1a5+rmX+edfVdK2hvTdp1MfdcIUN/A+VSlsWrhFN6JJuXBR9
         3yysyh2IEaUf05FgN6Pe03/dLzka4+4mhWt20=
Received: by 10.224.87.194 with SMTP id x2mr1565311qal.188.1275307921544; Mon, 
	31 May 2010 05:12:01 -0700 (PDT)
Received: by 10.229.74.193 with HTTP; Mon, 31 May 2010 05:12:01 -0700 (PDT)
In-Reply-To: <20100530003718.GA27024@progeny.tock>
X-Google-Sender-Auth: A4H43ijJ9gI__K5ZUC_HssWd8Pg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148039>

On Sat, May 29, 2010 at 8:37 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
[,,,]
> +static int msleep(int timeout)
> +{
> + =A0 =A0 =A0 struct timeval tv;
> + =A0 =A0 =A0 tv.tv_sec =3D 0;
> + =A0 =A0 =A0 tv.tv_usec =3D 1000 * timeout;
> + =A0 =A0 =A0 return select(0, NULL, NULL, NULL, &tv);
> +}

This code will do the right thing only when timeout is < 1000.  (This
is probably true for us in practice, so this is likely just
nitpicking.)  For the general case, you'd want
       tv.tv_sec =3D timeout / 1000;
       tv.tv_usec =3D 1000 * (timeout % 1000);

--bert
