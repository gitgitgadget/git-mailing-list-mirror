Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E92E11C1
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749889627; cv=none; b=lU6CZ0oNNlNMWm9WIMbElTDPbQTR5ON99YkXGaJYPFqcwaRTLN+eayjGVpAdT0nrp+cjVh5AO0Yo/K0Ga4yPbWHTpfJ5xqM6thDD2feP5jOP8blxkrNGggyWxkYWoEUlzeksp7tDWcNSGz1YEpxMng2Oo8eX3sUJP0L582zXNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749889627; c=relaxed/simple;
	bh=VdRdXFFBP4xLKp+HMx7Su4iXMsMZI4NQcPqRQbrC8Y0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=r4dyTin4aou5wR0JFYUg4qnjTKxmnx1mf00heYmb1cw06g3lGLUB+fyL1CnksPKo2BBaSIsqggvbTP/717JMbmb00+S91N1SnbVrYIW6j7jnuv36FOvkDFylHNO+sZtyr/G9VaXFamuaveKuadsP20u4pNhF0Cf14mqPVU0jH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz6t1749889581tbdb7f7e2
X-QQ-Originating-IP: 89bo3TnsfT6vbveX0jAaiYBdF1GrbXrni6Ruj3o/6ns=
Received: from smtpclient.apple ( [202.119.48.98])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 14 Jun 2025 16:26:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15492945286466792725
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] Allocate msg only after fatal checks to avoid leaks
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <pull.1998.git.git.1749843142000.gitgitgadget@gmail.com>
Date: Sat, 14 Jun 2025 16:26:09 +0800
Cc: git@vger.kernel.org,
 Alex <alexguo1023@gmail.com>,
 jinyaoguo <guo846@purdue.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3993AF96-E03D-46AB-B18E-8E6C1108EC45@smail.nju.edu.cn>
References: <pull.1998.git.git.1749843142000.gitgitgadget@gmail.com>
To: Alex via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OFWsfmE1GYcu1Xyg8Dvt0DlkU3STlL+MRjc4747/iglOBn3xPgyKDJ5G
	LPkoYMT74AzkmbJCeRLNjYwuVhQm2E6FfTaSAECF3djGsIxc8t70VjMc+uMVgiskER28bm4
	pb6s7O/K6ysZ8Z7vv3JeINGNxuFMITg2mWaTF79KWDrntTVYU5qcq0IYRDiL5GVsVBgSaWA
	AIKvxg5qdvKBLbSX6ZkU00/t0iNteNCmI+ifP83ygMSAV4pPr9uEG+Cy33YYu8eR+Pqd4vH
	dirJErvpXpZr2QMXyqe+aX/Et25tJ2vXaLKli0Eo+rFjFEjvAsYEy0zrhvmRnfdU1hGYXK0
	jidTpneqUhY8KMCtPQJSvo1r/sUIii6m2XTSwqn9svcPaF+5R+jbqkl108gRAy646W5r+jU
	DGTkabWrFzKPY12UxMMzlt5l1EnlDyMOFla2rmgNDBwJ9kY9I+7AmngIAbcpz3s0uLBKr62
	JwxojRTXTjPo2HgcM/BvKftPbH93j0JNMHw2U0ePhf4TKn+kkm091YYksCZfE8xvnc0gc66
	kJNAQMJGhyu0MEiVEJKq+ljzwl0ILbm1Vu/Iajmr8L2NTfXql77sb3EzpohOudt71aIcmb1
	enmnvsb69hpZA2wqqquZeFMgrL/uodajoq6XWNr8NxI/aFbzH6NCHgSgo4DSMyUgb5VLE0h
	BZXiuDHWI8ONmlJfvFnqJZiJFYRYRvoiUREUq9F8JcoBWGaVpj8bSZj4L57spIXamTpBFuP
	ECP7DUZOY4NrKXMCDxueRHoE0wyCkddDRExRP2fxPHpA0YiUmHO05NOJrgdOymt55mmLlw0
	VA7RPMR/AShaZetcwXxlhZBl4W4bzhfPZRBZvft3pIoqojxzYftomoIhXhaUEcHJhc8iSrw
	6evokQFgGnPAok88C9sEyDC+fsbMRu3cUjPaSW+v1NPpMGKGeeomNgvvVWlMpljIP6nWoQq
	xNUhBC4E+PbRsyT/UcThadGJVOjKxdhMxmowCKswXUvSZ3gz6ucDUkNyo
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Alex via GitGitGadget <gitgitgadget@gmail.com> writes=EF=BC=9A
>=20
> From: jinyaoguo <guo846@purdue.edu>
>=20
> In parse_reuse_arg, we previously called xmalloc and strbuf_init
> before resolving the ref and reading the object, leading to a
> leaked msg on die() paths. This change moves the allocation of

A memory leak on the die() path shouldn't be considered a real leak,
right? Since the OS will clean up all memory once the process
terminates, explicitly freeing msg isn't necessary in this case.

Lidong=
