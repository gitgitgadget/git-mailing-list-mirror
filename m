From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit.c: use strchrnul() to scan for one line
Date: Mon, 16 May 2016 08:12:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605160810020.3303@virtualbox>
References: <xmqq37pj55bg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 08:20:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2BtB-0001CL-Az
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 08:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbcEPGMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 02:12:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:51431 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbcEPGMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 02:12:36 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MMCSP-1awR8g46k1-007zFC; Mon, 16 May 2016 08:12:28
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq37pj55bg.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:l4ArqGl6FsmuXFf+6jIpLQGWrYfkiugrVHdyQkZ8Vy/9/iaS7Zc
 vPHQ4Egdsj1TxRCoslhNt4Va2+4CERg5G0gSBOD2HHZ1g22DU3tenn8lobOztgRtEjqTscP
 YUOrq3z780nZnWzoM5Jmv9gfMaWCgdUUvCFWWtFN2P7jQDsvR1TNgB5I8Zvqgw/LRYeFFAU
 UaNJGHcAqNLpttdw+F0bQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ETa/G+8ddQQ=:4BLZfhQSZidBnrG2epPvax
 U+8uIixM4FNLt8RjC2OYc59Aov2dY/dPrPP5BMJg14G9j+x3W7YHYDUgVdnmIWyARHYAHT8U3
 Svena0kEBpKWxcaWa+MOIbMnrv8dp5lB1mhOzYM3f27NDBfoQTb/9r5TDekQDJUzqltSAQbpe
 DTmKSB9E8X7J4GBoegaxzmyB4LrtErGgnUkEMy4ARFkym9Hz1BZ7b5OsALqn366+tEIVCVnJP
 Z3EuvN9W650kPemKNk+cwVTljGnmW8fpghQJUXlIRfUufKNC0NKQGtY/HcdXBUmtIdSbGicuc
 6sXNNE+/t2xAIEVjijXwVuwIX8Sxn+xFefpZEatul+MiTO9ew6lFvLxGVlNxZcZTzyN3l6eMW
 l6HEHJP3TgYIK/V5jjpQOw2nIeX3Z6P4pGHjEDVrYxtlRYru8MCrq2SROsjvYF3flYEH9qhkS
 kA/dNjWkpNCPBoHcuDlHThi9I66mA0AS9NiXEKOyc5Gm87Ng9rXY08JeaguwqqrmdklTWzq7J
 YFA19JaUB/0A6/0QI0Hxzmn6HXDXUaJkSmy8zw6mIG85pWtOnfwq34f/vFCjSFelk8xneAkAm
 VGbNFgaM46cD7YvkQtrC5VfDzR2W205cD+StyxCguxfws03aRFHZNDdDCSEgn9HSBoykROBu+
 sR/JdOjV9m96LyNk0LPgCX9N5tOcB/Z2eRIXrkAiLyVPrA5utRQg/JLgfLpSK/IypMJeMVCvR
 ONClDr8/d0uvXn2eWMO1rClq5t1bEi6KPAQwqjkxr8+0aAPltfR1I/KXGbrkpffzT1Rw5DcM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294723>

Hi Junio,

On Sun, 15 May 2016, Junio C Hamano wrote:

> diff --git a/commit.c b/commit.c
> index 3f4f371..1f9ee8a 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
>  		p++;
>  	if (*p) {
>  		p += 2;
> -		for (eol = p; *eol && *eol != '\n'; eol++)
> -			; /* do nothing */
> +		eol = strchrnul(p, '\n');
>  	} else
>  		eol = p;

ACK. This was my fault, when I introduced the code in 9509af68 (Make
git-revert & git-cherry-pick a builtin, 2007-03-01). To be fair,
strchrnul() was introduced only later, in 659c69c (Add strchrnul(),
2007-11-09).

Ciao,
Dscho
