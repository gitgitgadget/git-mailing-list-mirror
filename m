Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043C139CFF
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720976833; cv=none; b=fiD5+BBWB9lqQKBx1s9tQRXXlsCLJvpLmIZVmTRy5r//xgQFq26epkdlyYsUdcLvp6D7EpCJXf92ftazNYy+DhZNf1rcVs7R/+qsrGOxwdVQ/95p/K6zF31K8ZH2Tj4RrGGAVTsbUAmKDV88c34Pr6reqswPVAtDm5VcrsLcVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720976833; c=relaxed/simple;
	bh=ZUlzLBQP6Q+7mNfA2rPu4UhqhVVZ+kUxOvpAiWtVI+Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qf0fstI8Nld3RRzIVw4G4aZI1Yjq+AlQI9INLJjGF4GNLRXSfF8cSX7FmzFur2uW8CbkAokho6gNZUW1O0eFx3nQqJ0yCOLt03lXSaBFbOA7Yzm+7PGmo0X1Cck2U1SNJQCHDFHAlvRvmLq39wiKKvBuxzLzMFGsfuUE4EbNxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=aAZsC+Ms; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aAZsC+Ms"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720976819; x=1721581619; i=l.s.r@web.de;
	bh=+vbNgs09UKI7+3D2vIHYeGhbBeTELzUE+uGHl88xP3o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aAZsC+MssgxIpPOt5eLerlLjNLBKaCS8FRnE0wndRWunNIpQOQjAGMj2CVI8Sp0a
	 xktLhhasrhPbL8CDw52EaO3rVjorMjPyvcvQdIWdvKlraQWe5edh4BMNMYizWApV+
	 gVgr9JLoOVnOqEM04xiTzlGjZJQX2iFXyvZp7/616TZdl/h67fVaNuCB9Ewl3rBbl
	 zJlDL4AG1wXyEOIYZ3muAxeMEBd+RH6CsyWOb4VnH90s6S/+azc3JM0UBuAziBNdo
	 VTreMcME4wpHhwODflXZsxZNBEqalvi8Rt5w4BFI3NKwXYocutynknlCtcBpKSrGF
	 KK3exLycKwCh6y5gXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKxj-1rsdKq05EZ-00hYUI; Sun, 14
 Jul 2024 19:06:59 +0200
Message-ID: <075b3d08-4270-4064-8103-1fece055e197@web.de>
Date: Sun, 14 Jul 2024 19:06:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/1] t-strvec: tighten .alloc check in check_strvec
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Eric Sunshine <sunshine@sunshineco.com>,
 Jeff King <peff@peff.net>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
Content-Language: en-US
In-Reply-To: <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rUZcGLCQWLmVC59O4e1WHcmAcuU+oeW6KI9KC3MapeoiSkYWA/3
 vv+Dsb5A2yHqomwuTxQVyxUZepE5uW2lNUizz+XleN6JLHddq7w2n2QiCWx+mnarcXhFhva
 DttyJhy3zErPVIDK7kaDddoJbY+Roy3FwRHpWu4j7986PVOTCrkQqAuSv5dPg55pEd169j/
 XHVPiw4393xElrncsDq9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xqhFln93png=;OcWJ9T9MFionD0udJkyNefJYGLA
 ZlBg4kgn51p+Xr950UNh4kWMEiiO5k+PEZZPRlDY6uhOsbl/PIOPZyCYdR9Bs8u59Zk/dXc5W
 rF597+4luCyU4uQ9/TnHGMHZg02lpwWibgJ5Y+Tr5PpWO6yw4gu8tuoYAOjr7NTFBgUmZbAZ1
 tLm6GXsIp6FFw5rEZahxlTvh0RdDyt0dUGcSiijvD0kGE4R1zeD5RQGHa2aIQR9mMOCeKwfwP
 Yo8VFufoCSC3xDK8BjxhlgvuNbPLtCMtqMalR8+1CFiHlfS6SR0XnPwYJdGXu41rvkqDELiAr
 xgRIHIN3RbAfpSYexZKUhGYyNICKhePelB9T7sjX4cYGVVMr8vc5Qd2lcrD/jVsVq0SCOyoCQ
 Q5ffqR7JdgeHP4ULbwfTGvh0LFimWOVWaqZWdMyylQ0sQK/9hv6p3KZfv+8VmEHJazu5rMRr8
 VfsWYgvAaKBV7L/9wu2T5bbKBM/yA/1nnkG9frJbbNZLcA6gj4hMO0NBOG6jipcnjv53D4MPE
 B31eogzJ3eLlRVjEwdyTxEbeoo/3Hxpaiwq4sWGttPu9vVZW3JWFWPFML7IPbGiDngN2n3ke4
 oDNLwtZrkwGcoFMc7AhOr7TmzWTaCdoGL1Q0t3BQXvzOJ50gdiUbub6h14vh4A2+Y1YCfvXCI
 6NRTk7pNzJ/Gh5Wsf0J6k6QrZZssK6IjJTxrM85BOffgi7g/av0Rty6u4iVuK5TR1tBSWerbs
 7EMj40VsB/SzfFYAeQsTw2WGXVGhAOWv+pTw7KVTaUXEGp/cp6mNlo619UtroGupxrK0nr5dW
 EZRs12WyEJq93c6BrWCpWRtQ==

The members .nr and .alloc of an empty strvec are both zero and the
trailing NULL is provided by the shared global variable empty_strvec.
Once at least one item is added, .alloc needs to be bigger than .nr to
leave room for the terminating NULL.  The current .alloc check only
tests whether it's bigger or equal to .nr in all cases.

Tighten it depending on whether the strvec is backed by empty_strvec or
not.  A report for a non-zero .alloc in an empty strvec looks like this:

 # check "(&vec)->nr =3D=3D (&vec)->alloc" failed at t/unit-tests/t-strvec=
.c:55
 #    left: 0
 #   right: 1

And .alloc being .equal to .nr in a non-empty strvec results in:

 # check "(&vec)->nr < (&vec)->alloc" failed at t/unit-tests/t-strvec.c:55
 #    left: 1
 #   right: 1

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Bonus patch.

 t/unit-tests/t-strvec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index fdb28ba220..6a4d425840 100644
=2D-- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -8,7 +8,9 @@
 		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
 		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
 		    check_uint((vec)->nr, =3D=3D, ARRAY_SIZE(expect) - 1) && \
-		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
+		    ((vec)->v =3D=3D empty_strvec ? \
+		     check_uint((vec)->nr, =3D=3D, (vec)->alloc) : \
+		     check_uint((vec)->nr, <, (vec)->alloc))) { \
 			for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) { \
 				if (!check_str((vec)->v[i], expect[i])) { \
 					test_msg("      i: %"PRIuMAX, i); \
=2D-
2.45.2
