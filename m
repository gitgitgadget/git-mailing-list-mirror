From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6 1/2] cache.h: eliminate SHA-1 deprecation warnings on
 Mac OS X
Date: Wed, 15 May 2013 20:31:42 -0700
Message-ID: <CAJDDKr7VavpBhE_w6NKP+ZxB2YBmwW6mQ-Po763p7v5GmHzoPg@mail.gmail.com>
References: <1368663120-47102-1-git-send-email-davvid@gmail.com>
	<7vbo8bahh7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 05:31:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucouz-000775-3p
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171Ab3EPDbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 May 2013 23:31:45 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:59226 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab3EPDbo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 May 2013 23:31:44 -0400
Received: by mail-we0-f169.google.com with SMTP id x54so2265069wes.0
        for <git@vger.kernel.org>; Wed, 15 May 2013 20:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=lnXx2oxwaVw1k7GfnSVQgQU1bpWpE/UemGmzD74X/n8=;
        b=h+9VsV4DnbhAqfcVbh18FTAIc+vJ6BK5nIwZP/OchXIzTDygiXXvgpy2fnZMayaXQt
         N4jBuAIdccreFj85TLNf3l7SrdVplSyNeCx/HbRBQQsF0Oqqfr+6vxLcFB1ObeiE7i7o
         UgupEK2aaqmYelpEAVVWrH8hjqrq7Eu7r3BVaj0FexjaW0QjkuPa8jr5oYIjMGffwHsb
         T+Cgu9uRD1LjA+1R0PnoWwQTDZzYM6JYxcjOvo8u1u5YRBXP+w3f/qDhz8enFVhPu3VW
         FEHXbEoJZkM+X9wf42rRYht4EFGf7DWmIkA38YIgo2RdyIo04P4q2xxesjN2w7wiCDHu
         9xuA==
X-Received: by 10.180.21.243 with SMTP id y19mr19953474wie.13.1368675102716;
 Wed, 15 May 2013 20:31:42 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Wed, 15 May 2013 20:31:42 -0700 (PDT)
In-Reply-To: <7vbo8bahh7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224468>

On Wed, May 15, 2013 at 5:36 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> David Aguilar <davvid@gmail.com> writes:
>
>> Mac OS X 10.8 Mountain Lion prints warnings when building git:
>>
>>       warning: 'SHA1_Init' is deprecated
>>       (declared at /usr/include/openssl/sha.h:121)
>>
>> Silence the warnings by using the CommonCrytpo SHA-1
>> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
>>
>> Add a NO_COMMON_DIGEST_FOR_OPENSSL option to the Makefile to allow
>> users to opt out of using this library.  When defined, Git will
>> use OpenSSL instead.
>>
>> COMMON_DIGEST_FOR_OPENSSL is defined to enable the OpenSSL
>> compatibility macros in CommonDigest.h.
>
> This symbol will also cover not just SHA but also HMAC, would it
> make more sense to call it COMMON_CRYPTO_FOR_OPENSSL?  After all,
> that is what Apple calls this library, no?

They call it COMMON_DIGEST_FOR_OPENSSL.  weirdos,
but I guess they mean it's for the digest functions.

Thanks for catching the commit message typo.

>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> Changes since last time:
>>
>> Name the Makefile variable after the #define for consistency.
>>
>>  Makefile | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index f698c1a..b0eb949 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -137,6 +137,10 @@ all::
>>  # specify your own (or DarwinPort's) include directories and
>>  # library directories by defining CFLAGS and LDFLAGS appropriately.
>>  #
>> +# Define NO_COMMON_DIGEST_FOR_OPENSSL if you are building on Darwin=
/Mac OS X
>> +# and do not want to use Apple's CommonCrypto library.  This allows=
 you to
>> +# provide your own OpenSSL library, for example from MacPorts.
>> +#
>>  # Define BLK_SHA1 environment variable to make use of the bundled
>>  # optimized C SHA1 routine.
>>  #
>> @@ -1054,6 +1058,9 @@ ifeq ($(uname_S),Darwin)
>>                       BASIC_LDFLAGS +=3D -L/opt/local/lib
>>               endif
>>       endif
>> +     ifndef NO_COMMON_DIGEST_FOR_OPENSSL
>> +             COMMON_DIGEST_FOR_OPENSSL =3D YesPlease
>> +     endif
>>       NO_REGEX =3D YesPlease
>>       PTHREAD_LIBS =3D
>>  endif
>> @@ -1389,10 +1396,16 @@ ifdef PPC_SHA1
>>       LIB_OBJS +=3D ppc/sha1.o ppc/sha1ppc.o
>>       LIB_H +=3D ppc/sha1.h
>>  else
>> +ifdef COMMON_DIGEST_FOR_OPENSSL
>> +     BASIC_CFLAGS +=3D -DCOMMON_DIGEST_FOR_OPENSSL
>> +     SHA1_HEADER =3D <CommonCrypto/CommonDigest.h>
>> +else
>>       SHA1_HEADER =3D <openssl/sha.h>
>>       EXTLIBS +=3D $(LIB_4_CRYPTO)
>>  endif
>>  endif
>> +endif
>> +
>>  ifdef NO_PERL_MAKEMAKER
>>       export NO_PERL_MAKEMAKER
>>  endif



--
David
