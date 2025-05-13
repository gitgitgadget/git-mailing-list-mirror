Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D364198E63
	for <git@vger.kernel.org>; Tue, 13 May 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143788; cv=none; b=U9M3YC4JW6UWv7WS6WXSVDEKJrNX04VNDwQqd10xmPJkCJNAh9R7E+3WWnN8Xrtz5LfBcqQpm5YdlXehsXN06Prf/wBa/CqlFh4BiMITocVfCWka4afhMDvbDnLLjeElbrXXu2eIEJ+2nLsdo9htgirp+L/+xa8OIf3rWRUlmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143788; c=relaxed/simple;
	bh=bS3oADacvhkwJragEUB4bceY/JUsUymTBDaxzdUVOwg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MLJcwTzQ3EvqSF9nCGpzyWpSc7iUYPa0LTQkCVDSXMSKDcfTL4qbXOBLc8NI0Eh+Ztv3DZf97A10LPZZCVlHefnoBtQ/ouc7e06HBO0O+RJC2Qdj/t6opWNP9HrvVbIc/A7zLVqqxw2zLAJqdmLLzv7OKeAiPU0c6xpv7vQ0Aes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpgz11t1747143761t36555007
X-QQ-Originating-IP: P9GtmURY1DtBOUxoAyhZhkAM+FMqqYbhWuMNoiMNg44=
Received: from smtpclient.apple ( [202.119.46.47])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 May 2025 21:42:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7381436759085482678
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v4] mailinfo: fix pointential memory leak if
 `decode_header` failed
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqq4ixoiqhu.fsf@gitster.g>
Date: Tue, 13 May 2025 21:42:29 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9DE4050D-B036-4477-93B0-FF738A6F5C3C@smail.nju.edu.cn>
References: <pull.1956.v3.git.git.1747066627330.gitgitgadget@gmail.com>
 <pull.1956.v4.git.git.1747104551204.gitgitgadget@gmail.com>
 <xmqq4ixoiqhu.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NiJgP/70eYXdRA1CrMrXul5sz/ZDNMG+kZCxk7HTtbZXV5wKfqm9Guya
	Ev6gLC/lpb1PPNdDxXbFWxjXJQKHbIIjMl3ElU7nLAo01riGg4Cw4nB2KAs6JqZWpEGG5z0
	ZNQ3l2/0QJD/MOqSQWV5nmuhwj/yOUWwt48eRmW7uHZYuzBUrUOpSwuIXMqfjn9g8bRtOoE
	QJDtTZf5gNk2eTxPKo+hllF4088VmAcoFfTYm8KiqTqcldCqH5esUk8NtH3zoKLEPDy7RuR
	RFt7UQTezKwIBC1apfzL5br5qGevv3+9L67d/eYv7odl5Bwc+WoilLE26mhX8MufEmKMXCc
	5Ago6Wlis9T+Bns/mMCEjWgZEVE1HQF0jZ3qAEmj7Ijx2ERFDzvu3GDiCVWQf3R889nSJbE
	DsvUharcvX3sSfmPNN4obJlfNJvj8GeJFBvlvNy/9iua+4se3c14nmlhcZWz7UnY6CxR/0P
	tZAxE9hFCNUq0FuEmI5xyBGvEfYk9L+yBgw8IEUpon7cYWg0bEV/jHNimLZlxvK7tm4WzmL
	URNH3dv+0KMV2M6asTyHE2fThcad4lhLiznmws1xhPxEo357yrpxMS6HbQuWWszM4N6RwGN
	FCOjmRxyk/tpwi1wpTshsRNU6CaY8M/tOF9XAvb7WuieumH/XC0B/YlWvGVK1AdWsc2GY/x
	wjHrLqa7IoNPNGB6nJM4taeq+yGDMDkKaBezEujLs26tYIB2u3zxdgCRovK4JPXAP7vMH+u
	nOqUOKCfvXnOHQPxg0MQcxetZkPFJacPhw4Ldvvaaf29elQECHdbhudM3ALggDGwqSc0l7A
	/6J27HdetxeSZWZvVRxMjTaj4lynnlfI7csZwhqgdupBEeqEdI0lQ6W8YX6uWHIUO+97Foh
	KzG5XdmIaMjUMyx55wbsMbmQcWuoQZHArMDpVSS5FoJK4PcvKlNDSriHPqRu2hrRuqyak80
	b9l/JSodkR1zCwvgDLn8nMaAGoChTo3YOsoy0cfbjM1OzcA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> -static struct strbuf *decode_q_segment(const struct strbuf *q_seg, =
int rfc2047)
>> +static int decode_q_segment(struct strbuf *out, const struct strbuf =
*q_seg,
>> +    int rfc2047)
>> {
>> const char *in =3D q_seg->buf;
>> int c;
>> - struct strbuf *out =3D xmalloc(sizeof(struct strbuf));
>> - strbuf_init(out, q_seg->len);
>> + strbuf_grow(out, q_seg->len);
>=20
> Call to grow(), while it does not hurt correctness, would not be
> necessary here, but let's take this code as-is.  As the result of Q
> encoding (and B encoding as well) always is longer than the decoded
> result, strbuf_grow(out, q_seg->len) would always be over-allocating,
> but it would not hurt too much.

Thanks for your advice. Though I think `strbuf_init(out, q_seg->len)` =
also=20
call `strbuf_grow` to reserve `q_seg->len` size memory for `out`.=20
`strbuf_grow` here prevent multiple realloc operations that might occur
when calling `strbuf_addch`.=
