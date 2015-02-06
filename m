From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] git-compat-util: do not step on MAC_OS_X_VERSION_MIN_REQUIRED
Date: Fri, 6 Feb 2015 11:47:51 -0800
Message-ID: <28F603A7-610B-4711-9D2F-CD9866C96A74@gmail.com>
References: <f2a35ed9fba20d48ef5736ee4564101@74d39fa044aa309eaea14b9f57fe79c> <CAPig+cT0-ftZZyRORx-W2_Nit6XdgrpiyGS=pRjGtHoz1jW+Kg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJosi-000177-2D
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 20:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbbBFTr4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2015 14:47:56 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33719 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbbBFTrz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2015 14:47:55 -0500
Received: by pdbnh10 with SMTP id nh10so14106977pdb.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2015 11:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=oxpnG2/ib0Yd3kP6znyZD64um8s0CjJ20EWc/YpwMtE=;
        b=XiJ/acveI9txrBKUIYdGKdOyTNMIA3SFmPEK7XDvmNnRYTefpOOdFykmj8zpOH4FbE
         1InlIIc5iqHvtTmsCSQdEOaiWATNI1XXKl5AWNG1LAIJtIqtllJf1zYOlf8SNz4eEz80
         2U0R1XQl91R2YfvGaMS7MNuXnSqVxd09PGyGQbskSedlzvr627r8l1XV3lVgTMYI7Tro
         VbyM1+EqJToTCj+pX1y+KQ/UUgoeqmgccq13zfMSliFFbmgjintvxGYHMwoYEJvS6eiJ
         zst8/f9MWozyoUCBgjwYUdwVdXv5R7feKu9ym2KaTavt/19vMo2rc1fjgaLIolHu3fOQ
         mYHw==
X-Received: by 10.70.36.99 with SMTP id p3mr8212134pdj.81.1423252074907;
        Fri, 06 Feb 2015 11:47:54 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id r1sm8836474pdp.83.2015.02.06.11.47.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 06 Feb 2015 11:47:54 -0800 (PST)
In-Reply-To: <CAPig+cT0-ftZZyRORx-W2_Nit6XdgrpiyGS=pRjGtHoz1jW+Kg@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263422>

On Feb 6, 2015, at 02:00, Eric Sunshine wrote:
> On Fri, Feb 6, 2015 at 4:35 AM, Kyle J. McKay <mackyle@gmail.com> =20
> wrote:
>> #ifndef NO_OPENSSL
>> +#ifdef __APPLE__
>> #define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
>> -#define MAC_OS_X_VERSION_MIN_REQUIRED MAC_OS_X_VERSION_10_6
>> +#include <AvailabilityMacros.h>
>> +#undef DEPRECATED_ATTRIBUTE
>> +#define DEPRECATED_ATTRIBUTE
>> +#undef __AVAILABILITY_MACROS_USES_AVAILABILITY
>> +#endif
>> #include <openssl/ssl.h>
>> #include <openssl/err.h>
>> -#undef MAC_OS_X_VERSION_MIN_REQUIRED
>> -#undef __AVAILABILITY_MACROS_USES_AVAILABILITY
>
> DEPRECATED_ATTRIBUTE is a fairly generic name. Do we want to be extra
> careful and #undef it here to avoid potential unintended interactions
> with other #includes (Apple or not)?

The new patch only mucks with it when we have #ifdef __APPLE__ and =20
pretty much any apple code is going to end up including the =20
availability stuff sooner or later which manipulates =20
DEPRECATED_ATTRIBUTE.  Essentially that makes "DEPRECATED_ATTRIBUTE" a =
=20
reserved macro name on __APPLE__.

>
>    #ifdef __APPLE__
>    #undef DEPRECATED_ATTRIBUTE
>    #endif

If we do that, won't the compiler then helpfully supply a "0" when the =
=20
macro is used?  Or is that only when an undefined macro is used inside =
=20
an #if or #elif ?

That would break all later declarations that use it.

> On the other hand, we've already mucked with it, so #undef may be =20
> superfluous.

Actually I just tested it.  If we #undef it we could end up producing =20
these:

   error: syntax error before =91DEPRECATED_ATTRIBUTE=92

So I think it needs to stay #define'd to nothing to be safe in case =20
anything later on ends up including stuff that uses it.  The worst =20
that happens is you don't see some deprecation warnings that you =20
otherwise would.  It won't make any functions available that shouldn't =
=20
be or make unavailable functions that should be.

-Kyle