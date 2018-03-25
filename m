Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AECB41F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbeCYQb4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:31:56 -0400
Received: from mout.web.de ([212.227.17.12]:34085 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753281AbeCYQbz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:31:55 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaCji-1eIZSq1zNm-00m4bg; Sun, 25
 Mar 2018 18:31:50 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] unpack-trees: release oid_array after use in check_updates()
Message-ID: <b2380d1e-1d45-22cf-ba22-cf4cb02e1134@web.de>
Date:   Sun, 25 Mar 2018 18:31:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Ay5kA7F2UTceLZaIYyDk8J2fnZq3nJjXkrPkl+ZQH4IbEowKuJ0
 DL++pAfJusKvd223krdZ6NMZdUzGoWEUzLcezfXr86m35U4+rQNcIRt6asXcjczvJ9jp4Cz
 gsWTFX0n9aYv/FSMVSxOH9rYrRUwsReWK0z08SZQtJXjQSjuyWeRyPKmKov8WtK9EC1Bb/u
 A7qZNeeQEG8snpajmUfzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LOikF6pQ2jc=:5QZmFieHEelyJthe7486A9
 NNAmnu1jrrlQGq/T8ZuGTUepSFtr9hFug1foDvsLmBcLyKHCcbiArBwKoRo1XosvZvCB6j4kP
 eyzp/gxAJ/8cWBwfamjdgNPdoHNvFifFFbNBTQ7VgiriaCWWVXAaKrUK/6sQEjDyGR2aZCk9X
 0IPVYjDoxVDR8mMVVVUlDI9JyUpliMBdt5Wq4cQ4irzUEZG774Al0rwXKNE+ITASO+Kly6JeT
 F3MD1yjkl1MGmjl63Vma6B8pCs7CmV6K1hUx0W8eASLt8IPJfW1vjMrQ04yxmYSe+7iJt/yTi
 ujJ4t6ktQe5ZAy2kNPIqKb+63cpdY0rLMPJxpWDmmoOLBj7wQXvO6OBjD5pOiPDyW5VbO5MuI
 5lKMM2qTUGx6HVy5ctMhpo6kUxKTguTHJWXa3hunQLg7k39QC03umjZA6oPuPEcwF3tzOxN1a
 IfwbNjEAtr6Dv/VqsZGpr8or0MG38FJSobXFxINY70cDRza+A4bVVkqRJr0H2IJT31KxwYekV
 Lm1DajmINNRtUNFiyrHt1Cbh8R1u1woLQeB8gnnOIRaR1zujPiD3+f+YWQiYZqTnmld46Thas
 4Vw/msuIL3gjArdKu21CPxWt090YrpkzL0EZymSZfuwFcZfo3MWxN0Odl+yBoEEm5jk8D6+/D
 Ty73LJTu3+VRwjxlOHdSQZC4+18B+QOBwULVbjuKPmX5qeyi7uoFHpZ+zR3TQUSxIhy4g80sq
 t/Zrjr/0tQY6hLNEClVFlamtiY1+HyrL0nzOq7fHAeoNsbwmhR+LUyxdOViBouO2X3qKfQ+fG
 Q4cf6SeaFoGR5hnesN8QLT7y2xhqcRxasbppOZszBIQBy2SsDA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
That leak was introduced by c0c578b33c (unpack-trees: batch fetching of
missing blobs).

 unpack-trees.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index d5685891a5..e73745051e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -379,30 +379,31 @@ static int check_updates(struct unpack_trees_options *o)
 		struct oid_array to_fetch = OID_ARRAY_INIT;
 		int fetch_if_missing_store = fetch_if_missing;
 		fetch_if_missing = 0;
 		for (i = 0; i < index->cache_nr; i++) {
 			struct cache_entry *ce = index->cache[i];
 			if ((ce->ce_flags & CE_UPDATE) &&
 			    !S_ISGITLINK(ce->ce_mode)) {
 				if (!has_object_file(&ce->oid))
 					oid_array_append(&to_fetch, &ce->oid);
 			}
 		}
 		if (to_fetch.nr)
 			fetch_objects(repository_format_partial_clone,
 				      &to_fetch);
 		fetch_if_missing = fetch_if_missing_store;
+		oid_array_clear(&to_fetch);
 	}
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_UPDATE) {
 			if (ce->ce_flags & CE_WT_REMOVE)
 				die("BUG: both update and delete flags are set on %s",
 				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
 				errs |= checkout_entry(ce, &state, NULL);
 			}
 		}
 	}
-- 
2.16.3
