Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C67C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BA5217BA
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 17:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Nnyi7HIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBERT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:19:28 -0500
Received: from mout.web.de ([212.227.17.11]:54707 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgBERT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 12:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580923163;
        bh=Zln0kjMMU/qn5omvsrcrVIhTAOzai2YKR0NE7N3h49s=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Nnyi7HISikSial3u7LSDH2AEGmjWG8o5Py6R40i283QN1R3RQGel2CFTiN74YUD2r
         AymgCXLKLumJPuJ48bRWper5e4DbGvbI8FwxgznPueOZld9/YCOGblCGEPhMH7fVC1
         7+It/QrJ2CwrofQAHV3HdctTdARTK3iz0tKFkKS4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBTEQ-1ir78v1X2k-00AZDP; Wed, 05
 Feb 2020 18:19:23 +0100
Subject: [PATCH 01/10 RESEND AUTHOR FIXED] name-rev: rewrite
 create_or_update_name()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <e57aa3cb-ed84-c18e-bc08-70f747fe379e@web.de>
Date:   Wed, 5 Feb 2020 18:19:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xx96ilXoNzlMnN1sjS6bvbUPpQdgmcQ2lgj2QyIrnHIPZVmE4lv
 LirKtrC9D5NZxMMQ6F4NR8+h/DHwYaAr8eBwu0/TPnQEZHoVUuez1h7YO/SfrNRMqj9KEZS
 RNmY7fV0Z3A+pZonMYjR0Phesx4V1kgRMvzmi2xIf++RBsBuasnJRKoyIyEqN0mbKqOwSIS
 G5tnq8zvrBS95hOPnvnkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dgkHk2JQSR4=:tGjbHyiZ8BLjMYSH4qa3JL
 L0qUT4Racgnwudxz8mYP4AqxsYwNtU6WD1dUosuuH3VMfIKkdX9mrRvi9WeG0H9PP8PAE3Xt0
 roTYTnb5gJji13pyHSrCtrNjVza70XHPozU6VZ/6+NqOirag0RSQ/USSZQuY/lb/I3qMB7WY+
 cKCqHGCoA+jCs+yLg872SVzedrLAtp43UMI4N86kFEN5RsF4D6cfz63YI9qIIOoJvTX13TamP
 l78cDZ3D1zzHyU1YYbxaLfCjq3TXcbWUtPsuOwOVi5xej77QxFyxW4Lqa2mVJ1XiaV0re82Xv
 PIqMLZ+F+Bs9M51ovVcwJVVexkqShDKpteJZaPuF0wVO+GdAgc5CqlnlxChCxuN8XRvsNyZrK
 bTk8koWajMcgQee3kMDvVAJ+t+H0vr62XqYjzRgf+fFud7gn4UZbh6S4R6kKZ8RyS/ByK9egn
 a2HRCLxK5PRwtfi1p/cENVzRqfFXhB0dpK+PyKs80V8C+LR/Qyc1nMD7bcsh24P3d5tYpmP7K
 Mrh5KWsi7KA3v957mVWmuOf05BiR+yY7r0VhBP88Q0njlnbXjT+/NuE1BN1fBQWMSaQKhMr7m
 e5iKrgt5yL2SbqQTe47o2v4oq5UoSChdh3TGRbJBbIkolO+t4RxuuFuIXEXCVTjQElx8M8oYP
 OTi9IE1v7ESOUs4RQdvxr3IAq1lIYIYgL6AAVRyNf3g3kDnF0lIIbAzx8qqpdxjHgkm+fNupZ
 n12jConcpebpd8aRCYo/WcNBEc2cTXkpO9v9o1xSwAjqIvIhYYjnqRLJvqn4Raw7lhyOny+k5
 1EMU2bTMSXwKRkZ67k+YZ5GTGP23dFUCxTsl30SR+bk52dwFBdOFqSzuVXy9nMmqi2ZUxMb7o
 I2wgy8ZEZRneBVc1IVRTiU/AlKCfmk9NSezDlaOAFeJI38LvdRQvwmDR5nURIkWSI3qeiD9AT
 FxtfUDJRrHz1nnNK9dgpjt8rjvYbccjS71T8nJZD0q1dt1kGiPWVjyNJ178MVGKGZNomKLuOw
 /77vWE1PQXbSC5jF29r1mDmQX4L41EhnPe6Sc8wz/eir/STseEtXpVfout/z7OP3R2n956p21
 E+8+yV4L8lwRs4PgHE2TOtS6ejHo86C8c8NVC9AxVb49FriY4KI7HwWzrWCw8hhrHqj2YF2U+
 vsn7Q6KBiZ/3o0XcbXbcqdA5IIg7lg0IdtM5wbF8dHKKMYCO/XQjDrG4oU30paIctqoJxgXgi
 IS5JiWhBdTXa+UKWu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =3D?UTF-8?q?Martin=3D20=3DC3=3D85gren?=3D <martin.agren@gmail.com>

This code was moved straight out of name_rev(). As such, we inherited
the "goto" to jump from an if into an else-if. We also inherited the
fact that "nothing to do -- return NULL" is handled last.

Rewrite the function to first handle the "nothing to do" case. Then we
can handle the conditional allocation early before going on to populate
the struct. No need for goto-ing.

Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
=2D--
Missing From: line added; thanks Andrei!

Original submission:
https://lore.kernel.org/git/20190922081846.14452-1-martin.agren@gmail.com/

 builtin/name-rev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6b9e8c850b..c2239ac3f7 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -88,21 +88,21 @@ static struct rev_name *create_or_update_name(struct c=
ommit *commit,
 {
 	struct rev_name *name =3D get_commit_rev_name(commit);

+	if (name && !is_better_name(name, taggerdate, distance, from_tag))
+		return NULL;
+
 	if (name =3D=3D NULL) {
 		name =3D xmalloc(sizeof(*name));
 		set_commit_rev_name(commit, name);
-		goto copy_data;
-	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
-copy_data:
-		name->tip_name =3D tip_name;
-		name->taggerdate =3D taggerdate;
-		name->generation =3D generation;
-		name->distance =3D distance;
-		name->from_tag =3D from_tag;
-
-		return name;
-	} else
-		return NULL;
+	}
+
+	name->tip_name =3D tip_name;
+	name->taggerdate =3D taggerdate;
+	name->generation =3D generation;
+	name->distance =3D distance;
+	name->from_tag =3D from_tag;
+
+	return name;
 }

 static void name_rev(struct commit *start_commit,
=2D-
2.25.0
