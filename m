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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9479C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 08:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959DA611B0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 08:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhIKIBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 04:01:55 -0400
Received: from mout.web.de ([212.227.15.4]:40933 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235331AbhIKIBz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 04:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631347238;
        bh=xJZnghI+6gjHEugvJNlOxXX5Xoz8chOUFnGa2sT0nRI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=jwp8HFHu+3DKuOPVWthZS9K1iGX8t9Jtu2k/jKk6jLqS6E7AtDr9KC23bVnP/3sWi
         ZbylMiZNhZJaEKZ8UQC1z5+UHVS8m/QmS26KFYjKyFNmEq4VjBaZCclApctzLo1Eru
         KQ1nPfHbXBg+g+pL3+z0UJ7lmk3JanIYDbEzP2dg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M2dt7-1nF0pH0NpF-00sRHK; Sat, 11 Sep 2021 10:00:38 +0200
Subject: [PATCH 2/3] packfile: convert has_packed_and_bad() to object_id
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Message-ID: <8d7328ee-57b5-247c-7b28-8d28ece8a4f2@web.de>
Date:   Sat, 11 Sep 2021 10:00:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ltukPuk+plQHcckXVbDEsjxjax5BO8K3EDAlLp+NWVAOGveNpzc
 wdTNVgrZpA0Gs2/N11OcnUIyx+m8CwDakkIT8dsrDNTAbEN9ZIkY+bf5Ds2xE14cx+oaiwl
 pOOswR8no1/2V5FQK9M9hqk5wg3E6pZs4F52bWuMmRlkFiVh2LN8H8Z5TticjYscM5jeAUy
 a0egYKawR1RahSC3FuHTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e7xHWMxosGg=:wioYvQV22WDFcyzg3np29w
 YhFiO3u2GSoNKisPvPzN+kF/Kkejku87y52eKrjufvDrxkC8/Uu630Im0SyDH5rYObotrUd0q
 AW1twU8Lho+FWfQgvS1KHO4Aqbk5CSHj94b076bv7t3ZQNq0QqcRIEaYdMQaS+YbN4ZUzhvQS
 nyjsgcqpAVQ8XklLsb2Uf7a62UAs6S5gMT8l7PNSWAJVg/Mo7Kxf1NPvIjof+ZeG1P6lDnaXe
 R3a5zaT/MAhaWx1hXe7bhzONg+/bybS6lvgOiQfppcgf+sREgBKIhasRuFwyWxFY66Q2LkZwL
 yhP+2loY+m1t+2HNQl544YBj7SD879qev92H9JOyQq4+svxYpGvcE3CQq+QY/7YjVjkeFhYBi
 p/EXNwE7EfaKBn2MHQoUWUZHZYGJoxf7iIzYnMizy0+bFEzLB9kEbGegdhX/zTz9DaqNP/ibQ
 3LTL/1ks1byC7ouRjUefnWyxyfrM/BBRzjntSBJ4muVywEjBT1EtzSxQFyB9PDMCWsHX8WkZl
 TGQzf2NozPCdl6GhSRA1Rs4Ww3ZLnvqJxNwodMiiCbMiFGBcliCfqTDlFjkc1YXYFqHLZnCT/
 H4lGE9vFv+vdv8Y7AvlJZwSjXVSuZ/YBV/XNUiTsKcGr3YdvVswwl59OwVJJ1e+nN+uTAjRGy
 QTrPCaMMkVSb2TtZS9b1ViG1IeIZtQoOhOsQL3KtSGafjUHnVTLcBEzWNwq/eVJzrsTIIJY9M
 rV5IxbERDv+C96kLNPhsQYdW5pPVpKsrZtGsALZyqSrKY1TsWFbAybwxNgjQ9WTf6AuMHPZL7
 5X1p7LUJKYzx5x31h7kPppzw/3KncN3CkM7M0SQZFnEe4eazcJY0dPSbEqDDQ8q/wV34uDHPf
 eoWGYoiUlRuOS3UrpcJtO5/GB5jFNqFHv5aw5hpT17y9mTZpFLjrikB+Yy0KaMe0UoqrXol5B
 UkUtZPpgrbTKTCIoWVWQ/3cFC6Z+ohySjS5mv4wZDfgqlM13DMKMr5V8uQ4RwItCpGLibRWP5
 eLHuYCqwubvz+9Fx3MDWpD32c5VoTTIbnc05fzfJZ+yVg+9zGrhTYFGj/P3ExIvEpw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The single caller has a full object ID, so pass it on instead of just
its hash member.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 object-file.c | 2 +-
 packfile.c    | 4 ++--
 packfile.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index fb5a385a06..01e7058b4e 100644
=2D-- a/object-file.c
+++ b/object-file.c
@@ -1725,7 +1725,7 @@ void *read_object_file_extended(struct repository *r=
,
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);

-	if ((p =3D has_packed_and_bad(r, repl->hash)) !=3D NULL)
+	if ((p =3D has_packed_and_bad(r, repl)) !=3D NULL)
 		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
 	obj_read_unlock();
diff --git a/packfile.c b/packfile.c
index fb15fc5b49..04080a558b 100644
=2D-- a/packfile.c
+++ b/packfile.c
@@ -1176,14 +1176,14 @@ void mark_bad_packed_object(struct packed_git *p, =
const struct object_id *oid)
 }

 const struct packed_git *has_packed_and_bad(struct repository *r,
-					    const unsigned char *sha1)
+					    const struct object_id *oid)
 {
 	struct packed_git *p;
 	unsigned i;

 	for (p =3D r->objects->packed_git; p; p =3D p->next)
 		for (i =3D 0; i < p->num_bad_objects; i++)
-			if (hasheq(sha1,
+			if (hasheq(oid->hash,
 				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
 				return p;
 	return NULL;
diff --git a/packfile.h b/packfile.h
index a982ed9994..186146779d 100644
=2D-- a/packfile.h
+++ b/packfile.h
@@ -160,7 +160,7 @@ int packed_object_info(struct repository *r,
 		       off_t offset, struct object_info *);

 void mark_bad_packed_object(struct packed_git *, const struct object_id *=
);
-const struct packed_git *has_packed_and_bad(struct repository *r, const u=
nsigned char *sha1);
+const struct packed_git *has_packed_and_bad(struct repository *, const st=
ruct object_id *);

 #define ON_DISK_KEEP_PACKS 1
 #define IN_CORE_KEEP_PACKS 2
=2D-
2.33.0
