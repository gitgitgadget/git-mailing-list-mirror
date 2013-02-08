From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v4] Add utf8_fprintf helper which returns correct columns
Date: Fri, 8 Feb 2013 15:20:26 +0800
Message-ID: <CANYiYbGZEJXDjzBJa_qbQCgw9tcTMfOChNr6ANwaLvo=fB=bcQ@mail.gmail.com>
References: <7va9rho350.fsf@alter.siamese.dyndns.org>
	<4ea03e99bad13e2910b137fd3991951244fa23f1.1360289411.git.worldhello.net@gmail.com>
	<51149542.8060307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.co>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 08:20:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3iGT-0005rn-3n
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 08:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987Ab3BHHU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2013 02:20:29 -0500
Received: from mail-we0-f169.google.com ([74.125.82.169]:55696 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab3BHHU2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2013 02:20:28 -0500
Received: by mail-we0-f169.google.com with SMTP id t11so2809263wey.14
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 23:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=nkTmxM+xpTRK4wmE58en/DI20qkGPe+R5fuhfX8VHTs=;
        b=RgqxsnI32JTmPwqX0jjvmi4t2ug0q+8rQCax8To/VrZex5ctMQ12YBX82yM85oPC8m
         +2yuwesmFx8v4JMe17VS5pBiBxWy2NW58rm64emaN5MSbpMg3UzZ/D3KtJzgYNQDBm7H
         2XJkI4pfHU+Exi0O1T392ml9SAke6gMc+H6n9+t743iMve1ap+RCOI0Le1GKckf/WvBo
         NLG6qSIfa+4coL/TxZ8PvWOqcwd+TsHNkGN0rQ0PPmoTZAYhKt1QosX9WZYmJzFLjZGh
         8EuqCZvDzRIyCZlJ0Ti0xpWMR6oMSyH9S619zaAvC3tYnNcmJHbu7+s+rRu5TEBVZtmg
         pYDg==
X-Received: by 10.194.76.237 with SMTP id n13mr7526655wjw.57.1360308026811;
 Thu, 07 Feb 2013 23:20:26 -0800 (PST)
Received: by 10.194.110.199 with HTTP; Thu, 7 Feb 2013 23:20:26 -0800 (PST)
In-Reply-To: <51149542.8060307@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215764>

2013/2/8 Torsten B=F6gershausen <tboegi@web.de>:
> On 08.02.13 03:10, Jiang Xin wrote:
>> +     /* If no error occurs, returns columns really required with ut=
f8_strwidth. */
>> +     if (0 <=3D columns)
>> +             columns =3D utf8_strwidth(buf.buf);
>> +     strbuf_release(&buf);
>> +     return columns;
>> +}
>> +
>
> I don't think we handle the return code from fputs() correctly.
>
> Please dee below for specifications on fprintf(),
> something like the following could do:
>
> int utf8_fprintf(FILE *stream, const char *format, ...)
> {
>         struct strbuf buf =3D STRBUF_INIT;
>         va_list arg;
>         int columns =3D 0;
>
>         va_start (arg, format);
>         strbuf_vaddf(&buf, format, arg);
>         va_end (arg);
>
>         if (EOF !=3D fputs(buf.buf, stream))
>                 columns =3D utf8_strwidth(buf.buf);
>         strbuf_release(&buf);
>         return columns;
> }

As fputs() returns a non-negative number (as opposed to 0) on
successful completion,
Test fputs() return value as "fputs() >=3D0" is correct, while "fputs()
=3D=3D 0", "fputs() !=3D 0"
are wrong. I think it's OK, must I send a new re-roll for this?

EOF is defined as (-1) in stdio.h:

    #define EOF     (-1)

> And as a side note: would fprintf_strwidth() be a better name?

This is a nice candidate.


--=20
Jiang Xin
