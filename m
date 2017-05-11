Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEEC201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756771AbdEKUWZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:22:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35419 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754823AbdEKUWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:22:25 -0400
Received: by mail-it0-f68.google.com with SMTP id 67so4193019itx.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RGzIcpTLYM23V3xznk1zIoEIcQGryFGlF/ndujAS0BY=;
        b=uNE5EfGEe6JBc5WOcVTMbijxDpW2kzYcMlmyY7l3AoEzxRAS2CaXY3SsnF195fC19u
         Skf2O8BAnhzklaXzgL2sDsfHPky8BXvNJTNb7s7aBd8s+akFacqrqA4huclnht+0klRF
         KsA7tKUBXw2L2ukFkTQ/Zr1N5dYRLBuoOc0F9VdrHUSvt2zSuo8BFUOsUUArBsAKDXFU
         A2U2y9EzoA5C7NSv1W/EKRusLfR0qex9gRn8iP9XWaPYSEMrGT6ApLNz2TGX22QAVYTY
         aS5xP3vQfi5I0d2QRzGPK1Vs8a6/L67dh+PIQHBLBRL/9uMnIfOI+zWURD2nGUMCvs67
         rx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RGzIcpTLYM23V3xznk1zIoEIcQGryFGlF/ndujAS0BY=;
        b=a+t0JSjxCe2fIV1vpF8M/h5yH0vlQxEOtYR1UPfHv6lGA8MO/LMAiqTrZUp5C6dT2U
         ANEyn5Pvz+9suQpMXhdPmRUB29hfoF2lfq3EB2At+2Qw883A/10CcWwo6LRZcIkLFQlr
         IGRaNkDcf+AemS0lfOLpzVIpDjSnvdksOBh3DfGHAmb2pxUAkvfcXwM68y+7HVpdpGTl
         HBAiF0A8U62HloMX+sD3nmjMjDzKq+f9MG9zlFMQKpYtZJKfjkXgPZZG0lzYW7sbpnEC
         fAgY67/zmwkk83M+oZZ2glV5RHC6E4HhWo9Yh5kY1zscIlmXZNJdIupienQQE2DmqOdB
         tfbQ==
X-Gm-Message-State: AODbwcBF/krtDU7mAJEPFuiWsQ1W7O69HOYyasW3lVjcyDGSllMQTP7y
        0MacY305DaFsJ2YffmuMqONpgZWUbg==
X-Received: by 10.36.89.207 with SMTP id p198mr667341itb.71.1494534144242;
 Thu, 11 May 2017 13:22:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 13:22:03 -0700 (PDT)
In-Reply-To: <20170511201517.GI83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-22-avarab@gmail.com>
 <20170511201517.GI83655@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 22:22:03 +0200
Message-ID: <CACBZZX5tQKae=+fz-eofz+GwLt9mjtd26HrSt3zvjQGf++ve8w@mail.gmail.com>
Subject: Re: [PATCH 21/29] grep: factor test for \0 in grep patterns into a function
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:15 PM, Brandon Williams <bmwill@google.com> wrot=
e:
> On 05/11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Factor the test for \0 in grep patterns into a function. Since commit
>> 9eceddeec6 ("Use kwset in grep", 2011-08-21) any pattern containing a
>> \0 is considered fixed as regcomp() can't handle it.
>>
>> This limitation was never documented, and other some regular
>> expression engines are capable of compiling a pattern containing a
>> \0. Factoring this out makes a subsequent change which does that
>> smaller.
>>
>> See a previous commit in this series ("grep: add tests to fix blind
>> spots with \0 patterns", 2017-04-21) for further details & rationale.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  grep.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/grep.c b/grep.c
>> index bf6c2494fd..27de615209 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -394,12 +394,6 @@ static int is_fixed(const char *s, size_t len)
>>  {
>>       size_t i;
>>
>> -     /* regcomp cannot accept patterns with NULs so we
>> -      * consider any pattern containing a NUL fixed.
>> -      */
>> -     if (memchr(s, 0, len))
>> -             return 1;
>> -
>>       for (i =3D 0; i < len; i++) {
>>               if (is_regex_special(s[i]))
>>                       return 0;
>> @@ -408,6 +402,17 @@ static int is_fixed(const char *s, size_t len)
>>       return 1;
>>  }
>>
>> +static int has_null(const char *s, size_t len)
>> +{
>> +     /* regcomp cannot accept patterns with NULs so when using it
>> +      * we consider any pattern containing a NUL fixed.
>> +      */
>
> I commented on a later patch but really the comment should be fixed
> here.  And why not simply move this to where you intend it to be at the
> end of the series now?

Just losing the forest for the trees in rebasing this giant, willdo in
v2, i.e. just make this a function in the right place in this change.

>> +     if (memchr(s, 0, len))
>> +             return 1;
>> +
>> +     return 0;
>> +}
>> +
>>  static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *o=
pt)
>>  {
>>       struct strbuf sb =3D STRBUF_INIT;
>> @@ -451,7 +456,7 @@ static void compile_regexp(struct grep_pat *p, struc=
t grep_opt *opt)
>>        * simple string match using kws.  p->fixed tells us if we
>>        * want to use kws.
>>        */
>> -     if (opt->fixed || is_fixed(p->pattern, p->patternlen))
>> +     if (opt->fixed || has_null(p->pattern, p->patternlen) || is_fixed(=
p->pattern, p->patternlen))
>>               p->fixed =3D !icase || ascii_only;
>>       else
>>               p->fixed =3D 0;
>> --
>> 2.11.0
>>
>
> --
> Brandon Williams
