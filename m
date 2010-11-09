From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 9 Nov 2010 12:57:19 +0100
Message-ID: <AANLkTimhbp3AngtJjBYhHpa173=D-XJOg9L2sd6YMCwA@mail.gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
	<1288524860-538-2-git-send-email-avarab@gmail.com>
	<4CCFCCC8.7080603@viscovery.net>
	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>
	<4CD8F965.6050402@viscovery.net>
	<AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>
	<4CD918AB.6060206@viscovery.net>
	<AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>
	<4CD9241F.6070807@viscovery.net>
	<AANLkTins_qq=unv101JuV_CVvkp3KbTq5qycva7bZ7sm@mail.gmail.com>
	<4CD933BF.6070105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 12:57:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFmpR-000744-PA
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 12:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab0KIL5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 06:57:21 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36932 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab0KIL5V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 06:57:21 -0500
Received: by fxm16 with SMTP id 16so4850810fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 03:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8xVh5lDJTy6le8mTNQGhMwUloedgnvC7YBj5TJdEGro=;
        b=SdazjtAPKrcaI2muROd9YXqKmgj1x0onXpqr5E/GHCUNWaAtUf87/dotZts+iVmKas
         A2Kn7dkxgg/UeQCo9ZOBGYZ+QmRVPCp30Vg2G3LBydUrtmG79ksy8jP2WT1dgGD128c0
         Huoy6mh9nM8x/DHysDCif8SnuawzeOFhNPgIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ddx6qQwj/9Zr93Y0ng2IQveUnZn5skCBfRF6V9qwD7hoGNMMifggHHXQsHO0KwAUIB
         MH6gjRQlnPPLcTKV3ap9nTgS6JB4ee8qT8+gE68h5TJjRUVKrS09gGkXEXr7BBq5wW4O
         U8vKWioJWHvwjY+GA0VGOm4FCatjs44yuIvGI=
Received: by 10.223.86.6 with SMTP id q6mr4921643fal.144.1289303839757; Tue,
 09 Nov 2010 03:57:19 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Tue, 9 Nov 2010 03:57:19 -0800 (PST)
In-Reply-To: <4CD933BF.6070105@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161036>

On Tue, Nov 9, 2010 at 12:42, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> Am 11/9/2010 11:52, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Tue, Nov 9, 2010 at 11:36, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>>> $ time (for i in {1..100}; do git version; done) > /dev/null
>>>
>>> real =C2=A0 =C2=A00m5.610s
> ...
>>> $ time (for i in {1..100}; do eval_gettext foobar; done) > /dev/nul=
l
>>>
>>> real =C2=A0 =C2=A00m20.578s
> ...
>>> Note that there are only 100 iterations, so we are talking about 0.=
2
>>> seconds per eval_gettext call! That's an awful lot of time even for=
 a
>>> single error message.
>>
>> Thanks for elaborating. But just so I understand you correctly it's =
a
>> cost of invoking *any* program in shellscripts on Windows? So e.g. 1=
0
>> sed calls would cost the same as 10 git-sh-i18n--envsubst calls (but
>> of course 5 eval_gettext() calls, since it calls git-sh-i18n--envsub=
st
>> twice).
>
> An invocation of sed, cat, etc. (POSIX/MSYS tools) is cheaper by a fa=
ctor
> of 2 than a git invocation for a reason that I do not understand. (Pe=
rhaps
> it has to do with the number of DLLs that are linked; git has 9 stati=
c
> dependencies, MSYS tools only 3.)

git-sh-i18n--envsubst doesn't need to be linked to anything but the C
library.

If it is that's because I fat-fingered the Makefile part of the
patch. So it should be cheaper than cat/sed etc. if anything.

    $ ldd -r git-sh-i18n--envsubst
        linux-vdso.so.1 =3D>  (0x00007fff163c4000)
        libz.so.1 =3D> /usr/lib/libz.so.1 (0x00007f742dea6000)
        libcrypto.so.0.9.8 =3D> /usr/lib/libcrypto.so.0.9.8 (0x00007f74=
2db05000)
        libpthread.so.0 =3D> /lib/libpthread.so.0 (0x00007f742d8e8000)
        libc.so.6 =3D> /lib/libc.so.6 (0x00007f742d587000)
        libdl.so.2 =3D> /lib/libdl.so.2 (0x00007f742d383000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f742e0cc000)

That's on Linux, it doesn't need libz, libcrypto etc. It just needs
standard C library functions along with its own main().

> eval_gettext involves 2 git invocation (git-sh-i18n--envsubst counts =
as
> much as git) and 1 subshell in practice (some subshells are optimized=
 away).
>
>> So e.g. using eval_gettext once isn't a bigger problem than calling
>> some trivial sed substitution twice?
>
> Look at the timings: In my book, eval_gettext counts like about 8 sed
> substitutions.

How about if you just replace your tests with "cat". That should give
a more accurate indication of what speed it *should* be operating at,
once I fix those Makefile issues.

Anyway, if it's no more expensive than cat(1) (which it shouldn't be)
it probably won't be a problem to use git-sh-i18n--envsubst.

Actually I'd rather keep the current calling semantics (using
variables in the strings) than improve performance slightly on Windows
for what are mostly non-critical error messages. But that's just my
opinion.
