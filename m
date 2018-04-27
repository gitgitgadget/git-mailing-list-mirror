Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3660B1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 22:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbeD0WbU (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 18:31:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:50335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932453AbeD0WbT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 18:31:19 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MZlEg-1exPw61Zmg-00LZ5j; Sat, 28 Apr 2018 00:31:12 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH 1/6] sequencer: extract helper to update active_cache_tree
Date:   Sat, 28 Apr 2018 00:30:05 +0200
Message-Id: <ad31aab8e735f7de813860cacb32abbc406f43d1.1524868165.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524868165.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:1oXljhwg1U7or6Jt5s0rZy6c2pX8+R5iR3U+YKK+E7TZotftUK3
 ABeNDyjRsCdOEvEfiNRkP9MZgZ2vOws4UCNjg+2EspHpZTSDdtFwY8KrQzmlL4m/NbvEHn0
 GLw0Kk/0UaCAF3TdnEfVIY2fPAhYbxG7lRsRlTxzP9uK6CGpJcg5XvnlZgmO1xTvrk2c6bf
 XzSQOF1Uhgot+IvazXnhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XELYbHTps0Y=:WIMPkLrJGZf4FIdggBEFZy
 lF8jE49hCuDyhuafhyW0nf0FP+BEYGOrBLtjoAuXhXC0ktY0X71VD2ZMHze1nwRO8Am6+GlKa
 BRBgSKecmMU2+TzndZZWmYp5o1CIsIkk/yTVzgSCT8MC1p+l9I8/YnNXlYxKFrtOcvdEvYnxE
 nQeRWvOYEm3AyNqnZI/ljnY7YpbkdUK9hbaHeqpb8ASKumVhNIMLNObOA5AM4Aix4/GOMcWqT
 Ibx+SyPT345fBnUUEHQWhrGIfIivGu4ZQqf4WEH8eMzj+Oo6fvSPF1uL8YXFor2meHHZjftqo
 DN7N0PqXexeV0xeDoPFaFP8JuJJzaSWfMNvv2qgjfBu+vQ5ZBjrDsrz4UZwzBnkn7F/fVcL5B
 teEQ57PLWVqqVv8jVueRjkZSblos000OfQMn76yLnMBEfzpovCsagHU7SZdLd4A2XppVGActp
 z2R6QZiI1AO9utRS2mdiYZYKWu9Kcvx2BC2JQjKgah8Fw4F4DBRbEdrAZ0h+HW3msQgafSOx+
 5bvw0jR6m1pWqo9ZqqJoy0HxvqBn/h18yh0l2VnHL+Jlctns4Cu3Q0H2wGOe3LrPudkvMbh0W
 UPp5XeeH00dBEn3UrJ4SY/t5PWpAxonYa6MMMnkiRDYITt44B4P/5nEs87aT5rNbqe66YGMNS
 9K81P8K5JZAZRedrv2Ae4PHc+p0zoYYR9f8PXIIBMGnKc4Y0S0Y9hQ/8CGM5whYU3PIj9cg3Q
 MqJiC4bGilr1hRMHRlEFZW1urCGXUoMI776yG0FD1xUw/r5fL4V5XMJwVhdyCR/1OmlfCmTTz
 23VCQAG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch extracts the code from is_index_unchanged() to initialize or
update the index' cache tree (i.e. a tree object reflecting the current
index' top-level tree).

The new helper will be used in the upcoming code to support `git rebase
-i --root` via the sequencer.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e2f83942843..90c8218aa9a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -562,9 +562,23 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	return !clean;
 }
 
+static struct object_id *get_cache_tree_oid(void)
+{
+	if (!active_cache_tree)
+		active_cache_tree = cache_tree();
+
+	if (!cache_tree_fully_valid(active_cache_tree))
+		if (cache_tree_update(&the_index, 0)) {
+			error(_("unable to update cache tree"));
+			return NULL;
+		}
+
+	return &active_cache_tree->oid;
+}
+
 static int is_index_unchanged(void)
 {
-	struct object_id head_oid;
+	struct object_id head_oid, *cache_tree_oid;
 	struct commit *head_commit;
 
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
@@ -583,15 +597,10 @@ static int is_index_unchanged(void)
 	if (parse_commit(head_commit))
 		return -1;
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
-
-	if (!cache_tree_fully_valid(active_cache_tree))
-		if (cache_tree_update(&the_index, 0))
-			return error(_("unable to update cache tree"));
+	if (!(cache_tree_oid = get_cache_tree_oid()))
+		return -1;
 
-	return !oidcmp(&active_cache_tree->oid,
-		       &head_commit->tree->object.oid);
+	return !oidcmp(cache_tree_oid, &head_commit->tree->object.oid);
 }
 
 static int write_author_script(const char *message)
-- 
2.17.0.windows.1.33.gfcbb1fa0445


