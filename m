From: Atousa Duprat <atousa.p@gmail.com>
Subject: Re: [PATCH 1/2] Limit the size of the data block passed to SHA1_Update()
Date: Tue, 3 Nov 2015 20:27:31 -0800
Message-ID: <CA+izobtfk_k9im1gy7MCOt4p+99PD4A2iP93haRGDzerugr8Yw@mail.gmail.com>
References: <xmqqpozsdrnl.fsf@gitster.mtv.corp.google.com>
	<1446533930-463-1-git-send-email-apahlevan@ieee.org>
	<56389FBC.7050909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 05:27:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztpfd-0000ML-0n
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 05:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbbKDE1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2015 23:27:33 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35221 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbbKDE1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 23:27:32 -0500
Received: by ykek133 with SMTP id k133so53345365yke.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 20:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eB1pEXM19dk43MoT8m9pf4S1iTa6DfopvZllETdJE8o=;
        b=kse2p4EGtNJaIV0OxEv9ABaIFjvvS9IZIFkXITxyB99PFS7qpIF5JZ+S82Jpls+YyZ
         U6lWBFtdm95y1kz2qAR/eD1WSeYlKKKbusrgV39WUBhdsDL95aK3yA4RMgq1azzA/FE6
         6sIBrGm8EZbRfcHlmC3PRi6VgDi0frh8ZhtCC+muuGk/dBEo7ScVcQKnOZSQmYRINXIv
         rWXMAiTk7kz9EZXxpauqwZFEmprzhISEzGw6Z9GacymitySheK500Gv3313MCx1Ubyn7
         mWNmK9IYURhp77rV807gRoJk9KvKbmUuGMqomYxxZW690VKCLi4+XzfwarqS/XUGVsZV
         WlWQ==
X-Received: by 10.13.251.193 with SMTP id l184mr23076395ywf.342.1446611251924;
 Tue, 03 Nov 2015 20:27:31 -0800 (PST)
Received: by 10.37.91.198 with HTTP; Tue, 3 Nov 2015 20:27:31 -0800 (PST)
In-Reply-To: <56389FBC.7050909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280849>

Thank you for the feedback. The patch is updated as suggested.


On Tue, Nov 3, 2015 at 3:51 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 11/03/2015 07:58 AM, atousa.p@gmail.com wrote:
>>
>> From: Atousa Pahlevan Duprat <apahlevan@ieee.org>
>
> Minor comments inline
>>
>> diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
>> index b864df6..d085412 100644
>> --- a/block-sha1/sha1.h
>> +++ b/block-sha1/sha1.h
>> @@ -18,5 +18,5 @@ void blk_SHA1_Final(unsigned char hashout[20],
>> blk_SHA_CTX *ctx);
>>     #define git_SHA_CTX blk_SHA_CTX
>>   #define git_SHA1_Init blk_SHA1_Init
>> -#define git_SHA1_Update        blk_SHA1_Update
>> +#define platform_SHA1_Update   blk_SHA1_Update
>>   #define git_SHA1_Final        blk_SHA1_Final
>> diff --git a/cache.h b/cache.h
>> index 79066e5..a501652 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -10,12 +10,21 @@
>>   #include "trace.h"
>>   #include "string-list.h"
>>   +// platform's underlying implementation of SHA1
>
> Please use /* */ for comments
>
>>   #include SHA1_HEADER
>>   #ifndef git_SHA_CTX
>> -#define git_SHA_CTX    SHA_CTX
>> -#define git_SHA1_Init  SHA1_Init
>> -#define git_SHA1_Update        SHA1_Update
>> -#define git_SHA1_Final SHA1_Final
>> +#define git_SHA_CTX            SHA_CTX
>> +#define git_SHA1_Init          SHA1_Init
>> +#define platform_SHA1_Update   SHA1_Update
>> +#define git_SHA1_Final         SHA1_Final
>> +#endif
>> +
>> +// choose whether chunked implementation or not
>> +#ifdef SHA1_MAX_BLOCK_SIZE
>> +int git_SHA1_Update_Chunked(SHA_CTX *c, const void *data, size_t le=
n);
>> +#define git_SHA1_Update       git_SHA1_Update_Chunked
>> +#else
>> +#define git_SHA1_Update       platform_SHA1_Update
>>   #endif
>>     #include <zlib.h>
>> diff --git a/compat/apple-common-crypto.h b/compat/apple-common-cryp=
to.h
>> index c8b9b0e..d3fb264 100644
>> --- a/compat/apple-common-crypto.h
>> +++ b/compat/apple-common-crypto.h
>> @@ -16,6 +16,10 @@
>>   #undef TYPE_BOOL
>>   #endif
>>   +#ifndef SHA1_MAX_BLOCK_SIZE
>> +#error Using Apple Common Crypto library requires setting
>> SHA1_MAX_BLOCK_SIZE
>> +#endif
>> +
>>   #ifdef APPLE_LION_OR_NEWER
>>   #define git_CC_error_check(pattern, err) \
>>         do { \
>> diff --git a/compat/sha1_chunked.c b/compat/sha1_chunked.c
>> new file mode 100644
>> index 0000000..61f67de
>> --- /dev/null
>> +++ b/compat/sha1_chunked.c
>> @@ -0,0 +1,19 @@
>> +#include "cache.h"
>> +
>> +int git_SHA1_Update_Chunked(SHA_CTX *c, const void *data, size_t le=
n)
>> +{
>> +       size_t nr;
>> +       size_t total =3D 0;
>> +       const char *cdata =3D (const char*)data;
>> +
>> +       while (len > 0) {
>
> size_t is unsigned, isn't it ?
> Better to use  "while (len) {"
>
>> +               nr =3D len;
>> +               if (nr > SHA1_MAX_BLOCK_SIZE)
>> +                       nr =3D SHA1_MAX_BLOCK_SIZE;
>> +               platform_SHA1_Update(c, cdata, nr);
>> +               total +=3D nr;
>> +               cdata +=3D nr;
>> +               len -=3D nr;
>> +       }
>> +       return total;
>> +}
>
>



--=20
Atousa Pahlevan, PhD
M.Math. University of Waterloo, Canada
Ph.D. Department of Computer Science, University of Victoria, Canada
Voice: 415-341-6206
Email: apahlevan@ieee.org
Website: www.apahlevan.org
