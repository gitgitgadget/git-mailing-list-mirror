From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv3] transport: Catch non positive --depth option value
Date: Fri, 22 Nov 2013 08:18:44 +0700
Message-ID: <CACsJy8B0qBmBkx0n2B=ivUqZTgVz-ZLhTQ_nVJ4AV0njnZksfw@mail.gmail.com>
References: <5283A380.9030308@gmail.com> <xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>
 <528A9877.4060802@gmail.com> <xmqq61ro9utf.fsf@gitster.dls.corp.google.com>
 <528E2660.6020107@gmail.com> <xmqq1u294ih3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Andr=C3=A9s_G=2E_Aragoneses?= <knocte@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 02:19:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjfOx-0007i0-V8
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 02:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170Ab3KVBTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 20:19:16 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:59461 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab3KVBTP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 20:19:15 -0500
Received: by mail-qc0-f178.google.com with SMTP id i17so96934qcy.37
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 17:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EjUrIxJPmv0PSA8GNE7Fy3qsRzUFExxajNBbGAY67SI=;
        b=u2sNLMsYPkaaMCoFdmmmW/8/kXKEAj8PPZBhjftkPqtRhvFTIYcq2+V4+NqPXx5nun
         cFK6+/62scg7HoAXNJ3aYfRgYMO6T4gVidErXiWbcmzeeCXjENr2ftmYsnKhnIrJkYVW
         urbWwjomphcExwJZR5G7UjLBBQZyIKS1GzZk2n6e/q62t23RT/cOanwUFdqXDs024ad6
         UYOf8HCZAF+DSLWgnhP/UgtBpZnAIhfdPixjEh0BZp5xwZ0V/G+IP4tMtREBiCqP+i6v
         kv5L8Q9Sfa8usV/7vqENBo2sFT91LRUYQaoCrkBSBgB+3hf1oxbEKzdxwjf9FV/S91+F
         B6dA==
X-Received: by 10.49.1.230 with SMTP id 6mr16999456qep.48.1385083154851; Thu,
 21 Nov 2013 17:19:14 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Thu, 21 Nov 2013 17:18:44 -0800 (PST)
In-Reply-To: <xmqq1u294ih3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238169>

On Fri, Nov 22, 2013 at 3:18 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "Andr=C3=A9s G. Aragoneses" <knocte@gmail.com> writes:
>
>> From 99e387151594572dc136bf1fae45593ee710e817 Mon Sep 17 00:00:00 20=
01
>> From: =3D?UTF-8?q?Andr=3DC3=3DA9s=3D20G=3D2E=3D20Aragoneses?=3D <kno=
cte@gmail.com>
>> Date: Wed, 13 Nov 2013 16:55:08 +0100
>> Subject: [PATCH] transport: Catch non positive --depth option value
>>
>> Instead of simply ignoring the value passed to --depth
>> option when it is zero or negative, now it is caught
>> and reported.
>>
>> This will let people know that they were using the
>> option incorrectly (as depth<0 should be simply invalid,
>> and under the hood depth=3D=3D0 didn't have any effect).
>>
>> Signed-off-by: Andres G. Aragoneses <knocte@gmail.com>
>> Reviewed-by: Duy Nguyen <pclouds@gmail.com>
>> Reviewed-by: Junio C Hamano <gitster@pobox.com>
>
> I didn't exactly "review" this.
>
> Have you run the tests with this patch?  It seems that it breaks
> quite a lot of them, including t5500, t5503, t5510, among others.

I guess it's caused by builtin/fetch.c:backfill_tags(). And the call
could be replaced with

transport_set_option(transport, TRANS_OPT_DEPTH, NULL);

>
>> ---
>>  transport.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/transport.c b/transport.c
>> index 7202b77..edd63eb 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -483,6 +483,8 @@ static int set_git_option(struct git_transport_o=
ptions *opts,
>>                       opts->depth =3D strtol(value, &end, 0);
>>                       if (*end)
>>                               die("transport: invalid depth option '=
%s'", value);
>> +                     if (opts->depth < 1)
>> +                             die("transport: invalid depth option '=
%s' (must be positive)", value);
>>               }
>>               return 0;
>>       }
>



--=20
Duy
