Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DB1DE4F1
	for <git@vger.kernel.org>; Wed, 28 May 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450230; cv=none; b=CkEjwd8hM97NgW9x/CqOHSvQJZt69EGyXhVDckEzLKhK+4lVvRWnri+ErqWtsuJuzjhxOef8D80EkMpb6MeJGrLNPSHOJtdNAV8nFwgVhsjXUgZIiyKtpuECEmNIoVKgrRj27pcbRIy1FfFL6R4x5t+f8t0plpTh5N0CuM/z/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450230; c=relaxed/simple;
	bh=McDNaoUBSUJ+wnP497ogEtf5DXoqAgSyuoKTk7gETQw=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=dgVyfhTln3Gl+Mc53njah7aQrcRTPXpd+EOjFIiSRSqMagHGyQjWEApxIJlJcLvtqTXkHQSNNGB/bFWVgFDB5lEEzQxlP40Wbmaqc4Dab1+QIMouckvxI7hLiyq6OureFNnAcDekQ4If3JEhr6+8Dsrnc9bCW0Yayxq9clgLvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpgz14t1748450209t3a2309db
X-QQ-Originating-IP: EEZEYSclvlSps5287ViYWY+zTvGD9D+AKOuqElxF9Nk=
Received: from smtpclient.apple ( [202.119.48.103])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <git@vger.kernel.org>; Thu, 29 May 2025 00:36:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10719353319187407879
From: lidongyan <502024330056@smail.nju.edu.cn>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: [RFC] revision.c: traverse to many revisions to find boundary
Message-Id: <3378F2BB-B2FB-4E07-9C02-A57D43D1A89C@smail.nju.edu.cn>
Date: Thu, 29 May 2025 00:36:38 +0800
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MjlOSqg8Riw0b455r1E+20meuXJfognL/boHJIuE0cBqhMzGxsyI1fRJ
	442+pabdZ1FeijoQ7koMoHUi62Lyz+v4cThZyK1FYK9XZ/UlzHFKdCfj0nLGxUc8Y64IsSQ
	+bk9vy33L93QmV6xIanevNFH8TM0HLv6oOgHdMxViAaxFpYlnfZ+szDbniSp5chR4gSE/up
	gtLvpskD58pygtbniqotDKoJibRfM/4ycIfhihbgEQ59RioWReb6x8K+TJ8YyNzN4uaa6Fg
	yNPfHhtwg8G9uYTnjK87xJEZ3ecPUYMG1AxjUsbEluBB4+6/cuOyw1Z8uv7131/d8qKj/Eg
	qlR0uuViIZiDbzznCQoBxD41gz744YurPrEDhHYHIryrUuIZLsAhvnhUmmzc8+b2kIP/9ez
	lvGnra6zJ7eMmJ2et6nnWU6OZOEog4sb6NQoxVJH5LpkynG90Tcdlt9SWS+8UfBcuUY7XRk
	Topzylt95wc6p+LzE24yxqjZBE5cLTIgn/ZMw2eKiwTzUB8YmP7WJkZPmA9J9tm3YrXcnyB
	bp14HoppfM5+swfjLhsAsNL+cmElE2DOxFCN2MEb/y1CAk1CmaXZfic2tGLJJUtEfAKIntn
	Q6Tb3SrxtO3nB6EMAm1v76DKSYAWRFnjYPZS6b/BUilXDNWOCriVvcSzJNWMeKZB2icUf3z
	Ugd5qXR1WqiyR+e7dFH+AQ+hJCGVHeC4NshDSxTOfSJfyfAK9Aew/pwBA6OBaIHtHDjDZdM
	cwuAj75ges8NNbDq0ZK01Uxx1Biy43hCgkABGjGBIqJaECeTCRkHW2PJL/OrCpl+BNn1zCp
	m5gXbkeWxBzkPqGLxLkWlVzRfl64Ib1UPOITQ8vaxiF1KllDnkYfM3OwApyghpXF/a/UpO3
	r0BRGVWXMXcts4gYG4sJIlMSmr257GsrBCCiNUiH3Oz026SYgZRCuOyYDaThmdI1kpGoRFS
	PzQJ2XsZC4R+f8jsInwzepUjK2c5U7vun8JQ=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

In revisions.c:get_revision_internal(), when the caller wants to
retrieve all boundary commits, this function identifies the parents
of the last commits emitted by get_revision_1() as boundary commits.
However, if get_revision_1() encounters an UNINTERESTING commit,
it continues to recursively traverse the parents of that commit.=20
But only the earliest UNINTERESTING commits are eventually marked
 as boundary.

This raises the question: when revs->boundary is true, do we really need
to continue traversing after encountering an UNINTERESTING commit?
Perhaps we could optimize this by stopping the traversal earlier=E2=80=94f=
or example,
by doing something like this:

diff --git a/revision.c b/revision.c
index 2c36a9c179..0d99c22913 100644
--- a/revision.c
+++ b/revision.c
@@ -1176,6 +1176,8 @@ static int process_parents(struct rev_info *revs, =
struct commit *commit,
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |=3D (SEEN | NOT_USER_GIVEN);
+			if (revs->boundary)
+				break;
 			if (list)
 				commit_list_insert_by_date(p, list);
 			if (queue)=
