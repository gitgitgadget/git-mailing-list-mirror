Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59A4C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 11:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C50B24673
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 11:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WEPqNPOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfLGLQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 06:16:10 -0500
Received: from mout.web.de ([212.227.17.12]:53283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfLGLQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 06:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575717365;
        bh=FN394eaNxhuzQ6Pr5Da22PJQAwN5HNS0dhc0gewEwm8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=WEPqNPOOmwguH6EGL0cG8iw1SZ2IZ50eeVKObKfv3WIxh0j36coD+tNgGReh/4dWG
         DA0Fxq9sZeqjAn5PyXdfJ3KchcTxnx4a967vK2r7q/hbETDuocDoX0VFpVxDY27BO7
         w94qSDqgTsu8a3aNFPBIEpjj00UhocgP2tk5TL+w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2uj4-1hnErS3kwQ-00sgzf; Sat, 07
 Dec 2019 12:16:04 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit: use strbuf_add() to add a length-limited string
Message-ID: <f4c7d65f-d7bb-c574-fe48-8d2df0c2907a@web.de>
Date:   Sat, 7 Dec 2019 12:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sYKRx94vt669Mm87hC31r4/9898vMjICiU9ne/od0gvuf2+z70M
 68q3MQxYs9/O20bO3+QR5LbiW94MrVsiAcwf6m5P/7apNk3dydkSXVi+C44GKSogmoulqcP
 e5Cq9CfVfn/wj6WEl4IDGDXNhPL52U6K1zRQfgyHWgnmAp0E1jY6TDdNoU0PA57CZKA1PUm
 bNyQCI1ToTDmfFhXJWxTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e7kNdRLGYPw=:EWLcCAIRNBYAfkJhhJM3sa
 t57KGMKFAr6AcLyea3LixhJ4NKV3Id0L5J0U8Ddy3lmNKuZj299qcYzHdnQHBlIKSd0/NUOWH
 HJ7p+jxNdGz+9x679Nm4xookUsvLf+x2GJ8lC2AOQkpbT0vR2mlMIT+j0P7iZ1i1CUd3Ld2F8
 fGA9QUh7ueGV1cjC7Ftdu68WQzrCqtqvuFCpbjh1YKX0egmJF9vzxxFtwL+MuM6ZBhmO2E4Bt
 lGRKJCrXNW0BQi7XOTNmudBl7UQJ3mIC5Uj8/4KZ4uSwObMsOD/L60niy75N93blbxcgDGTf7
 r41t9c3B/cUcDRXJ+PZYBiOqtxYHUS3qLCqNb/3Rvu03fHIiFqQ4hugIID/6uSSPruP2TpnzB
 7my3AGlZIQXESXvQioxMFjyMVRhnODu+nFx/8fPVXEBSSaHeL1xmZVW/IR9zaZONREGVmJ5Xv
 PYWneVepF9B/rREKB1RjBY2jD7bNIRqkYPXIpvt4nPoG9TfTdgAYOQ2aEE7W2ckTTljJny1ww
 RxLg/RxKJAQDgk6Kp3DVYrZggUeF6GnfCMm/3KmNNDZLPHvUEkY3sOQHMjPTolKMqvTSyBfBT
 E+lQLrozUzXA5c+ubp6icBFGgtXaqR6K6FaC+TRh4Uxd106WWk9olJdwYf0PKFjjrKlh525Ff
 aOm5xb4EV44OojxtVfBjDjuzZg8d0BCfH7OysgHVkcr7b6O8R/4SW/wBWoS/X8Ocnc2gQNoRd
 IPOfS1EmPIZfF/UwhH/H5HvwDW8+YsFwOaj1FWydQF54rFiUXkbZCMu6M0DnQcQoHQr2THb7A
 RRXAbId/0vgUINfOs4D4zMztdyv9pLsFHYbD/YqZBAunGKnBaH2kJsC2w94lqLMrjmOCtNlR8
 VJ6NfLqfIFsmxzD6Cwvyze5Ndc+nRqyisSl8NU4VhCI2E1pby2pBMZoBOz2GTWq7n5D8Mej8r
 tv9fyLUedzj5jlQZr5za4AbTr6egNIwoi9fWzf8BFwWSPmROl5FYAz/BFbAVmcrTGTiQg1r0q
 vEmFwQNMTXjhYaSETJU+Qs2nV/1J5YhtliBVZ6pNLWHDEww8v0dZrb0zn8K3B4njDeJ9QTZ5z
 HgL8Ct2raxzTjU9nl6iA8N1A8UiCw9OP1KEbsq2MM0u6FCbrusEUw9e4BlEITvAHf8mjxz9Ui
 tUHSObvDvUUTmwdssmLhBub335IXXxR3g+6SnWYnnR18PmVAOhDkLHyY/1gK6FkRe/Ydtp8+k
 XwcP4/OtNGK9XsvbDvmX+aprDYJ8l93cL+vFz/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is shorter and simpler.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 294dc574cd..35a1fb9ad6 100644
=2D-- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -537,7 +537,7 @@ static void export_one(const char *var, const char *s,=
 const char *e, int hack)
 	struct strbuf buf =3D STRBUF_INIT;
 	if (hack)
 		strbuf_addch(&buf, hack);
-	strbuf_addf(&buf, "%.*s", (int)(e - s), s);
+	strbuf_add(&buf, s, e - s);
 	setenv(var, buf.buf, 1);
 	strbuf_release(&buf);
 }
=2D-
2.24.0
