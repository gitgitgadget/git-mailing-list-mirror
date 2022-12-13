Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23473C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 06:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiLMG1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 01:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbiLMG1V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 01:27:21 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97011EC41
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 22:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670912831; bh=PZ75OHNfJZHJHhg1G9t4yYdrXvZO/lOCFczlXLp9Gf0=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=dz785E3a69XZ/AhwxDfbwouOWfLluoQ9MyGxnVRSJyCR79H1ec5hDVeWqI94kS+KS
         3FxzNvJGpgOphxe9ORoKShkLvGcC1RSeh1AC1irE1GFF18iDJvKJi1SyLY0yrJhFxo
         Wr+aiIj91bs1IltqXehvWdldiYYKF1QL/L0cUkzvsDI+dozKMFOpml//jXZ6Tj2dV4
         ysBv+OdJCDMssYFp4cx4n0vyvTv2dKWzaP4lUfFF3EO3LDk1aK4icpa4MdYW25AsCm
         sdzAlJI8C/LpvXkeEfLX3ntFUuu6ebxBrQ456FYRPZNGMiKSC9mAFfB9dbZVcD9BjL
         VfsMv0+HA7HRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFlm-1oS3AL2AEM-00eZ7d; Tue, 13
 Dec 2022 07:27:11 +0100
Message-ID: <7cf2ea1f-8dbf-5639-3874-86de391ae20a@web.de>
Date:   Tue, 13 Dec 2022 07:27:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit: skip already cleared parents in
 clear_commit_marks_1()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8jWLzzIEr4w8cMpQqVpY2+H4HbqnkvM08yVyVR1qj04mhDh0WYK
 eOHmeI33Rg2YuPapMz8aOYHdBnMXLHkGCECCq+Ba6tfodTh5A5VLM9zy9yah/K3A7krecra
 8bsH3Y2ZRbz3Sfb1ifLMVutvxWgwgHZUMhHQkqSIX4/b+uCsxvmJK4bksVY/sGQJDjBJzDe
 Wy1wY4ENGne52+XAphT2g==
UI-OutboundReport: notjunk:1;M01:P0:nHXVNMX4gKs=;MX/9cVEF8lK3EHLEXQC2cSkH6SL
 z+iJIJFHrMBhvRU0gl9QmcjK9JPyrxbLS46MQAENgSAoXEqCYD2/mEjUhqwnjLom3zaZAMVNj
 PN+322IaKoK6vA2lnSgQl2p4AAyK9iAGzYPHYllHW5YwRbjz5XXT8yo5bml0tJ8piJc34v3Up
 NSbRzz+Nj1DlIcFZhoeLRY6xg97M4DdvIACzee/vN7PygKUW3PIOzB9tIUhUl38KDEmw2wYjL
 rYA3YwNBwYah3VZ5NkbFAEYej3Szz3mN4+3Htdupf5n+LM49Ji3plLzpFpdxlLVoVJ22gyRUr
 wbugeJbTBWhn+WykjuJ2K1N+eRbM18sRHpZw5EUb1dSWPxPdmO4sDpXfCNakOt2oa/LWghiZ3
 AaYgwzWM8QUBohz9S8j9H5zkSBJnwjSARJnJsdeAoZ/ss0mInMuL4NJrxms6z2dA7pWJ071v5
 7addlCfOgOQgQDH6jybUWw8zcMkBWtqqbOQ4zo1jDHXFI0rMdri3x7AQawQMZVY4t4Q7MtUVB
 aVWt8R3rkhyveaCaZNnn0GN3u/jhfeWZjFqpfhde1NqPk1MTSYS01VCf1AzA4cyhT/N1mMc98
 ow7lXKdCjdeUuebFJI4s+qhZ8wmr5rDTWSQcbVea6MumX3J/kfGui9gdI3bL+v7iYD728SoMC
 qeaVQ+joRENZiBRLQz3ZeIW8xt46nv4GswrP/zoENNjai3y4xnrxJf/csXTN+vxald13o5Drs
 d314lQRpwZTU0Otpo87CuBPEihOqmJTO8b4t2uuBSsCRn8cSTPb9UuUjTM2T5LJPdxBn6j4X1
 gKoihei8guFARX4Dx2I9OnAEALXlkaSLtOJdygXQWsqdyRRwe14mUQQ6W9U7ks+maw23pqeLs
 +pBZKIRNanHsbIbKxP7s8VB0Swb9jis9A7l32bCQgSlKxjSIVWzJFGEpmYvxHK3cRNkh2Hnup
 ThPCcg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't put clean parents on the pending list, as they and their ancestors
don't need any treatment and would be skipped later anyway.  This saves
the allocation and release of a commit list item in ca. 20% of the cases
during a run of the test suite.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 572301b80a..d00780bee5 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -701,8 +701,10 @@ static void clear_commit_marks_1(struct commit_list *=
*plist,
 		if (!parents)
 			return;

-		while ((parents =3D parents->next))
-			commit_list_insert(parents->item, plist);
+		while ((parents =3D parents->next)) {
+			if (parents->item->object.flags & mark)
+				commit_list_insert(parents->item, plist);
+		}

 		commit =3D commit->parents->item;
 	}
=2D-
2.38.2
