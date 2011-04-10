From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 6/9] gettext.h: Avoid using a non-standard C construct
Date: Sun, 10 Apr 2011 14:54:15 +0200
Message-ID: <BANLkTimFQjbf6pz7upcb=QJngZdPTgWLmQ@mail.gmail.com>
References: <4D9E056C.1070906@ramsay1.demon.co.uk>
	<20110407221015.GA20080@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 14:54:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8u9z-0002We-0H
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 14:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab1DJMyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 08:54:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38342 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab1DJMyR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 08:54:17 -0400
Received: by fxm17 with SMTP id 17so3081782fxm.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Aj6q1htbApygIn8wQ+EaepFEurZbSJYBDP4qrK69FPQ=;
        b=Pb72ABPgB3uTb1MTKkwj/4hyOqUkaRTC/rBIpN+njLUKLKCXa7lkokjZl4dfGdfBnJ
         0OC2NGmE+R+ufugSGdR9qhFsYdfwjAsj+vadLVYN8ROkl509sxak9LoOgz5WnhN9W+ox
         At/zC/lcAF9Drv0ad4SoORDHJhrVVtZyGkWS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vgaQF0mHjX60yXohzjP0sQRC4x+muZDkqCHzkS/wiuYmH1fAE7D7s7no/1hnTlaJfC
         jU3SgQJ46BNf31y4tUG8KBoV6RgN3sE80mIWiaZAxcWE1/0uIcXjI71zgjHaCVTq5hM9
         XiW94l2noZ1siJ3CsKgmQs0Zmjw4NdY/scvsA=
Received: by 10.223.25.197 with SMTP id a5mr71032fac.29.1302440055973; Sun, 10
 Apr 2011 05:54:15 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Sun, 10 Apr 2011 05:54:15 -0700 (PDT)
In-Reply-To: <20110407221015.GA20080@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171250>

On Fri, Apr 8, 2011 at 00:10, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Hi,
>
> Ramsay Jones wrote:
>
>> +++ b/gettext.h
>> @@ -35,6 +35,6 @@ const char *Q_(const char *msgid, const char *plu,=
 unsigned long n)
> [...]
>> -#define N_(msgid) (msgid)
>> +#define N_(msgid) msgid
>
> Good catch. =C2=A0Thanks!
>
>> In particular, standard C does not allow a parenthesized string
>> as an array initializer.
>
> The subject line seems unnecessarily vague. =C2=A0Why not:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i18n: avoid parenthesized string as array =
initializer
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The syntax
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static const c=
har ignore_error[] =3D ("something");
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0is invalid C. =C2=A0GCC and MSVC can parse=
 it, but for example
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tcc cannot. =C2=A0So remove the parenthesi=
s from the definition
> =C2=A0 =C2=A0 =C2=A0 =C2=A0of the N_() macro.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Ramsay Jones <ramsay@ramsay=
1.demon.co.uk>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Acked-by: Jonathan Nieder <jrnieder@gmail.=
com>

This looks good to me with this commit message:

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
