From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/2] Include unistd.h.
Date: Wed, 25 May 2011 23:52:44 +0200
Message-ID: <BANLkTi=w1hpmrK8_Vv8vTLtDF+qf6cETEw@mail.gmail.com>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
 <1306332924-28587-3-git-send-email-mduft@gentoo.org> <7vd3j64oq6.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mduft@gentoo.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 23:53:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPM0u-00070F-RI
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 23:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071Ab1EYVxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 17:53:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34467 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab1EYVxE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 17:53:04 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so37360pzk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=onOAxQl9QdVYHPcu92FQC0v/0Bo/kkFy1CzqaB5A1jc=;
        b=KDhjeOfVS9tYag8MD/BJkxtcLRpex398RbdE702DyDgpVgchi7XLHEZKxPvezqwwa3
         LinGFbRJM0yCmkm1Gh8xXau2pzMDf42lYhi/twc4I4tjNYheQ9nYmhnbPNbTN5JTKI9C
         y5n87bl4NIOwkOoO+lCgZTjc0fvnH6/FInKiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=LC7kVevRgPYAeT0xRPDcaze35vKArzmEgVJJIB3tMezHf7wlw0Hm20PeyJ+rzLai41
         9NVu/Sv8eJGgcLyGU1qc46y+uRhyv6/II1z5P/7RqWvwYkAxMpKVDsQ3ihp5mSR3zpgW
         WXSS2sC4RmGrSFpHo0BR8jt23FGGJX/9aTOaE=
Received: by 10.68.12.72 with SMTP id w8mr40410pbb.165.1306360384593; Wed, 25
 May 2011 14:53:04 -0700 (PDT)
Received: by 10.68.47.131 with HTTP; Wed, 25 May 2011 14:52:44 -0700 (PDT)
In-Reply-To: <7vd3j64oq6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174468>

On Wed, May 25, 2011 at 8:30 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> mduft@gentoo.org writes:
>
>> At least on Interix, NULL is defined in unistd.h, and not including =
it
>> causes compilation failure.
>>
>> Signed-off-by: Markus Duft <mduft@gentoo.org>
>> ---
>> =A0compat/fnmatch/fnmatch.c | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
>> index 14feac7..0238cca 100644
>> --- a/compat/fnmatch/fnmatch.c
>> +++ b/compat/fnmatch/fnmatch.c
>> @@ -25,6 +25,7 @@
>> =A0# define _GNU_SOURCE 1
>> =A0#endif
>>
>> +#include <unistd.h>
>> =A0#include <errno.h>
>> =A0#include <fnmatch.h>
>> =A0#include <ctype.h>
>
> The header stddef.h is where NULL is supposed to be defined, and comm=
only
> used headers are supposed to define NULL the same way as stddef.h doe=
s.
> There is a conditional inclusion of stdlib.h in fnmatch.c and stdlib.=
h is
> one of those files; probably that is how the upstream pulls in NULL w=
hen
> compiling this.
>
> But we don't define STDC_HEADERS nor _LIBC (and we shouldn't), so I d=
on't
> know how the existing users of compat/fnmatch/ gets the defintion of =
NULL
> from. Output from "gcc -E -dD -DNO_FNMATCH compat/fnmatch/fnmatch.c" =
does
> not seem to show any NULL defined.
>
> Other platforms (e.g. SunOS, IRIX, HPUX, Windows) use NO_FNMATCH_CASE=
=46OLD
> and compile this file. =A0How are they getting their NULLs?

Windows/MinGW:

$ gcc -E -dD -DNO_FNMATCH compat/fnmatch/fnmatch.c | grep NULL
compat/fnmatch/fnmatch.c:29:21: error: fnmatch.h: No such file or direc=
tory
#define __MINGW_ATTRIB_NONNULL(arg) __attribute__ ((__nonnull__ (arg)))
#undef __need_NULL
#define __need_NULL
#undef NULL
#define NULL ((void *)0)
#undef __need_NULL

The "#define NULL ((void *)0)"-line comes from stddef.h, which is
included from string.h, which in turn is included by fnmatch.c.
