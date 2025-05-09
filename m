Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D16139D0A
	for <git@vger.kernel.org>; Fri,  9 May 2025 01:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755606; cv=none; b=dJejHiOZ/bdLnJXKrVMiG0z/gK1BHI9qOA06amm52AI/DFHZMEii6AE7TT0Kmzehe0hbQc+cQms8OMbgq4e8o4/vOe41GKlThZnycWawWxoVGSDrcjmrM8Z0U6fLKxz2E3TFB4Osiuvl+JwKrcZC2SzTiTJtrozUgOsKN97aMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755606; c=relaxed/simple;
	bh=GcQhTlUJUOgsUqnGGQYHBiDAv/YaNomfElXFlclxKj8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lCCjizl5TJ8Xssrbr/39mVg1A5bvzVYmek77UWwFnnssjY7NBiZVvXN2lwR5UZzouly63PIEx6faAymqDlq5cPdrLw59rQShYQzNotKJ0jbxjrwfifT40aL7VleQVIBln5iLtQd5unGVINSlTPZMhQK7qldUHlUAUcYgZ6bENEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz9t1746755530t87f75455
X-QQ-Originating-IP: GkTA+YZx0viQGwMf0p3xDjhal0VfYqKuB5nEz3cte0w=
Received: from smtpclient.apple ( [36.152.24.174])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 09:52:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8019495912542183850
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] decode_header: fix pointential memory leak if
 decode_header failed
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqh61u4ul4.fsf@gitster.g>
Date: Fri, 9 May 2025 09:51:58 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <19EA1FF8-836C-4444-A027-A65CF28E2CFE@smail.nju.edu.cn>
References: <pull.1956.git.git.1746711521614.gitgitgadget@gmail.com>
 <xmqqh61u4ul4.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OGvgEoGelOUdH0DeLaC4KH1ctTO2kSMFaDS7VXctOGwUtzfolffrkwq3
	Uj46PzluVahLbZnlfY+fDjCE3vadfq5SEfc7LIVVV7RAIM6kVw94z0V78wHrGpIHhH9T4ya
	1VeXBgY455rIB1HdS+mQRM42ZuUxaQl1cAPk8dqROhbLGXwfm4Ea6XM5eA9rMqe/FHpyZ2b
	Jrz1Bv5R0OwHOsBAWVr00SEtu4GEOnBq2HSTWyCXnvbXmngQSD0lEkkDpwKc5Mczd/VPeTR
	7qihDo+2c6uVy0+qWVAHEqCkyK/wHErjovNdXv3QqKoiAGlRC6+vr+7QE3ZPPKOdyOKfxUv
	KD7+Q4La3vyVJqr/Ihg8zbZgckwgJW/fkA8xubjWvapPFmtwWPZrOpeFf6RdkgHw/UawJEa
	RzhhLCD7BTMVV9J3wMCYBCI2mgjjcUnmvpfSvTbb8DPDXi853IHRHLoj6Y3SA/PAo3VMrZ6
	dk4Kg+pwMDbkCC6MK66n2uv9f817fwWUR4TzV/oHVUUFZQFCMDHNLT74otUt9bDCvdXZhtX
	2VR4YzszyVrEfM5reB/K1aJyVX3dOqq52kP0diM5nj7uugv+SX0Md4eIr4J0l4i8pyd/S0B
	x/YESEPPLOLsckZfknVqK75KUdk5vNyL1y5oRhjB44LmPHp290ao4blLLBUlE4bTkG71JdW
	L1BkPUPyZB+ie0hLCLdyJaUxYMiSj4LidUUOd2OQgn+NygWJNjx9lnBTCNmBO9z0p18GTS8
	RDx2TSO1q78OTJ/C0mHAzlLZAHtLWfPLX7l1fyDuXnS4uAtZLhLZRSjUkRwjm89hnReq7ZF
	BRv/HR+n9QsgHNzDNlvCw1lyk2NwdPE0wYTjVCJurcykvFYRUMTyJxY3Gu/MdU5FquXPO6x
	eCTQy7KNqYXxlg4lIcT3+DW4IWQOPsK160aDnD8lLuZSoI0kphWCdbJGW7E7NpVkO+7jxV8
	ojWQ612KmEAg67p2GWtMy7B4BnWoZektF13QxyEsjEvsRV9zOv4D8DAPNrp56pzweS2/xRf
	6aPde3kBcaenB2KP5z1RMVexmWWxg=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Thank you for your suggestion. I will update the log message in next
patch.

The only reason decode_?_header might fail is that xmalloc could=20
return NULL, whereas other functions will cause the program to terminate
 on failure. If I pass a pointer to a local variable into these =
functions,
decode_?_header will always return 0. Should I change decode_?_header
signature in the next patch?

> 2025=E5=B9=B45=E6=9C=889=E6=97=A5 06:16=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>=20
>> In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf stored
>> in dec will leak. Simply add strbuf_release and free(dec) will solve
>> this problem.
>=20
> We try to write our proposed log messages so that readers can
> understand the idea behind the change without having to look at the
> patch.  Even to those who are intimately familiar with this area of
> the code base, an exact line number reference rarely add any useful
> information.  Something like "In mailinfo.c:decode_header()" would=20
> help them better than "In mailinfo.c line 539".
>=20
>> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
>> ---
>>    decode_header: fix pointential memory leak if decode_header failed
>>=20
>>    In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf =
stored in
>>    dec will leak. Simply add strbuf_release and free(dec) will solve =
this
>>    problem.
>=20
> Just FYI, here is a space to describe what would not have to go into
> the proposed log message; there is no need to duplicate what you
> already said in the log message above.
>=20
>> Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-git-1956%2Fbrandb97%2F=
fix-mailinfo-decode-header-leak-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-git-1956/brandb97/fix-mailinfo-decode-header-leak-v1
>> Pull-Request: https://github.com/git/git/pull/1956
>>=20
>> mailinfo.c | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/mailinfo.c b/mailinfo.c
>> index 7b001fa5dbd..7a54471a481 100644
>> --- a/mailinfo.c
>> +++ b/mailinfo.c
>> @@ -536,8 +536,11 @@ static void decode_header(struct mailinfo *mi, =
struct strbuf *it)
>> dec =3D decode_q_segment(&piecebuf, 1);
>> break;
>> }
>> - if (convert_to_utf8(mi, dec, charset_q.buf))
>> + if (convert_to_utf8(mi, dec, charset_q.buf)) {
>> + strbuf_release(dec);
>> + free(dec);
>=20
> OK, this fix is obviously correct.
>=20
> A nicer fix for longer-term may however be to fix the calling
> convention for decode_?_segment() functions, so that they take a
> caller-prepared strbuf as a parameter and fill it (and signal an
> error by returning -1, a success by returning 0).  There is no way
> for them to signal errors they detect (if we do not count the usual
> form of doing so by returning NULL, which this caller is not
> expecting) with the current calling convention.
>=20
> We'd still need to release the data in the strbuf "dec" even if we
> did so, but the strbuf would be on stack so there is no need to
> free().
>=20
>> goto release_return;
>> + }
>>=20
>> strbuf_addbuf(&outbuf, dec);
>> strbuf_release(dec);
>>=20
>> base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
>=20
> Thanks.


