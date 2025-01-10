Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60306209F48
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514048; cv=none; b=Jfowr1oWnKUi/MGvlkad7kqK6iIgtiMd8Zu0ezqR6vCX0nSrwII83xYiWPQPe3Kpb+zHisRzS6O14S8JPFh2qeDvsoeDkKvPMudgdUA0IY4WCEajU+K3HvMX3IVF4LRnwpM/p60w58bxGuYuzq8MnkEbElI59TkIZg3Dh5UIYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514048; c=relaxed/simple;
	bh=o6V5OUuwY/z8h9MsJ40g2tKwRR59FpwBkt426YXyKk4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RM+dMZ1ALr01K9+yBBUxattP0KS3an02tZOSRla5NoBbInV65UWSZxtTDyBHBFkZOREOAWAsgQW+F394/+2Wc/dzp7HzU58EaZDhhxTVsU9TsmYW2ouJlGyggRddKl0HAvqPvCei+DUeS4yppOGOpXR1sMiS4D03Zui+AiJOV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=SNCqB8kZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="SNCqB8kZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736514042; x=1737118842;
	i=johannes.schindelin@gmx.de;
	bh=w65TQ2WScUwZjdCK6ijDKkEEbOK30DD1y5+FgpL+h4c=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SNCqB8kZTfu1QK3ExDP9rX0r9QDzw04vj4w94Gq0g/y/ZsUNVYVDhNpZ/j+KzB0w
	 4aPARvA/J9KgL0Lx8UTlIwhkRbXAc5tnpt3Kaz5R1taVt9dW7qnH/PfuIMb+xVj+N
	 S4D4DO3bQB9KoLKr2T5zxHHAWiumz+hWKYCayutbnBmnne9/AyODibGMgF+rJ6spq
	 3whZQSokGo2eH28aOerxUlqRDgM7GubVWdzRXTumKkrrlLZShxEAqOqhNW+709tdq
	 s2S6zlZcIlPHWYROlVyQEHRWon/w68M+ByVBjUIOHZ9RiRNsTNr2V0G3G6WKIyDUJ
	 BzDcClXNXspR5qwHqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.189]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1tY9Mu3nUP-00GNBG; Fri, 10
 Jan 2025 14:00:41 +0100
Date: Fri, 10 Jan 2025 14:00:41 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, 
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] builtin/blame: fix out-of-bounds write with blank
 boundary commits
In-Reply-To: <20250110-b4-pks-blame-truncate-hash-length-v3-2-e61f25b68f30@pks.im>
Message-ID: <992502eb-5131-228e-1915-a35038211f4b@gmx.de>
References: <20250110-b4-pks-blame-truncate-hash-length-v3-0-e61f25b68f30@pks.im> <20250110-b4-pks-blame-truncate-hash-length-v3-2-e61f25b68f30@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DhpWlLgoVnPXd3cq/haWrHpc4sljabivsHern7o1Br1iJMgx7fA
 flRbUIgfm0nvT2BouCIOOw6Z98GurdeM6Mfw3MjRddI0zbOHw7r5UkuimMxahnZdUH40bWf
 /ZDf6sO7AX7oyDUVvHbmKpdhl+rS0Obi0ThrZf9cnorJC0zgOTwfRH/YPxP7JVo3R4u6+RG
 yWC4OCHaCQmeuqdXRzJTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qT/iIJquGxk=;1hL6Vxz3XweaeK14w/dZrY69gx2
 SQXra8s+sE1MOYoPhoJcvVuW5ma+KosHRJ1yPwVpdfNu2amTSwedh3ltYf12P1ib1sGv5BJAg
 ITcxAllIdPcwyFE64Xwe3dgQHr7Xoz3t9/1O964HfyoLmCnvhZmQK9adLaU+Bc6/WqsRnV284
 wXTuiCTBMKW4EfvMIhjCUmgYQloYoCLpYzsehGofZPFCjd2Nrtv1OIYVmlDn3MsqoRr4V/nsO
 eJ1h4lRnxbP3RTWbJob9GZL3BpPtuWbqZknbZzZCrysmhI3gJTCHtci5PjDvh8oqKeeL7TRp/
 Ey3I2gVzsjcr4SXHjNcxOWXaaUJERzTuCnl7OU3ezdeudBUzx0qVoQlPAhicz16xkdk7o7rZn
 riUwk/Sjq57Wh3TYDWIkCgTiNgy4SzWiMt8wheGMbAABDfgXf/Ju5FNHperXXTfCkNdo82VUm
 AQTXT1DzgLqaLEgmLQe2Yeybo+xfsLfaImK9o+5Ew2w3nzzn9mYjYHhnKt29EYOIWTIiV0SyJ
 hDVRTLMjbkBRfscSw49WdiHbVYndHaRbSjgXyx6VxwdjvPDVo0/Fxyz4QTw6wW6rupx4JPSJf
 plcfkWbEvVKk3ZaICWyVTUqh4s5y3TpVk2UblZMBfHxJnqhfJBc1biyiVy0TE89eOwwJvA4Hi
 d8TtB3HSXD+XJsl6aXayt9JkikNGkaBMgMYakF8VI3CBO5q3aC/f3U8HSYH2UofcuxO589OKy
 V3pA52kqaV2ov6F0rWniyrvYscMreXkXLlcBv0SgXqBOnl3MtSp3SZpyefclHgnoGI406aIhD
 clWTiw6lL5SArVGTkjNWTyUh3lb9Ut5Dg1GOBVuE2cXO/UQnS6eSWtWEu4nMM3LIV1V/yH10M
 g11zYd6TWXR0p+j+jqmxLfYOrWnLeWQEytEJZHrMP3EK7y570iwpVLRoGdtZ2FV6mFtzUQVvj
 KtBJb1/QxX7iuwnVGDRraEqdcTW/epR9hIVwYns1wMpY25gxC9T77A2457aIcDut2UVTuFlZT
 Ru29bOCRZaBqCs7BnEDk2QQmHMyDKFi/ZHSqi9fUz92dJu42lYIK8BfMWfOmkeGTcer1oeg1f
 WFxjQ9cXvdg/Iu5DYdN2SRgG0PhacW
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 10 Jan 2025, Patrick Steinhardt wrote:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index d7630ac89cb7bd6e9ce5d72c6a98aa433b3b12da..7555c445abe7ca2fa54670ac=
8fee1d95a6dbafe3 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -489,9 +489,9 @@ static void emit_other(struct blame_scoreboard *sb, =
struct blame_entry *ent, int
>  			fputs(color, stdout);
>
>  		if (suspect->commit->object.flags & UNINTERESTING) {
> -			if (blank_boundary)
> -				memset(hex, ' ', length);
> -			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
> +			if (blank_boundary) {
> +				memset(hex, ' ', strlen(hex));

Using `strlen()` is a neat trick.

I could have done without slipping in a style change (introducing
curlies), but the most important thing is that it fixes the bug.

Thank you,
Johannes

> +			} else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
>  				length--;
>  				putchar('^');
>  			}
