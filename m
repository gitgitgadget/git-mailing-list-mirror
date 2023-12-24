Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C35CA64
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="hdzwhi/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703437325; x=1704042125; i=l.s.r@web.de;
	bh=sclnTDdwxJ7MJwQoafb6WS0tW6n3vW6vxxaHzQpu3/A=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=hdzwhi/LrWnUlBypb6yLDKhHHOADtFbsTy8U9ywLKgHtpjxXcjYsY6FzSc8fkUQ5
	 SSFT4v2VpaOV37gR5meHdA8FyHjQ9VTAoorlSlNXs9XktI4cUhwa7ocYXnxfG3LhO
	 YXdJrvDQZ2BecsLbFlJGBFNAliLpuDnlRsSy624MHmAuup94tJu6ouowG850gzjCE
	 34379fpYg7xIXkblibLPTCoCKz4O+Xc46Ct7jfoRU31SyXPR0jVnIqKk3KxccZDGT
	 uV0t+amPn0hHZpGBSiYKQaaGymkNRwgD9IMVUaDy/OlmtxSF9qyasysRiiYUSs4hi
	 r+9hdU1/DvMDPYBfTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1rRJEW3sgu-00AOr4 for
 <git@vger.kernel.org>; Sun, 24 Dec 2023 18:02:04 +0100
Message-ID: <3e15d11a-bd19-49ca-b674-9b50e0ba7fc2@web.de>
Date: Sun, 24 Dec 2023 18:02:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] mem-pool: simplify alignment calculation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZueaEKdwxR3bI1687IyU3d5CXJPjNuoX+U+/o8QDTbHJBIrG1r4
 TOZE/r+O8H/4SkjVIo+HhuWiutvZ/egS71UO/TaF3HnBhYcy/PoEUeGioxD9pz0fK7d92Ca
 dSf8wTbMFFruqE/gRrA20XasAAufeH41IVl0aXxNAjI4RU7NgRSd3mEtmS4Dg95VLG11SR1
 cGLq6eSmhzl2ocMTND9nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3fc7WcMgGQ0=;3UMJRFQWrKC8fJZ/uOVlYlRmZPg
 7GxHHewl6uS5nouF/uaFW2P2A0YbNOewy0SjEoAYhvkJp+0hvM337AFWUKlwmD6jCCCHmLUVr
 5bF6Unb4JypDRWUCDlGtb7I57ciIReEHPEND5DNvLpiQk1MInf1JLHCAPcbylAJLUbsd/ub7Z
 HPVLXbOXzf9NQDQM80r6vZOHum/9hFr6pahn86Z+SsQM2LawUCBsf7P2jnFndDg4/Zr26Gwtr
 hXVEBdQZfnm5AsZTKgKqaKAmydyTXXNcYrFYq4EvOI0Z5/WEvwM+U4+MWye4rKeZklbfF0TH+
 cHgSF+tSN77B9v8JUET/GeWkftt+mOkDJb4qiTKxMv/blL2dosHHILRT4/GjA1I4FCmMoHBe+
 seA/BB2hfUIHV7AF3d43TzqEJz4LyqhU1HHTIMLkPu9mgzLNIdsmJwao3PeFj+qa6151rXkrb
 yacND0tpBlfta3G7DI5G9hRDFMx+cfs+gXF0egCbtXyJFyRWjUUihOkZp22c+ymxpmZgcJ22H
 YbF3aui8vdzq4dNJRC51f1a0Hy8WgWvMil8w0JseXs7FtoXQ8WEBc+RFn7qTH8lTit6Y7Ay8a
 9W6vLDq4Ex5O95qIKgUiCxnyyRYyIlPOJLZB0McaLJvnaoc6tM/vvagzP9DeNpA8Xb/vHSbCj
 QI9rvCS8urPaLqo0yOYsjZGb87ddu9l+yhY3DBy16WSVvzHXdNvNr/oYulh/zqiuFqRhv+LYq
 SahRuqx/XsY6+1o0h4f0dpbftedxHEcGIjcklrKC9Om/haxn6Ob/IsFd11M4aHb7hzWS47Ixf
 dlyCUhnPR57/lAIxrQcAXMCgG2irTd0G9glMHe27NOWgVmnmT84BHBVgtY1c2jDF0UefELN2s
 9EGjhTvXPyHM6Za6OAGWUMFFwWS1A5S0eXcde0GyF2H/Qtu2kNqckkR2uvEweKPdbHuYg1KxN
 5v8XMg==

Use DIV_ROUND_UP in mem_pool_alloc() to round the allocation length to
the next multiple of GIT_MAX_ALIGNMENT instead of twiddling bits
explicitly.  This is shorter and clearer, to the point that we no longer
need the comment that explains what's being calculated.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Latest Clang emits the same x64 instructions for both versions; GCC only
emits the supposedly optimal output for the patched version:
https://godbolt.org/z/jPscnPqna

 mem-pool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index 2b25521e2d..2078c22b09 100644
=2D-- a/mem-pool.c
+++ b/mem-pool.c
@@ -89,9 +89,7 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
 	struct mp_block *p =3D NULL;
 	void *r;

-	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
-	if (len & (GIT_MAX_ALIGNMENT - 1))
-		len +=3D GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - 1));
+	len =3D DIV_ROUND_UP(len, GIT_MAX_ALIGNMENT) * GIT_MAX_ALIGNMENT;

 	if (pool->mp_block &&
 	    pool->mp_block->end - pool->mp_block->next_free >=3D len)
=2D-
2.43.0
