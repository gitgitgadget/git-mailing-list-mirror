From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sat, 8 Jun 2013 11:53:18 -0500
Message-ID: <CAMP44s3UYCX+DzgnErB=0GdD3w5k2GkNKjv46ZA_NVHm1Z0YLQ@mail.gmail.com>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
	<1370644168-4745-3-git-send-email-felipe.contreras@gmail.com>
	<51B31651.6020307@lsrfire.ath.cx>
	<CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com>
	<51B32FFD.5070302@lsrfire.ath.cx>
	<CAMP44s3K=VtkeCoKqnU9To9YbfO7vph9MsMWtgLWw0n=cYyq5g@mail.gmail.com>
	<51B35414.1090101@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jun 08 18:53:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlMOK-0003nF-L0
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 18:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab3FHQxU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 12:53:20 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:51043 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab3FHQxT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jun 2013 12:53:19 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so4643684lab.31
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8S+IEDyvHcNalSzejgyg0gsLncytd03ra1fhuj07NSg=;
        b=HlD9KR8hx1Mxnu+5ypBMWRQCgO37Mf0sLPvAdgDFEWP8nQKqq1WygmBzxGhNIy0TAd
         i/0QhmGrqZzakDn+XUboErtkdKrS6ilsw9riqKa6V7+A4wW4Mvrl3MJJ0n9CugkI/B2d
         17i271GL56sRaaeozrENEkCmwc/EB+20dwjVOOF1wIzLHc/TzQJ5E136Hs3ubaO77nr/
         fW6zVjVtDXJlBoG5bFBhafTJMnvfsT9azJlfEAcE4ilX3ceZ/DO1xn1h00+f9j41AlK5
         yRP9zzkJ2wje183tQnZLZhWwG1W8G9F9qmWkdRP0oKxzdsXTKAswcJLu4BOxV83axlKx
         12Xw==
X-Received: by 10.112.16.163 with SMTP id h3mr3326172lbd.85.1370710398367;
 Sat, 08 Jun 2013 09:53:18 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 09:53:18 -0700 (PDT)
In-Reply-To: <51B35414.1090101@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226839>

On Sat, Jun 8, 2013 at 10:56 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 08.06.2013 16:04, schrieb Felipe Contreras:
>
>> On Sat, Jun 8, 2013 at 8:22 AM, Ren=C3=A9 Scharfe
>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>
>>> Am 08.06.2013 14:15, schrieb Felipe Contreras:
>>
>>
>>>> Why leave it out? If somebody makes the mistake of doing the above
>>>> sequence, would you prefer that we leak?
>>>
>>>
>>> Leaking is better than silently cleaning up after a buggy caller be=
cause
>>> it
>>> still allows the underlying bug to be found.
>>
>>
>> No, it doesn't. The pointer is replaced and forever lost. How is
>> leaking memory helping anyone to find the bug?
>
> Valgrind can tell you where leaked memory was allocated, but not if y=
ou free
> it in the "wrong" place.

It is the correct place to free it. And nobody will ever find it with
valgrind, just like nobody has ever tracked down the hundreds of leaks
in Git that happen reliably 100% of the time, much less the ones that
happen rarely.

--=20
=46elipe Contreras
