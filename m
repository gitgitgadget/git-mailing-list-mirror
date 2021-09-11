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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E15DC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B8461208
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhIKQKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 12:10:02 -0400
Received: from mout.web.de ([212.227.15.4]:36643 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhIKQKC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 12:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631376523;
        bh=05Z4jkKLJpZoidHD9mjl4lxCXgQUSFmwwaTirFUuHNE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=EBcG74LhN4ifEQciniLl/5eCzas84yjh0TL/6ey4TIg07M5/NwuCIFvnwJ29LnCIY
         5lDh8CuNB/nUQWEZLOaziz0C0ApjtdWYgr0wYRbt2At2TiRZyoHIqp4fZdhXs/sMBt
         iCS2um8toeTLBSH8qF8dEc5Kk7hZYx8cQs9ejyTI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LbZpT-1mo1Jo06pv-00lBcz; Sat, 11 Sep 2021 18:08:43 +0200
Subject: [PATCH 4/3] midx: inline nth_midxed_pack_entry()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Message-ID: <7d9e67bf-e057-694c-c976-ba19e9521882@web.de>
Date:   Sat, 11 Sep 2021 18:08:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V1cy5VYXHao0oNnhHCNdG0Arne/BIAQLjf2vRR9JS0SSJD1pH7q
 ju6lHa7ersCCjDATANdLJZQIyV0kk5xWmke2eJ3m+ZIA0Vv1oeeCf/g7VdoevEmhF9/Ejvy
 UYYNMNGUmX5+4vC0150L7frsQpEDYN21ZBRRAqI+w9h+Ggm+E2GSvvaFhubIlZLF3bjQ/m5
 tP9xrJsUbvFzKxMAHEtfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rwiETTILFiM=:4SCj4ZvBeWSptCZZr4x5xI
 nKUOAgf29IWjbyf0iqwVy1oeZ6qe+cjKx5hwVimnU3yO9eP8SHu70CDIJ51e1XtMZWKU22CKg
 W8n8N/GNupGLC1fVHjp2brOvY4as8PBpE8QE5qEnF3O8ek89Y6MI7TRMyl+imFrq3CNgEDXid
 rwhxZ2vgK8as37oWyDjgbTRNGGH6I2wCvA64/ChTBttDO/R9EanF6aTTm2QgFB/Jsq5EWd9t8
 LxqyylImW2ifM7RRzX+YNW2GQPmsMmHN61+ocfaaYr9y+XgwA9dQYvTSovbzxPYpbe2SimuD5
 3xJYzck8Rp4yh7Vete+yzSavirkhjUp+i85q+zyXAAIu14yoRFICsREZ0h6ds8hgMjrn44zxe
 vajyNUhOct2scOl7dCKlUlPbDNuliyf/VylHiJWb4VWkzbgsUnKrDLnVDxhh8So6cx/Z4n8zt
 7Lq31i/bp/08BaQkWrP3mTydi0vu23uRF1VVyUAAM0wpOsV53XeuBoBSlNRhvIHtoBEQsJwLp
 qWc/vOQPdE4YQSPtUkjapjCnkPlQlErrlDoLfzV9jdcsdV3rzT4yv97VqmjcTMDyYjz7xDEV1
 NSrwKW4chxw+HlCBQasPLO3jDCYrtS7sNg2DVYUXL93fnZBaZq3aaqgt5QPryc5NjMlvlLmxF
 3WtqBnlAKIrAr3IsoVccyPGHusbkL3Aoz9GkaATeegk4yfJ5Z75PnJYe7QsbX3yq3VKIFQnAs
 lFS3WK2sizPpjfTyvijMwuzslJlppgLumhnKlA1UcQzbdwbx2eXJUGlCcu6WcOkpv0c2AzNvA
 Ks94yQpLIw5lHBXUMQaXSICuipOgmIWxjBtdRzBNNkeGK6pi4btdnuQAU83gLU/E+G7p+QGeL
 yzWnET66qKkfXC/Ce2YO9oyU4TH9iNa9ASb3KL7OpXMJrCJgjVzB6nnwqwYBvSaQFPvbxYuxx
 d6BBqLLYwokVHixpPwzMzPWE3ovcQr+nsMndko8zv2jTiAAG9wQ6q9KFdghqtRVMMvsgDS4D/
 w2QwCPpppR9W06ZUnD1OilZUfQen1ay1lXAI09h9rEyAT0FcM3EnB64Wdm5bTWEMjaodiHXL3
 ZWTyF6b/liu+IQ=
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
index 01623fb339..59517938a8 100644
=2D-- a/midx.c
+++ b/midx.c
@@ -276,14 +276,17 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_in=
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
-	struct object_id oid;
+
+	if (!bsearch_midx(oid, m, &pos))
+		return 0;

 	if (pos >=3D m->num_objects)
 		return 0;
@@ -304,8 +307,7 @@ static int nth_midxed_pack_entry(struct repository *r,
 	if (!is_pack_valid(p))
 		return 0;

-	nth_midxed_object_oid(&oid, m, pos);
-	if (oidset_contains(&p->bad_objects, &oid))
+	if (oidset_contains(&p->bad_objects, oid))
 		return 0;

 	e->offset =3D nth_midxed_offset(m, pos);
@@ -314,19 +316,6 @@ static int nth_midxed_pack_entry(struct repository *r=
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
