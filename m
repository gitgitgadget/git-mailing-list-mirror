From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/3] janitor: add DIV_ROUND_UP and use it.
Date: Wed, 22 Jul 2009 23:34:35 +0200
Message-ID: <1248298475-2990-4-git-send-email-madcoder@debian.org>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
 <1248298475-2990-2-git-send-email-madcoder@debian.org>
 <1248298475-2990-3-git-send-email-madcoder@debian.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:46:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjdc-0004eW-WA
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbZGVVqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123AbZGVVqD
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:46:03 -0400
Received: from pan.madism.org ([88.191.52.104]:57656 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828AbZGVVqC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:46:02 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E29E146504;
	Wed, 22 Jul 2009 23:34:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1C1692B228; Wed, 22 Jul 2009 23:34:37 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.rc1.192.g631f9
In-Reply-To: <1248298475-2990-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123784>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-compat-util.h |    2 ++
 help.c            |    2 +-
 preload-index.c   |    2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 6dfc0dd..9f941e4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -37,6 +37,8 @@
 #define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (bitsizeof(x) - (bits))))
 #define HAS_MULTI_BITS(i)  ((i) & ((i) - 1))  /* checks if an integer has more than 1 bit set */
 
+#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
+
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
diff --git a/help.c b/help.c
index fd87bb5..6c46d8b 100644
--- a/help.c
+++ b/help.c
@@ -100,7 +100,7 @@ static void pretty_print_string_list(struct cmdnames *cmds, int longest)
 
 	if (space < max_cols)
 		cols = max_cols / space;
-	rows = (cmds->cnt + cols - 1) / cols;
+	rows = DIV_ROUND_UP(cmds->cnt, cols);
 
 	for (i = 0; i < rows; i++) {
 		printf("  ");
diff --git a/preload-index.c b/preload-index.c
index 14d5281..9289933 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -76,7 +76,7 @@ static void preload_index(struct index_state *index, const char **pathspec)
 	if (threads > MAX_PARALLEL)
 		threads = MAX_PARALLEL;
 	offset = 0;
-	work = (index->cache_nr + threads - 1) / threads;
+	work = DIV_ROUND_UP(index->cache_nr, threads);
 	for (i = 0; i < threads; i++) {
 		struct thread_data *p = data+i;
 		p->index = index;
-- 
1.6.4.rc1.192.g631f9
