Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DCDC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1A0611AD
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhIKUk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 16:40:58 -0400
Received: from mout.web.de ([212.227.15.4]:41443 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhIKUk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 16:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631392772;
        bh=lHTXetwVNz9SumpRqgv0/wismiJmJUtXu2jqspkK58M=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=hFt1Q5iwRhZbt30Ixj5gShNo7PzDk1E+O0KmXAYVp4A5rAM+i2YJUf/nRMNqgGAUm
         2ds+zoDqqyUyvYLyscVGGUfFHxyLZDlL8HehW9O3GR085d968iowvEh0DoJGAGxFeE
         aNoaWi5vnHF+KdipnZcQ3FDkGYhm/NPVo62rdhYc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LzVMw-1n3WyM197a-014ncU; Sat, 11 Sep 2021 22:39:32 +0200
Subject: [PATCH 2/5] midx: inline nth_midxed_pack_entry()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Message-ID: <06f0f546-31c6-9cf5-5e11-999cb354c91a@web.de>
Date:   Sat, 11 Sep 2021 22:39:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9jV0S9P0yWWhk2PaE7ctPVIhQ3Fd8Fovb82Z45MBh3XDhmy7j+4
 JgAN4Qxkx7d61qjZHvmAd/LtL+MlQE7qYg/G5JAu13Z2SrF3S//tsyI/rYg/UCAroMWfYxf
 J5GljE1LeA7jL5tjbJCy6bQI/CjSHOGGcytQoDiu2CpEqIsDWGQa47VR9/PUaAKzSA1Guwe
 QCb7Jc8a/VLdGO+Y9Ko3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/iEfHntam08=:2fawZgIw4uB5rbD/eH8+6e
 anhpYSr3nQVmyYfpuYssb9E/MRZZmy1nARBDmbEME/r0BrPAJqw8aOIKPn6+6RZptBsofGuaA
 tdxLtdSby2YDLVSt2FexZ1rPVmVFAWvIDnEV4iHkun122Xj2KVnsAs1x9NTRO731hM6c8bXSI
 wyAiNL+N0Wp1DAOpNDjWBjWUqSds/9FLMwIYYQghTEHHuJsXZ0kInOQFWAT73bIzn9llUvW+l
 QWxDBLE02svpoUGuspiTqVJ8KM1Nf8A4GPrRLh8EiSmZ8/ovVi2746GL7NjFTF9I68XDEo7ek
 WPCbBxkcQYn+I0NKHWP8yNQF9tl/+ERbT8LTNncqJ7E9OAS78/B2tVGAJLDR0q1xpZsP0faMT
 X3Gy3dpEV094p+mIygph8VIqEUjJQjAZy0r8IAP8zYV9tTMFRJFi/GkhVf9pJbrvPK8bVkZ7D
 y8EuamoWo7UWAOPwVtBCzFNx/ODJsWVYM8MCZqORfntzTpK/njFtFfoTv+y7b/rtQbnGY8Io5
 hKhyl3EorPcopjD0vKRIgIQw+qDYkOZh1SqXjjS6TjlhHluazv2YnmO9wYbxVU4cWOzWEmiRX
 U2SYa+BS3VU2Z/ypNAAGrZL8idOxcUyIzdkwjCRWIKFFLaLE+oJIRYDY9ND+0H+2Uk7fW1Oe+
 0PtCM0FlHudJ2EEWjYnANuRNUm+/7yojZSY9WfCZUYs1SpIdGWLzEewEJa2tljgTVLSHE/Gnl
 PydDB+3NzgvPWIEcOKcj97ejl6FqFxMmsZxF1LewhBmIxz1C5uR7Asqw6hUZYWmX0W3ueeSPz
 GL3efJsBd0fKfLxwuLSPxUaybaOqSHWPpN3259NiolbbeT29gb8KWOc3cmshSUt65EdGgBbSt
 HTK188xuG8qyN0jfnLuWt+VaynMCr7UItJTjlhflHFjeOIL7nBD1yWo2215QKWLgKlww4oqDU
 5Aci2yK80eAhUVo8bi4A6jBVTPTewmpUNItI5EpNf3XtaO/jATy9xjM77gjRWzlpUdY9ruLB9
 3768w+wFwIZ3jwjY0VpYS3VZ79oRMkI6v+AFuRaqAhiMq7n7QY99ghma2tOImJXwbMYfDGvH3
 sG9nlQsdRsQRoU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fill_midx_entry() finds the position of an object ID and passes it to
nth_midxed_pack_entry(), which uses the position to look up the object
ID for its own purposes.  Inline the latter into the former to avoid
that lookup.


Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 midx.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/midx.c b/midx.c
index 321c6fdd2f..8cb063023c 100644
=2D-- a/midx.c
+++ b/midx.c
@@ -276,14 +276,18 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_in=
dex *m, uint32_t pos)
 			(off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
 }

-static int nth_midxed_pack_entry(struct repository *r,
-				 struct multi_pack_index *m,
-				 struct pack_entry *e,
-				 uint32_t pos)
+int fill_midx_entry(struct repository * r,
+		    const struct object_id *oid,
+		    struct pack_entry *e,
+		    struct multi_pack_index *m)
 {
+	uint32_t pos;
 	uint32_t pack_int_id;
 	struct packed_git *p;

+	if (!bsearch_midx(oid, m, &pos))
+		return 0;
+
 	if (pos >=3D m->num_objects)
 		return 0;

@@ -305,10 +309,8 @@ static int nth_midxed_pack_entry(struct repository *r=
,

 	if (p->num_bad_objects) {
 		uint32_t i;
-		struct object_id oid;
-		nth_midxed_object_oid(&oid, m, pos);
 		for (i =3D 0; i < p->num_bad_objects; i++)
-			if (hasheq(oid.hash,
+			if (hasheq(oid->hash,
 				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
 				return 0;
 	}
@@ -319,19 +321,6 @@ static int nth_midxed_pack_entry(struct repository *r=
,
 	return 1;
 }

-int fill_midx_entry(struct repository * r,
-		    const struct object_id *oid,
-		    struct pack_entry *e,
-		    struct multi_pack_index *m)
-{
-	uint32_t pos;
-
-	if (!bsearch_midx(oid, m, &pos))
-		return 0;
-
-	return nth_midxed_pack_entry(r, m, e, pos);
-}
-
 /* Match "foo.idx" against either "foo.pack" _or_ "foo.idx". */
 static int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 				const char *idx_name)
=2D-
2.33.0
