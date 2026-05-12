Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8338E8BA
	for <git@vger.kernel.org>; Tue, 12 May 2026 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586972; cv=none; b=ZcolrslqvCIZnA0l1ImvsaqLNvlJRhZ+duGBYuKgUUQn+wAn2h9U3u7GjxH9bfZsvieCRQBWQifCHbV6eSMTOt8tr3GsNVnKru/CPUbwwSoYLXvel/GayZ+K9CvEmkeAA39051rqHRpCPIOuGrrbIhVyiD8daG9F8SQ3SJxj5gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586972; c=relaxed/simple;
	bh=9MIENaljSu/GXBAE5UJovp7blAp7KI+EV4dJT7wymu4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw98UXBCZofgUqSpbPwl2C5XTyhOWjw35yWbu8v9BiftVNQkhh1xvXyaVC7kQpWMX1RxHBqU2+KF4+H22rJGa2ol5JidbIKoclL+EdaPErahcuB78ZaE/pI3yKeDVfy14x5fy1hQpUiK2+zQbK46kTiooMVVJ3NHtI7i+LRJVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Q5pPTyDl; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Q5pPTyDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778586968; x=1779191768; i=l.s.r@web.de;
	bh=/KvS8qnvicffd1isBhyS/gXJ9lAYFU6Y2Ft4VVnj1Sw=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q5pPTyDll/2z3yRx4BoDpbHOZY1kOj7t32ZmJ9PiB50ei7OCO7SxZ1xVnZcHTZRp
	 OxienFIiGekBXpeIE3n9RuU1zactTa1NzuBQo4QQyG861twUoisZeYmGciAK9j2Pt
	 JfsrpXStNghFc0IINk0umrqNK6TV5y2dJ0fLsOl0PUscsPPS3Pg/uo+fed4KHeyxU
	 X5tGhxVEbd45GBv4W1/0TWZ2RZFlStmyLuXzEJvzh5BjMsQrKSPkXvcp5ZTyOTQ6s
	 6V/2Rd70XDIv4ce8X4rRI/Fj+ArdnWokQsrAHom7tuFXvvre86VOMex2Zq38QydOI
	 VBJU1ROh/qQxVFKBdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3qK-1x29Cs35yM-00gE8l for
 <git@vger.kernel.org>; Tue, 12 May 2026 13:56:08 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 2/4] cat-file: use strbuf_add_uint()
Date: Tue, 12 May 2026 13:56:01 +0200
Message-ID: <20260512115603.80780-3-l.s.r@web.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512115603.80780-1-l.s.r@web.de>
References: <20260512115603.80780-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:idZy65BWis1NVqaGoo59lG1UDFXO/4KEk4bwi/zjuJ6f77R6dxo
 EEk1cDBDeBTR0C/gTV9sEWu2b6BFfVf9/wq9msN78AYYVm4crwjcG/XvJJWhukMXcA3+Wtm
 J3hSssOM4cD6eMTEzKn6dlR1iZYw/yiO9TVLHiyn1g284KniPNF5upxBpeeCdtYm+iIYUdf
 Qc9q0dU9a82s0piZUipvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e0A+WECViik=;gGww1OXFMQBg3qenmrdyvD1aCvk
 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

Speed up printing of objectsize atoms by using the specialized function
strbuf_add_uint() instead of the general-purpose function strbuf_addf():

Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check=3D'%(ob=
jectsize)'
  Time (mean =C2=B1 =CF=83):     751.7 ms =C2=B1   1.5 ms    [User: 733.5 =
ms, System: 17.1 ms]
  Range (min =E2=80=A6 max):   750.5 ms =E2=80=A6 755.0 ms    10 runs

Benchmark 2: ./git cat-file --batch-all-objects --batch-check=3D'%(objects=
ize)'
  Time (mean =C2=B1 =CF=83):     720.4 ms =C2=B1   0.4 ms    [User: 701.9 =
ms, System: 16.7 ms]
  Range (min =E2=80=A6 max):   719.7 ms =E2=80=A6 721.2 ms    10 runs

Summary
  ./git cat-file --batch-all-objects --batch-check=3D'%(objectsize)' ran
    1.04 =C2=B1 0.00 times faster than ./git_main cat-file --batch-all-obj=
ects --batch-check=3D'%(objectsize)'

Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check=3D'%(ob=
jectsize:disk)'
  Time (mean =C2=B1 =CF=83):     404.6 ms =C2=B1   0.9 ms    [User: 397.8 =
ms, System: 5.7 ms]
  Range (min =E2=80=A6 max):   403.3 ms =E2=80=A6 405.9 ms    10 runs

Benchmark 2: ./git cat-file --batch-all-objects --batch-check=3D'%(objects=
ize:disk)'
  Time (mean =C2=B1 =CF=83):     378.3 ms =C2=B1   0.9 ms    [User: 371.2 =
ms, System: 5.9 ms]
  Range (min =E2=80=A6 max):   376.8 ms =E2=80=A6 380.2 ms    10 runs

Summary
  ./git cat-file --batch-all-objects --batch-check=3D'%(objectsize:disk)' =
ran
    1.07 =C2=B1 0.00 times faster than ./git_main cat-file --batch-all-obj=
ects --batch-check=3D'%(objectsize:disk)'

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/cat-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d9fbad5358..62160ca9d4 100644
=2D-- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -330,12 +330,12 @@ static int expand_atom(struct strbuf *sb, const char=
 *atom, int len,
 		if (data->mark_query)
 			data->info.sizep =3D &data->size;
 		else
-			strbuf_addf(sb, "%"PRIuMAX , (uintmax_t)data->size);
+			strbuf_add_uint(sb, data->size);
 	} else if (is_atom("objectsize:disk", atom, len)) {
 		if (data->mark_query)
 			data->info.disk_sizep =3D &data->disk_size;
 		else
-			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
+			strbuf_add_uint(sb, data->disk_size);
 	} else if (is_atom("rest", atom, len)) {
 		if (data->mark_query)
 			data->split_on_whitespace =3D 1;
=2D-=20
2.54.0

