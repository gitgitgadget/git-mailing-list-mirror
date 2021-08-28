Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F026C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 21:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33791604AC
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 21:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhH1Vbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 17:31:46 -0400
Received: from mout.web.de ([212.227.15.4]:51269 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhH1Vbq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 17:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630186250;
        bh=N26JBwBZwRkt4QXL+WBj6HHFLfKFV3/G6mQ/9pwPgMA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=B0fjQaIaz6clFXgK8hd/Qv4Sc1vI1gw0qG+ODo0vRu4NGLRg3XQFA3wj7K3UsE3CF
         rbi4x80j1VxTU3Zq1gncdopKbH009djRgcEn4Ng4/4tEl4ddt9qDYNI6c2DZHSPc1P
         F/GVQw/rPESCL0veZoteLPohgIswOcHME0S4JywA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M5x4z-1nDIzw3hsn-00xrqt; Sat, 28 Aug 2021 23:30:49 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
Message-ID: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
Date:   Sat, 28 Aug 2021 23:30:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Pd2iYNROSK9+K9MBeiGXJsHaPRup9kl0CpM88MOVKiXHWPQSO+
 DQWa+SgBgXmv3eRnzbe5YCIpLBGOGfQ1WVp+IBWsO+bKDVsEaddWMWo6phI35eQGRW3tRoJ
 po5BtKPSYbzRKx7wwk43ccWgQd1Gd9GJuvn4UQcd48fywxNgyB0SOaicwIsGjEaEvDvTA4a
 OrJ7mR+WJK26jhwGxiCAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eWd0G1A6qWE=:nyYxgerLU46N7sTT4LJP6Y
 QNuVBBrd1mM7ppdWF/XZwl8TuNcEVov0aF7IFcae+OBj7CO9cyueuhdiugqyp7fV52pKLIXEE
 eaL/g3x8kfMvjXkP0Oa6n7XoXcYyK8p8HbM/MMBJ7KlwNlvkDNDWQJCy4F9SyIBmeUfl3ftg1
 HDiz8xhfihGGHoWbTW2yZ0EHW/+MQ6gPoWE1cc76KzJDDpVRaa3o2UCegqWy+5CQO7fDMQv8A
 vVN0CzJblkK3xdUo3yMR7j8YZq1MhIMA6Ax/Nx/S/L1eZLhACqFjYux3fAncNowaID8hwJMNE
 Sb36sJUrs7bD63F8dXW3mi05kvSs4lS+Gn2f0hWz74YRxajKgmNQtWbhmqkAj4wwc3eH8eIF1
 w7Eh4NkE6UetVQYujXgi25HmpOLQJQ/ZraiptMR1PxqIDAoIc9KYIv5Q8nmi4LMwNCZ4YW+50
 lG+iL71QOFG9p+zyN+HzMIF1uFcbf9rFDwyw9SkAyll7dAJQQ+lxa/A+9uk3e8mNZdxFIJ/7b
 oxo5g9Jvm0bAbARsVWHRvsRcTE1GW8Kil7FIokPLM9RJy1aMJQKB7rI7KdRWoDAWPClCZIh2R
 uVyk+zD/j50gbHhDT7Nd08eSey8GTJClJdLvuRYAeWffZdwX/hNiM6Ndr0T8Tz6YLDUDOJ+Sk
 r9L9uY7QaTvyAAc9iDbvLtAof7NsEJioaA2WDDsbrnBcQtwvFLwkcR3FJiOTgPFErvdKi49ih
 pahjL7SYjWGRRpoZn/pTbcIynolKvrwB9p0ohvyV1ffn3wod1582TsDCq7lcDjrewRT3vUCLE
 +z+Rk6jfXluRhh1mKjkzjQCUKEb6NBoOkoOmQK5AoQdgxDk+mDeEGa3hTRfrhw4Snv+JOHE38
 4jMDL+ohOVVIMqp8BrYSjsyrWipMe8FL0yIm2ttUM+E67phOqo90VCrknHny1ItEQz+/Z0rd1
 liO84cz8RHfdRLdIntqgptWvu8f36Wj4lCwFyyUrexJQ7ns/T/eDGD01wqiKvjoeQSDIAz40i
 I/3UFSzrr6cM9/bhn7w/zD7Bncu33NgaEHlk67yKsCmQ5qZYI2K4O8VqjQnlzeiE606wK/0Gn
 6TMfgu5I+sTTOAjgy+0J6CN+VnMt9vpjT6a
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call fspathcmp() instead of open-coding it.  This shortens the code and
makes it less repetitive.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 merge-recursive.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3355d50e8a..840599fd53 100644
=2D-- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -55,10 +55,7 @@ static int path_hashmap_cmp(const void *cmp_data,
 	a =3D container_of(eptr, const struct path_hashmap_entry, e);
 	b =3D container_of(entry_or_key, const struct path_hashmap_entry, e);

-	if (ignore_case)
-		return strcasecmp(a->path, key ? key : b->path);
-	else
-		return strcmp(a->path, key ? key : b->path);
+	return fspathcmp(a->path, key ? key : b->path);
 }

 /*
=2D-
2.33.0

