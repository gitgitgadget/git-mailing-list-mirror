Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787128E57F
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034814; cv=none; b=ESDKCfAt/fSBeXXgZRFmxa3qxhThcsIGZ8X/FJDnV1qXDOvJvMNicgC3/V/mdPp9NXwIL1YQS4njMMzBeN4rAsm3PYbpKxpCiuncRtbsS0N0A+nBQ1TrqFED3ycvwyPD9/y8mH2p5LghFZJVd8FjdTiGU5DTx2Ip3LdMTfx/5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034814; c=relaxed/simple;
	bh=d4l81px6pYaNp9DNGybV7FLJXNmmJu2LouPWoxs8JBI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dcNocn9mltaxMmnCyEuVLIwRo8U624C26H4jLt2AAbF8/9sw6kql6hqQTOzqfENJR8ONsVnegYxidrqPkD+++jHDFZmkdTTB4MhrK7nrzxPZFauTSqujmj0mof5kw41SatGlhgTfBJlw3f+1gsPUWAQHkp9B7gwVthjVzn2P93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpgz11t1749034774t7e6f1fa0
X-QQ-Originating-IP: VC+395Nln45PcQW4ksXqnLVJR57+8stWdjx3oY1vf/M=
Received: from smtpclient.apple ( [202.119.45.152])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Jun 2025 18:59:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12710617050948892556
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] repo_logmsg_reencode: fix memory leak when use
 repo_logmsg_reencode()
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aD_8NxMi6Dk7CmSl@pks.im>
Date: Wed, 4 Jun 2025 18:50:46 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8AC87451-1FC6-4359-9A16-928B77185779@smail.nju.edu.cn>
References: <pull.1988.git.git.1749006607791.gitgitgadget@gmail.com>
 <aD_8NxMi6Dk7CmSl@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NyqG2qnv0b2dV9HON2Gx1B6tF4wA6pSYhUTquuwiTMQ/irHcJmFw5nFs
	/BBuVJSbegahPMuDiKZKWbYsp3izeioHPEsBxRrIt/X0fnJ0BwHZRvWHcwu/q/zz1p+AcH2
	VqAiTsTYWTCykmeWRXV/Rt5t51z2ki8sWyCnmOUMtwC9XxkUI/J0OGE9w+fFcx2yHO1meg3
	BZTKqQDL6PkVR3of1nh0eEsvs4mVsE24YUVEUGUPxL8ZFhE0aDOfz8LkeqdGfx4/jHk7lFT
	l7Wbh9xZhLQSEHU8T+vGnlH/iWKxdxHMMFY8zBe6YUJWucJpV9rZA/Nb+suzzLY2F93/MSg
	xvTArndQtIBihgZ7Ryup9XfifFEmtrwjHE7nzT2i0hojMKSAsQnjSmjtEbWWWchf9E6hF3v
	6dLJf+bHpLRYfVrFDMHhZZ6L0fOJ5uTOp1LEBg8GUm+XsDmFxT3zAgNjB2Np9CJIK3VubwZ
	0PXoyifZSqXnvQd20bFrIgvp7yNMBKSBDB3e5suSUefW7isqUigcJkecd0NEbLVZjoDnf1i
	7cCT24/3BdK/zPlhPkKIC4lcre8Wizs7Ksr8m9WmpjS3GYuvqlISbbsWmZ+W74Pa3guDlHh
	mvkAtwZPd01Tt+0Sq0PEWaU5cqQkZ5OCov2MBn+05JfvXtZ7QCmB+8zJ3aGBJX6DMFRoayw
	5742CgZseWX4Rd60+Fq4fujfbQQQ2EmP8KVYav2iJ+hvhxjl+/GqP3e3x0DOXt2C4/0kNaP
	YVZ0iw+oJYd/70kMsbmAt5uWQYz2Z962f1SpnIK4l4E9/oH8ikW7NrxNAtDenkbhTBFx9Nu
	zWJgpjqF1cq+GwH5LG2ccv3WSmxLoFK8vBaXC3mTCWKplRUD45s99JUVripe72khlYYsuL2
	LaRd3zfE+xtiThknHYvGY4jjI6LozF9XhXr+spjhk5GUmUJhkpk5IQCZ4zL9nB9aPO06F13
	3jGnnHsip9UcFlBd5MAv/KE0NEcmHmR/OxYE1Uo50M4r8hdcM58Tw4vzPHyrR2yISXvUhsW
	GZzfjUpzzkqWdVP0rXleOmhZl9pV8v/nQNiuBZXkkQu0Km+sUxt7OOlXMtH1LOqZ76mMnxV
	Q==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=884=E6=97=A5 15:56=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 04, 2025 at 03:10:07AM +0000, Lidong Yan via GitGitGadget =
wrote:
>> diff --git a/builtin/replay.c b/builtin/replay.c
>> index 225cef08807..6172c8aacc9 100644
>> --- a/builtin/replay.c
>> +++ b/builtin/replay.c
>> @@ -84,6 +84,7 @@ static struct commit *create_commit(struct =
repository *repo,
>> obj =3D parse_object(repo, &ret);
>>=20
>> out:
>> + repo_unuse_commit_buffer(the_repository, based_on, message);
>> free_commit_extra_headers(extra);
>> free_commit_list(parents);
>> strbuf_release(&msg);
>=20
> Makes sense. This one _looks_ like a leak that I'd expect to hit in =
our
> test suite as it's not part of an error path.
>=20
>> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
>> index 30075b67be8..dfc7e85ae96 100644
>> --- a/builtin/shortlog.c
>> +++ b/builtin/shortlog.c
>> @@ -186,8 +186,10 @@ static void insert_records_from_trailers(struct =
shortlog *log,
>> commit_buffer =3D repo_logmsg_reencode(the_repository, commit, NULL,
>>     ctx->output_encoding);
>> body =3D strstr(commit_buffer, "\n\n");
>> - if (!body)
>> + if (!body) {
>> + repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
>> return;
>> + }
>>=20
>> trailer_iterator_init(&iter, body);
>> while (trailer_iterator_advance(&iter)) {
>=20
> Should this one maybe be converted into a `goto out` so that we can
> release resources in a single location, only? Something like the below
> patch.
>=20
> Patrick
>=20
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 30075b67be8..dd08bc40161 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -177,7 +177,7 @@ static void insert_records_from_trailers(struct =
shortlog *log,
> struct strbuf ident =3D STRBUF_INIT;
>=20
> if (!log->trailers.nr)
> - return;
> + goto out;
>=20
> /*
> * Using repo_format_commit_message("%B") would be simpler here, but
> @@ -187,7 +187,7 @@ static void insert_records_from_trailers(struct =
shortlog *log,
>     ctx->output_encoding);
> body =3D strstr(commit_buffer, "\n\n");
> if (!body)
> - return;
> + goto out;
>=20
> trailer_iterator_init(&iter, body);
> while (trailer_iterator_advance(&iter)) {
> @@ -206,6 +206,7 @@ static void insert_records_from_trailers(struct =
shortlog *log,
> }
> trailer_iterator_release(&iter);
>=20
> +out:
> strbuf_release(&ident);
> repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
> }
>=20

Replace return with goto out do looks better. Ident initialized
to STRBUF_INIT means ident->alloc =3D 0, so release on it is also safe.

