Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01E71F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbdLYRnr (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:43:47 -0500
Received: from mout.web.de ([212.227.17.12]:58959 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753020AbdLYRno (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:43:44 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Meji8-1eIZTn0Hns-00OGMD; Mon, 25
 Dec 2017 18:43:39 +0100
Subject: [PATCH v2 1/9] commit: avoid allocation in clear_commit_marks_many()
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d37d0e0d-c703-a70c-cf0b-969e54473557@web.de>
Date:   Mon, 25 Dec 2017 18:43:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:IJqk6xBEt/9U9OfhWau9UasvXZ3eFGzPXYY2S6PY0g0nQcgaLPm
 g6kaKEdXaaKl8onz7iX0EbnmtU3sJz/a7cTTkkJd2FKG68H066R9fPcYWSMECK3vHRXomRH
 AIopW8zQcN94IFeAdgUXhFqKIk9gCFm7T8LcCJwdTXwOdk43K+53ydY1h9AEy2pa9DWmu0+
 Rik1hVKOd+hp2gW6XB4Iw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DmILJP15ESo=:QhEZRH2/3LYGuMtahsnDwR
 BwA9QQp3ydD5AsHBJSUmBsKhyTefRFrJRERzw5FV+HY72LmF5dSH3cQactAz5bMv34RgEW1zE
 vGougNO/D7u6Eh6da5fD5nvEJ3u9C+YiLeUuJSHNtTMEoqyIr+32mdZLMv0IoJZs9pB2zeGOz
 sEi90YPmioqalOE2bPLGYgGPdSU6Jx9ElOw2n6FTiueBxYs4sDW+ZyoQZjSrJHqofTxjCQ1KN
 T9j1yeTpZsGBmjiZ2hSkFb3dzNpVPjHyAcSwC/WcHRxVQAwMYEM/k4YKqT/QjKAJbpjKwf4YU
 4EtPr3ir/ZOAfos76Lt1+IFh1Q/y5aR2ALsVIbZaW9thrGc3RW+rn3IdnWwuk6bfRyPgNayHE
 K0UDUcmlDgIoP+Y/wh+gPnhfrjKhYSTegJ5miV7RYdtgxsNeqnuuXTPOJfyf2jODl3YNPWPMO
 aPjWb+T07j2yOBP5aAx93IXuI8t61JuKG4Sf4qeq72RXzxgsXabSAY5BCRLGFOhAq5BkBesl6
 eV4kqVevrTqzLI+qtZ3w6DjIhdLxezWuRH0i9xs30tkW6wyzDbTnlNtxWz2vh+D5BfjwgD1Mg
 XtYOxYioeSEVHeA5nvsCiNWNOpqGO/v0gCNSNe8dYKcAjqVQ5B+V3ZyqsRzA8USAM5qsep1Vq
 K2HavbeulEz7+kzqea9OGDYoofhCWlEFFkCB8RFMo8D+eN7bWUPmQgU4YVysi1fjF1y+kK+2h
 QbGyQatJpDQJEOPOfNOx4sEzj60ag6jW0lnrCLtCNwYGrUrSzE8lw4XBrfmOAZhqm0KMXYV/D
 mFzwLbro4G6OvyXXp1Pwa6m2/F/jI2vqG7dnT4T9CDMXVjMxtI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the entries of the commit array directly to clear_commit_marks_1()
instead of adding them to a commit_list first.  The function clears the
commit and any first parent without allocation; only higher numbered
parents are added to a list for later treatment.  This change extends
that optimization to clear_commit_marks_many().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index cab8d4455b..82667514bd 100644
--- a/commit.c
+++ b/commit.c
@@ -545,11 +545,11 @@ static void clear_commit_marks_1(struct commit_list **plist,
 void clear_commit_marks_many(int nr, struct commit **commit, unsigned int mark)
 {
 	struct commit_list *list = NULL;
 
 	while (nr--) {
-		commit_list_insert(*commit, &list);
+		clear_commit_marks_1(&list, *commit, mark);
 		commit++;
 	}
 	while (list)
 		clear_commit_marks_1(&list, pop_commit(&list), mark);
 }
-- 
2.15.1
