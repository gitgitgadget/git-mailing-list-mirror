Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936762018E
	for <e@80x24.org>; Sat, 13 Aug 2016 12:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbcHMMLo (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 08:11:44 -0400
Received: from mout.web.de ([217.72.192.78]:56367 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186AbcHMMLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 08:11:44 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MgOCo-1bsyJS1G8k-00NjjY; Sat, 13 Aug 2016 14:11:28
 +0200
Subject: [PATCH v2 2/4] commit: factor out set_merge_remote_desc()
To:	Jeff King <peff@peff.net>
References: <57AEE4F7.7090804@web.de>
 <20160813092330.vmy2hip4papyuula@sigill.intra.peff.net>
 <57AF0D8E.6040309@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57AF0E6F.4010902@web.de>
Date:	Sat, 13 Aug 2016 14:11:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <57AF0D8E.6040309@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:88YMXdbwFXZ0fg5aJI8GBfd96bVmWR/V0Tc/Tb+GaJkraB/xBzo
 gJJw1INIiQsGgnnXX/tBimyCFkkHSihe4zUUgln1Gn3CiQKjpv1PB2FYpw9mYAfUrHmV5jY
 VlztwOvZw8aImg86jNAsX1tH+nC/bQL36hDb6t0payLrxT0pThoMHhfHw85bZbr+j/2KCbu
 AhNy/HlY2LnED7VRNTP0A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:zpvRqHBS234=:CO4APRUVOXTSDvNtqEgWvq
 k+0c3WgLXykx5UIeechhIDxZbjCrwOqchbwdMYQPTNBrWc48qHPozoAeTmMrVk/jgI7yWTm0r
 5ayybZesJFy93EyaZ1Ha671q/vhqf65072lErUd6i5BuatoJZfhcgsGid/7NsmiJgBfPSaVBo
 Rw/ivOBl1DQ9Do3mIl5JWzoa8i2/qRQMfBvvnkJKVI+wn+Aky61AxINwBzgALtU3CU6YmKzbT
 IjL6eWQZ5BLzRH8BKjvhAOD978oQhIfxS6KqG3KxqQauxJGTCSGqMJUOM7LTYz2vat2rjiC5O
 d+xe6peQb0x5Akt+Y73WWAEzJUS67Xinkm2opQwzVAvfRhIGvNajRrlYBWEmDFzafqvdvSCFQ
 vY7nUeyY5dorsz6+gruee4is41soHAyBun1uHch/lJTG4L9hi+iCyrbhpLCHblrRqAc9bHTqg
 Va3o1gczCs66bOWJ2pBQmAfnX40ec/FbCR/OneVmjAoXv9sNKxLnTNu5qtPHw50xE+7euVHLv
 PVLcnlaZZkSXJEvcNG4Sh9JRwUSVXLhCXB0FgmIwLISjW6NRn6/clpWSXKGkK0BzwSWWzjd3B
 I9LWBoHphuVcvxy0+J4hYKSckKHyM3Ws43WdpOBIh3+4fKRLfGgO29p1TLAyMduRYqQUhBwP7
 qLr4O/Y5H9UT2uk2ItCVpICTXrRwVOlrzUHEdip4GDoYnLrazWSI4EniPfYam9INp+raKLPva
 gGuJhJJ+evnro1Rew3PYySvmODlaquZsy4wLCKK/horAsXTTcTyjjtoZDyJET+6T7e5oeefs0
 SIhb3QL
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Export a helper function for allocating, populating and attaching a
merge_remote_desc to a commit.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c | 19 ++++++++++++-------
 commit.h |  2 ++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index ccd232a..8bad713 100644
--- a/commit.c
+++ b/commit.c
@@ -1576,6 +1576,16 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	return result;
 }
 
+void set_merge_remote_desc(struct commit *commit,
+			   const char *name, struct object *obj)
+{
+	struct merge_remote_desc *desc;
+	desc = xmalloc(sizeof(*desc));
+	desc->obj = obj;
+	desc->name = xstrdup(name);
+	commit->util = desc;
+}
+
 struct commit *get_merge_parent(const char *name)
 {
 	struct object *obj;
@@ -1585,13 +1595,8 @@ struct commit *get_merge_parent(const char *name)
 		return NULL;
 	obj = parse_object(oid.hash);
 	commit = (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
-	if (commit && !commit->util) {
-		struct merge_remote_desc *desc;
-		desc = xmalloc(sizeof(*desc));
-		desc->obj = obj;
-		desc->name = xstrdup(name);
-		commit->util = desc;
-	}
+	if (commit && !commit->util)
+		set_merge_remote_desc(commit, name, obj);
 	return commit;
 }
 
diff --git a/commit.h b/commit.h
index 23ae0c1..84bb507 100644
--- a/commit.h
+++ b/commit.h
@@ -365,6 +365,8 @@ struct merge_remote_desc {
 	const char *name;
 };
 #define merge_remote_util(commit) ((struct merge_remote_desc *)((commit)->util))
+extern void set_merge_remote_desc(struct commit *commit,
+				  const char *name, struct object *obj);
 
 /*
  * Given "name" from the command line to merge, find the commit object
-- 
2.9.3

