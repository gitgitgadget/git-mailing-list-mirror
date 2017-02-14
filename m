Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6838B2013A
	for <e@80x24.org>; Tue, 14 Feb 2017 11:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbdBNLdS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 06:33:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:53115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751562AbdBNLcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 06:32:18 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5MIN-1cTESK0ANb-00zUbW; Tue, 14
 Feb 2017 12:32:03 +0100
Date:   Tue, 14 Feb 2017 12:31:57 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] name-hash: eliminate duplicate memihash call
In-Reply-To: <cover.1487071883.git.johannes.schindelin@gmx.de>
Message-ID: <7fb6e739dde4dd733524708bae57f0e6e75f61c9.1487071883.git.johannes.schindelin@gmx.de>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u+NumPZSmCmfpwvnMzbJzGJERLyzy4AoOHWQ+ilffmTZZtTuooS
 1bWnW7g7mBwEPVkr9ZWA2hzU9Cxp8nSxQjQky4pkJCQdWRDMoH+L3XfIpdaGcsy14yLjFJs
 AtjlYOKjpyFPg9SildONCb4UwnirwVKDpIJZd62l+J5zt/QVc7pwlVZP8qm7ahr+xgCtoMO
 UklnboMaC4H7X//L70M4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oB74awWB6FA=:K6u7Ji8lBhWgnL/zY1+JJK
 a1GrD+zwh7MQ79gF47jPiPpDTeDTEvH/cdiZxSyj72idmv6wOD4OuVaF6mkODQupwuEcLJe8U
 vifYS8TuMZq52XwfM6YoUs1w+qG4yZX900ovPWPT8hO14PYuu6RGs1x+Q3YiYm3EEYeNtYouS
 qb6dk/aPLy2u6rErF5JkWFoMd2beJ0mcN5hPCaV7gToCQOGDspVlpJ+/t/xxaxfZdhCcYRPVi
 NDbsEhx2QqqrIBEpmUyI/hq5bQZiHPoDvuoltc/xoFZS/7w9lWpY+O6foA+jLd+samOD+zXB9
 /BaboT7UIjCnw9HqmtU0WmPVyoNaXDjasfWMB0vbY056tLaGTEAC1OY5H43k679YmgIDPnzOZ
 1cE7Sy60ScfgWlZgHiiTIU6hfOcZb8PDDZE852J+BOHr1kFVGhAkyqD6lK+yTVglsM+41FgcR
 eCwCtwHdMVRZgOXUKsI15AGsDO+LFCzc4YI3+WiVxmKrRTPUkz0unF1K0392b4ujtmMM9ZKvl
 03G1c6Njqrv87O11u8Z0DNjwg+Zszrw/8ta8dsxTJaVdhAZVBbr4Pa2LA0kXxzGfaEj4eowED
 DpXv8qQ9vKIFg1zO83NTNHYzbV2AImbv7CjC39og2eGzfeZK0aVAR9mIDBdlEIy84dtn3xIzK
 Yc+pAX28OCmpFjaiRH/gUhXa0ykPiY7i1J83ZQ4Mi+N6XIv8RWUhPJmBuEBQOmZIvlXaeOOWb
 zgcMMx4prVQQN2LstIsPBb/KpjW0MWm77eWIfD5HOe7aVz5WTR2g+4NuHsKYi4x2RTPBRE5Av
 KMdXUrY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

The existing code called memihash() to pass to the find_dir_entry()
function, and if not found, called memihash() again to pass to the
hashmap_add() function. Remove that duplicate memihash() call in
hash_dir_entry().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 name-hash.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 6d9f23e9325..ad0bc0cef73 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -23,15 +23,21 @@ static int dir_entry_cmp(const struct dir_entry *e1,
 			name ? name : e2->name, e1->namelen);
 }
 
-static struct dir_entry *find_dir_entry(struct index_state *istate,
-		const char *name, unsigned int namelen)
+static struct dir_entry *find_dir_entry_1(struct index_state *istate,
+		const char *name, unsigned int namelen, unsigned int hash)
 {
 	struct dir_entry key;
-	hashmap_entry_init(&key, memihash(name, namelen));
+	hashmap_entry_init(&key, hash);
 	key.namelen = namelen;
 	return hashmap_get(&istate->dir_hash, &key, name);
 }
 
+static struct dir_entry *find_dir_entry(struct index_state *istate,
+		const char *name, unsigned int namelen)
+{
+	return find_dir_entry_1(istate, name, namelen, memihash(name, namelen));
+}
+
 static struct dir_entry *hash_dir_entry(struct index_state *istate,
 		struct cache_entry *ce, int namelen)
 {
@@ -43,6 +49,7 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 	 * in index_state.name_hash (as ordinary cache_entries).
 	 */
 	struct dir_entry *dir;
+	unsigned int hash;
 
 	/* get length of parent directory */
 	while (namelen > 0 && !is_dir_sep(ce->name[namelen - 1]))
@@ -52,11 +59,12 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 	namelen--;
 
 	/* lookup existing entry for that directory */
-	dir = find_dir_entry(istate, ce->name, namelen);
+	hash = memihash(ce->name, namelen);
+	dir = find_dir_entry_1(istate, ce->name, namelen, hash);
 	if (!dir) {
 		/* not found, create it and add to hash table */
 		FLEX_ALLOC_MEM(dir, name, ce->name, namelen);
-		hashmap_entry_init(dir, memihash(ce->name, namelen));
+		hashmap_entry_init(dir, hash);
 		dir->namelen = namelen;
 		hashmap_add(&istate->dir_hash, dir);
 
-- 
2.11.1.windows.1


