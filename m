Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF0620899
	for <e@80x24.org>; Fri, 18 Aug 2017 01:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbdHRB7u (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 21:59:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37560 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbdHRB7r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 21:59:47 -0400
Received: by mail-lf0-f67.google.com with SMTP id x16so5391020lfb.4
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 18:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=oYcx1Z3KZCGUx9vkYNOci2grBRhBuJcwIsxqqJUdfbA=;
        b=GTQPATjxJwHvr8FasggN8M58BPsApBKy6NVt5UNAQxPQjJn827ntVQhVIzEj50aZxJ
         ap7FQbo4I7WQpT/vJoUi39F0WuqRjBJ53CMGwb6jCSmRq/TycOYFLfeij1bzNb3qPCCc
         rvR+h57JHX8dCZylt1M1qLvqV+DYqZ331Oa8zZI2IajBp+XYsiaUZ/7kXNO3fIHRjtHt
         9aoV2P+k8+NBsYFzx9zNrSl0s9HPbWr0y0ka18nVrGNHCgg1TDQeRSUDg9prywugOi6Q
         XxJOMacwB12ajca93ZWv7uJ2jlHKYccwXPurlPNDbxS7VoWRhKz5NKQz5Y3WjXdOL48C
         jxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=oYcx1Z3KZCGUx9vkYNOci2grBRhBuJcwIsxqqJUdfbA=;
        b=FiD5rmYRAOXBnKMTAKiW6fLLJwEiJecY7+30popQbCSgA5LfDBcJdogMD9z9igQq3a
         xFw1beg1FH7R2H5+nMFAQ0lbh7UC+7WQOWQpCkprSgVPWS18UrBprpdZljk1ZRQqSl2z
         rGQ+l1bgrBLUBfGjIP6JThDhNXLlPepjmvu3yfnCOVWiZD/8DDlvO11tM1/lGR/FNEul
         05KVz6mWxJq2XVA/bHvq3itCaYV5GadP8JuYiEDHhCUvGYf5b2hoz8jb6YZDDWRSEIkO
         Abc6oh79DpNaMdB+iCsEewIRpKsVyfAIklAxyrv2UNm9zsNJCoeGsUBJm+PmyCWzJeqe
         SlEA==
X-Gm-Message-State: AHYfb5j3qqW6Y/vluEfA8jK+9D0Vh3krupfXHBG5nE0J0EncF6qartQk
        wUaDQL8HzffEdWa3Uw0=
X-Received: by 10.25.221.197 with SMTP id w66mr188629lfi.223.1503021585632;
        Thu, 17 Aug 2017 18:59:45 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c23sm363156lfh.79.2017.08.17.18.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2017 18:59:44 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 4/4] commit: rewrite read_graft_line
Date:   Fri, 18 Aug 2017 03:59:38 +0200
Message-Id: <cb98970b3f6c175321f52efb65deb48f9cfeabae.1503020338.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503020338.git.patryk.obara@gmail.com>
References: <cover.1502905085.git.patryk.obara@gmail.com>
 <cover.1503020338.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503020338.git.patryk.obara@gmail.com>
References: <cover.1503020338.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Determine the number of object_id's to parse in a single graft line by
counting separators (whitespace characters) instead of dividing by
length of hash representation.

This way graft parsing code can support different sizes of hashes
without any further code adaptations.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 commit.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index 61528a5..46ee2db 100644
--- a/commit.c
+++ b/commit.c
@@ -137,29 +137,27 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 struct commit_graft *read_graft_line(struct strbuf *line)
 {
 	/* The format is just "Commit Parent1 Parent2 ...\n" */
-	int i, len;
-	char *buf = line->buf;
+	int i, n;
+	const char *tail = NULL;
 	struct commit_graft *graft = NULL;
-	const int entry_size = GIT_SHA1_HEXSZ + 1;
 
 	strbuf_rtrim(line);
 	if (line->buf[0] == '#' || line->len == 0)
 		return NULL;
-	len = line->len;
-	if ((len + 1) % entry_size)
-		goto bad_graft_data;
-	i = (len + 1) / entry_size - 1;
+	/* count number of blanks to determine size of array to allocate */
+	for (i = 0, n = 0; i < line->len; i++)
+		if (isspace(line->buf[i]))
+			n++;
 	graft = xmalloc(st_add(sizeof(*graft),
-	                       st_mult(sizeof(struct object_id), i)));
-	graft->nr_parent = i;
-	if (get_oid_hex(buf, &graft->oid))
+	                       st_mult(sizeof(struct object_id), n)));
+	graft->nr_parent = n;
+	if (parse_oid_hex(line->buf, &graft->oid, &tail))
 		goto bad_graft_data;
-	for (i = GIT_SHA1_HEXSZ; i < len; i += entry_size) {
-		if (buf[i] != ' ')
-			goto bad_graft_data;
-		if (get_sha1_hex(buf + i + 1, graft->parent[i/entry_size].hash))
+	for (i = 0; i < graft->nr_parent; i++)
+		if (!isspace(*tail++) || parse_oid_hex(tail, &graft->parent[i], &tail))
 			goto bad_graft_data;
-	}
+	if (tail[0] != '\0')
+		goto bad_graft_data;
 	return graft;
 
 bad_graft_data:
-- 
2.9.5

