Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CBF429800
	for <git@vger.kernel.org>; Thu, 14 May 2026 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771479; cv=none; b=LrvqJW9ZKy6+rtuNkYgwyMKC1JNS0aj52qWEfsyearVpRDekPZ/YJsQiN2kcipaYN661ghc+DPB3saNugXf6/gD9HJCUybjfZZnKbFWkPwmIV82I+JKo9Zbe1RlBbiC0LWqZQ0u33RIPpzzZoEMz5sKhcKCUjrmF1KI7cSnU4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771479; c=relaxed/simple;
	bh=W5mfwmtaIaWl3jyQy9uh5St7cBhckpBX7aPoeCGHLbA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JxOjrX5fHJBr//mC4JwNEwt2TnbLzgco/1WwuKGpqNwuc6eGyteDADPMvZtET3i2Kw/ltU0md/ePE+IDSGMVpeP25BlQVkQlRQkE5Q8s7ko1ZOAVYYbw4YYnvJKIstpae82A3LwLbVtCf4eXkeZi1ZbxkM1oKhbl2/4vb5KrwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=uDG7MonL; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="uDG7MonL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778771467; x=1779376267; i=l.s.r@web.de;
	bh=qu7UwKF13m7efGjeMiMze5RDnHjvE0Ag7FK5e0e3390=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uDG7MonLMvxkc/v4MLGe7ENXvQqeKbxqphRmrug6CJ8GWSjHxzO9l5bvcyhPWIvh
	 MsUE+sTY0Laq55xyAs+9Xv/BGF6atLEryaR4d6IoqSWVigVIkGQfIuaCAHfndkGIX
	 asIOqIOOsv/+uiKz2S60RnjjJAHXFx1g7/BGM2Ozt+5o8ZRxeBpKDehn/eGVSocVj
	 iOEdyxSbr1ncdYSy2U/7VpnDaWmUyU0zc1wAJZgL911KWXHWzc/U+NuEznWeExVWP
	 0fklTQf0ltXodIS2S1QcucKgvxTjUoQaL2zjYtMfek8yoZzwvLltX+9ldHN0TsJ3z
	 O3EaIzcHNbjnRcBWVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1wzusI42Zo-00lsbq for
 <git@vger.kernel.org>; Thu, 14 May 2026 17:11:07 +0200
Message-ID: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
Date: Thu, 14 May 2026 17:11:06 +0200
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
Subject: [PATCH 1/2] strbuf: use st_add3() in strbuf_grow()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nZISltmIY4yraA0jSuwvsUBtiuPGaBkyY6l6twFmlyrPmFSMBH/
 1PzAw54JOC4gthyqK2c++ni7/zf3jc28BYQz9tmYPeMeFVH75c796kAtfa9XzGIfXTSJU+Z
 QP2ZNdK9cAX/PkDMXKNWwwHz+R5i7F4AQvFQvw90Yc4qHUkeCTBnOU+dfqgxgVdyHl9doLv
 fafTPXzNa0/ZlAxpPRAqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2tKCeYpfSOM=;9RkDPhuhzBvP8juQf12FHj+x3Mw
 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
 GEr3BR9Q15jjlMF2e1/SmgQdhqqT9mQAw==

Simplify the code by calling st_add3() to do overflow checks instead of
open-coding it.  This changes the error message to include the offending
summands, which can be helpful when tracking down the cause.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 strbuf.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 3e04addc22..bb04d3910e 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -106,12 +106,9 @@ void strbuf_attach(struct strbuf *sb, void *buf, size=
_t len, size_t alloc)
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
 	int new_buf =3D !sb->alloc;
-	if (unsigned_add_overflows(extra, 1) ||
-	    unsigned_add_overflows(sb->len, extra + 1))
-		die("you want to use way too much memory");
 	if (new_buf)
 		sb->buf =3D NULL;
-	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	ALLOC_GROW(sb->buf, st_add3(sb->len, extra, 1), sb->alloc);
 	if (new_buf)
 		sb->buf[0] =3D '\0';
 }
=2D-=20
2.54.0
