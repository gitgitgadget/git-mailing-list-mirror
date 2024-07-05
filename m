Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38A16EB47
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199034; cv=none; b=bynDddge7r4/6ehMPM8CueJoTtM0HkljneF4m7p5++9lDuDRpJqEefJxYXsbpbkkfMWXdePmrLZDvXBU4ixN2YfsaYfqegf/3yv56C9IU/sw9xRh292K0kyz8HK9Y23ANnTure2N6o2XRF1jsHaSE5AVw/zInqnjhNCowQO1LGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199034; c=relaxed/simple;
	bh=p5Hl3qr626AhKrktHJJPZqcpJC3SbyWSZ+JCcQglROs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nw54z5plEjlG+HNGNycQb1inEluglitQen29iJL3i3/tlf7T8G7dn4rfzjhrAuFXAgxL5+5lHqmIMBBoD8K3gYT5671741ofUk94Gq0ceJN6pSp6A7JTXdjv8F5unOJGr8GSQOjRF0gCoWv95bLkjTdiRh/HBo2QVXQhQOFXTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=O/4hsOGQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="O/4hsOGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720199017; x=1720803817; i=l.s.r@web.de;
	bh=b980dtSMZZc8e7eL62Y8/iZ204knM1gUohktE3WshL8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O/4hsOGQp5UQGg/81l7OksyCf8vxRJab6W+OtL95mW58hVVkUPVCEuwccR0nbFPG
	 vkcud1Z+Iksl+fZoc5F8Rys0G7pMG1GUn45UuEc6j9Zla4T80lrHAPwR+kJs9oyRr
	 Nkd8spaZ94X0LhTgvELpH71C5iJQ6pMYLk/VRbuZHctLD87ZGtgoNDYwXYfG+xFBM
	 RwGBnqmLkmVon9YKhH0Fmg2lCbooQVbE6KjX+GeurWwoWd72/vjCRhuO+TIiTJPwq
	 ur2BoRCSv9XwK2nreXDI+BC16Y6fQjudCpjEXq6421c36l5VN5kglqsmo/LLCWd+2
	 WaKeUDqXXnv8BFhpuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDQj-1rsdWI1ra3-00qYQR; Fri, 05
 Jul 2024 19:03:37 +0200
Message-ID: <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
Date: Fri, 5 Jul 2024 19:03:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] t-strvec: use test_msg()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Eric Sunshine <sunshine@sunshineco.com>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
Content-Language: en-US
In-Reply-To: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xV+O5o00taNiOMfMtRnU0ydMvZQjIOq3VnnDSlr2PBOzqTzqRKx
 RQ2/ktJQtLdnMNCNSJq/kIbYSHZcHsoIkZHJEWOdE0RC4IT9WFW8S6e0ovgUdPVw8AKCw87
 /MQ2PiugwtZQ5gE0+E2x1gdh0T9Gab3jo2WHAoTWNhBks3e7QkJa0XFrILZ/1xGDFAP7Xm7
 DyWhcGkMkEuub5rq1wnIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9mxSvAoCODk=;qw7i+M5faa+ZEvopxafahhoV0qb
 JDb7iZOzozof+O81Kc85Cr/S2SzsORbXiiGoNJeTE2Q7keD7Np6j7Qgd1GlJYqVc9tL2xBVYm
 DOcghroEtxR1bcdyCtSdNgFrauHKSkR1wy8pgaSuz/s+10JZbUYPNNzIRw293RuCNbXME0Ggy
 odS8fD9CutBQig5ILb6/HjXfnTfkMs05yJp6cdWv1e81cwyfER29FMIVpf57sPMKT8xaz/iTX
 Ouxu/S89NgC8E3edKiayMWPjtIa7ur7Wpi89ItYhgVPqQQNDWfmSI/VeB0CCkSlDmG0iwLMQB
 xEi+9ybyC7UyEp6mpJU4qO8N0/Ogc/14G1ncKpRB/7awAMl53e9K1h4oN8aHesNiYRUg9GEEf
 Tu/1G2MtPbmDqqqQyoHhchI7kv+TnTROAkmyscUF2EnJewec+QhbLWwv2W66ah5h3H+8g+XO6
 7Nb8mvRRp5b1XhqjsHaXS9Ch5C/tY6GBST7Tr4wLz/IsnmY94N1N40n/gXR3oEGqKcqtR3SCo
 FQJu4j7X9UGmXLyKz8kRQEegcwWe772UkuOUZALxiSfqQSivAcWNGBX1EyPgesezmoVXVLgXd
 ue+StqcMZAsZOaXcztDuzTAjsZM8cu7UKSfqMhPGOtda/msxH/Dt2gCZqz7fpxqCyQSJ0FP8X
 zk9tcuNURK5hBaGs0S7cju+3lWdTVDPdop3mb4ddmBoSlruiegICVYdSmHmvWU5WyNkhYWI8Y
 /RUx94tKaxgD3LB87xZUYh2xvlRhKMCdfqTl4WwEqJP2VKdaVH4s6Ed3C3MEGd8P17ZTIE9HP
 ZUtUUHCdIXFc9AmZO/O5h+PLzx+eSogQWi6iME69tSjSo=

check_strvec_loc() checks each strvec item by looping through them and
comparing them with expected values.  If a check fails then we'd like
to know which item is affected.  It reports that information by building
a strbuf and delivering its contents using a failing assertion, e.g.
if there are fewer items in the strvec than expected:

   # check "vec->nr > nr" failed at t/unit-tests/t-strvec.c:19
   #    left: 1
   #   right: 1
   # check "strvec index 1" failed at t/unit-tests/t-strvec.c:71

Note that the index variable is "nr" and thus the interesting value is
reported twice in that example (in lines three and four).

Stop printing the index explicitly for checks that already report it.
The message for the same condition as above becomes:

   # check "vec->nr > nr" failed at t/unit-tests/t-strvec.c:19
   #    left: 1
   #   right: 1

For the string comparison, whose error message doesn't include the
index, report it using the simpler and more appropriate test_msg()
instead.  Report the index using its actual variable name and format the
line like the preceding ones.  The message for an unexpected string
value becomes:

   # check "!strcmp(vec->v[nr], str)" failed at t/unit-tests/t-strvec.c:24
   #    left: "foo"
   #   right: "bar"
   #      nr: 0

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- Typo fix.
- Grammar fix.
- Reworded problem description for brevity.
- Qualify "name" in the last paragraph for clarity.
- Add sign-off.
- No code changes.

Thank you, Eric!

 t/unit-tests/t-strvec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index d4615ab06d..236203af61 100644
=2D-- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -17,12 +17,12 @@ static void check_strvec_loc(const char *loc, struct s=
trvec *vec, ...)
 			break;

 		if (!check_uint(vec->nr, >, nr) ||
-		    !check_uint(vec->alloc, >, nr) ||
-		    !check_str(vec->v[nr], str)) {
-			struct strbuf msg =3D STRBUF_INIT;
-			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
-			test_assert(loc, msg.buf, 0);
-			strbuf_release(&msg);
+		    !check_uint(vec->alloc, >, nr)) {
+			va_end(ap);
+			return;
+		}
+		if (!check_str(vec->v[nr], str)) {
+			test_msg("     nr: %"PRIuMAX, (uintmax_t)nr);
 			va_end(ap);
 			return;
 		}
=2D-
2.45.2
