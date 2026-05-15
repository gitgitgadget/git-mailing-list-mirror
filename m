Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EB3E3173
	for <git@vger.kernel.org>; Fri, 15 May 2026 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830437; cv=none; b=d/UBhqD/yQyGgUOV6T43WbBGiCMp4FEA711Snz5N/0UtpD34GDCdik2bLSmrKCSiGc6nRdDKj+cgumXOeUQdsvGSLKJxJxoVaORNAyY/GV8rABzhStetlUKzSZ6Qs1oEJJese3vdmOAbRAssQ6TDOL74MgQqrT43H6gk+0hWEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830437; c=relaxed/simple;
	bh=XV+OzVbgNbfL239/ppdp5sVhnOhy7BvyQdVrtgA+K40=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GVhRlXCU371HhrgxL252SAfvvWIn73++LJX8ql092MYfzBQL9iJCu0bGMcLIysE9OJHZ0Y1h2sHbCJ4EgF9khYLzSxJtVxmUuWeYZI6QEYnFvG/E1zR1vYivbenAvFk+Q7Z5XeCtI2CfXNTYoavywXFjm0+KvO76fcGi+5FxW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=c0KE7t2u; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="c0KE7t2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778830434; x=1779435234; i=l.s.r@web.de;
	bh=Jtr3pLWHQ+k8BlQ8OK6Kw8BW3/ub+/zJYtVuhuCiVKQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c0KE7t2ugCtQVG2z5ODd3zS0a8d1AvP9syLtDepNKjWPn1IhhCXcoshI/sEnCl+8
	 wHQSPp+3TGq4u5Wi/QMVMHOkpXbxByncP6VLbZw3ZUkk263bup75JZ3ylm+I1Ylo0
	 z9skloTnEDpRHhULLfnIeFjthKvMv3ptWVuE0zWRUAtnz9x96JNUg6gyMjB5Un4K1
	 cNY3xpBTzxsDBM6ZScSDmbi7UIi07AAndTowxl9Dia7lYpV4dbU78G+9GTZZOcPRr
	 as+D3wSblqGdM8MONAcLHxd0J0KmJrIRwDSx4Gx+23NBUiVzP8xYRSn+BFEbudgQp
	 zEXqVX3ZBqIU4U/YZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrwrx-1x9H1D036r-00dOEP; Fri, 15
 May 2026 09:33:54 +0200
Message-ID: <816be07e-2cd6-48fe-ae93-57fa0f2543ed@web.de>
Date: Fri, 15 May 2026 09:33:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] trailer: change strbuf in-place in unfold_value()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <9629b0c1-b28f-4cd2-8d59-67d909ca9052@web.de>
Content-Language: en-US
In-Reply-To: <9629b0c1-b28f-4cd2-8d59-67d909ca9052@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zoxk3WeCWdaycUOgQds73ltAfnu5+SaEMg8u7eZMB0IusbbyyB+
 Ux8P6fq1Gi57YPL9N4BOGvPWT+44+Hb6pTR6Vr4ScRamVSTwm+fDaXt4Iny0IdOH7XFX0xz
 oTVpyaLxm4/HqVouS4bfHqk2r89/WpraImKF2S0z0wlE7Dwu8FIJQZF0gF3u3XLaoMXqcJS
 FGtDuzTtDB4y+GDDND5SA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kVcWiqs2lRs=;BemGL8o34PBpXKpzPEOzGT7hlhl
 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
 r1GLXHzIYuYrigw==

Avoid an allocation by doing s/\n\s*/ /g (replacing NL and any following
whitespace with a SP) right in the strbuf instead of copying the result
to a temporary one and swapping them in the end.  We can safely do that
because the replacement is never longer than the original string.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Formatted with --function-context for easier review.
Changes since v1:
- Removed always-true comparison.

 trailer.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/trailer.c b/trailer.c
index 470f86a4a2..6d8ec7fa8d 100644
=2D-- a/trailer.c
+++ b/trailer.c
@@ -988,29 +988,24 @@ static int ends_with_blank_line(const char *buf, siz=
e_t len)
=20
 static void unfold_value(struct strbuf *val)
 {
-	struct strbuf out =3D STRBUF_INIT;
 	size_t i;
+	size_t pos =3D 0;
=20
-	strbuf_grow(&out, val->len);
 	i =3D 0;
 	while (i < val->len) {
 		char c =3D val->buf[i++];
 		if (c =3D=3D '\n') {
 			/* Collapse continuation down to a single space. */
 			while (i < val->len && isspace(val->buf[i]))
 				i++;
-			strbuf_addch(&out, ' ');
-		} else {
-			strbuf_addch(&out, c);
+			c =3D ' ';
 		}
+		val->buf[pos++] =3D c;
 	}
+	strbuf_setlen(val, pos);
=20
 	/* Empty lines may have left us with whitespace cruft at the edges */
-	strbuf_trim(&out);
-
-	/* output goes back to val as if we modified it in-place */
-	strbuf_swap(&out, val);
-	strbuf_release(&out);
+	strbuf_trim(val);
 }
=20
 static struct trailer_block *trailer_block_new(void)

Interdiff against v1:
  diff --git a/trailer.c b/trailer.c
  index b89fa12fe7..6d8ec7fa8d 100644
  --- a/trailer.c
  +++ b/trailer.c
  @@ -989,22 +989,21 @@ static int ends_with_blank_line(const char *buf, s=
ize_t len)
   static void unfold_value(struct strbuf *val)
   {
   	size_t i;
   	size_t pos =3D 0;
  =20
   	i =3D 0;
   	while (i < val->len) {
   		char c =3D val->buf[i++];
   		if (c =3D=3D '\n') {
   			/* Collapse continuation down to a single space. */
   			while (i < val->len && isspace(val->buf[i]))
   				i++;
  -			val->buf[pos++] =3D ' ';
  -		} else if (pos !=3D i) {
  -			val->buf[pos++] =3D c;
  +			c =3D ' ';
   		}
  +		val->buf[pos++] =3D c;
   	}
   	strbuf_setlen(val, pos);
  =20
   	/* Empty lines may have left us with whitespace cruft at the edges */
   	strbuf_trim(val);
   }
=2D-=20
2.54.0
