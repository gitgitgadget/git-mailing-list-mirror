Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0CB1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeAGSPf (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:35 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35894 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbeAGSPd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:33 -0500
Received: by mail-qt0-f196.google.com with SMTP id a16so11272056qtj.3
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VgnRfuQ3Rgh9qn08VRlRX9AGt8fch/9uUiu7FeRT7P4=;
        b=JSzUrRj+78WDkQ67BUHNMXoLYVzkWYByQ5z/N9T1yMV0OX1ZSn1AhIK98IVLYx5W2D
         xha1+jjhyQs74+PhAQ+O4hF+f3JZ2Z5DfBvGWFOKwxHM+7tDGbDEXtwzN3f7Tezr+h8Y
         QJEauJMltHmMDjbcmIhPmV1hdNdwGUay0so6UH/Yos3oqDnLW1mGbbL9NSfi/VcFrWxK
         ovQ8ZjAq3XzcSkxumEN7cg6jQjoRiKQzVfrDrTSTgnXm6Htb1lu93242JyvQaH6ZE6vd
         YcOgrAra8Kyqoao1EcOtoNDY+FUA+HbO9SrvpWXyIUdOMEWTOGlltzK+7ZnGOauvKRtx
         /mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VgnRfuQ3Rgh9qn08VRlRX9AGt8fch/9uUiu7FeRT7P4=;
        b=NNm4Fr4eRiPy4kkbgHWehbeUwmx17IN1MQWQcYCcqDyEssS1O0OD8HPs4J60Ulg0M7
         Qupvo3NemudyjEfc0b/VJUhExZQQWpp8dHwR233DFyNSNZDbvvdlPMWUlPjA7JZne4bv
         SnYb8qbx/G8VFZotJD/OwN8NSnc/DFlTti3vpPwBF62fbo4rh5VdqGj8/SgTbP3EWfQz
         QVbXDzMB4hvLMuPvbLg7ea9+A99ML4JEQecr3IAQ7ZQT7j4mKWxCpE+XLo/Uae3CbX9b
         8XkXWWtcYRzX4SsW96I4Vdr/6wOXRHfue2oIrYNPPEPMLTi5guigBbrVpC5nMyAdLtOs
         KdOw==
X-Gm-Message-State: AKwxyteeyfBYDmrKTK6SswA/69hJYXl5C3+5CzFZpMM8LtH/qD/gEJLB
        NETeKZemM5D/g20JConRIFOx0jafWSU=
X-Google-Smtp-Source: ACJfBoszBGM/AZ6YRB9uUEoErnNXJVQ0dblGAcrTF394hiUq8T79PUq7UeRM2AMI6oro5/ljCcZdvA==
X-Received: by 10.237.49.161 with SMTP id 30mr12526765qth.218.1515348931919;
        Sun, 07 Jan 2018 10:15:31 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:31 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 18/18] packfile: use midx for object loads
Date:   Sun,  7 Jan 2018 13:14:59 -0500
Message-Id: <20180107181459.222909-19-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When looking for a packed object, first check the MIDX for that object.
This reduces thrashing in the MRU list of packfiles.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c     | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 midx.h     |  3 +++
 packfile.c |  5 +++-
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 8c643caa92..4b2398b3ee 100644
--- a/midx.c
+++ b/midx.c
@@ -329,6 +329,90 @@ int bsearch_midx(struct midxed_git *m, const unsigned char *sha1, uint32_t *pos)
 	return 0;
 }
 
+static int prepare_midx_pack(struct midxed_git *m, uint32_t pack_int_id)
+{
+	struct strbuf pack_name = STRBUF_INIT;
+
+	if (pack_int_id >= m->hdr->num_packs)
+		return 1;
+
+	if (m->packs[pack_int_id])
+		return 0;
+
+	strbuf_addstr(&pack_name, m->pack_dir);
+	strbuf_addstr(&pack_name, "/");
+	strbuf_addstr(&pack_name, m->pack_names[pack_int_id]);
+	strbuf_strip_suffix(&pack_name, ".pack");
+	strbuf_addstr(&pack_name, ".idx");
+
+	m->packs[pack_int_id] = add_packed_git(pack_name.buf, pack_name.len, 1);
+	strbuf_release(&pack_name);
+	return !m->packs[pack_int_id];
+}
+
+static int find_pack_entry_midx(const unsigned char *sha1,
+				struct midxed_git *m,
+				struct packed_git **p,
+				off_t *offset)
+{
+	uint32_t pos;
+	struct pack_midx_details d;
+
+	if (!bsearch_midx(m, sha1, &pos) ||
+	    !nth_midxed_object_details(m, pos, &d))
+		return 0;
+
+	if (d.pack_int_id >= m->num_packs)
+		die(_("bad pack-int-id %d"), d.pack_int_id);
+
+	/* load packfile, if necessary */
+	if (prepare_midx_pack(m, d.pack_int_id))
+		return 0;
+
+	*p = m->packs[d.pack_int_id];
+	*offset = d.offset;
+
+	return 1;
+}
+
+int fill_pack_entry_midx(const unsigned char *sha1,
+			 struct pack_entry *e)
+{
+	struct packed_git *p;
+	struct midxed_git *m;
+
+	if (!core_midx)
+		return 0;
+
+	m = midxed_git;
+	while (m)
+	{
+		off_t offset;
+		if (!find_pack_entry_midx(sha1, m, &p, &offset)) {
+			m = m->next;
+			continue;
+		}
+
+		/*
+		* We are about to tell the caller where they can locate the
+		* requested object.  We better make sure the packfile is
+		* still here and can be accessed before supplying that
+		* answer, as it may have been deleted since the MIDX was
+		* loaded!
+		*/
+		if (!is_pack_valid(p))
+			return 0;
+
+		e->offset = offset;
+		e->p = p;
+		hashcpy(e->sha1, sha1);
+
+		return 1;
+	}
+
+	return 0;
+}
+
 int contains_pack(struct midxed_git *m, const char *pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
diff --git a/midx.h b/midx.h
index 5598799189..b7e8b15fe4 100644
--- a/midx.h
+++ b/midx.h
@@ -11,6 +11,9 @@ extern char *get_midx_head_filename(const char *pack_dir);
 
 extern struct object_id *get_midx_head_oid(const char *pack_dir, struct object_id *oid);
 
+extern int fill_pack_entry_midx(const unsigned char *sha1,
+				struct pack_entry *e);
+
 struct pack_midx_entry {
 	struct object_id oid;
 	uint32_t pack_int_id;
diff --git a/packfile.c b/packfile.c
index 866a1f30dd..9ec39a83e9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1883,7 +1883,10 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct mru_entry *p;
 
-	prepare_packed_git();
+	prepare_packed_git_internal(1);
+	if (fill_pack_entry_midx(sha1, e))
+		return 1;
+
 	if (!packed_git)
 		return 0;
 
-- 
2.15.0

