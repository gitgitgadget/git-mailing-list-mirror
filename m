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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3804C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB28061211
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbhIXGLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:11:49 -0400
Received: from mout.web.de ([217.72.192.78]:58519 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231675AbhIXGLs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632463810;
        bh=LYATp8YqqFs+6v9rGkIDXi8pfFh5KoBWP3l34PyO2Bc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=RTtZ0vd8CjT3Ca/iykXfpO1MgmDpLZdGKzRQ5DxFrEYGEUFs2/2ZaDBrlELx1zUTO
         i65OIURBD0AIcHb6Big74DljRbjqziGemReTLo2e+WfWVE7nuMbf4bp1N+nIWnP8RD
         XOVRQeXTf8O2uleWfUZT5pfpQdpOGuJgON2xfPik=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LqDQS-1n7P0s1Zrs-00doja; Fri, 24 Sep 2021 08:10:10 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] packfile: release bad_objects in close_pack()
Message-ID: <33a0120b-c10d-2709-49d3-7c3dc26565ee@web.de>
Date:   Fri, 24 Sep 2021 08:10:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kYjHeRw1S78Av9iF80pTGMA23+cp1f57hH5nnSoWW4a6pT1/sRn
 Gm462quFOr3+pLfaHiAwysDqhAYKpyIl6erxgCBvtthQXuY5lYut01slMaluer5bbK8nXct
 e1a1qCnI2yxLYOsFFG0aPYoxWMg38eHBoXkb9cBLcwkEBTOJJKtUzYxw7xJ40C748Gf5Kbp
 q+53ObZNGwqxcoJG6OBaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jJK7zW5GRPg=:N1sqfWxMr8BkirPbuGOP0P
 T+ndSANYyaxUeXwpaGtPBz+5bMmlO3NvsRDCAXCyWvsxSdGjFORwYR1O0KluANt2x8EskVZg3
 znPfqasg94+wJqqpWnBDM1znQYWt8U+8dKDbgKFwqH2vKqlSJdK/OPJwvcC+dVxE7CHQrVnTT
 hhYpL+LaScHkblxs2TeIsyAXtTYJyARxwdx6194l2uR3KYpfuXYebPROO65O3ECvvx7ZC9Nrv
 QhPl+fFjbNpOncyrjQmuDnsYoI0mSWCI73fbL3JzkqGhespjfufls7iDY6qcMLvvQyE69y1kY
 hhZJqTh2DR1APezSQPLLe9lglEq3bKuKxVEfZUsnVSKklNMVups+ov7DmR6qQEvzIqFgMLJ69
 D56LS5ka2BvkdNvta5oAU6Sapx2C4AA02klfcPAclvM443pq/C+OdW92np0ROATa+gATHccJw
 bMtAEs5M768Q/wMR3Wn0XNUkQlr6TrULwnw0WD8SXgA38vq2n1uQ5YLkcU3gPNXsUJetVoF6S
 lgALt4MD3uE0fzfZ0weGYFz4Gv+H9iHYja+iZQoXcik3p1UzhQfD8ChCCYbqY5zjDQYoLn72E
 S60TUopYgrLqgvzgVPM3T4k5YHF5FnX2Sxv10ym9pvD0rkZQ2pZLH44YhTvTrlZjTfJUWXZds
 rQGDWIHWYP7S6sVcOz7anhb8ZMmGTIiremtep46owpylvpq4VJTP8wKwHLsIOoGntmMsvlKBc
 yfRr2PPi8gIMZ7ZqcRUFj5jW6HGvVKQfsRH3Z0M2IOA3LaBuWx892AdtxcizHOW7nPT5JP1Vh
 AONDuzUd9etFR8oegOr+YOu/kA5qABFgbSUBHy67jLi7RyM+jkikeTOK7Ac6ShP912lH0JWzV
 4Q8fkoTnuvMLXknOdtrRXkXDwOg1L9explmK/TiYyWTrITyZzJW/BeKs3s9DN6UvEq0+1BKnw
 b2MOZEjIl46DMCUynGXu8L2TltzmeGfmyxyjSZLgxoW9ogA1ThQp0lYvRPW11fWmPmQ9Byee2
 dSGk1lY1eoNrfu8HNF/pom5sxLqb+Xw9SIOuyt24mT4CWLgLi61Qt0GpWiy0AUHWzg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unusable entries of a damaged pack file are recorded in the oidset
bad_objects.  Release it when we're done with the pack.

This doesn't affect intact packs because an empty oidset requires
no allocation.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 packfile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/packfile.c b/packfile.c
index 0e92bd7bd2..89402cfc69 100644
=2D-- a/packfile.c
+++ b/packfile.c
@@ -339,6 +339,7 @@ void close_pack(struct packed_git *p)
 	close_pack_fd(p);
 	close_pack_index(p);
 	close_pack_revindex(p);
+	oidset_clear(&p->bad_objects);
 }

 void close_object_store(struct raw_object_store *o)
=2D-
2.33.0
