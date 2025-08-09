Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6134627F01B
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754728479; cv=none; b=Fy7PNjnrF3T87OnvBIhb9L+5E513UV29D4hbIVmYsYF3DPc0GVR5qk4R4Dwqf2NLT532sHu1T39FzhmQNTBYi4O1k2umLZddu3EZjh1S3MAau7pTmdMUloL2wcrP+DPmg4c9413LsNUbbH+F+Vf/f29ysb1uiunteDQoO4RJ71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754728479; c=relaxed/simple;
	bh=GjhRkwTHsefv4Co8jpR+lJ1pS8OP27AUg1iGxUbmsTw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MqO+XIdBSlV8M2SlZBUVD0f/tR7ijRBC0xdctZEIfCaBOIi7RQ3bAIksCwzrPEbWPWLToH9sZCrtHcoJWa+VTQec+h/pBr9+1aRdzEGs+1ScUv7beuGSpldjbuZN0WV5WdXEQ34yUP5T9cFhIhtwIkGF+IAt2/El49QxkvxDp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=lK9XL97g; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="lK9XL97g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754728474; x=1755333274; i=l.s.r@web.de;
	bh=ANuQrGhxGbooAJm3jk+6bPxHbbPUPnzNSixao4XIWXE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lK9XL97gKTaW64EuFVBblp6FaPqNefQxhp/TBgYaX+BLmXaTisH0PGUSp/SZQNoA
	 wR4TNccu8mmSe+oclG7QZW8AoGMpkSdIuDnGtnaG7H8Arwicotr5eI/iH4R5iP0Cr
	 4JnJkwgl/yoDf+S7pDwQGEjs6BAzFJdOb3k14wt5z4gMc4dDRAqQ7DiOxCX+us9Lh
	 6iuo8/IHxhX6XlQnobTc4XUTqUPocb0SduowmKjsFC7YpPy4tv4//eMEq5vwurO6J
	 z9SV1qek3wkfu7Ac8cBPM9nG+mcr4ehGsH7VGxKG2pszIUslx2pLQ98Tp0w3eRbaQ
	 V/0DgPnlGR6nTLQ4LQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.110]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGSW-1uswQQ3ISg-00GOXK; Sat, 09
 Aug 2025 10:29:16 +0200
Message-ID: <1a32a666-fcf4-4f05-a468-2afa07fa0e2d@web.de>
Date: Sat, 9 Aug 2025 10:29:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] for-each-ref: call --start-after argument "marker"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lDkjkl0TlsPyYCETwZDFZjMkH/vZ7wVH6K9bsXZ6LLNDGHRTaZS
 hpO+Bl83peKf9+Mt1w3lA7e5NPvoqNtpJ0WI9eL0h9H4VpQs6Ipz/vPdbf1rokhdrtfUSMd
 UUcw7SzC1qEMrdru5SKBouyDi0OojsPCpAOQjABzbPer/YKl8OttnE/SURU6erlIcH+YW5B
 N0P7NjXLLA7xSmSy9nchA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ng+RzLqA1q0=;ME6mcXf8ct0XVBf8UCMcawdq2to
 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

dabecb9db2 (for-each-ref: introduce a '--start-after' option,
2025-07-15) added the option --start-after and referred to its argument
as "marker" in documentation and usage string, but not in the option's
short help.  Use "marker" there as well for consistency and brevity.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/for-each-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 8b5fe7b65e..222637a2c0 100644
=2D-- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -46,7 +46,7 @@ int cmd_for_each_ref(int argc,
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <=
n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to =
use for the output")),
-		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-after"),=
 N_("start iteration after the provided marker")),
+		OPT_STRING(  0 , "start-after", &filter.start_after, N_("marker"), N_("=
start iteration after the provided marker")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_REF_FILTER_EXCLUDE(&filter),
 		OPT_REF_SORT(&sorting_options),
=2D-=20
2.50.1
