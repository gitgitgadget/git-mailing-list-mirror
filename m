From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] fixes for ActiveState Perl
Date: Mon, 14 Feb 2011 20:48:05 +0100
Message-ID: <AANLkTimb2puTjj=DDqJcshwSVgqebhS9__jHoY1KdO_7@mail.gmail.com>
References: <4D5914C1.9050008@io.com> <AANLkTimCXEbzZnR1k32u942hjB37nThN_RDBL5N7owHa@mail.gmail.com>
 <4D5984DD.1030004@io.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: rkitover@io.com
X-From: git-owner@vger.kernel.org Mon Feb 14 20:48:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4Pm-0006Zd-DY
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab1BNTsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 14:48:35 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48249 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab1BNTsd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 14:48:33 -0500
Received: by fxm20 with SMTP id 20so5598097fxm.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 11:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=O5k24xUtxwr3vzZGMGXM2eYRTOJggpI6z0V0Zhv7it0=;
        b=G0BkQ4W2WUgzwQjysP/dFczhQFZ7+t5PxYmnrgciYM8AUQJ/N6g4nPJ865gtiL+vKr
         aspvteL7Zd/nefD8nM3wA1DQlyWpRHKY9qxzlLn5fPxnGGMFI+reH4U+dv+Tab60kTHD
         7ntlSIchGVH+RVcuCNivDaziVSX4lM4wU/X8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=RNWCW4CezxF3T98SyjfxuGrH3lNxuBH2lFUngjaH7i6eTgRo+LDrd1q2Q7gTJA3geQ
         MiTxM5Q6lZKg5Fp7/VyEhfp85T8i4hzIrjNVGotMgwRgBhoB7+XfwFH8mb0B4JFDAz2F
         4y1xl3m24m3BVq5TUJyLs3noNtIkP/Jtrs9WY=
Received: by 10.223.118.136 with SMTP id v8mr5047582faq.90.1297712911467; Mon,
 14 Feb 2011 11:48:31 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Mon, 14 Feb 2011 11:48:05 -0800 (PST)
In-Reply-To: <4D5984DD.1030004@io.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166757>

On Mon, Feb 14, 2011 at 8:39 PM, Rafael Kitover <rkitover@io.com> wrote=
:
> On 2/14/2011 7:49 AM, Erik Faye-Lund wrote:
> ...
>>> diff --git a/perl/Makefile b/perl/Makefile
>>> index a2ffb64..1fa99cd 100644
>>> --- a/perl/Makefile
>>> +++ b/perl/Makefile
>>> @@ -3,18 +3,28 @@
>>> =A0#
>>> =A0makfile:=3Dperl.mak
>>>
>>> +# support PERL_PATH=3DC:\\Perl\\bin\\perl
>>> +PERL_PATH :=3D $(subst \,\\,$(PERL_PATH))
>>> +
>>> =A0PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
>>> +PERL_MAKE :=3D MAKEFLAGS=3D"" $(subst \,\\,$(shell $(subst \,\\,$(=
PERL_PATH)) -MConfig -le "print ((\%Config)->{make})"))
>>> +
>>> +ifneq (,$(findstring nmake,$(PERL_MAKE)))
>>> + =A0 =A0 =A0 PERL_MAKE :=3D $(PERL_MAKE) -nologo
>>> +endif
>>> +
>>> =A0prefix_SQ =3D $(subst ','\'',$(prefix))
>>>
>>> =A0ifndef V
>>> =A0 =A0 =A0 =A0QUIET =3D @
>>> =A0endif
>>>
>>> +
>>
>> Why?
>
> Windows perl (activestate, strawberry) uses nmake or dmake. The
> makefiles for these makes are incompatible with GNU make. This code
> retrieves the make Perl would use from its Config, and uses that on
> invoking perl.mak .
>
> This should also allow for using EU::MM for the MSVC+ActiveState buil=
d.

I'm sorry for not being clear; I was talking about that single
new-line, not the PERL_MAKE-stuff.
