Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FFDC433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 09:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhLRJrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 04:47:18 -0500
Received: from mout.web.de ([212.227.17.12]:44495 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhLRJrR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 04:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1639820824;
        bh=pjA7sTc23hakqzHJI0gY5sjpr/iEsirjuB5YbDFSdeM=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=Mj+e/1KIBKOJz0mQbWAC3UISMMhZanNLbqPi39wu+1TzxycRkc1OofR4qtZO05/7+
         Uc9aa7AIZ5TtLJLaFuZAoXPpdB98twEwAdytg3XvrRSg+pgNxIj9hEgzHyd1dj4Z77
         KtlmDI+tNFuC1IdNH2K1mkjzn6iXrFf/2a/zpgeg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1aDp-1mwaMV1hxT-003CNz; Sat, 18
 Dec 2021 10:47:04 +0100
Message-ID: <5b151dc3-d4c7-29d3-71ed-a79033693d5d@web.de>
Date:   Sat, 18 Dec 2021 10:47:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] daemon: plug memory leak on overlong path
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LVr0RrRnLgX8Codyt8kmmaHPYbckX4zRwTgWDCJJtn+BMbz26Vi
 O331/i38q4p59Wqrdu71qWA6GI9k1k0xJwxP54SW5ycQvSztt6LxXj+Ffn5IiRJd81wCU83
 QQvxZ/R4qi1OFbrLBT7fIJQG7RP8/e14ERrz9XzH7Lm8JTK2uojwMx5E/6muB89+H8UoVqQ
 ekOhUJBzRy7Olzo3+TadQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QsMcjt0U2Uw=:mxNAIEeuq0Cnnq8hlYGFaj
 FUXU11Km8nDHz9SL+R+XSRd+LsnVwHGPGRq/sxfJfpWTydmZ4REohSeND3e9yjCUyLiOecShj
 tu5Z5AlekSeXg0WjESzcTxb52ZJJpk8JzIvJaoOZUWiHRFwoSW44225V9MArhGRX1fCA5G2T8
 7V2MrD1/2ruG+bUgsGbCSHF1/+GCQOaQYkejtGQjKTgyvg625MQZLh3SrpcCiDUFprxGvtQaz
 4p5BGGYa+EuHCehEqdaNiVEKmXAwogoy3Kr/tPdO084q4M+b+LApH4Bm55u7NSzf5zbgkMOwM
 b/hN0jhT7j45loSWS7Y0dFM1Nk9b6iQJhMUk7JkL5Nfhgw0jpfFOMwanC6s9EXBtIxJMLw85x
 BY8A01eOEgKw92XLkmlI0MycxJbzL7GzKyRGjeylRYKYoaN8UOtBh4EfY106oYunD/8XIGeE7
 FpBLHwjsa7BwOTDzrOEHZQnm3cKGnEM8dO+/YtJKnx7VxLpj2oVr8nzJX021bQ8rzHK/kDN0S
 OjHz6yIf9OkaZB5a562EaMhTiV97AFXAf9uIjqmvPIIe7S9ofiqp4vkNngspJJKeEzV37SgCT
 eAhrWBySlVNv2HlVn9a87/0fCpnS09p0AMLZMTw5zz3Pu83O6FIBwYKrnvnLI32RN6fihTzqy
 J12enHOjNJ81BNji/9DxW32KN0SifEUd737jmQ87sO5SV6HEFti6dr7177VJH6vD/2W2BpqhD
 RmD1Cgt+2hKOfvjYQwUdQCVcgC1nCYNuZJfwlwDB0yuusYb0NOOEU3fHxXMWGwpBkJ1ut6IWq
 0/W5ddXRxWNAEU0qIGZF2Gewif+x7LHcAbzQ2n45hsDOiq75nHkSyW046JYWE4kKCmyM5MuTx
 JExMFz/RXDq4e4LqHEZ1lzCWXhaVpI+2joM+dUieTBYS/zLPqeJSrV2wGXMat4e9HI5v+Jfoi
 hUS4Gs20d1KUjPRtwmxNbzUoit7MShZ8/Ub673yKFkyMlWIJV9AdrJofqo+1a7CJshyrCG7+F
 5R7FUb4eh3BoYU5tgCSWvepyyyGC2PnYD/iKNICbi/72pq4qFrWsQuJ+mAorj9AgIQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Release the strbuf containing the interpolated path after copying it to
a stack buffer and before erroring out if it's too long.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 4a000ee4af..94a5b8a364 100644
=2D-- a/daemon.c
+++ b/daemon.c
@@ -232,13 +232,13 @@ static const char *path_ok(const char *directory, st=
ruct hostinfo *hi)

 		rlen =3D strlcpy(interp_path, expanded_path.buf,
 			       sizeof(interp_path));
+		strbuf_release(&expanded_path);
 		if (rlen >=3D sizeof(interp_path)) {
 			logerror("interpolated path too large: %s",
 				 interp_path);
 			return NULL;
 		}

-		strbuf_release(&expanded_path);
 		loginfo("Interpolated dir '%s'", interp_path);

 		dir =3D interp_path;
=2D-
2.34.0
