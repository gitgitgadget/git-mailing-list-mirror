Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362EEC61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 19:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjBDTKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 14:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBDTKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 14:10:32 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA302798E
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 11:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1675537824; bh=oxF1jh6PTAcCNstMFmBhwxSsr1Vz5kmJ89Dj9rGWWak=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=hlIpp8YmSWOD5ge/pI8Bqd9ZL6UCRedAPfqcaQWXckfjeyGS2wHz8kgstJH27LVHz
         jD8wbLrO6dEVrbfT9EY+N+WquHwWCPpcp2SVK3U6b56BJxLoGvopdsIoTcLawJP4St
         7NGUoFKhYi4nTH1H8yyhDWkdtaFR4ZXhKHd+hzWKeMBBoFeXf1weRk3LwDM65k0IwU
         Am0ielbDlA3B6xthb/L366aUK9Dpj53rEviFBHx3Ovx+VkJrTGU4O1qW8dkV9hdFO4
         uc4xKaoO7mmI9wGcalK8eo1Pn0TmwhM2+ce33BMAKzy87H0ZYCEkzuz9dC3rJdbkOS
         xIJ+EwEiwYQww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRUV-1p6a5z23Ln-00IVbJ; Sat, 04
 Feb 2023 20:10:24 +0100
Message-ID: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
Date:   Sat, 4 Feb 2023 20:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Gp1PMLADkV4X9XtQW/Dp08n1kxESntVwy6E5Tl0MNiyL3JZSpP
 n8mwlXwlBb9MFYcRmcj/mjPSx/YRisD/4fGsVrB/8O8eupIWicoG+P7lCZYD1UMgAUTjWs+
 6FWGcfS/soT8tQfXqllEk9cleFGRx98XBjIg7hsqH7pieInd4J9xknwLl2GpTBg8n4of6eB
 GrkBkOmXib8VWRCKedcqA==
UI-OutboundReport: notjunk:1;M01:P0:ELARifXa6ks=;lSt+D5ZxT7LJO0X6jXTEaQQe846
 3wzVLDaaZhu2DpPym3MasbG0nU3DaH71b5CvpkuH9IuS6vZYP/tfXo/bYTa1ll7GepCSAyU1X
 2QrT6KWAiGO1vFInYqck+uqFc8engx6epbEDsA4HP9atXQIBmdcZjPrODz0m9se6aimT9urqS
 jqwJmByIFZ92k/THGVnKQl0KQn5rh+bhsNO2TJh1yJeiFfhlf5rPc5aszvQb3pi3Vz348Yk7X
 OhFJPubTMi7knX8rbl3g2wNV35ihQJi6ZIUUUITljQtOShhdW7LsnhbCxabZM/e34rXzgK8LJ
 qdwo9EZ5hYIsdUFV57+bQth5KP+e6hnQvwyMnVh+ed1FE1gVY5qlQhjh2wKqaawa3kkwHewU/
 KegVx1JScgwVmtdHv+So4C7wuV3RgH4JSUddEXCfQ+AnOl0IJbWCijHNKUbM3d78Jk3cFy6Fk
 ZNwdyt1KVT1tvEFrrx8bKD4RHg0lW5eB1TnsX9BAGwKOPN0V5zH8ACS1W02h6Q2dapvIFOzxP
 1Doo5FXlpwCv4HI/fc73EHfeRuDWT4VHZ18yoCpyny+k/XJQGh6dAS20JuEyr6LsVVxQgzWFE
 dsHzjQsqJuXMepkVmFlWBFeO3f63eUM98Li6hZ4Gh5KhFNmvHPnEO+Vn/m/UEgYSicX0l1Hxw
 XnOCssnXFGnBqSSllpBfgfn0DTK21hcUuMTB5sn28EUGwV7TLDgoLfMHoguGqoGvkAvjgKPdd
 ctdsX/vwnZO1SKiddziHVP3Dd/vdvFLVqBOGGch71bPjczhL7zLyT08m2zjZGgdXoftl+JTlB
 nnmkwLeE316Y8ofABujzLvRERkOhiUwXccUnJBV92bgJ4RbMVi2W7PmaXEchUi4CiWsmvYrKn
 PbhS27zAjbRR0k2xuGFFq+5Ed8emL89vySUjuiRPxaTGKjbwnecLLqnYE5JE9zRB47IBGwSyw
 JbrhlQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use size_t to store the original length of the strbuf tree_len, as
that's the correct type.

Don't double the allocated size of the strbuf when adding a subdirectory
name.  Only extend it to fit that name and a slash.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 cache-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 9af457f47c..35f7617164 100644
=2D-- a/cache-tree.c
+++ b/cache-tree.c
@@ -760,7 +760,7 @@ static void prime_cache_tree_rec(struct repository *r,
 	struct tree_desc desc;
 	struct name_entry entry;
 	int cnt;
-	int base_path_len =3D tree_path->len;
+	size_t base_path_len =3D tree_path->len;

 	oidcpy(&it->oid, &tree->object.oid);

@@ -785,7 +785,7 @@ static void prime_cache_tree_rec(struct repository *r,
 			 */
 			if (r->index->sparse_index) {
 				strbuf_setlen(tree_path, base_path_len);
-				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
+				strbuf_grow(tree_path, entry.pathlen + 1);
 				strbuf_add(tree_path, entry.path, entry.pathlen);
 				strbuf_addch(tree_path, '/');
 			}
=2D-
2.39.1
