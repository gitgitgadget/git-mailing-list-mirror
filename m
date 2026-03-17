Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8932B99F
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773755290; cv=none; b=oWKMW6W2YTYcfohH/76fH8SfMCDr/LiZi8ZqJrndEym5/XCRtMCezZb097OzXaPhKS2h7dwcu1fXrOGsGUC52BIzMOA/ETxYAlUJSADq4C3DArh+D2sEhswc2U9ZDJ+qYU6osyVeUY2+qrmExm+Z+hCa/vogFya0+3i6hiuQOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773755290; c=relaxed/simple;
	bh=vPr04lGG+B1Vl2Y9n/KY6LOQX1OwPAH+3CxriK7QHk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7D12ILi6VuJl+dqayReHjM6FwJg2luD400WIl4lqnKTXyZuiI941WcUo6C82qg0f2tvUhenE9GXpo7sNYcY9ojuncI20QE6Vgy70dpr6YLBvRfNsV1TvohJl97bgnbcsqmN4z3wd4GEystSPZbIKMON2+UYJ1UE0k/haxLaQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=eAAPJCvJ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=xSOlftGl; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="eAAPJCvJ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="xSOlftGl"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=eAAPJCvJs1G5XKe92Onv1xY6Ma/nUoGvVGQw9WhbZ7mJ4DWslEV+NX6nfkIIucTzWOUHglFH6U6g2AAqV4yrnGfU7ZHAISKhJPOhj+t2A342GD4CrsHk2/Ezngh8EejzZFz/xAWJlBuitwHRdCwc5BzKcpbWFYbyHWArmNUyp2D3JE7lgRPL4chLUgOZUzjDaVOUZVX/dNWaGgOcv8wuUEp0MeWH7803YfgilX/G5Er82tTpLFDLeOjStI9+ho+x+OLb8b8bngbe0Gnd9cDPLgJa93EsPg1AFu0ypXtDjq0mc+54PZqpWKfmq5e+bl4rX4HYLRVQjt3KCDj/Bh6ssw==; s=purelymail2; d=malon.dev; v=1; bh=vPr04lGG+B1Vl2Y9n/KY6LOQX1OwPAH+3CxriK7QHk4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=xSOlftGlXAyXe/h7CkJdqdKfmP5XfBLOrldHdQ9WDAC7hjCk4QCzMbpYjY2zJccqGwGphf0UiPbx49nvpfPJ5VaxcgIHY6GG+PYJPoL082mTxeTD+/Us1B/sT/3ZWd1J77DwGig5qAZ+/x7pPg5y6wkdZFMAbvJ7efXBr1BUmfZDmPm1iHxveVavF3s1I0agKp1APwNfzEtF8OU8CtCi/nJqOnDSpdtC8teY7eBME6mcQQKPpkzQgaYkkBomc0eFME1ZGcpzCGGtOq4OPEsW7l/Kf+zkiGBaXjGMoKndADyO07qdEUJexdszw/kSTQZAD/jBJ5eQ+s5ekuTURfD0Xg==; s=purelymail2; d=purelymail.com; v=1; bh=vPr04lGG+B1Vl2Y9n/KY6LOQX1OwPAH+3CxriK7QHk4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1385409061;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 17 Mar 2026 13:48:01 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v1] builtin/patch-id.c: make reliance on the_hash_algo explicit
Date: Tue, 17 Mar 2026 21:47:39 +0800
Message-ID: <20260317134739.2465620-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Call get_oid_hex_algop() directly with 'the_hash_algo' to make the
reliance on the global hash algorithm explicit rather than hiding
it behind get_oid_hex().

Signed-off-by: Tian Yuchen <cat@malon.dev>
---
I tried to modify all relevant functions to support calling 'repo->hash_alg=
o'.

However, this failed the test:

not ok 26 - patch-id without repository
#   =20
#        cat >diff <<-\EOF &&
#        diff --git a/bar b/bar
#        index bdaf90f..31051f6 100644
#        --- a/bar
#        +++ b/bar
#        @@ -2 +2,2 @@
#         b
#        +c
#        EOF
#        nongit git patch-id <diff

repo=3DNULL happened here.=20

I can't think of a particularly good way to solve this, so I didn't bother
with it anymore. In other words, replacing the_repository with repo here is=
n't
worth the effort IMO.

At least for now, this section is no longer "secretly" reading global varia=
ble.

Regards,
Yuchen

 builtin/patch-id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 2781598ede..2939c353fd 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -90,7 +90,7 @@ static size_t get_one_patchid(struct object_id *next_oid,=
 struct object_id *resu
 =09=09=09continue;
 =09=09}
=20
-=09=09if (!get_oid_hex(p, next_oid)) {
+=09=09if (!get_oid_hex_algop(p, next_oid, the_hash_algo)) {
 =09=09=09found_next =3D 1;
 =09=09=09break;
 =09=09}
--=20
2.43.0

