Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BCF2FBE14
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765027673; cv=none; b=X5H8mN6OlXGbi4VANLo6X2rKfSazfK3GDp1pluejzxfHKZeLUpzi6haE1m0OjBYfiKTdst71X9SpXESaXMFHEN3p/Ej0yQCNztEEylDi966c6D6KlxyxkEUE5IPs1ZhADLFhSPvy4H0tnsO3+qCvI9u4qHi5Nwno9ZVVXPag/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765027673; c=relaxed/simple;
	bh=ele+02zAMg9XP02KBTd4pL9ZEXJ424oBbgavTmIzBsA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=thdNAYM2xob5qL5FM8CC0lOaXwmcQ5n6/n14i225cuiZ5OrGIZXYiJvFeOiKsrHhl9XRt6uNzjWlH2vZ12yghferBtZDd9xvFhgRs2ip6PN/sPGGC2YcNOuPobzepDx0TQ7GvjcCRF8to5kEhx8ez9t4dI9nhTCdr0msI5qsbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=CXdbShUo; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="CXdbShUo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765027667; x=1765632467; i=l.s.r@web.de;
	bh=aEsG9JOY29Oby+o8pArpuihi7hA9FOMOpqID2QNx2Js=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CXdbShUoiZJqhkAVNNte+mpVItGGeBdM+kPlPHYiBqE9bB/saMa1RyBkNmYjB+1P
	 5GztPQtExIDtU6bnBqUt8GTbjcR6Pyg3ec8fc5FLLwmEpj8ep3kP9rpVdoTGDgh/H
	 QB6p0PCNIpvpHavb3WgQ6PiQZ3Y2RLhLTguh3YniZgw83quxWi2gRI8VcW5uBIw2r
	 yWMK44YaDou+Nxs5PVEr4RqwB2c4l7LlOJSOPcMOCaJj0I3P75tCYMSrInxPOY/At
	 gGdebqrfWSrwwy1BULS28NS168ozZMqEFKujMpkmf2KaxHPGIa/jUBNAmZSaNAtDF
	 q5LA6dta1IEIhjq6+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.21.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODmV-1vhcp01uUz-00LTwG; Sat, 06
 Dec 2025 14:27:47 +0100
Message-ID: <c8b15174-314e-4f10-94b0-e46f96bc75a4@web.de>
Date: Sat, 6 Dec 2025 14:27:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/5] compat: use git_mkdtemp()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
 <64e62623-b911-4ddd-a481-05191853c0a6@web.de>
Content-Language: en-US
In-Reply-To: <64e62623-b911-4ddd-a481-05191853c0a6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RiDzSNx5k4V4RQkKXiafcgWSKPVkDw5ejXJ0gku80Ril40FIY+W
 Lor/ttN9pgpBKdksdh+dzxlJdDZi8+0MO+CUthF4gMza9DJYv9VImx2TF1w7ANADFm6To4s
 H0fl0iTBb2ojBljg053HdVSLx6/Nwwet3oJjqoYRtyRs+BcH856JNy6SGpwFBhm5kh5yvJD
 X0y/w3Z8TcZ4ub5HpmSvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OVArByzne4w=;eyrS2BVMlUcmzl8hmvWce4ELGOP
 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
 HSpw1+d9f9ddAbq1w=

A file might appear at the path returned by mktemp(3) before we call
mkdir(2).  Use the more robust git_mkdtemp() instead, which retries a
number of times and doesn't need to call lstat(2).

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/mkdtemp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
index 1136119592..fcdd4e01e1 100644
=2D-- a/compat/mkdtemp.c
+++ b/compat/mkdtemp.c
@@ -2,7 +2,5 @@
=20
 char *gitmkdtemp(char *template)
 {
-	if (!*mktemp(template) || mkdir(template, 0700))
-		return NULL;
-	return template;
+	return git_mkdtemp(template);
 }
=2D-=20
2.52.0
