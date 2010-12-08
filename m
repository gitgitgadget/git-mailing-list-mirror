From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 02/14] msvc: git-daemon.exe: Fix linker "unresolved
 externals" error
Date: Wed, 8 Dec 2010 13:41:14 +0100
Message-ID: <AANLkTi=oP2dNT_ju=wEsZkupV0Qf3zFci_mWQgCYh71Q@mail.gmail.com>
References: <4CFA8EB7.9070000@ramsay1.demon.co.uk> <AANLkTi=cVTcaQTQqNeQoNHhUrEBZvE5B=aFDy=r+k0uQ@mail.gmail.com>
 <4CFECD34.3080809@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 08 13:41:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQJL4-0002yQ-CW
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 13:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab0LHMlg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 07:41:36 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:39897 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408Ab0LHMlg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 07:41:36 -0500
Received: by fxm18 with SMTP id 18so1006968fxm.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 04:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=mR2PB97JrXBqKlyv24zSbdzU2vraSvLf+qj1h8hgjqc=;
        b=qxeUzl8Eco0aQCwhMG/LM6EHYSmh50106+pevmJj7MVfY/Kj0h1HjupAzJoxa1K5gv
         ZtQc8ogM54UqAs+hkeW3x7a0P0fSNeqSYfjwyhe/xMWu4V+0QVmPUsxyopha+5EZiwi/
         CprF27UCHldpKMavgT61g7S4PXKcPp+guykQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=PUbll0+0qpCASu8ZSg9bLIkpfS8dSd9wZic//INh4rhO9e6YlvzQhYnHvVtoqmnp5j
         GWQB9p3PJzFRF/rOojcJac6+SPx4i7I6qKDqsVXRoGveRM8hQwcIYjtSeX7N28HcWvps
         oHNPLcl3lJJAacMcy0IR8tfPWyPWQhcfLbCP4=
Received: by 10.223.83.8 with SMTP id d8mr8497515fal.94.1291812094727; Wed, 08
 Dec 2010 04:41:34 -0800 (PST)
Received: by 10.223.95.202 with HTTP; Wed, 8 Dec 2010 04:41:14 -0800 (PST)
In-Reply-To: <4CFECD34.3080809@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163193>

On Wed, Dec 8, 2010 at 1:11 AM, Ramsay Jones <ramsay@ramsay1.demon.co.u=
k> wrote:
> Erik Faye-Lund wrote:
>> On Sat, Dec 4, 2010 at 7:55 PM, Ramsay Jones <ramsay@ramsay1.demon.c=
o.uk> wrote:
>>> The msvc linker complains about external symbols referenced by
>>> the new poll() emulation code. In particular, it complains about
>>> the DispatchMessage(), PeekMessage(), TranslateMessage() and
>>> MsgWaitForMultipleObjects() functions.
>>>
>>> In order to satisfy the external references, we link against the
>>> user32.lib library.
>>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> ---
>>> =A0Makefile | =A0 =A02 +-
>>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 1d42413..bda9fa6 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1087,7 +1087,7 @@ ifeq ($(uname_S),Windows)
>>> =A0 =A0 =A0 =A0COMPAT_OBJS =3D compat/msvc.o compat/fnmatch/fnmatch=
=2Eo compat/winansi.o compat/win32/pthread.o compat/win32/syslog.o comp=
at/win32/sys/poll.o
>>> =A0 =A0 =A0 =A0COMPAT_CFLAGS =3D -D__USE_MINGW_ACCESS -DNOGDI -DHAV=
E_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Ic=
ompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=3D\".exe\"
>>> =A0 =A0 =A0 =A0BASIC_LDFLAGS =3D -IGNORE:4217 -IGNORE:4049 -NOLOGO =
-SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
>>> - =A0 =A0 =A0 EXTLIBS =3D advapi32.lib shell32.lib wininet.lib ws2_=
32.lib
>>> + =A0 =A0 =A0 EXTLIBS =3D user32.lib advapi32.lib shell32.lib winin=
et.lib ws2_32.lib
>>> =A0 =A0 =A0 =A0PTHREAD_LIBS =3D
>>> =A0 =A0 =A0 =A0lib =3D
>>> =A0ifndef DEBUG
>>
>> Looks sane. But it's a bit odd - it currently builds fine without th=
is
>> patch from the IDE, but not from the makefile. Is the linker-libs
>> different between these?
>
> Er... dunno! ;-) I don't use the IDE (except to read the msdn docs), =
I'm
> *much* more productive in vim (yeah, I'm a luddite!).
>
> So, how did you create your project file? What does it say?
> ie. you tell me! :-P
>

probably by contrib/buildsystems/generate, but I don't quite remember ;=
)

Anyway, if the result of contrib/buildsystems/generate builds
differently than "make MSVC=3D1", then I consider this an issue with
contrib/buildsystems/generate, not the MSVC-port.

I can try to reproduce it at some point, but I'm really tight on time r=
ight now.
