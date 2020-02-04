Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD7C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A38D21744
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="U43L8kHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBDVY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:24:29 -0500
Received: from mout.web.de ([212.227.15.14]:55301 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBDVY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580851464;
        bh=s8saV2LHQ3fZw6rOPr7IeIhg4dla46uNi1w9FtxC+9o=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=U43L8kHpwkjeTHEUBRtRDVDNnhO4BV1xqw+w8asV2iG803vGvbXjkUbcmMdKWO5Qs
         3mI6tdlO4oPL04KEVhM2mB16e1bxO4QTcB6eDhANp6dtpfW8NqcdN7xXSTGVG89qDG
         7xlnCIzWbOVaGV1vbzwvIEjmn69ob2we2ZvoJ8RM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lu1Be-1jiVLC3EiU-011PsK; Tue, 04
 Feb 2020 22:24:24 +0100
Subject: [PATCH 08/10] name-rev: pre-size buffer in get_parent_name()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <c7f22d8d-10f8-0c97-672e-0a50182901e0@web.de>
Date:   Tue, 4 Feb 2020 22:24:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fq2dItztj2NSkE7GEYcTVDDWCBqTMWR0TUERuJ+hXzwrBaktP2S
 f4g1CYTcKzolWdW4j0PcNkqFmd+kUH8/Oz8RSV+5vLfIh7Nh6fNa5j5Mg2ImT/Zy4aPo4m2
 DYLhctk0wVQO79ZI4Sphd0G1PeHshS0Nx44xaRng5h8V/VKyfpZ55F3GU80VXizzHhCqMMm
 jo8jp7to5HQbnro9Rz1JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R/iMC0JIb9c=:Fzu4oPTpSJYEtrWlIOgA7a
 aCq2hp8MfU74S3GhaQ5peb3M/wCdKLuCWFK4Z8cIy08+aSZbaVJw1ZHU4vrJH2pm9mx2Aq3xy
 xnqN5GNxKYzHrDE2+exYWiLJS/sIOEhN8v6YAPyKFBptP6qiewHuKGJRz+qElcNKI8dMk+1C3
 kpXJDWud7E6HgzCbT/Aln9wNe0q9hmS8fplp1IE6FqjleYcU9sWcd2Aam17DZgjj9yXDljkL5
 dxBkhftQBxrWCc9a9qTcf+R8QPC5i4rOSJ/XYrOIgqojtc38G6Aek7lYGt8hu9Kass/A2bUv9
 /2/5AUzaDUFRB8EZuvKz1OHoXTSF73/hMAwXGts7jJe8rT3gG/apuhk6q9FE16Y05J/WxcaBx
 8RD6NHfk2aH9TuC53wjAeyp05C/glpW2YJCrZ1Axr66MuiH5Zy0oAW85l4EYm/Y5mtTJGF+dt
 VgwB8xAJbCWV+ILi4o3GSoeu70FBEKuIbJ116v/lILMmqKmhrbsWVrcaSFmyIeHifA1EuaRER
 7flRsjPvr2S5a0wT5mTV5RcqUct0x/tagRmv8jRh8cEpKOnt57aUWpqUUIGh6inOZ1bwe45yK
 1Dy/3TCTE95XvfxExgpzaF5EpGk3MN1A4IerRoKC8BW9XQ5P0X1smCgs/GkzcJd2N+dAvowbJ
 V5L+L4tsNPZcvtYPMGAVqjdUInY/ZG3PHyZbjmuhRmEUixHpnux/ioWrdop8ke9miLlikSmi6
 GXsFb7GH4LrNVFXJCCnFlEPetQFQ/L7rxtePb/7ydLQOg5CBBbpX1v1/ZmYCbBwB6N+sm00pV
 2mFWSbf9fmimt+soKHuTUv5jnkkE17HBepi/zZSIsyTdDDnSBu0bg6bbi9ipXWcKefWZcJjgp
 o+D34iWOIdDEepdpyqu40Yj0/whZAqYCK1T5Y+s3pMai7JETx3nK5IWML3WRCCs2K6lj50Aim
 QU0xHCLL0MJZ5pB6Q/hW83WLx3gHOQWkAcGcZTenRDrrnD73SSnSZ8WhmZ1ULdeHiKs0F/s5W
 NQaFb1mzuoZmf7QlLqhEr1aoVqJZXVkT3wBjfsfgIF8h/W2XyrXZm0DRyW9mU4Bi/i1Z13lnz
 1NtUmZoYqAjN5IrIdVeseTJcTwnAvyeEIkZzHhJUqGalze2CLISV8ZZKswTO4wFV81sQkAV8t
 /Nmj0mOf1O180RR4iDnRmJaexjVg3Yt10/f+D3/YzWj44fuM9TbBsuKFZG3baCQoG2I5Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can calculate the size of new name easily and precisely. Open-code
the xstrfmt() calls and grow the buffers as needed before filling them.
This provides a surprisingly large benefit when working with the
Chromium repository; here are the numbers measured using hyperfine
before:

Benchmark #1: ./git -C ../chromium/src name-rev --all
  Time (mean =C2=B1 =CF=83):      5.822 s =C2=B1  0.013 s    [User: 5.304 =
s, System: 0.516 s]
  Range (min =E2=80=A6 max):    5.803 s =E2=80=A6  5.837 s    10 runs

... and with this patch:

Benchmark #1: ./git -C ../chromium/src name-rev --all
  Time (mean =C2=B1 =CF=83):      1.527 s =C2=B1  0.003 s    [User: 1.015 =
s, System: 0.511 s]
  Range (min =E2=80=A6 max):    1.524 s =E2=80=A6  1.535 s    10 runs

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6701fb1569..793356edd1 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -103,15 +103,23 @@ static struct rev_name *create_or_update_name(struct=
 commit *commit,

 static char *get_parent_name(const struct rev_name *name, int parent_numb=
er)
 {
+	struct strbuf sb =3D STRBUF_INIT;
 	size_t len;

 	strip_suffix(name->tip_name, "^0", &len);
-	if (name->generation > 0)
-		return xstrfmt("%.*s~%d^%d", (int)len, name->tip_name,
-			       name->generation, parent_number);
-	else
-		return xstrfmt("%.*s^%d", (int)len, name->tip_name,
-			       parent_number);
+	if (name->generation > 0) {
+		strbuf_grow(&sb, len +
+			    1 + decimal_width(name->generation) +
+			    1 + decimal_width(parent_number));
+		strbuf_addf(&sb, "%.*s~%d^%d", (int)len, name->tip_name,
+			    name->generation, parent_number);
+	} else {
+		strbuf_grow(&sb, len +
+			    1 + decimal_width(parent_number));
+		strbuf_addf(&sb, "%.*s^%d", (int)len, name->tip_name,
+			    parent_number);
+	}
+	return strbuf_detach(&sb, NULL);
 }

 static void name_rev(struct commit *start_commit,
=2D-
2.25.0
