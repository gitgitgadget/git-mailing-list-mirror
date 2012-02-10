From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Fri, 10 Feb 2012 11:06:43 +0100
Message-ID: <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
References: <4F3472F4.4060605@aegee.org> <7v1uq3toyq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 11:07:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvnNw-0007Nl-5P
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 11:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759141Ab2BJKHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 05:07:06 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37196 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759136Ab2BJKHE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 05:07:04 -0500
Received: by lagu2 with SMTP id u2so2223582lag.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 02:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1Jqkx7HdC/H24urUlVrVBwl8mPW5gDHrGkZ0+bp33q4=;
        b=oyoIfFKwbWQaOWLb2OOehANBNfhntj5cba/BeTKSv7g4jlKkobatrTKdPLbO1SBMo7
         fYjmX3UHV8TeeTpgkaQBPXw+of1/fQOVEAG/EJwzVLtNyVmsk+/eZTjIAuLaiGc0uRsp
         9LmEx5xPwg8++jC52pYAYtPmFvTKd84sajRbk=
Received: by 10.152.102.237 with SMTP id fr13mr3767881lab.10.1328868423140;
 Fri, 10 Feb 2012 02:07:03 -0800 (PST)
Received: by 10.112.1.230 with HTTP; Fri, 10 Feb 2012 02:06:43 -0800 (PST)
In-Reply-To: <7v1uq3toyq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190398>

2012/2/10 Junio C Hamano <gitster@pobox.com>:
> =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=
=BE=D0=B2 =C2=A0<dilyan.palauzov@aegee.org> writes:
>
>> Hello,
>>
>> git 1.7.9 makes use of libcharset and /Makefile contains:
>>
>> ifdef HAVE_LIBCHARSET_H
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 BASIC_CFLAGS +=3D -DHAVE_LIBCHARSET_H
>> endif
>> ...
>> and the problem is, that libcharset is not used when linking. =C2=A0=
To
>> solve this, please replace the above extract from /Makefile with
>>
>> ifdef HAVE_LIBCHARSET_H
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 BASIC_CFLAGS +=3D -DHAVE_LIBCHARSET_H
>> =C2=A0 =C2=A0 =C2=A0 EXTLIBS +=3D -lcharset
>> endif
>
> Thanks.
>
> What platform is this? =C2=A0Is there a guarantee that any and all sy=
stem that
> use "#include <libcharset.h>" has to link with "-lcharset"?
>
> What I am wondering is there are systems that need to include the hea=
der,
> but locale_charset() does not live in /lib/libcharset.a, in which cas=
e we
> cannot make HAVE_LIBCHARSET_H imply use of -lcharset.

I've had some similar (privately sent) bug reports about the i18n
stuff from someone who built his own Linux distro.

Basically we make assumptions that certain stuff will be in the C
library on certain platforms, certain headers go with certain
libraries etc.

Evidently none of this can really be relied upon and we'd have to
probe for each one if we wanted to make it reliable.
