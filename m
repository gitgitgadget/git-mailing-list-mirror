Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615C42AA9
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749212630; cv=none; b=D7E73V0puoXnhTQOWaR2I2xtmyBOP60C2Rf/J4nWqL17WmZqSdFXmZWhoihBJPQcIOgToGJwpgUysOQfoTCkoAleBXPms5tyrn63dWICQ6oE5TKffbyLruwGV4l30hmnJyNAELAm99W1fJVI0LG/u3LLxiLtmV8/hUgTC9uOjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749212630; c=relaxed/simple;
	bh=8gKf7WkmT4PuU8L7hIFA+kqRGWyzHbTQhnBb1DfvsYE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ncpdyLLavTBYum933wib0F1H8U125rO56ddC/J24yVFVaF4hiZMY8iIPdicaqo+VmkyG7cdhIlqSi23KDIzY6ADrm9CH5TDFWmO3rI1ro7Y6vUh+ymqbNYwtBjiPS7gaLWRIaLUcBOFFN5XnQ6nCo/vxV/M8FSw/ZjaPwVScwN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpgz11t1749212579tb52bc166
X-QQ-Originating-IP: SvKxnsh1F5SzKkmRymBqr4rxoF6GpeWMnbT5Vn2ZYNo=
Received: from smtpclient.apple ( [202.119.45.158])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Jun 2025 20:22:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5232200214794432596
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
In-Reply-To: <20250605072308.GA2066712@coredump.intra.peff.net>
Date: Fri, 6 Jun 2025 20:22:46 +0800
Cc: Patrick Steinhardt <ps@pks.im>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1487EB97-8D97-4535-ACF2-96AE8C3F5DB2@smail.nju.edu.cn>
References: <pull.1988.git.git.1749006607791.gitgitgadget@gmail.com>
 <aD_8NxMi6Dk7CmSl@pks.im> <20250605072308.GA2066712@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M4K5nIxZYv59g9LBb8vPNPxtgoZ0bc2x4NJI3LyZVy97I6Os4qyiUP/W
	xLUTezRzf/JY/U3JnY+sUjq7OF3SsxonvQCFhulx4QnkrPk5L8WceLiY1ImUIunFG94/ylx
	hOM1fx+c3qk5NZOWEXuKLYJaU+gDS3CjNdVshE89LW2q+gno+hfsfWjn4jZM2DnGmiGHLhb
	xTJrbqWOhaCQmvmGj+GyMESqWA8vLPv40hrHK2lgeQDkB7HzpJVWFMQmG811tt8FeCKk6D6
	8bF90ISGN7LRtiuGMmy4KBzUV5WgohdAGscs7t8oG0/LCR6eHURXzV+rNB6xZ5ysC+bdMpV
	ntBRZ6ucdVZMHQdnRrBM5q1gDBV5NBg5z0vnRvEAwZ19G3eA5nkJwRZUSoHSZkwuwIhnZ8R
	A5erT3ZJsw0okQ+F45WMGjdJ8Tv6TIk8l2IswlSUOCv4znTv7bnfFkt3gyWGpoJVYO12h9n
	6E7hrPAW8nWxSymgeOmd9caOB1UjNNA6R+1Ogh4QrAsWFMlcQGXntGOdLrTcHlzrWskEPr3
	dODOA+V3EJ8e5emCNtoQr39Ig6J7hI05/Axd8QVhY6U/cM3YzwF+0wn46AF77mHnZDdQmn1
	uNJzfX4JxDsHL6qmC0JVnVg81K1kUPUqpjRMMlu1GGffgONJEABCIwmxD8+njYqnsIRgJcC
	vnJeWmYLYJoyJmU5rlz8HPs20nVGW7KZsLXsQ3KRmjWcPzhUD3cwVpA7NZDtuaQJfGvxUc1
	R1ANi4vkY8iI4pMyB72aPnCXC4+VeohomAwK0vNuM9PDLA1Y0UO6ZpkBqo3Aau7TdfmU140
	SbDj5LmoyYNcwDx6pHxZPHFBOzZ73EQjjxnN63HCN5LwXEnION2SsllL8V6SK2qKsS1+6te
	rXH8yUyYunYO5Hw7a5RutIofLnPIbK/x/A3fEyoBu8RmoGVEpV/MI0BTzrAwkEHC0o5Prim
	ejE4BxKjU3AJivo7YcMQyY+TWEg8l+eiVb8M4gmdC8BoyYtHm/cLgVizoJs2OHhtWzP3QfN
	W15LBJ5w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=885=E6=97=A5 15:23=EF=BC=8CJeff King =
