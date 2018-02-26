Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6C31FAE2
	for <e@80x24.org>; Mon, 26 Feb 2018 21:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeBZV3w (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 16:29:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:39321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751424AbeBZV3p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 16:29:45 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ma1Mt-1f9rw62Go3-00LpGU; Mon, 26
 Feb 2018 22:29:37 +0100
Date:   Mon, 26 Feb 2018 22:29:36 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 06/12] sequencer: fast-forward merge commits, if
 possible
In-Reply-To: <cover.1519680483.git.johannes.schindelin@gmx.de>
Message-ID: <6f05185df94d07db847b4bdad0297af31b798bfd.1519680483.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519680483.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CtAPYqIE/98081Zfp4VUz8E9vX2/3Udjy9qi5WC+J7A9LdZR/nL
 HkcnbmkPDU92QHFPxfDfN5EIL82FrU1uzokaaTcWEp0AMuaAWz8KwpwIZB/E1Ck+uQWJ9e6
 aPe12M9s69Ibj6cn1Szhu18wm7YuwijQGzf1i0eIboqEqEIPD2KLgI/Q7aHU+ytAz3BVJKw
 OIZQlCwDme36xfuPOJ31Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7EslPlHXeEg=:Z3mcgJaYincADDpeLP9a1n
 slmIR99VQPOJYiYZoTRwhcl5l8P5FthnTYAD4pV4h57lk/cJrXF/9P37654lbrN6G0yARbkdF
 Er05MuuQUJlbxoBS1QKp2oq+9n3NBTHidDx9s//4hlWjR5/rrpM1iAuSNxnMlHuZSQ+ytw79q
 hXcvzuJ5R0nPjhUcu/Pl/4lJm3LIhd0BbzXwe71Gi9TaW4PDOFSYcr+xgQFJV8eGxEjShNvw+
 TbQViqINFELukJ0Y1ldSy/FeritQ2DpAsdkJ/3UogrQf7lZXqZecggAR/OQHtkGJ170cCqOMz
 x9sFuQOmTGVHNCdIAWTk5jTO0ERc55ZayFoz++oN1IeOr2oqrlwI1BIqvxPtXSdrD9hz4LzBd
 +sjsakK1nvXX1PmV4K6s3jadECtDOmEowFhVapHbss3aALfEc568IGdCxE2CFTU8NdE3gu3VK
 hVPmY7SfcygH1J/q9uHeYfmglpsSxJfWdpSPs9nwPC9pULz5K1vG1/OLgV0GTYAslAIrpnQVI
 K/gLWneC6wTnGjPDH4IM729e7IvPZCNrYFyz857vwgroI9OmDAFzmtaHVC9GWIOeZhU1OTbDn
 sk0lSm/T4QeVFgtsnvReXgv+eKp0k0qddTJAq7aSXtC795MG+hqXUuaZbLx70Jnj4g9FHfDza
 Yoi2bzpXJUVzsQSRV4afaJJeqcB9EnH+AOUA1IACC6JeUYx9vW6OjGTP82vfzCkbhrS1pHy5H
 AzkzADmaymvsue1TMnh3Rs54AZQdpvkYuz/w/hlusyA/mcmN8xfgDu/D4woV4ZOucJ08RDdwW
 /AF38an9LpB7rHcdPuyoh7K7ejtn9a/r0lFhTP9dQrUBztyC7ktNWzs1743HozioOeQgXsK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like with regular `pick` commands, if we are trying to recreate a
merge commit, we now test whether the parents of said commit match HEAD
and the commits to be merged, and fast-forward if possible.

This is not only faster, but also avoids unnecessary proliferation of
new objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 64dbd1d3e2e..361ec98f764 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2651,7 +2651,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *common, *j, *reversed = NULL;
 	struct merge_options o;
-	int ret;
+	int can_fast_forward, ret;
 	static struct lock_file lock;
 
 	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
@@ -2719,6 +2719,14 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		strbuf_release(&buf);
 	}
 
+	/*
+	 * If HEAD is not identical to the parent of the original merge commit,
+	 * we cannot fast-forward.
+	 */
+	can_fast_forward = opts->allow_ff && commit && commit->parents &&
+		!oidcmp(&commit->parents->item->object.oid,
+			&head_commit->object.oid);
+
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
 	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 	if (!merge_commit) {
@@ -2732,6 +2740,17 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		rollback_lock_file(&lock);
 		return -1;
 	}
+
+	if (can_fast_forward && commit->parents->next &&
+	    !commit->parents->next->next &&
+	    !oidcmp(&commit->parents->next->item->object.oid,
+		    &merge_commit->object.oid)) {
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		return fast_forward_to(&commit->object.oid,
+				       &head_commit->object.oid, 0, opts);
+	}
+
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 		      git_path_merge_head(), 0);
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
-- 
2.16.1.windows.4


