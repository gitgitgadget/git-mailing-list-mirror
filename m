Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF7C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 11:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AAA20748
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 11:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DVvlNZug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKZLSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:18:35 -0500
Received: from mout.web.de ([212.227.15.14]:34333 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfKZLSe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 06:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574767108;
        bh=N8YSW6L6dTBB5ygwZ8c77AdOigo1bPg7VIP0xb9ZMWs=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=DVvlNZug5Wg3WpPlbuZvW3qaOhGYKo5givuYAju9N8G1tNUBFZlUnfeY/FEbeXqPR
         UvfYw9K8pJUu6g8FtsUtIMbZ2GGEcNsknxB7E5K0Jggh3Qj7PE3VhEFAapmktmNr54
         LzYSUBszdy2FL1zhTUMAHvnvBN2CGij1ONfJsGXc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvS5r-1hs4zn1YMF-010f6j; Tue, 26
 Nov 2019 12:18:28 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fetch: use skip_prefix() instead of starts_with()
Message-ID: <f6ed729b-3cd3-a91a-d69d-4960e4a0524f@web.de>
Date:   Tue, 26 Nov 2019 12:18:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:InwH/Z95mL3hh+ojzMKa2v1A68NQhOtrqBzKTABQoRGWnluc016
 Z5+QaLMreBH6bG9+CnbKNyR5AwNRNTaGeOM3pT8jzIiVbEq8TD+1cNZBBYgqz+ZWcgQ6kEU
 H3XmQ53ZzsF/RarVqCj+SdUULjNgfRNJwdGARaanJCjnT88JkXw26ciX6h6nQFAKg6e2rX6
 b6SKy9ACkZZSvvu2CGsJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iApyFfi7MNA=:9rqro3hJ7rgFDSbrwcQbsy
 VoSjQ8Twz6o5yXLpyKWIvgQeeGUM/kjONvaf0PJSJtsU1VMJh0fcjO+FZ6el36t6k7t4elclr
 Y52cwbrKNT/HmLGQUHgwAQmK3B3xdgu7i2WM5SJwCQ33j012h1U+3tXtPphshXUsaV17y33br
 lENbIsNCXticG8lx9MaFfN7XxH1papGeXOxLaFcARt2nevC4zdeIJzLN7h4UH8z1qV+g8GmIc
 7gkxuvGYKGdS62FZwCT1XwdZeDEt+LjRsmyucO4cjfOlAjThuKj5L+KORwzHyMxq+G2b0jQck
 hXnKgsvM3ocQenXZQk30waJUf07ROT48YM4tJ7fFRTWfVbLK1kl6kXgjKAQAW7vt4H4au7oko
 P4HvaaJkDpkohDy7eRedZYYDSTeecyiwJdc26WiXlXlf/BhQIQ5saR1FoR4ic2YgPcEV3qWdx
 DpW1LSyX6d0b4zGUx8nWcOM5MPFLMi4JoB3kM6eMyBBDLl/B1k6j5VQG56QDrawj6At6Rr/jD
 iXRIWiV0t8dNQjR1GBMTjEfbOUbAijRoS5skI4XxYJ+KRlR6LdP4xTPIDZ0eomH6ho2CYOfaU
 ym30SAKFJ9FfG+GrvhHh71kO9ZEeGKdIsOACm2Vh6H5eWxLawTH/hPOGCARis7P3sgSjupTNS
 9QWRz4lfMxHZiSfHqvi8JX8h416xnhDzpLTRa0BkGyDUohNXlZrVvQ9/6Ll0VR57CFmhUehRO
 qCQ7uLVyqkdq0GiWLWkalsWn5fPN6Bx+qX92DkhLVLGSK+MYzeX23hq3Z3aY47XPw614BJIpY
 ct9sEiq6WaNzC5yOJzKOX5VzZbPTLBkIegRb+U3NopjaMtvYyADxcrXy7CKM2bdx9Anv6sz4f
 srHRLGGLLcM4ll5xlt3EOzMiXiINiXdcCVZDU6KSoVxia2lR8xj/WzqRgeDqN1lMXPvsZs1J/
 FZ56TESPkFDjkySwMBf4x8sqGKMOxvUcQauAz2itThST7LWR+EWxdJ9SW0vyoatuIB+Hj0D5H
 Yv2n4QEgioI6d88nzLuEA9JGIogvvFCup9SGLC5MZZEXxIgfHuVl2LLZTftiYvL5CErWBQcZe
 MloGFqI0gvvvevHACcqDKBqBOhxmPHjlTFx0Dm4dkM6eMZ3t7zE4NXEL0yptC7rWT10uYKn4v
 rUCwWxTWG9dsq4nhAZCghAidTpZAOnBph6ZlB91gQn5HRx/iXk67ZfSGLREC0Eabhk33BO6kz
 x0PyTaMo7n7lMtRjFYteh2V/zsIHpvKtg4F+RPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of magic numbers by letting skip_prefix() set the pointer
"what".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/fetch.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 863c858fde..02e8619618 100644
=2D-- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -954,18 +954,12 @@ static int store_updated_refs(const char *raw_url, c=
onst char *remote_name,
 				kind =3D "";
 				what =3D "";
 			}
-			else if (starts_with(rm->name, "refs/heads/")) {
+			else if (skip_prefix(rm->name, "refs/heads/", &what))
 				kind =3D "branch";
-				what =3D rm->name + 11;
-			}
-			else if (starts_with(rm->name, "refs/tags/")) {
+			else if (skip_prefix(rm->name, "refs/tags/", &what))
 				kind =3D "tag";
-				what =3D rm->name + 10;
-			}
-			else if (starts_with(rm->name, "refs/remotes/")) {
+			else if (skip_prefix(rm->name, "refs/remotes/", &what))
 				kind =3D "remote-tracking branch";
-				what =3D rm->name + 13;
-			}
 			else {
 				kind =3D "";
 				what =3D rm->name;
=2D-
2.24.0