<peff@peff.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 04, 2025 at 09:56:39AM +0200, Patrick Steinhardt wrote:
>=20
>> On Wed, Jun 04, 2025 at 03:10:07AM +0000, Lidong Yan via GitGitGadget =
wrote:
>>> diff --git a/builtin/replay.c b/builtin/replay.c
>>> index 225cef08807..6172c8aacc9 100644
>>> --- a/builtin/replay.c
>>> +++ b/builtin/replay.c
>>> @@ -84,6 +84,7 @@ static struct commit *create_commit(struct =
repository *repo,
>>> obj =3D parse_object(repo, &ret);
>>>=20
>>> out:
>>> + repo_unuse_commit_buffer(the_repository, based_on, message);
>>> free_commit_extra_headers(extra);
>>> free_commit_list(parents);
>>> strbuf_release(&msg);
>>=20
>> Makes sense. This one _looks_ like a leak that I'd expect to hit in =
our
>> test suite as it's not part of an error path.
>=20
> We'll usually never flag a leak for commit buffers, because they are
> stored in (and owned by) a commit-slab. So the memory is not leaked
> exactly, but we may hold on to it longer than we need to. This mostly
> only becomes obvious when we do it for every commit in a code path =
that
> touches a lot of commits (e.g., "git log" or something).

I understand. The static analysis tool which I used to test git find
repo_logmsg_reencode() might allocates memory through xstrdup()
or reencode_string(), then it report a leak. And I find that xstrdup() =
is
actually dead code. So only reencode_string() may cause leaks.=20
 =20
> The exception is if we actually had re-encode, which requires a =
mismatch
> between the commit and output encodings (which both default to UTF-8).
> And then it really is a leak.
>=20

Agreed.

> If we add a hack like this:
>=20
> diff --git a/utf8.c b/utf8.c
> index 35a0251939..d7b7d372c5 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -3,6 +3,7 @@
> #include "git-compat-util.h"
> #include "strbuf.h"
> #include "utf8.h"
> +#include "parse.h"
>=20
> /* This code is originally from https://www.cl.cam.ac.uk/~mgk25/ucs/ =
*/
>=20
> @@ -442,6 +443,12 @@ int is_encoding_utf8(const char *name)
> int same_encoding(const char *src, const char *dst)
> {
> static const char utf8[] =3D "UTF-8";
> + static int always_reencode =3D -1;
> +
> + if (always_reencode < 0)
> + always_reencode =3D git_env_bool("GIT_TEST_ALWAYS_REENCODE", 0);
> + if (always_reencode)
> + return 0;
>=20
> if (!src)
> src =3D utf8;
>=20
> then running:
>=20
>  GIT_TEST_ALWAYS_REENCODE=3D1 make SANITIZE=3Dleak test
>=20
> turns up this leak via t3650-replay-basics.sh (as well as in t6429).
>=20
> It's probably a bit too specialized to carry around as a permanent =
test
> mode, though. I thought it might find other cases, but it doesn't. The
> other one in this patch only triggers when the commit message has no
> header separator, which is not very likely.
>=20
>>> - if (!body)
>>> + if (!body) {
>>> + repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
>>> return;
>>> + }
>>>=20
>>> trailer_iterator_init(&iter, body);
>>> while (trailer_iterator_advance(&iter)) {
>>=20
>> Should this one maybe be converted into a `goto out` so that we can
>> release resources in a single location, only? Something like the =
below
>> patch.
>=20
> Yeah, I think that is nicer, though...
>=20
>> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
>> index 30075b67be8..dd08bc40161 100644
>> --- a/builtin/shortlog.c
>> +++ b/builtin/shortlog.c
>> @@ -177,7 +177,7 @@ static void insert_records_from_trailers(struct =
shortlog *log,
>> struct strbuf ident =3D STRBUF_INIT;
>>=20
>> if (!log->trailers.nr)
>> - return;
>> + goto out;
>=20
> If you convert this hunk, then we'd look at the uninitialized
> commit_buffer variable after we jump to the out label. I think the v2
> just posted is OK, though (it touches only the one conditional that
> needs the goto).
>=20
> -Peff

I actually learn from your hack that GIT_TEST_ is something like =
GIT_TRACE,
both aids to test and debug.

Thanks,
Lidong

