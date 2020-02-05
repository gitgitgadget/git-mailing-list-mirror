Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C3C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 15:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1D020659
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 15:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="loO7C+hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgBEPWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:22:24 -0500
Received: from mout.web.de ([212.227.17.11]:50727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgBEPWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 10:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580916142;
        bh=eajZuzWAq1kYIRhM2JEmjvSTlrc2EUWRQWVdPRITnZM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=loO7C+hOFWB+ZdGVgAvNoXA2Xvq94TnRv61o9yQftzUcB7ZozUqAqczkfUSfep1CJ
         fHGi7bA+XYx1D9g/mYJdc/HSVfKeANy9DR+1MHbaj6UbRLCSj/cxq7x/Emy1tq+/BQ
         uy19+dx1K2BT/cAhOT4vZrvJ1rxDAvUit9Tum/VA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dTd-1jrK5h00iT-00sJar; Wed, 05
 Feb 2020 16:17:16 +0100
Subject: Re: [PATCH 08/10] name-rev: pre-size buffer in get_parent_name()
To:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <c7f22d8d-10f8-0c97-672e-0a50182901e0@web.de>
 <9b98835d-d94c-19f5-42ba-d583a33306cc@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ea3910e1-f1cb-8a3c-0e32-5c33eeeb8af6@web.de>
Date:   Wed, 5 Feb 2020 16:16:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9b98835d-d94c-19f5-42ba-d583a33306cc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rZlon1r/TltJjJsxtJYBZdDhlrHNqIEY0zYyQZYVgRTU+1YWiJR
 g407TSBDfpA47d01m75Jx5QM0I756P5NU2fVEBgg+CXRqkKhoqNEewN4+olPFo2hR10tmCE
 shcADuYGou/NOgWb5z3ROPVa9IYMJF4042s+pOypumzUyPMXWWYLJWudmNIOrpLdLSeoE2G
 hY1xibN7ZVXVbx22oLjZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GkDgIt7f+zY=:DC3VS9b2nf/B/UjThgz5e0
 YLEdB3lycHMoTSWNDWvRHoFbKJ3hPHVDWUqmHG41w4YeG5aN+sbQ2lcMx/JINZrX3NkDPz7Mp
 2+V+Z6F5iq738QfTL7KtF7njRLT775B1Xr8dUtgaa/YKyI7sqm2X7Y8fHUQ9Z/Afudwd9+9PO
 F8T3sYN9dZbfJdZeiQAC2e+EKRJKtgDubKfP7Jf8wV/QgF7ZKnLjqNcdu32+G3Hg06VuEvT0h
 VKDLYcwOivCgG+pM5G59fAx1CcXmKSw68WV41fmSqnM34UKZQObQvKI7NR/pF6NjOG3XeyzX3
 CDkpf1lPG96t8PtZgqXhighnii458+yOKKmbvKfq2NHj1Iv/5Lxi/5YHUNArtaV2QCfKTIUhO
 O7LPMreMM/lOQgmPP+tSO55QDeiIbWFjsE1fh6+D67GCcIvlrgEjHug4EDgiN0d5cODLCu4vs
 GN0jbW5cnE+QFoqukyZOIuscQWfEbtyiaBuS07kV7r+nsEC261d2PU93zc16DAFyC43b90nSX
 qYU8cZx0lYBy+LtYrfmZLdGDXOtLaDcWW478bFZavJQJWoDpviOPMJEq4+vE6lFSgeKbostOw
 dSEGJTi9FKyP/Zk8Ibwj6XSBOhTNqogMQePDMy0y9Sqfv+xWFMl8QGNOszXkLvB0E095+/+PJ
 Fh973Jr4FCsbQXk+uIj07MP5p9oYeW9rM+9CByova5QtbIc/tYr9YYmtNkIkqqG5eBzXexOZA
 x6iE7AThj1P8iFS0hUnww2zFqSx24GlJg0oUjFgNpaUCviHXuY/+zdEH9SMfqO0uCEwNNycAG
 iw61OImlDgIFQUWYse5yKC8mwt6YDZPbL6qCRlbmJmDDszCVhj7+HOKBu1CHV5m8RcLW1nYXE
 MwKHxeH04S517r3dkiDFaO4oFL4R5z1VI2Wz20G0DPVGQbbGK6C3KeLbn8wegxd8jq3fohKbh
 M+kbIb9iFPCMsyWmBY6NYMK/xhl9tMAlT2Wxjj52Nx8Vrb7T8hIWaFdWcSjCU2UsZzR5LWfrL
 X2xtvyPUCKOpskUlW5vM/p14zdSxOstrmqAMj72qjInbpVbbul7aX9hgs1pNO9ksNzzDvQu9X
 j7b8aTZ2wJYVTwqv4EWq2vuZKVyZ1iSQC+EGOMZXncu3rvcA4YTSlFFbTZqxuf9WM2Xa4GxoS
 XicJATnEcHglQUWAG5qSKRUTL78GFLG1LP+H+QQTL8Iy1mUEcIV468RlS4YtaEZt1OSWxcedr
 U9wwCHeZ74xNfwXAq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.02.20 um 04:19 schrieb Derrick Stolee:
> On 2/4/2020 4:24 PM, Ren=C3=A9 Scharfe wrote:
>> We can calculate the size of new name easily and precisely. Open-code
>> the xstrfmt() calls and grow the buffers as needed before filling them.
>> This provides a surprisingly large benefit when working with the
>> Chromium repository; here are the numbers measured using hyperfine
>> before:
>>
>> Benchmark #1: ./git -C ../chromium/src name-rev --all
>>   Time (mean =C2=B1 =CF=83):      5.822 s =C2=B1  0.013 s    [User: 5.3=
04 s, System: 0.516 s]
>>   Range (min =E2=80=A6 max):    5.803 s =E2=80=A6  5.837 s    10 runs
>>
>> ... and with this patch:
>>
>> Benchmark #1: ./git -C ../chromium/src name-rev --all
>>   Time (mean =C2=B1 =CF=83):      1.527 s =C2=B1  0.003 s    [User: 1.0=
15 s, System: 0.511 s]
>>   Range (min =E2=80=A6 max):    1.524 s =E2=80=A6  1.535 s    10 runs
>
> Nice!
>
>> +	if (name->generation > 0) {
>> +		strbuf_grow(&sb, len +
>> +			    1 + decimal_width(name->generation) +
>> +			    1 + decimal_width(parent_number));
>
> Just curious: these strbuf_grow() calls are what _really_ improve the
> performance, right? If you dropped them, then can we expect the performa=
nce
> to be similar to the old code?

The replaced xstrfmt() is defined in strbuf.c and trivially wraps
xstrvfmt(), which in turn does:

	struct strbuf buf =3D STRBUF_INIT;
	strbuf_vaddf(&buf, fmt, ap);
	return strbuf_detach(&buf, NULL);

And strbuf_addf() trivially wraps strbuf_vaddf().  So indeed, all
I did was to inline xstrfmt() and add the strbuf_grow() calls.

Their high impact shocked me a bit.  vsnprintf(3) really doesn't seem
to like working with a buffer that is too small (when it's supposed to
just calculate how many bytes it would have needed), at least not in
the one from glibc 2.29.

>> +		strbuf_addf(&sb, "%.*s~%d^%d", (int)len, name->tip_name,
>> +			    name->generation, parent_number);
>> +	} else {
>> +		strbuf_grow(&sb, len +
>> +			    1 + decimal_width(parent_number));
>> +		strbuf_addf(&sb, "%.*s^%d", (int)len, name->tip_name,
>> +			    parent_number);
>> +	}
>> +	return strbuf_detach(&sb, NULL);
>>  }
>>
>>  static void name_rev(struct commit *start_commit,
>> --
>> 2.25.0
>>
>
