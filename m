Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359F267B84
	for <git@vger.kernel.org>; Mon, 12 May 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047282; cv=none; b=OSsyJXbFGCIgEqnw6raCIpCm/VK1QGklJwmDTXDFb7bgwW64ZX6yGrt7JXMscWpLLOk+8dzugfGs1Ew8JrFk5DjbaSyojuPcSc4pkD0KzenNEj5TGDymjHMC9qus6vFbAMC3XNAtkTcRjfDMLnnjTdGqc5DRAF/7pNBYUObGiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047282; c=relaxed/simple;
	bh=ctcd9DHh6m08CSQW+V2PqYj4s/EYBg6C2GLl8IgayCo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R5gIoi3mM75zPNwwKJzOSYtF6ongtSJcMiuqVcGu1NQIEATc1rb9ZMUgngDzUEXt32/uqpJiJYJq+aUcfkrjVsobhP5IwCWQbAtxgpn0DmUj6+WRJFZzexF0wRH9lL+3pqQQv+wXRZPnpr5Pur4bDTxMkScW7x7CPUOpCdpfvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz20t1747047255t4224b324
X-QQ-Originating-IP: SsYc+O0PPj93TFxfzkbkQOnMpaBf/ANdcKanWNLbVUE=
Received: from smtpclient.apple ( [202.119.40.154])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 May 2025 18:54:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10647728274872083934
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2] reftable/writer: fix memory leak if write fails
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aCGwgbJ_dbO4vKq3@pks.im>
Date: Mon, 12 May 2025 18:54:03 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A6F44C3-D501-4CBC-9563-97714708C5A0@smail.nju.edu.cn>
References: <pull.1958.git.git.1746849030749.gitgitgadget@gmail.com>
 <pull.1958.v2.git.git.1746980165245.gitgitgadget@gmail.com>
 <aCGwgbJ_dbO4vKq3@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MSyoPQEuxKCu/huOOSWSPh2FVU5+X8SFz9OcBs+Uh55y+HH3QBRMqB7D
	48aXkNB3mokRyqq+YvsPaFNgLgvnk+OgM3g5CkryVzAj6QmpUfdgo0c9hXHxRjQG0cX5ot2
	hb+sE5IAbEf3fNeX7IMu3El+yU+lLKy/imDSTORyM4z44CNligPqIKKyLoigTEKFTpz+DWV
	xP6olx2Ap8yzISEcROEVCkA9DHtXz49iWWFl59nJ5j0rVb9ndgRsOP+pc4Q8tYpSmRCH0aD
	8cxk/tbK1qouNt5xmuYU/XJENCRanoasFkG36epRFyNrZjfW1OcAGSJQfwi8w8D9Ai6eNWG
	jfnwUR6b60w11qLxySQoClRfrPLguaAS+DqBt7RZ/AGutoQHViizMhA4a87Pt6xb5xFxQlt
	XTuRiGZGUAzIVAmD9nubcp/f4uhqNz2XCll1nL3e9JYeMVmojvyjAuBW7tI1+cREyQcZwNc
	R3MuJM4uFsuJugh1EghZGb2hx9nbSeILtG84eiLUTvRyAv6a7BO3n13N5ou4C7v0A4KXas9
	Oc3GgGPd3MoZuB8yAVAAurtq9KQ69CgbQ9ROiOC0FWf3GT/3Ok1D9GE0o+WQHbmHH3M07Ga
	8oUHx97/KxwAXEisK3N5j7Mfc2POS5BI1z0eCu6jxTnUXU/N9x023uOC/S/A5crW5SqkXAJ
	uFHKwV08qHJrR5mHduHxaLYcaNOvqm4zwpDXYeWWUqmwBFiGVdGKtrXfQw0r5lOlMCBxSlb
	JgmvKp6eHe+szNHUCHhRSbT3IxbJ/ZNollLgDQHOzGxTing9U09oKK1BP+0wgn/OqNC+fEj
	HeLyiCakLcWupukFHYIPDQKWQeCfbE8UDFZGtMEoV53ZE1ZLD41PKH2AnqicwfPXgt3yCrl
	H9MOlx0dVGa3dCgcBNWiFpFD3fZkV0u1PEtACg5cTUNyGqurZiqhheypHWt0N7XX6cpZgQ6
	EzjLQ/ufcVayZLCnVEkxco1hr3p/OixMWl1gFLdo9bvSS79Mn/tmBhTlu
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On 12/5/2025 at 16:25=EF=BC=8CPatrick Steinhardt <ps@pks.im> wrote=EF=BC=9A=

> Nit: I think it would be sensible to split these up into two commits, =
as
> they touch different areas of the code.
I will split them in the next patch.

