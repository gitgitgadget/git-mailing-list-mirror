Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B041F667
	for <e@80x24.org>; Sat, 12 Aug 2017 08:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdHLIrc (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 04:47:32 -0400
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:58161 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750983AbdHLIrb (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Aug 2017 04:47:31 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dgS4u-0005VZ-Qt
        for git@vger.kernel.org; Sat, 12 Aug 2017 10:47:28 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id w8nS1v01F5BuuEg018nTxu; Sat, 12 Aug 2017 10:47:27 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 96B5A45D4513; Sat, 12 Aug 2017 10:47:26 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH 5/9] Convert various things to size_t
Date:   Sat, 12 Aug 2017 10:47:19 +0200
Message-Id: <1502527643-21944-5-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

---
 bisect.c                | 2 +-
 blame.c                 | 2 +-
 builtin/fmt-merge-msg.c | 2 +-
 builtin/mktag.c         | 2 +-
 dir.c                   | 4 ++--
 dir.h                   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2549eaf..0580c82 100644
--- a/bisect.c
+++ b/bisect.c
@@ -131,7 +131,7 @@ static void show_list(const char *debug, int counted, int nr,
 		struct commit *commit = p->item;
 		unsigned flags = commit->object.flags;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
 		const char *subject_start;
 		int subject_len;
diff --git a/blame.c b/blame.c
index 739a280..f628b42 100644
--- a/blame.c
+++ b/blame.c
@@ -1621,7 +1621,7 @@ static const char *get_next_line(const char *start, const char *end)
 static int prepare_lines(struct blame_scoreboard *sb)
 {
 	const char *buf = sb->final_buf;
-	unsigned long len = sb->final_buf_size;
+	size_t len = sb->final_buf_size;
 	const char *end = buf + len;
 	const char *p;
 	int *lineno;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 61ab796..3faf100 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -464,7 +464,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
 static void fmt_tag_signature(struct strbuf *tagbuf,
 			      struct strbuf *sig,
 			      const char *buf,
-			      unsigned long len)
+			      size_t len)
 {
 	const char *tag_body = strstr(buf, "\n\n");
 	if (tag_body) {
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 0663106..ff919a7 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -34,7 +34,7 @@ static int verify_object(const unsigned char *sha1, const char *expected_type)
 	return ret;
 }
 
-static int verify_tag(char *buffer, unsigned long size)
+static int verify_tag(char *buffer, size_t size)
 {
 	int typelen;
 	char type[20];
diff --git a/dir.c b/dir.c
index f161c26..0c7c767 100644
--- a/dir.c
+++ b/dir.c
@@ -180,7 +180,7 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
  */
 char *common_prefix(const struct pathspec *pathspec)
 {
-	unsigned long len = common_prefix_len(pathspec);
+	size_t len = common_prefix_len(pathspec);
 
 	return len ? xmemdupz(pathspec->items[0].match, len) : NULL;
 }
@@ -2673,7 +2673,7 @@ static void load_sha1_stat(struct sha1_stat *sha1_stat,
 	sha1_stat->valid = 1;
 }
 
-struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
+struct untracked_cache *read_untracked_extension(const void *data, size_t sz)
 {
 	struct untracked_cache *uc;
 	struct read_data rd;
diff --git a/dir.h b/dir.h
index e371705..709c72c 100644
--- a/dir.h
+++ b/dir.h
@@ -349,7 +349,7 @@ void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
 
 void free_untracked_cache(struct untracked_cache *);
-struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
+struct untracked_cache *read_untracked_extension(const void *data, size_t sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
-- 
2.1.4

