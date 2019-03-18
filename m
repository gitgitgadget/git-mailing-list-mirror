Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540AD20248
	for <e@80x24.org>; Mon, 18 Mar 2019 14:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfCROaC (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 10:30:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37070 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfCROaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 10:30:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id m12so13707372edv.4
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JtrBtrB7kYrMOC2BJd4LmQcyzpe+JykjorRDlHIG3hk=;
        b=Mh1h7Z1VHzzB7J16f5tl7Q9tcajY3jDq7MK5YIyoKZj4pGl7iyy3NEvFKswJlsHa4+
         nYxarevY+FA8BPDq6mWCMstkI4MaXbJO6nlbZubDWAqcL4CtSK1+61cE8jpMGg64ATyo
         JJpaKr+72SSNhLPRY8SiqkznjsQBCduqPhyGCdwUUXzPStBNU5gY3rDgYEBe7MqD0Gw4
         oxzOz2Y6ooG0FhbdGQClGNdII/XtLgaVaTpwmEkmZW6k3+oU4QYQZA5LP2mM/Qzdjf8T
         GBM26Z80M0qLIZeEZgcs1x0WvOO50J91mWL5YytYG8gph0Ax5dY5i+p6H0NxS+JuS7n6
         uroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JtrBtrB7kYrMOC2BJd4LmQcyzpe+JykjorRDlHIG3hk=;
        b=ZQjw4CD39lBY0aUyKAnr86QW/KiwCCwPeTWwde4AWdHem0yzEhUEznd7mTOHTOL63d
         Y+8EKZcoOAleDh/uXMr+AoohSVf/B/vQkbuVvYHrsc/vAcgaPnR6dQYfemcXX4LJho0f
         C0DSUCDbIGIIPlLUeTMFMvkI34BzNL8KV3CJVcaiJAsfeLX/arCN+NVzDId9srEaKygT
         vTLHAZzNMlmWLT8qPi9tBMKZA34LPz9V/MToCbMzuSxNhJ+ffZzuI/rS/DuFAZSrrq8I
         hmFIS5MSMMUxuyVAQTjChkdUoymfNWhnSwJWBfkCvKMJh14VjjCMew79Ub9v5d0Rra2k
         lYIQ==
X-Gm-Message-State: APjAAAUKrVN+19RScsfKhb6JupPLl8jc70Ntr+dUBzi20noe5aY0eXCp
        IeYLVO5Olxn9vTL6upTkZ5Ghzqdk
X-Google-Smtp-Source: APXvYqz4wpxNw+peHqmepdLQ5luqMafwsLPB/SBwAyaNcfcyJ88Ex0haYo+CEBDhhTAsTH2OtapbSA==
X-Received: by 2002:a50:8b21:: with SMTP id l30mr13773248edl.190.1552919398225;
        Mon, 18 Mar 2019 07:29:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12sm2450321ejc.5.2019.03.18.07.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 07:29:57 -0700 (PDT)
Date:   Mon, 18 Mar 2019 07:29:57 -0700 (PDT)
X-Google-Original-Date: Mon, 18 Mar 2019 14:29:53 GMT
Message-Id: <86f6b0325821a9e1742a28895f9c9b712a1fdec4.1552919394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.git.gitgitgadget@gmail.com>
References: <pull.166.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] midx: verify: group objects by packfile to speed up
 object verification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach `multi-pack-index verify` to sort the set of objects by
packfile so that only one packfile needs to be open at a time.

This is a performance improvement.  Previously, objects were
verified in OID order.  This essentially requires all packfiles
to be open at the same time.  If the number of packfiles exceeds
the open file limit, packfiles would be LRU-closed and re-opened
many times.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 midx.c     | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 packfile.c |  2 +-
 packfile.h |  2 ++
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/midx.c b/midx.c
index d2c39b6d37..0376757390 100644
--- a/midx.c
+++ b/midx.c
@@ -958,9 +958,29 @@ static void midx_report(const char *fmt, ...)
 	va_end(ap);
 }
 
+struct pair_pos_vs_id
+{
+	uint32_t pos;
+	uint32_t pack_int_id;
+};
+
+static int compare_pair_pos_vs_id(const void *_a, const void *_b)
+{
+	struct pair_pos_vs_id *a = (struct pair_pos_vs_id *)_a;
+	struct pair_pos_vs_id *b = (struct pair_pos_vs_id *)_b;
+
+	if (a->pack_int_id < b->pack_int_id)
+		return -1;
+	if (a->pack_int_id > b->pack_int_id)
+		return 1;
+
+	return 0;
+}
+
 int verify_midx_file(const char *object_dir)
 {
-	uint32_t i;
+	struct pair_pos_vs_id *pairs = NULL;
+	uint32_t i, k;
 	struct progress *progress;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 	verify_midx_error = 0;
@@ -997,15 +1017,36 @@ int verify_midx_file(const char *object_dir)
 	}
 
 	progress = start_progress(_("Verifying object offsets"), m->num_objects);
+
+	/*
+	 * Create an array mapping each object to its packfile id.  Sort it
+	 * to group the objects by packfile.  Use this permutation to visit
+	 * each of the objects and only require 1 packfile to be open at a
+	 * time.
+	 */
+	ALLOC_ARRAY(pairs, m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
+		pairs[i].pos = i;
+		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
+	}
+	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
+
+	for (k = 0; k < m->num_objects; k++) {
 		struct object_id oid;
 		struct pack_entry e;
 		off_t m_offset, p_offset;
 
-		nth_midxed_object_oid(&oid, m, i);
+		if (k > 0 && pairs[k-1].pack_int_id != pairs[k].pack_int_id &&
+		    m->packs[pairs[k-1].pack_int_id])
+		{
+			close_pack_fd(m->packs[pairs[k-1].pack_int_id]);
+			close_pack_index(m->packs[pairs[k-1].pack_int_id]);
+		}
+
+		nth_midxed_object_oid(&oid, m, pairs[k].pos);
 		if (!fill_midx_entry(&oid, &e, m)) {
 			midx_report(_("failed to load pack entry for oid[%d] = %s"),
-				    i, oid_to_hex(&oid));
+				    pairs[k].pos, oid_to_hex(&oid));
 			continue;
 		}
 
@@ -1020,11 +1061,13 @@ int verify_midx_file(const char *object_dir)
 
 		if (m_offset != p_offset)
 			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
-				    i, oid_to_hex(&oid), m_offset, p_offset);
+				    pairs[k].pos, oid_to_hex(&oid), m_offset, p_offset);
 
-		display_progress(progress, i + 1);
+		display_progress(progress, k + 1);
 	}
 	stop_progress(&progress);
 
+	free(pairs);
+
 	return verify_midx_error;
 }
diff --git a/packfile.c b/packfile.c
index 16bcb75262..d2bcb2f860 100644
--- a/packfile.c
+++ b/packfile.c
@@ -309,7 +309,7 @@ void close_pack_windows(struct packed_git *p)
 	}
 }
 
-static int close_pack_fd(struct packed_git *p)
+int close_pack_fd(struct packed_git *p)
 {
 	if (p->pack_fd < 0)
 		return 0;
diff --git a/packfile.h b/packfile.h
index d70c6d9afb..b1c18504eb 100644
--- a/packfile.h
+++ b/packfile.h
@@ -76,6 +76,8 @@ extern int open_pack_index(struct packed_git *);
  */
 extern void close_pack_index(struct packed_git *);
 
+int close_pack_fd(struct packed_git *p);
+
 extern uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
-- 
gitgitgadget

