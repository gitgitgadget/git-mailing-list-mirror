From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: validate entire ident string
Date: Mon, 26 Apr 2010 11:30:33 -0500
Message-ID: <20100426163032.GB10859@progeny.tock>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
 <20100424160608.GA14690@progeny.tock>
 <20100424190419.GA7502@spearce.org>
 <20100424203827.GA24948@progeny.tock>
 <20100424211042.GC24948@progeny.tock>
 <20100426160247.GD7502@spearce.org>
 <20100426162422.GA10859@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 26 18:30:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6RBq-0001xa-9M
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 18:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab0DZQ3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 12:29:40 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55257 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab0DZQ3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 12:29:39 -0400
Received: by pvg2 with SMTP id 2so406051pvg.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Py+aO/NDaTGeKM8XjS+usyx0NpXZdvYXFswyJa5PFHo=;
        b=HYsRbwmiJHUkMhjoAP9nIl1XP8qFOgGwEo7kiju7ILXv7hTIrl5EsfsDIsk5Hy0Kyx
         Av/ZZe3LhOPAcm220mFtXYAN1v3UZzPYn+RKhdjLRoajj3A8ufFWFBiBTvWuilXVaF2K
         GYEeJELuAKdHDIShCcGGAvR/MLdII+Ky2ImL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VPozAid1cAJ4nhVdMG8RxP7gmVtPZ1Fm0T1o8LlxbMZ++bpXZ0FF4JfjKMxVJKYveV
         YlpghizTzk+B0W7yocNAIQ1jOHv75QkTD+59EM2IAeVhHqp7DeuZcnGkTpLiGOdNRqP2
         3zUKOXHyCsg4mdkR0S/OUgscyDfjuFw2Z8zTY=
Received: by 10.142.2.28 with SMTP id 28mr2042449wfb.207.1272299378829;
        Mon, 26 Apr 2010 09:29:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm3232869iwn.13.2010.04.26.09.29.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 09:29:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426162422.GA10859@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145827>

Jonathan Nieder wrote:

> -		lb =3D strstr(a + 8, " <");
> -		rb =3D strstr(a + 8, "> ");
> -		eol =3D strchr(a + 8, '\n');
> +		n =3D a + strlen("\nauthor");
> +		lb =3D strstr(n, " <");
> +		rb =3D strstr(lb + 2, "> ");
> +		eol =3D strchr(rb + 2, '\n');
>  		if (!lb || !rb || !eol)
>  			die("invalid commit: %s", use_message);

Err, this will segv when it fails; better to use

	lb =3D a + strlen("\nauthor ");
	lb =3D strchrnul(lb, '<');
	rb =3D strchrnul(lb, '>');
	eol =3D strchrnul(rb, '\n');
	if (!*lb || !*rb || !*eol)
		die("invalid commit: %s", use_message);

This is even more permissive, but I think that=E2=80=99s okay.

Sorry for the noise.
Jonathan
