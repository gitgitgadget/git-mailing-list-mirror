Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B532082F
	for <e@80x24.org>; Sat, 15 Jul 2017 20:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbdGOULf (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 16:11:35 -0400
Received: from mout.web.de ([212.227.17.11]:58047 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdGOULe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 16:11:34 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lhvpu-1e0nwe1DAQ-00n7lr; Sat, 15
 Jul 2017 22:11:22 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] ls-files: don't try to prune an empty index
Message-ID: <bbc51fb0-70ce-3b02-274b-31b5dc035e29@web.de>
Date:   Sat, 15 Jul 2017 22:11:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:uAY+f5xkNn56tUa30lLhvyFdd9rBiaU8IA3h8WWpYONeh8Tv76B
 xzqCYuklBQeua3LPzwbwJVeYUhQ45JUm8eLoPKhJ6LWdOu73uSJIAPTzrXQ9ugT5AupBiSF
 5yYmkKtdq+2kFwz54d2Xx0pqEKO2JCpY584qvp5eNkh8lZ9IXZ/56iGWjyMO0H1jX62AIft
 4vGhxgEloA7cjGOml+yng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WW0XXj2lYyM=:N4dwA2NogBR0+ndEhBWCky
 gtCyBQOcllR6X0skE3kl4X+/KGff60wYKALJlu8yX5NhJTQkn1OwMXYE6oBYYSZaUywbunQYL
 j9UU1m3LEH0iFYoWdZz9x06qNZYSas7Jc8Maj0kBMz3aDJfMHtOzc9ZNklbYCA2gMFFjHQXmk
 jH2h58TxiScZRY4XBxCup32CWKYYUQJK3IG7m72fCV8yrC94g7Yl+dj+6lkCitQI+gv7l/30U
 S6mHL8nQLye4QP2CRjxNOf8t9TLfFGE7YoFZtEG3+di5aQDnXhV1WVAb9CqR6rNY34i7cWWMj
 NQa+3eBWu7EL5hVfV/vEKJSwLKSmBLrBZjzXIGGQF0kCduFA4VJ0MyYF9YAt4Y7xMCmkolGkw
 5/9sOSjfguRCQnDDQsKeuHjzp9Ja5jyVdJ9bKM4dkDO60up0ZFWENJSFyXecu5l7zVnbHTfPz
 J6e5Rkqo85A8Xk/j/z+4paiLUQ5Vk5v6/TpRLbQEWOUDe9xvrRrlkaOxBZQ12q9tGcsLmsf0J
 gC2IqX8Ff9q4mVWQ26BmEW8HvhWUul7gqdJ48GaoYsopHlZGzMYnho7ZTJ9qZftkKCwBIqD27
 g92U1T82askGZ4teeZOw8AR8dTCR9LLYumAcA9q2X19U6kcnzSkcNN+eyglbghNiv//trB95I
 sF0P3aI574lZpC1JX82SKIEP3NEStKNI2dfGTN1tWwhsOViPYEE1okWoqeNFftRdrWl1pq6Hl
 KflCgmZfwVtSJT3fKtSmIPxmrXGPP2aHtOTipsjzymbTmk4M3jBYY5ajD4P6lJv140HKJzrdI
 9BQJn+eW7z7K2jbZuQ+wXcLt2j5h+U4e/EjciyCXH2Uc7XwTYE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exit early when asked to prune an index that contains no
entries to begin with.  This avoids pointer arithmetic on
istate->cache, which is possibly NULL in that case.

Found with Clang's UBSan.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
  builtin/ls-files.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b8514a0029..adf572da68 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -362,7 +362,7 @@ static void prune_index(struct index_state *istate,
  	int pos;
  	unsigned int first, last;

-	if (!prefix)
+	if (!prefix || !istate->cache_nr)
  		return;
  	pos = index_name_pos(istate, prefix, prefixlen);
  	if (pos < 0)
-- 
2.13.3
