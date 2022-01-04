Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538EFC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 15:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiADPM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 10:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiADPM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 10:12:26 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3455C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 07:12:25 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id kc16so34665194qvb.3
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CGA3qcm3fCHmpt2BRRXHVLbLdWdlggkd7p+YZxtH638=;
        b=XhNBCO9tivcxijB1xMs6tYCFOzzlDbxRw2TrAHtfo2UgRwJFhHgQbvRWu3kNUcW6Ny
         OK/qux6f5IztH2ulU4Ft2838Sr7Q5lgQ/2Vq2MQp0qlqXpQT2A4htFtgmlpQX6SHbdan
         N3GGFFmNwAhgrQJSU/7NntF7yjRtL6hAgk3TCt7Rk3CgDQGZT6ratmq3kIlGS7ZGGLZM
         X+jaELOX5JlDBDsksa+0qQoRzbBitScJ/SFPZ7a7jJXfeTkUKzNW3WSlxWMv2LQ2PzD/
         0X1cvlb3q48fCeWsn9hmUhkDwPUT+8rz/EXDx6GjwxmARMpST4i9vGYW+rd51yB9tqK6
         HOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CGA3qcm3fCHmpt2BRRXHVLbLdWdlggkd7p+YZxtH638=;
        b=jtxZaTBWNVD5My9fujMNQGQEHma6S7kbbiZ8AHXgJSHRFwBGCV5h9QJjNXv48LEBzY
         N7PUrVj7X7uqaEeMG/zyH3sgJAxIUDzX4BcqEkOr2296EEZusQi/uftsA828TA0CXBou
         wGWgz0Gxc81Onl3GAxnK/6GjY/HDo/sIg9aMYv/3NgIHDANNltL0WxaKk7+phpos28ik
         kqAHcba+2bi6tFW0HjouLScSxGj7wR2SLO0+KCk+9zqdkE4+cPtY0yIMnQPIuzaOkHWw
         RhVkK30ahgbGeDbL9GOSP9rakexK/kvZszxUwYYZffnLBxXc5Tf6z8WFNRU4B86qo2+z
         Gv5g==
X-Gm-Message-State: AOAM5339CANk06qjMABAB6U27szxEzv2fwjPUNs6jS3XkuO8Ak+59H3q
        BfFN9g9HSUwUv0EOEyEDBBE=
X-Google-Smtp-Source: ABdhPJzgDm2kia/R+W2epyF4c6rslLS/J+Rz0XpvrZiJSW/AusBZuyOVd11Ulb7TM16eNOVA0juZog==
X-Received: by 2002:a05:6214:1c8c:: with SMTP id ib12mr27905353qvb.104.1641309145085;
        Tue, 04 Jan 2022 07:12:25 -0800 (PST)
Received: from smtpclient.apple (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id c7sm34151853qtc.32.2022.01.04.07.12.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jan 2022 07:12:24 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v3] receive-pack.c: consolidate find header logic
From:   John Cai <johncai86@gmail.com>
In-Reply-To: <xmqq35m4gt5x.fsf@gitster.g>
Date:   Tue, 4 Jan 2022 10:12:11 -0500
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
X-Mailbutler-Message-Id: 8D90A097-D4E1-4AD8-8ABE-E71B4CB6876A
Content-Transfer-Encoding: quoted-printable
Message-Id: <CAE7F284-4D3F-4412-ACC1-216BB93F74EB@gmail.com>
References: <pull.1125.v2.git.git.1640758765723.gitgitgadget@gmail.com>
 <pull.1125.v3.git.git.1640931460758.gitgitgadget@gmail.com>
 <xmqq35m4gt5x.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 3, 2022, at 8:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> +	size_t out_len;
>> +	const char *val =3D find_header_mem(msg, len, key, &out_len);
>> +
>> +	if (val =3D=3D NULL)
>=20
> Style:
>=20
> 	if (!val)
>=20
>> +		return NULL;
>> +
>> +	if (next_line)
>> +		*next_line =3D val + out_len + 1;
>> +
>> +	return xmemdupz(val, out_len);
>> }
>>=20
>> /*
>> diff --git a/commit.c b/commit.c
>> index a348f085b2b..8ac32a4d7b5 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -1631,12 +1631,13 @@ struct commit_list =
**commit_list_append(struct commit *commit,
>> 	return &new_commit->next;
>> }
>>=20
>> -const char *find_commit_header(const char *msg, const char *key, =
size_t *out_len)
>> +const char *find_header_mem(const char *msg, size_t len,
>> +			const char *key, size_t *out_len)
>> {
>> 	int key_len =3D strlen(key);
>> 	const char *line =3D msg;
>>=20
>> +	while (line && line < msg + len) {
>> 		const char *eol =3D strchrnul(line, '\n');
>=20
> Between line[0] and msg[len], there may not be a LF nor NUL at all,
> and strchrnul() will scan beyond the range we were given (which is
> msg[0]..msg[len]).
>=20
> But that is something we share with the find_header() if I am not
> mistaken, so I am OK to leave the code as posted and leave it
> outside the scope of this series to clean it up to make it safer.

Good catch. Thanks for pointing that out-I didn=E2=80=99t notice it. =
I=E2=80=99ve added a NEEDSWORK
Block to this so we can address it in a later patch series.

>=20
> The reason why it is probably safe for the current set of callers
> (and presumably any reasonable new callers we may add later) is that
> they computed "len" by scanning the block of memory starting at (or
> before) "msg" before calling us, and we know that the block of
> memory is properly NUL-terminated.  find_header() is called by
> check_nonce() and check_cert_push_options(), both of which tell
> us to scan in a strbuf, which is designed to be scannable for NUL
> safely by having an extra NUL at the end beyond the end.
>=20

