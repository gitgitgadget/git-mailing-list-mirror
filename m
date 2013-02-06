From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 2/2] i18n: mark OPTION_NUMBER (-NUM) for translation
Date: Wed, 6 Feb 2013 11:02:27 +0800
Message-ID: <CANYiYbF8DCPxqGQ2AFFXpSm0nO+wFDg=qrn9C8uoZO6fj__NHA@mail.gmail.com>
References: <20130205121552.GA16601@lanh>
	<883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com>
	<8d6d4d869ea58e0a26b3bb6377fc102728948997.1360080194.git.worldhello.net@gmail.com>
	<7vd2weu1sq.fsf@alter.siamese.dyndns.org>
	<CANYiYbF1cS=K9M0cwE5V0pUJMPEYGiJOjJwg5KQScCf8pjyTqw@mail.gmail.com>
	<7vpq0enoui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 04:02:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2vHg-0003YD-0i
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 04:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429Ab3BFDC3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 22:02:29 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:57613 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab3BFDC2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 22:02:28 -0500
Received: by mail-wg0-f47.google.com with SMTP id dr13so713793wgb.2
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 19:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=igNT1k1gRRk80K7F5qaXoNBWyqNmZ5fNtcnoSbsf7g0=;
        b=WGyoYsf4mN/IkJO0pPRcImycX21gFkJB6RLfnHKiVig4ILEYUSmWv/NkDVwZLEazAo
         AtkY6ri7fpuX0Ew12T1ec9tQAFEQT+pcjISa+wTASfNTjrRbsB0++wBxlaqnweM6klGX
         9vtdtafNl2BPCgLaWDn6usi3wPwozBBMJ02QcR2eMLuN9DEUYFsqBZJSPVtawWCqV1pi
         LI0gBmolDQ4FNIa9MEoOt/asJYtUHRVw0Md9eAEOJNDhtptWBATBHPonBFqFtwMLNIZR
         4D08XyZlsH7JRESYW2v/kWSJbSbJ6bVeKh26+0ZZxlqORZLzu0ZuEnFPReRb5iexilGq
         NqDA==
X-Received: by 10.180.93.41 with SMTP id cr9mr2065567wib.19.1360119747633;
 Tue, 05 Feb 2013 19:02:27 -0800 (PST)
Received: by 10.194.110.199 with HTTP; Tue, 5 Feb 2013 19:02:27 -0800 (PST)
In-Reply-To: <7vpq0enoui.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215559>

2013/2/6 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>> I agree, a helper named 'utf8_fprintf' in utf8.c is better.
>> I will send a patch latter.
>
> Yeah, the idea of a helper function I agree with; I am not thrilled
> with the name utf8_fprintf() though.  People use the return value of
> fprintf() for error detection (negative return value means an error)
> most of the time (even though non-negative value gives the number of
> bytes shown), but the primary use of the return value from the
> utf8_fprintf() function will be to get the display width, and the
> name does not quite capture that.
>

How about this since [PATCH v3]:

diff --git a/utf8.c b/utf8.c
index 52dbd..b893a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -443,8 +443,11 @@ int utf8_fprintf(FILE *stream, const char *format,=
 ...)
        strbuf_vaddf(&buf, format, arg);
        va_end (arg);

-       fputs(buf.buf, stream);
-       columns =3D utf8_strwidth(buf.buf);
+       columns =3D fputs(buf.buf, stream);
+       /* If no error occurs, and really write something (columns > 0)=
,
+        * calculate really columns width with utf8_strwidth. */
+       if (columns > 0)
+               columns =3D utf8_strwidth(buf.buf);
        strbuf_release(&buf);
        return columns;
 }


--=20
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 010-51262007, 18601196889
