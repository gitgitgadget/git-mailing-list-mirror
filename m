Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE282D7384
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759154; cv=none; b=C6UEKaWpS8I3pCizgX9u8ZUgHNvMMr2yIGMKYuzabKbUaqrmIBVOoU6j7B5XYucMBKPjYKzNlVs4Zf0ermJ3Krrg5Q2RGixc7uQhuFv8K4kkCzzipqFVdudC4Fs4EUvLkijD0IUScS55Zz4OnF0e8ip0NArzld44bZevVWywzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759154; c=relaxed/simple;
	bh=ele+02zAMg9XP02KBTd4pL9ZEXJ424oBbgavTmIzBsA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=lltnIvsFarvP527ub31rjmrwFwSMvzqQURRAkIORp5KzLS4h1l79d3sRoxJc/EAq06rwaQfcq2heiX1aWk+5q9aqvftrLbg+sdG/ZKb9HuoWu1Ckj0ONj5Xz8o2Dt9VyMJ4cuOAbjFE/TPJtDYHCHHmnirPskAoipyO9n33ovqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=P4W16y5/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="P4W16y5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764759150; x=1765363950; i=l.s.r@web.de;
	bh=aEsG9JOY29Oby+o8pArpuihi7hA9FOMOpqID2QNx2Js=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P4W16y5/+eqECvQBASSntuGXK4z7mLkgovctvovqHUS5T9F4ghT1Ei6BF8vyhuN0
	 0zwhTl1RhOIob4IkEECZDNITdEnPUhAMlMh8vjrGnF63iBwjfe2lVKqjB6k+Y/Y1G
	 RnmX/DDYkEwNml/+jHaMx470JpCLhErp0WlNe4loRs+iWflZytoA8DhJu+GU4xAdD
	 QZh/8A+3rrBqiymQ8AJ4KLY2PUXVdwUNLD20MoTG8nmoAjrLPOVrgweoHMDu0xFvj
	 Lsu+14tUthbvZiFFgkYlZsKLdlzCawyRYEFG2EibtnAwmQUxQS3VsKge3BuSKWXt3
	 32o6n2hXlqi5YekG8g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.29.250]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4KNZ-1vR1aR27jF-00EQ07 for
 <git@vger.kernel.org>; Wed, 03 Dec 2025 11:52:30 +0100
Message-ID: <4c70b527-9c40-4396-8c8c-95177c5d92f0@web.de>
Date: Wed, 3 Dec 2025 11:52:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] compat: use git_mkdtemp()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Content-Language: en-US
In-Reply-To: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GDZPdXiTaK2+im+5lquFpkxwY5jRwIS2zo8MGdFe5rRUlHy3Ppy
 YBC9T9k1Mamq0B6tgVY5GTTUcTbtR6fB5GExgMZQm5iQ2YbC3MuN/WcQ4sNnvfMiVMmzkT0
 +MmBAjHPOBAjbDy9NRejurthpkSp++mBpbS4+JMCw3qeR902f8VtdNkhvQrcE9fusX+YVG1
 lyEyQx+OauxZ2bPhwICcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gQT30vONwek=;I1xk2w6tlpuJn0teT8RIm+LCUAh
 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
 tOXkw==

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
