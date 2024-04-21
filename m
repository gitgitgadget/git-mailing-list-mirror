Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838579FD
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713703245; cv=none; b=QJSm513T0YnwFeJ98p/Rq1n7EGP38aTzpLLWisjq+LRYwIbBIuOApqBELnXYF2spJi2+GTPX0qRtrv9p81eImSJWR1/y+BTqS5tmJNmYrHIi87CRBeaBMp2r3OT5IC1OipraF9znFTOU/PGSFfz4uXlJZm5zN67J2ZdekRzOpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713703245; c=relaxed/simple;
	bh=TfxCA2I5mMxCrpy2qjGoJp1xZmYskrMimTzD7sCI3TQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YDjNJMgU7TVkS4f1Iv/RPC7YVb4VhumgTRTAYi5PT/3UhewhEq/YpatzNBFDXcngoZuUl+jf2S/QPqXmGmSrAOca7eN8ItIkImchZWSM3+IRAplQ8hKyvWdhR6mAuR/Zao+tHyMGHyvyk6anBCGJWSB6Rwvad14M/U394ybym0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=hAbY6jQc; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="hAbY6jQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713703229; x=1714308029; i=l.s.r@web.de;
	bh=u0/+CsJf+cQBIdfBz1hGhdzAN2uEcReuyj296NMcDfw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hAbY6jQcLAquJaJd3H7wbi6EyO4zNFS0wWzUJD9132gKZbuZTWbt9xBhlXW55ZY+
	 3wofdW8TqcULBbbsz2IjmUzI9AClsrEUXS31GLh3c0XE3rFhPUagRVZtaWatI61U0
	 4Pfvokn7uocCR1VT7/RlA4oBQMm83QV6+8ff3ZsfmBl/4GSryr9/bU0WFN4eLIN+z
	 1doslATzGm38e2VwTBLU6rQeNz+H3s3fy6nVQ0BDHPeP4+bjnn83wCSDwIInZlAho
	 FF7+MlOMMOvWhUFT//c+jB4Y2Y8rPc9FOJfL12MS8qNGa3gTXTs3B7Br4nB+EbFlS
	 QeArLLqZemOlrUE2Xg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRk4s-1sAAY30pNC-00TDW1; Sun, 21
 Apr 2024 14:40:29 +0200
Message-ID: <ea752a2b-9b74-4a59-a037-4782abf7161e@web.de>
Date: Sun, 21 Apr 2024 14:40:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] don't report vsnprintf(3) error as bug
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SWy2IhlzYEnjBw4s/xXosGujxatRHaq+b66mY9Ml/Z5efKptKY7
 LZ0dGDTNsEq8XIoQbVnsO+FVVo5s3HR0CrVYV9Ge+PC8MFdfAduWCdOEJYf6dmr8pw69sw6
 HoCD3liaBAXardVrj+5hOXM3NA2piKatb62B+sCCmZU26BqCe7GPPnAisGOv6ifhJH0xCrP
 k3FK4PLKZm3M/tRIEduIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hTArNcmjH/w=;PCOZ7fW0Ji4sCONaIJqW6771H73
 HxHzez9GklGb45KsAGhU/dLAuCKdiBKNZeAygNJnA7MPVYxxRp5mQ5IHr6MJ+xpShR9Ff2hEv
 PNNtjr0c/zyqt2eJRUpP/z2WRMLk3NDsV454iDQvhHZRb2nhXczGkUqkxgtsjAoG/bALJXXfz
 4NFfuQ/UP/7JbaY44e3jC1IWwavz6mEedG/0KB36JRxrnDMuKih3hbQbzHfDTYBbov41PHArS
 nlZaX7ASspoObDoLs6F8368zyUIyiw37aSBrC8iHKzi5pjTjvC/EhxTqTDJpPCEEpcOTfqmYp
 lx5RQx5k3krE29+b/+/yu199m+8TCOJhWNcLpMs83OFAT6vuHq7Rw3nXz6BgTGtoQhlZ/qh2M
 WAh2TDnpqdXY0WxU3M/3neW5OCrBeRDk3C/+vWDcpCveV5IYeGRl5JXTVFDMTCEwnwU9mKPmO
 KqdxyF4j2jY51HpJG3sgCZd/giUm9R4sYflzyhWAeyg4Gt27rOq/JBWzgO5wUw0Ewivye82uJ
 nIjsmNAm0SKy2kIy9hE0x8CKfTJdW7Rs9ipvyhN/VMoK6b54SvNJ8kvt5uTeTTbYKJX2YE4Yk
 gD/wIdEOC4FEAdg51SORL6xuEWEdyL7+fCnu8GnNGnfRjYP8s64kyxXS9ZAzbTV+4/5hdK5mf
 rDllxXen4ujhRhVo95gQdNgUjvt6rlDF6sy2AO+14GoxVAod3iuC8SoCDPHQ2zTQx7RBO8EUC
 JzbkgYF5DOxFrsyw6VRgU54181n2t986JvniNHtqw/H5hgnYZ4wTHFVIEwyUzWGyFFxKQn1N+
 oDJscrpXkoJRmAFIxqMDD5TXeo4apoqNBW06A8aSOpMVo=

