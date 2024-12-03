Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A320A5C8
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263107; cv=none; b=oGO7A6wurxbAkl74B6u1syv9mHxhCEyHCyeGQmXWA5H6zKMvxQWAXQUoNdHVyoCx0Y+pP5CE+dCHEo0BfNMFeVUQHmwp8Xlbb/L2xhruZ4eBKC3DxIUndirIwHOsO1d0rKDPIk1ahqfUtwu3wEYlvQhxT8CShIyOH0uCqvy7/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263107; c=relaxed/simple;
	bh=0T2JX7SF+2c60ryYWKMDCIIap83hc27MUbNSiJhBWyg=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=lwQ3MUPdmtUn8GQaCpPWbuspnjchRHx/yJiB7VcstB82Y+DVUM0YWObuXb2QPGT/9LULEyMdq7SfebPukvvsh74E+dQsraoUEKkHyFNvfmdjZXr0MMd4sH0Sv5lj51pF0Dtd/CtpQ4Y9WhK2XDvA4p7zVjjaplU5NpRGC+m9Bxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=iGvOdmXX; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="iGvOdmXX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=lNv2r9/jcpZekDexLtj7koQJ6L6kOMn2ZxGPBdRxTHg=;
 b=iGvOdmXXrMUT8hIuXRRpdOeqqP9bu/UdrplbRX7C8Vsv3lzTtqXQpaeTuGpxe43RM3L7lFlUH9fz
   LEryftpS6Lv+ng3LwxP+kt5now6AFw6NHWKQ1FPYaEDbm+w03JtUody2Mv6e+jfvrn8E/x9dBX09
   FUkk/zr4gkx+MdT0MyjwFzAWJuAJ/UVhRtCyq3ttcSg3g8cJJfTh10+s/vlbHiuc+XHU9GTMmV1V
   w3ZQKe1PRkQT6V04HYRV+EokcTvDuAEs3W+u+b5DEfNBAb4b8g47awNt6dInub5+HOs6je7GQEIf
   /W67p709VrrmuGxmrDHKsBWXGOda2leR8iSAfA==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNX00I8WUD5CE50@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 03 Dec 2024 21:58:17 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [RFC PATCH v1 0/2] set_head finishing touches
Date: Tue,  3 Dec 2024 22:56:46 +0100
Message-id: <20241203215713.135068-1-bence@ferdinandy.com>
In-reply-to: <xmqqiks7oprx.fsf@gitster.g>
References: <xmqqiks7oprx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFqDQYZm1jFPCZW4D1Fmo9zRzjP+gpQNTqhKjfCq3HsU0+faZzMQLQkVEsEkPva
 9litAjVwA0PDvpxXpARdDFf+FhVB+PGHqivU97fQX294G3DtidB0AcSw6BQny65P
 +d+WfXFExf+RJrqw35KrfDKbQ0D7zP+/yvlmkJvtpB3uCcNXD8ltgDwuBwkhrh0z
 FStgggLlLiUrMaYReuadGi3KQ+ZDtZYcLZVtaH2Q6tcGATRvcTmFnKvEkM9MzHVx
 FuxxpZXpTfj5ug3aE3vrVkIsT7/jqyb5nMQl5CcveQXrS61tD69V65T4U9jeMn3R
 o88B9I87EI6agonln0J84H7SbzWzty2laxOImdpyqJp8Fzpp3d1k3jKttbDSnffT
 YHXmFS5j4SMQpmlXdYZwwNSq2f8D2E54Jj6uGk/SW1FyeHOVxXi0Y4eut+n1EXav
 YV5C30dL1lo0qxc11rdyBJ9wYWokuHwXP1KZPkqwv4Zrsbw3fLWMxiLG

This series is intended to be the finishing touches on the fetch/remote
set_head changes as in built off of bf/fetch-set-head-config
<20241128230806.2058962-1-bence@ferdinandy.com>.

Patch 1/2 contains the missing setting Junio was missing, while 2/2 is
an attempt to do the right thing.

I've marked them as RFC because I'm not sure about a couple of things:

- 1/2 contains a slight refactor by extracting the hints into a separate
  function to avoid writing it twice. It could be argued that this
  refactor could be in a separate patch.

- I'm not exactly sure what should be in this hint, I added the new
  "warn-if-not-$branch", but arguments could be made for adding
  "always", adding a generic "or see the other possible settings in the
  manual" or any other combination

- I've seen some examples of advice stuff in yellow that can be
  disabled, so maybe a complete explanation of possibilites could be
  done with that mechanism (I haven't yet looked into how that works)

- I'm also not entirely sure about 2/2. I think it's a safe move, that
  is very unlikely to be annoying, but it's hard to judge from my
  limited perspective on all the different possible workflows.

Bence Ferdinandy (2):
  fetch set_head: add warn-if-not-$branch option
  remote set-head: set followRemoteHEAD to "warn" if "always"

 builtin/fetch.c   | 26 ++++++++++++++++++-------
 builtin/remote.c  | 12 +++++++++++-
 remote.c          |  5 +++++
 remote.h          |  6 ++++--
 t/t5505-remote.sh | 11 +++++++++++
 t/t5510-fetch.sh  | 49 +++++++++++++++++++++++++++++++++++++++++++++--
 6 files changed, 97 insertions(+), 12 deletions(-)

-- 
2.47.1.297.g6455f89743

