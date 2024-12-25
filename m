Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237E22615
	for <git@vger.kernel.org>; Wed, 25 Dec 2024 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735151936; cv=none; b=HgnpBPVQFjhYMLNrStOWeI6AAGOio3AJVNBH6gOLWyAJw2G2X+zpH5FM/Yn269HKRTaoyys3qU6npSvqbRWKyk8Jv0BOm3tyQEOT6oT7w15s+XI22PpjpL//6TcuFr9HAZW29P7E7cdGSf3EibfpCot9cs1U2I2eccl+iKjmf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735151936; c=relaxed/simple;
	bh=AMvxWrJKXlKe7act6hJa8/4dxI7g1era30ZozgVAgIk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eRCrvffleCZPo8bpUV51Qn455OA0wjgufmq1k2KMEzDST/yKkF7KMH8pe1V0FxV14KodB8TlZxPCRGHLecAea9+fv85sqfECjwxQonFg2EmZNWgxskjIAp521ccnIIOLjxCMNtpBJy3AirSEBdd9y6iNRYoQYUv25+cgWj5CAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=uEWpC5qq; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="uEWpC5qq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735151930; x=1735756730; i=l.s.r@web.de;
	bh=BHk3O0sM//TK8QWaIGxz1AQbFuItjLHdy8eY9u1Bj/o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uEWpC5qqhhcuPTmqTKENDAWvzBR+9PECEDdGxTwsHfNjVw7MQKt2ahCbbJz4uBEg
	 13iXg7y4m0a1i2ay7HC8ueEVir68rVPJC9S11IYTnbfzYwMZ06ukG9CQzCr/Poawc
	 8rlv6Y1NxlysK6FbtgUtJwHMWrnMv3gZv+hymX1JjE6WyPFvCmnNrwQp2ICFwOjkS
	 XYX3YNq1JNvNcH8nX7sd7FYRtXEknYSZd3PmFcS6CjcH9WLon3lNgpQPfbHLV15W7
	 +Anr91zv+UqhyM79RwhnBzFj7ZRPbjxfq7Jcy7eb11jRKFjcBv7hCZafRyS1I+qCC
	 XclGP3IHRdilcaUXrg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62uQ-1tbc8I0SZE-016Row; Wed, 25
 Dec 2024 19:38:50 +0100
Message-ID: <6084c017-9557-478b-b485-a1c1a21842e7@web.de>
Date: Wed, 25 Dec 2024 19:38:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] t-reftable-merged: check realloc errors
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Content-Language: en-US
In-Reply-To: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rDljamnGyIvyYxt+Ot7PpKMf6hyLFgg/5awLj47J5WAzf0oQczX
 Ym8aHaEi6GpzQdXqxHcWKuD8DqjfLj7r67XiD7+W7UV9uTyeeP5z/caYZgvjJOQKWuVk42U
 jRXL5amzEDFG0od8Yds/IB9vN6cme+jswhxJksYMu6FHKCwl2KVbwM+j45KNhTz7Cq6h38Y
 2nfsBBMB/xX/dgxaVfdJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7wwFwaqJFrc=;mje3eUYmiiBuiVYyxqaqkzo8GJG
 h/T2+gHR3df4MAuHECkzyQWKuFSMEy9DrnTy7IXQtg/6gDwKdOB6QmrA14vjOKsqQOvYtiFuA
 1n1vzlgJa0/U9H2RoPv+oUooXhoKPZO8x3waIU93/xyZaLl8dertK/N3JZJr5xOxvflE1ZRRM
 f4TyTN5rW38RL71W4ZyBNs2Hg3ofIGF/MM+C0XdorBf0xidT2schepvfUZZ2D35NiFJnex+lv
 tvotitkiZqpiK+o8AtXlhJSb+B1PgZpyJbmMsWmsCJSZzu1MFvFH9is8bmQwkWcGH1qkN45v8
 li16dGpvJjuGCU20y7u+Md71Afu3bzevVG8LMcM0XaBPle303QjG0BVtuHBiTIxctXw5C0W2n
 pZ5M77HKwLPSPC6Am70e+fbwLu4pZzf/4+8r2OiiUCq4UBBxW6C1MQIBQEy2MZ9O4kRddnWGR
 i39+J6HO2C9Ooi2UX/hrJTzKgF9gnZh6IqigKbn/TAYPCDekLT34KugikcsimkXYfDifLRAg1
 NeXki8Wly/ANOZ5+UY10byMCTp1Ar68J4of/QoI4ZEo7zXZMmbdzhDlB1P/a5aCRWnscctHly
 2hiFKKrnha7TiXi5ZUZ4hUPVOrpPHw8TR9Ob6WEvka2dyJDznBBJHYOt1TzOSbhXkl+JESfab
 uqKJi93KkH1nk008VeUifOurosRUX/OeOc7ExgQHJoJ20P705FGcfjfSNFI6q2tbzB0gL63F3
 ld8sbW+Wr2FT2/4hn80y/ZeYd6iSed9UFF2NcJi1OUmnxI00Sg4jQrBKMVFASB7/LOPEIRuI7
 4MJ1TQNpAcReUqfD0qRvPpm8AnBoeNuzJ0/NyJYtgvt0Tze8t5GqUEQhL/QubapFptnwVmQQ7
 w9Y8yZQqJ83fidS+1k/NRKuUhN3Epz/Gg0a6hW4Y6DLzaRNYn5CyAX7WDttKVq3bJb0CieA34
 uxU3DZ+K6usvUIqgExUnX0G4uvmC9IFWojFPgKtX41G8upHn7/KGme+Plh6IeAIDPu/EEFKem
 MRzCP5DZHDidA2vvY19WkvHUnuDnVwJ7GcoxcqypEODdfgEpAxfiKCXbXjRAllyMUyfP+C207
 zW39QSCv8=

Report reallocation errors in unit tests, like everywhere else.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-reftable-merged.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-me=
rged.c
index a12bd0e1a3..60836f80d6 100644
=2D-- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -178,7 +178,7 @@ static void t_merged_refs(void)
 		if (err > 0)
 			break;

-		REFTABLE_ALLOC_GROW(out, len + 1, cap);
+		check(!REFTABLE_ALLOC_GROW(out, len + 1, cap));
 		out[len++] =3D ref;
 	}
 	reftable_iterator_destroy(&it);
@@ -459,7 +459,7 @@ static void t_merged_logs(void)
 		if (err > 0)
 			break;

-		REFTABLE_ALLOC_GROW(out, len + 1, cap);
+		check(!REFTABLE_ALLOC_GROW(out, len + 1, cap));
 		out[len++] =3D log;
 	}
 	reftable_iterator_destroy(&it);
=2D-
2.47.1
