Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92720C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 18:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BB3207FF
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 18:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="M0L/j/z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgBIS2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 13:28:39 -0500
Received: from mout.web.de ([212.227.15.14]:52273 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgBIS2j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 13:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581272913;
        bh=3ZE34+sO/uvcLc4GgmFFGrUmWVgYeINUJQaTyWCqYZ0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M0L/j/z9XWVHEoUDP9AuB4XNsoYxfMlF6v2ZnP7BtPjwSsvi+Ey4rL+O6x4yNBAZz
         /OFGXSxA/iadhtqoIEfyI/LKGFZq5QsrdhQDOmLdAr2oLxayMs2KXgZMMd3L3/Wtf9
         392dtCLnPaO8V99zH9CIW69rcByFZv81m842qLOc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCZTG-1jAEzK4C0I-009SdI; Sun, 09
 Feb 2020 19:28:33 +0100
Subject: Re: [PATCH v2] strbuf: add and use strbuf_insertstr()
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
 <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
 <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <60b491a1-2b71-d5a5-398f-e6743e2c617a@web.de>
Date:   Sun, 9 Feb 2020 19:28:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9jpty5IuuzJwhkqUw5b4z/AOvaJTCAq1iVWmIA9rNeataKUffR+
 8TwWQWK8mhSmaIcsXaT9y9trpnb5Wnkn4mqJDHSrQ9OT4sHmcIkXD1q3F2GFqVA3rgmLP5i
 Deor8JNydOeh5/OQahwKoDzX+0LnYUhaL2QlfGpHSEJTzNHhB51UNBVpqByaWFGmY5SSMIu
 jWOif+uhqjo7Eg7pVCPpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kqgWLyy91XA=:hfzkUmvJsnVgK5Q7wF52IN
 egk/naYzu4zzR2U1SgZVndUy6RmF7lYlB7rvsBDkmKkKR7s8utV6K8iAqHTB2aZXCO+MbTk67
 JAmeUcX8S4VGMxceMqyxcNE2AxNpS0Nm+ZjtInwNEm1nZETC26usrMO5G/+pkvkmCUetPz3uc
 Fi7P1Y6cbGbYTcY2pUqLCXmQyLbFMqyrlGaVHk8sAubx/BqgB2qAOwCOGm7y40su5NDOEpt4P
 GMVSGEsSpQQjZuw7jltb/KnSgzXyFO0LjKTbPiFhnHJnTWFe3J/b+s0vVikiRAzlD57zXIYso
 ZIEKB6N3JQhlAWjC63EB2YfRtI5/l3HEWzFDKrCrcQaEgeX0lE7QKqDXcLoz2xJW5Q1JcRJkn
 B1kdHfOc0z7dl9SLHBHKPjd26y1OpRGbQD6IMeRJ4LPfBZBzazuMSb1/SN0Tm96U9PfAIfVal
 etWLzDsOuahU0WKyX9rcohKGoq312LiO756wSIDEUeeETK+INvJi/ZJfTxe5LEFexYV1snj8r
 eG7NYrXNSFjCphFhdmqlqFiT3TOk6SMbWFd0fcgZH4VpmCWibm2kxtl+jQICfKlZys+XY0F2s
 HkVe59toOrqn7jw5yaEv290Ncoc8Q2NdRaRmrABP5ebdZQcK3RIOfqeARj9H4cMjK/ZVAmqUV
 7hojrLsTyGylZH2fOI7z7zEnN6KOCuebZT6OOKtno1pmAUjO3FYs4NZFYjMTMInG35c33HdAV
 /EaPoorlWNwzkgnWQvf+XuEcFvSHdf/i/8+7LcHvngJwYANNLHCIdPnDwMXytt7iLL/JadZs/
 xyDYUOTbfAWI/lONhGxTj6oXa5mbE+Ia0cIwHCq6mnPsG2n4VgJ2eRtvrgXbGqzi1VQ6wpfXh
 Hkm8Sdgyq3xgfpb7mxEyuXBD5do7Yc/4DrVinpY3zJIb6mqYJvENmQ0A1radwxIdyVxs3u/SA
 /iCz37aOrJGvRknPtUqNQGcaskFVmQrimVMtup0jyjcoCjX2peneXKF1zPgkOtmDyw+j6qOaR
 l4Z64/W2eTRmdxYmXX8mCNZU80hojX+Z35UGfn4Ql3p6P5sSrOX/kF4mUg3aSHk19qDaBU/xP
 sV6cvs+k4ggJZ6u99z/G1a5hcqzJ2QJCSWkzqUHx1x7HqKF941Nht1NGq0BKUEGAz3Ya5M5c2
 bvbPVyRodk5l0Ou0ojNm4kNwi64uY1Q2rRWa5CRKqyNP1CiqiTHXMvQPIk8p249/9JXGzX67A
 PsNhnyEic0Hskl8Pw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.20 um 18:36 schrieb Eric Sunshine:
> On Sun, Feb 9, 2020 at 8:45 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> Add a function for inserting a C string into a strbuf.  Use it
>> throughout the source to get rid of magic string length constants and
>> explicit strlen() calls.
>>
>> Like strbuf_addstr(), implement it as an inline function to avoid the
>> implicit strlen() calls to cause runtime overhead.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> diff --git a/mailinfo.c b/mailinfo.c
>> @@ -570,7 +570,7 @@ static int check_header(struct mailinfo *mi,
>>                 len =3D strlen("Content-Type: ");
>>                 strbuf_add(&sb, line->buf + len, line->len - len);
>>                 decode_header(mi, &sb);
>> -               strbuf_insert(&sb, 0, "Content-Type: ", len);
>> +               strbuf_insertstr(&sb, 0, "Content-Type: ");
>>                 handle_content_type(mi, &sb);
>
> Meh. We've already computed the length of "Content-Type: " a few lines
> earlier, so taking advantage of that value when inserting the string
> literal is perfectly sensible.

Well, yes, but it would be more sensible if we'd have only a single
string here.  At the source code level we have two string constants that
happen to have the same contents.  Handling them separately is
reasonable, I think.

The compiler is merging those two, and resolves the other strlen() call
at compile time, so the generated code is the same.

> Thus, I'm not convinced that this change is an improvement.

The improvement is to untangle the handling of those two string
constants and to use a C string without having to pass along its
length.  That doesn't make the code clean, yet, admittedly.

> Digging deeper, though, I have to wonder why this bothers inserting
> "Content-Type: " at all. None of the other cases handled by
> check_header() bother re-inserting the header, so why this one? I
> thought it might be because handle_content_type() depends upon the
> header being present, but from my reading, this does not appear to be
> the case. handle_content_type() calls has_attr_value() and
> slurp_attr() to examine the incoming line, but neither of those seem
> to expect any sort of "<Header>: " either. Thus, it appears that the
> insertion of "Content-Type: " is superfluous. If this is indeed the
> case, then rather than converting this to strbuf_insertstr(), I could
> see it being pulled out into a separate patch which merely removes the
> strbuf_insert() call.

Interesting.  It makes sense that handle_content_type() wouldn't need
such a header prefix -- it's only called if its existence in the line
has been confirmed.  And I also don't see a hint in the code that
would justify the insertion.

Do you care to send a follow-up patch (or one against master if you're
not convinced by my reasoning given above)?

Thanks,
Ren=C3=A9
