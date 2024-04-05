Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B381316ABC9
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314701; cv=none; b=VD4Y+ERGZ2FfTa7kS2LbT3ak1KgATJUr4347plN0jhPlRtX56VwTcJzpRuU4sqwiT0ppSrs00Q2jx81EttuOkxRy44XJ1g9ujTTj3yfPUm9UNdBSk58bpo8212+o8O/4FdI3u24sifeB56VITwuoe9Mwth4duBI4QId6P2nBNjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314701; c=relaxed/simple;
	bh=4e8DfZ+dvBb1Ue4bV/S1qhJX8ssIJcCkns71v9hqThc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=alKNv9JGL4BpL1B9900t5KnHAuVlFhPymsHRTbWnGtvHGH8zb+xFOchjYfO7hdTUEMS1sHPSNP+cndeA0XKCFu1NNM8xZlhyWuXaWQT8J0ik2tQUFVLwk4o1ZqWm0gWZaaR1/qu0TYcHO6WzNx2+TkuBEABdvfOzF5XI9jkMlmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=SOqpkaHo; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="SOqpkaHo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712314696; x=1712919496; i=l.s.r@web.de;
	bh=56u6P8gaHJI7T4sP0xdjqm0KVEH8W/dIAXUlZj3k3p8=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=SOqpkaHoTfc+xMBtmLF+/6zqbdO70Uhi8ubuC3xhwKfrxgHjdNODZyw4nWQNWUUA
	 k8xqnM6Wk9kMIOxhVVeqClNwGdQVw94yuXJWq17iHrHxyxDNLI6AiUlS+AmMe/f4y
	 mlrktLSL/VjHnijeRmJ7zV0raaFklCV+geIDP+3VF6ZRQU5tp+Y1wCAZW2QcTlRAc
	 mqDJCKrBDG+AqgZHTZV5ltFEpE58jCgwU5jxhYnieLhuHrq0ic8/o21AUxTjyXYFt
	 5UBJw/pp8fFddPco7Gh5ep/6NhNOfI4BIYo+KC6CWCqU7vwYm3ntX2M0mbiFDtU6O
	 EjCyHCkv30jt/qrbWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.225]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5Ug4-1stkQc2nog-016wjf for
 <git@vger.kernel.org>; Fri, 05 Apr 2024 12:58:16 +0200
Message-ID: <5ba55ee4-94c7-4094-a744-584fc623b391@web.de>
Date: Fri, 5 Apr 2024 12:58:16 +0200
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
Subject: [PATCH] apply: don't leak fd on fdopen() error
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dVPfHHZSKOcoPZR1DnCM8AmIuj7QcmZKqAP1oFmUBC0rqflv+vW
 CjssJjUZA2eP9tKVaqVht1aJMIw16hVxi6BiXXG3cqzEI+e6tG++AdCmIhnSZWdaXrevzJk
 r69CHT/SZZDMO0hW/SU841dCZ6BukbAO1EJLZEL6S7tKO7nmnchUER63sNkW/CCj9+hAm3o
 UJbxDUIMGeQjnyzpaftNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tIJc/1tMQ+0=;hXW/l/kYGtX9zFBlrH4W6qdeYpe
 PdiaAUzrbLryBwDlzU4YkXEL29LkKsdoEd4613VMk6PljIwyueq29/NYQUDj+Kfb997YnPEcU
 fTyfEeqUjdUdkmQ/SHZXYEUPha7Mx3MuyYxc5KT/hGTIWuqGvFIdXmc0DhyOsIA4q9x3Dlxlq
 W68DUaslc3HV7CdtX6y9Ymd7IbeZ2B2UkIp3/uklYOHfXam2Enain7NIyg0i5cfEaIfGZsD0W
 Fxe+0p08Tr6SuYyQwUJ1P4NXcHlaQoNkI1NoPTJnku9/RNlBxm/6Ii2y3Rp4aEQfPAPMOui1Q
 WjdeHoegLMDu4obbCDc1KwMSBb63Hqi0hR2pHVgRHjHqT9QI4dwA5eCNkh2r+Wl9giSK6UUlB
 YYUNlf6ZuhLbXgiqy+vhHBw2UPqJpkVKnh3drLN7DKbQR46/KEPoc9AB++jvFtbp3+Est4k92
 KirTCgK13veW+0nyjlj54l18DokHcWJfNsHJRi54OZGaXK5j5SgMbcaOlOyXAg9H0cCPG5/bX
 ltRUe1nufD35adpEqZ1eljetcAJY5pOFIUbvijqAs9WbAmZ9iuXt7ChJL3cG97EjCBql8iFRd
 T8j2joeWAyPT6W07CtZJEV/9pd8zClByBfOsZSDAomVWPcg/4DHnv8ovHaN5nxdfk1Y5GMW6U
 nXMLn1viKOLzPlwAR6Nq9WqFx8BSERU7XWuYub5LWonIyOqEt/huL8D1XYwV4jTGd8WoPZsAI
 zXbumPscTx728B4wApdcr5C+MR0aBP5oLcdO/rOU9/tIqx7X/DWUypZUBwmUZa6TiCf7z6qoG
 EwSqEBoFeCvrkjkB3l5+xE+yprmbNtGBrlOBTjJ43z8ow=

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 apply.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 432837a674..1cfbc2f074 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -4655,8 +4655,11 @@ static int write_out_one_reject(struct apply_state =
*state, struct patch *patch)
 			return error_errno(_("cannot open %s"), namebuf);
 	}
 	rej =3D fdopen(fd, "w");
-	if (!rej)
-		return error_errno(_("cannot open %s"), namebuf);
+	if (!rej) {
+		error_errno(_("cannot open %s"), namebuf);
+		close(fd);
+		return -1;
+	}

 	/* Normal git tools never deal with .rej, so do not pretend
 	 * this is a git patch by saying --git or giving extended
=2D-
2.44.0
