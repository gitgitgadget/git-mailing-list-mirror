From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH 2/2] Include unistd.h.
Date: Wed, 25 May 2011 22:37:34 +0200
Message-ID: <BANLkTim4gPAyA9vLnpBz7qRY+b4RQ7LwNw@mail.gmail.com>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
	<1306332924-28587-3-git-send-email-mduft@gentoo.org>
	<7vd3j64oq6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mduft@gentoo.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 22:37:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPKpu-0003xM-3L
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 22:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259Ab1EYUhh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 16:37:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53173 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab1EYUhg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 16:37:36 -0400
Received: by ewy4 with SMTP id 4so24215ewy.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XViwDWZZ3uiHs+A95vyLAPRDerOYCCCeR3mclUwkwHo=;
        b=T6D4KnXFOz6QNvBV4NOG8BdiUh0KunZyX8vBse92SOQ7rY0iKHCuHvrlLvIGXjf2W0
         8Rzf8DyaVcjB7wKtEllOSoIPKpr/BvE0ttluH4c5YKFHY4FtN/8Fk1wg/H8YuM51V1Lz
         O7bKT+8pCRlkgq9tZE2WnfnIfBFP+p+gYdiJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=mXiOPbRvga8sRP/c/EdEsCGZnQ65ZdppHGgWLRmbe5w2huhpXTHdwRolzbUKo1kAv6
         BuWNsKUIeWtoG2oK1T/QxG5+Aaym2Bs0dSnVllDjsmQ/AFLmCf7K8EZeRI9ceJl2zILN
         vGxqC7vNwJ797GLWtDzR+eBYJ56zpHN8svLoA=
Received: by 10.204.73.206 with SMTP id r14mr4680055bkj.181.1306355854681;
 Wed, 25 May 2011 13:37:34 -0700 (PDT)
Received: by 10.204.83.196 with HTTP; Wed, 25 May 2011 13:37:34 -0700 (PDT)
In-Reply-To: <7vd3j64oq6.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: vdhbATUfQ7q5fKf8r0S4BBm_BsE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174461>

On Wed, May 25, 2011 at 20:30, Junio C Hamano <gitster@pobox.com> wrote=
:
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

According to POSIX (well, IEEE Std 1003.1, 2004 Edition at least)
unistd.h must define NULL:

"
The following symbolic constant shall be defined:

NULL
    Null pointer
"

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

IRIX defines NULL in <unistd.h> and <stddef.h> (the latter via
<internal/stddef_core.h>).
Solaris 10 defines NULL in <unistd.h>, but also in <stddef.h> via
<iso/stddef_iso.h>
Tru64 v5.1 in <unistd.h> and <stddef.h> and a bunch of other places
(string.h, stdio,h, stdlib.h, everywhere)
AIX 5.1 in <unistd.h> and <stddef.h> and just about everywhere.
Linux also gets NULL via <unistd.h> because it includes <stddef.h>,
but then stddef.h isn't in /usr/include, at least on my system -
presumably it's in some compiler-provided place.

=46or all those non-Linu systems it's always a straight-forward no-depe=
ndency
#ifndef NULL
#define NULL 0 /* or sometimes 0L */
#endif

-Tor
