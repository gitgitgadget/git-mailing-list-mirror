Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05834C3B187
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89C72082F
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dJ2fhOVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgBKQSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:18:32 -0500
Received: from mout.web.de ([212.227.17.11]:52947 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgBKQSc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 11:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581437903;
        bh=xO+saUCaAas4ylA1OVG0atsLGZk4fZpZtZZg8Rxm6T4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dJ2fhOVRJQXR5iHh3nXYjMgB/yFE6TomPvoA7GMzjMSdZUB8I3NKaJTCRWa4B7TUF
         zgdYbiZt/nKEZl7jsefU4qflJoADw3T8HxN6igonKfhNVgGfElkxNzw0YI83dKDoUm
         uOb4bXTlIfegmf4mrDP0mmQkTTC5bUayBUbIBxbw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEa4-1jGyaV29k0-00FVNb; Tue, 11
 Feb 2020 17:18:23 +0100
Subject: Re: [PATCH v2] strbuf: add and use strbuf_insertstr()
To:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
 <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
 <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com>
 <20200210234427.GA632160@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a5622196-1978-2fe5-144f-99edc5516dd6@web.de>
Date:   Tue, 11 Feb 2020 17:18:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210234427.GA632160@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:91KTgOdxrdgDkCnmkLgREHL8yrAbMZ7S3On8TKciBcKUk1rXhAh
 A/bSUwygPz37VP3xXIfyUAgWAc0ETrpGEGU4s3G6f0FqFKRYg2Hdnkl7do1MJ5rgo8oz0sZ
 a2kprKI/catUOQvF5pEbA+5TNjyXYmLep3jdvwybooyXZ/fmM98XhH4Liw7F/KR8SpyDWom
 U/eOyDXyGICWmhEqJ4I3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NEyMzrvk2Ac=:PKcHh2a3eTmq0HmsWHw8oZ
 zwD2Rv09DILmmD+fk60/rNPW8u2N+jLq4s9nb2HcywVPIM1WUFRfLl6TlKY7W0Ue0thhKtauI
 yVcDaSGyq3IWJs0TuNjL6h5UtpPSdTmydyo4H+wrb9PC480m8JekHIshIfrWY6W8aO/vbOBH8
 6wE1ywaFanLOXPMPw8srgSVNjpJ+rATyshhMxmH8FdCAKGKjEvihmGTwNF1hIolruuyf+/NVS
 gqzgFTt4F83V1gjvUHRyXrm4uG8fjKxhw66nWaYugTD3L0wcY6zQnv6cG1NObcLlxY2YMILHZ
 zcz8DysCoWE0GPLqIVbXUqIM/OKFzE4kRgPbpBCC9H4hFU3gyASLfHP8WcHnv/uYLfuo4Ydrr
 YAAOcRvIYlUhvlWPTjZ24dedw757VLP7NVwHbbC1sSCDzUImm2TzJPnFxOv9ejeS4jsqfpkHu
 bCmKXVlfOrvqUo2iMjrcQD+QPGPEDftg+Dor0nRCsHXC62Qx04133GNiJCNZ9zwhZFtmD2KZH
 npbhfWr6uohMrr+1rdAaBRiB0l6icFe1FHGLxbYxfr/kBFm5UiUieisOLrDcsvLywx7nU/W1w
 xIyAgqPp2A2QWGhTj2BfWfMr1jMt11dsuParXvOAElR3eyTQpjzSy4NhfU9YV1cPV6ugJNdiB
 VoaO0BpsxZRigl3AWQ3mmfkwI4bhotltC73r7OpakJSPshZOK3+A4OGiE5vTjELjlvgxGhAEw
 drn3Fyhizl0SXQv8jMX0TJ80Pm9qe9seTYuLY0igpkb53Nu8Ac3JT7/2FEUr62ahhqYTblFYl
 3eTnxUfOZOdTi1RhNt/nAvIoMY7o0Wr3X+N6KckgkK7ZsGok9Uao+kxP0Mo6dqvDjOaoGPyuT
 Lt1rt8/jeKd59yEUyvLo4yqYlajsxFCIktTLJBQFdao9/P7OAzWCreSa+r0DJLGma4Mf8kg2O
 P9kUECpAG9U+BtElBlY460Y35q1jgTfz242j/BZRO+X4oqcDA09j4LMFKDnWfKp4brxFLVqLb
 6U08tov9riueNoRVyPSI9lp9mGV2gDzr3MdaT5Y+gyaHxbky2aR9fThq71wBpoCWekPV9U+5g
 BpA7gqoYxN+WJd6F/ST1jVjCdv3dMGnfA6FTxTwiY1NIOCGeI4z2cFV+wr4/FG2DLlV1W0mqt
 weKtuFGn/8J0ypM2wo9WMBa/c5621BNsScUpZMUSEkVBRwuORqepNwAuhmLcbhQH5DqG68+mp
 VYowL08q6Qf3NDYmu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.02.20 um 00:44 schrieb Jeff King:
> On Sun, Feb 09, 2020 at 12:36:22PM -0500, Eric Sunshine wrote:
>
>> On Sun, Feb 9, 2020 at 8:45 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>> Add a function for inserting a C string into a strbuf.  Use it
>>> throughout the source to get rid of magic string length constants and
>>> explicit strlen() calls.
>>>
>>> Like strbuf_addstr(), implement it as an inline function to avoid the
>>> implicit strlen() calls to cause runtime overhead.
>>>
>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>> ---
>>> diff --git a/mailinfo.c b/mailinfo.c
>>> @@ -570,7 +570,7 @@ static int check_header(struct mailinfo *mi,
>>>                 len =3D strlen("Content-Type: ");
>>>                 strbuf_add(&sb, line->buf + len, line->len - len);
>>>                 decode_header(mi, &sb);
>>> -               strbuf_insert(&sb, 0, "Content-Type: ", len);
>>> +               strbuf_insertstr(&sb, 0, "Content-Type: ");
>>>                 handle_content_type(mi, &sb);
>>
>> Meh. We've already computed the length of "Content-Type: " a few lines
>> earlier, so taking advantage of that value when inserting the string
>> literal is perfectly sensible. Thus, I'm not convinced that this
>> change is an improvement.
>
> I had a similar thought. I kind of wonder if all of these "len" bits
> (and their repeated strings) could go away if cmp_header() just used
> skip_iprefix() under the hood and had a pointer out-parameter.
>
> Something like the (largely untested) patch below. That would also make
> it easy to support arbitrary amounts of whitespace after the header,
> which I think are allowed by the standard (whereas now we'd parse
> "Content-type:    text/plain" as "    text/plain", which is silly).
>
> Worth doing?

Sure.

> ---
> diff --git a/mailinfo.c b/mailinfo.c
> index b395adbdf2..bbb5b429f8 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -346,11 +346,16 @@ static const char *header[MAX_HDR_PARSED] =3D {
>  	"From","Subject","Date",
>  };
>
> -static inline int cmp_header(const struct strbuf *line, const char *hdr=
)
> +static inline int cmp_header(const struct strbuf *line, const char *hdr=
,
> +			     const char **outval)
>  {
> -	int len =3D strlen(hdr);
> -	return !strncasecmp(line->buf, hdr, len) && line->len > len &&
> -			line->buf[len] =3D=3D ':' && isspace(line->buf[len + 1]);
> +	const char *val;
> +	if (!skip_iprefix(line->buf, hdr, &val) ||
> +	    *val++ !=3D ':' ||
> +	    !isspace(*val++))
> +		return 0;
> +	*outval =3D val;
> +	return 1;
>  }

And you could rename it to skip_header() to fix the issue that its name
starts with cmp but its return value is the inverse of a cmp-style
function.

And it could take a char pointer instead of a strbuf, to reduce its
dependencies and make it more widely useful -- but that might also be
a case of YAGNI.

>
>  static int is_format_patch_separator(const char *line, int len)
> @@ -547,17 +552,17 @@ static int check_header(struct mailinfo *mi,
>  			const struct strbuf *line,
>  			struct strbuf *hdr_data[], int overwrite)
>  {
> -	int i, ret =3D 0, len;
> +	int i, ret =3D 0;
>  	struct strbuf sb =3D STRBUF_INIT;
> +	const char *val;
>
>  	/* search for the interesting parts */
>  	for (i =3D 0; header[i]; i++) {
> -		int len =3D strlen(header[i]);
> -		if ((!hdr_data[i] || overwrite) && cmp_header(line, header[i])) {
> +		if ((!hdr_data[i] || overwrite) && cmp_header(line, header[i], &val))=
 {
>  			/* Unwrap inline B and Q encoding, and optionally
>  			 * normalize the meta information to utf8.
>  			 */
> -			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
> +			strbuf_addstr(&sb, val);

That assumes the header value never contains NULs.  Valid?

>  			decode_header(mi, &sb);
>  			handle_header(&hdr_data[i], &sb);
>  			ret =3D 1;
> @@ -566,26 +571,22 @@ static int check_header(struct mailinfo *mi,
>  	}
>
>  	/* Content stuff */
> -	if (cmp_header(line, "Content-Type")) {
> -		len =3D strlen("Content-Type: ");
> -		strbuf_add(&sb, line->buf + len, line->len - len);
> +	if (cmp_header(line, "Content-Type", &val)) {
> +		strbuf_addstr(&sb, val);
>  		decode_header(mi, &sb);
> -		strbuf_insert(&sb, 0, "Content-Type: ", len);
>  		handle_content_type(mi, &sb);
>  		ret =3D 1;
>  		goto check_header_out;
>  	}
> -	if (cmp_header(line, "Content-Transfer-Encoding")) {
> -		len =3D strlen("Content-Transfer-Encoding: ");
> -		strbuf_add(&sb, line->buf + len, line->len - len);
> +	if (cmp_header(line, "Content-Transfer-Encoding", &val)) {
> +		strbuf_addstr(&sb, val);
>  		decode_header(mi, &sb);
>  		handle_content_transfer_encoding(mi, &sb);
>  		ret =3D 1;
>  		goto check_header_out;
>  	}
> -	if (cmp_header(line, "Message-Id")) {
> -		len =3D strlen("Message-Id: ");
> -		strbuf_add(&sb, line->buf + len, line->len - len);
> +	if (cmp_header(line, "Message-Id", &val)) {
> +		strbuf_addstr(&sb, val);
>  		decode_header(mi, &sb);
>  		if (mi->add_message_id)
>  			mi->message_id =3D strbuf_detach(&sb, NULL);

The repeated sequence cmp_header()+strbuf_add{,str}()+decode_header()
makes me itchy.

> @@ -607,8 +608,9 @@ static int is_inbody_header(const struct mailinfo *m=
i,
>  			    const struct strbuf *line)
>  {
>  	int i;
> +	const char *val;
>  	for (i =3D 0; header[i]; i++)
> -		if (!mi->s_hdr_data[i] && cmp_header(line, header[i]))
> +		if (!mi->s_hdr_data[i] && cmp_header(line, header[i], &val))
>  			return 1;
>  	return 0;
>  }
>