strbuf_addf() has been reporting a negative return value of vsnprintf(3)
as a bug since f141bd804d (Handle broken vsnprintf implementations in
strbuf, 2007-11-13).  Other functions copied that behavior:

7b03c89ebd (add xsnprintf helper function, 2015-09-24)
5ef264dbdb (strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`, 2019=
-02-25)
8d25663d70 (mem-pool: add mem_pool_strfmt(), 2024-02-25)

However, vsnprintf(3) can legitimately return a negative value if the
formatted output would be longer than INT_MAX.  Stop accusing it of
being broken and just report the fact that formatting failed.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 mem-pool.c | 3 ++-
 strbuf.c   | 4 ++--
 wrapper.c  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index 3065b12b23..a3ba38831d 100644
=2D-- a/mem-pool.c
+++ b/mem-pool.c
@@ -4,6 +4,7 @@

 #include "git-compat-util.h"
 #include "mem-pool.h"
+#include "gettext.h"

 #define BLOCK_GROWTH_SIZE (1024 * 1024 - sizeof(struct mp_block))

@@ -122,7 +123,7 @@ static char *mem_pool_strvfmt(struct mem_pool *pool, c=
onst char *fmt,
 	len =3D vsnprintf(next_free, available, fmt, cp);
 	va_end(cp);
 	if (len < 0)
-		BUG("your vsnprintf is broken (returned %d)", len);
+		die(_("unable to format message: %s"), fmt);

 	size =3D st_add(len, 1); /* 1 for NUL */
 	ret =3D mem_pool_alloc(pool, size);
diff --git a/strbuf.c b/strbuf.c
index 1492a08225..0d929e4e19 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -277,7 +277,7 @@ void strbuf_vinsertf(struct strbuf *sb, size_t pos, co=
nst char *fmt, va_list ap)
 	len =3D vsnprintf(sb->buf + sb->len, 0, fmt, cp);
 	va_end(cp);
 	if (len < 0)
-		BUG("your vsnprintf is broken (returned %d)", len);
+		die(_("unable to format message: %s"), fmt);
 	if (!len)
 		return; /* nothing to do */
 	if (unsigned_add_overflows(sb->len, len))
@@ -404,7 +404,7 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt, =
va_list ap)
 	len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, cp);
 	va_end(cp);
 	if (len < 0)
-		BUG("your vsnprintf is broken (returned %d)", len);
+		die(_("unable to format message: %s"), fmt);
 	if (len > strbuf_avail(sb)) {
 		strbuf_grow(sb, len);
 		len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
diff --git a/wrapper.c b/wrapper.c
index eeac3741cf..f87d90bf57 100644
=2D-- a/wrapper.c
+++ b/wrapper.c
@@ -670,7 +670,7 @@ int xsnprintf(char *dst, size_t max, const char *fmt, =
...)
 	va_end(ap);

 	if (len < 0)
-		BUG("your snprintf is broken");
+		die(_("unable to format message: %s"), fmt);
 	if (len >=3D max)
 		BUG("attempt to snprintf into too-small buffer");
 	return len;
=2D-
2.44.0
