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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0CFC433DB
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 15:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F2B22482
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 15:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbhABPVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 10:21:30 -0500
Received: from mout.web.de ([212.227.17.11]:44485 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbhABPV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 10:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609600771;
        bh=MC1iOgK+jP1iuz1lW8p411V+Dr+/B/HaXe40J8zdW+0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LemzKSgKz6GmtMTr1qX0/MjeIrWFeFzPYqtb+Oh0sK+kUGjiyCQFyqM/wkJt/NHvd
         KIEKNtPjA7hV24mS33+QGXdl3+61upGG5G4Zeo0nkjmQogHmWVl2NeT1IYq6FAwwRW
         YoWnKos2waov4JEhqcyJAgcQkmSTIYdH6YARb79Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.159.90]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgSv-1kGdJo3Lxb-00l9xb; Sat, 02
 Jan 2021 16:19:31 +0100
Subject: [PATCH] cache-tree: use ce_namelen() instead of strlen()
To:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
 <daeb59ee-861d-9c8d-3601-6aef1ac3fc94@web.de>
 <3ed37ae6-1f09-bd6b-c9d9-c8089da1af92@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a8b5bb13-5c88-d744-b47e-7204e12ad05d@web.de>
Date:   Sat, 2 Jan 2021 16:19:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3ed37ae6-1f09-bd6b-c9d9-c8089da1af92@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MrLRf2kdn/mOcZ1bS1X2nvefzN9OJX8BqQameTZ9FyVDUQVKAOH
 1wmqaJvIfSzWaMEUMr9ZdCTRHLIXjZpkuwbhSF9fkFUl8PHCQIPzV4mq0jweNgiBRrtWTn9
 iKspocoinuucMudJsIr9hQI/CnpdYcKbZoNNX3WOiTw5QYfwNMh0mG3W536C80pPQbVGsGj
 3z2/8vHOcJvH2FsbB4BQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hbKuHIUXsiY=:+8T142zaGKaTWAHAWYc5Pe
 AsZOEUW5sQxC3q2me62sNXChuv9ffrFwAXQes14uCMhgjoMXe8XwaURmKtpfuW85GiIhs1xxg
 7aUauZHbFtF9MjMiqT1VQGAs7rOIW1PjusQWyhs/kTc7o7IgbZ9sc3WpRa03fzWMD6x8IL4ys
 9THGbg2s96XmYAKnVZC+jxZANN/narQ2Gi37IjDl8qQJxtWOW19X6noGmfPTY9snJr8GUHvG3
 MDuHK/bxJUkHwetwT6RT6wX2oY1IuRX4rkQ6dRuC8DHhqeEC0gM5el+2hPCtblfT3ucNmRTwr
 Edy3wm3bKq153se6amvuQmcAO+tmCzjrVHuW/+RZU14d7Awm0CmLRrazb5M80UUKH3YLfLCO2
 a5KkFltFqYK+gcQyfQkQQWwxJoYMv8Txp1S4ApfgLzPCGQw3YxWU8Y4R5V/KZYuW03DlP1OZI
 78u1HSnTUbH969Q0qNiWh4mZ5lLANE+JPsJ5C+eMFy2VbzeOwdGp+yM59/bS1NUa/iYSfW2Nl
 k5thp7y0qj5njyVD1uior40XLucXaHfUaWCgDaP5z/p+nlAlgWStU1K36taHgsWqTKNUWc+WE
 iv8LDcHi2pN8v5kO6JdYxjG5TwgqCczpn/dAxVJ7fBO6XPnpwtwCYReeMQM0irr1gN21xcuNK
 puaSboK3Go5Cmz/U5hTUQxWvNb0ziDnRdcc1nTRvIKKPVgFV7/KTduv3D2XGEKhVot1eIeBIg
 JbAfhEEDDDdRRcQwFf9iUOAwrBBr+XXhwj7ObcsM9p6WWxRN5B/+vIaXn9IckEC0RRu1AiWcX
 sG+W4gi/Zx6CU1BvH6BkRPclWkDeucbgTlwMXtKGsiOp2SCkj4G4Rst+ZX1Yw2vcvGHy3syOG
 s/CZfX/hfEfiZdF857hQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the name length field of cache entries instead of calculating its
value anew.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Not sure why it took me so long to spot this.. o_O

 cache-tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index a537a806c1..57cacab195 100644
=2D-- a/cache-tree.c
+++ b/cache-tree.c
@@ -185,10 +185,12 @@ static int verify_cache(struct cache_entry **cache,
 		 * the cache is sorted.  Also path can appear only once,
 		 * which means conflicting one would immediately follow.
 		 */
-		const char *this_name =3D cache[i]->name;
-		const char *next_name =3D cache[i+1]->name;
-		int this_len =3D strlen(this_name);
-		if (this_len < strlen(next_name) &&
+		const struct cache_entry *this_ce =3D cache[i];
+		const struct cache_entry *next_ce =3D cache[i + 1];
+		const char *this_name =3D this_ce->name;
+		const char *next_name =3D next_ce->name;
+		int this_len =3D ce_namelen(this_ce);
+		if (this_len < ce_namelen(next_ce) &&
 		    strncmp(this_name, next_name, this_len) =3D=3D 0 &&
 		    next_name[this_len] =3D=3D '/') {
 			if (10 < ++funny) {
=2D-
2.30.0
