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
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D49208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 18:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdHRSdW (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 14:33:22 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34780 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdHRSdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 14:33:21 -0400
Received: by mail-lf0-f65.google.com with SMTP id o85so6744564lff.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NHksv65jeOXg8JoZnsDL7Xg4NX0ackod9NP5q5KQZpg=;
        b=T1llx4pJCOjdlJjDWwosnzKsj9l02gMWz80Y/gaIOu64U7IO9RsRZrDOFMxJiNcBv8
         JwBKnNDmGMW2FkaxYA0twOYkZvaNbnsNF3DRnCxlPWjLDT58GFoYTmBlrtJIBZy0AaTB
         IO5Q5liK7gnWnpI/Uk2iZRCz8l2wSzwd+4px7BEptKoBVcLezOLKhiUHcYusM1KdFG1S
         WLR+2XTZ6x/BBFUghucJjSM9AV1FxVInDNiRQFg8K7wgFGaw/Apeuhoy9rTOknCXvOip
         xj/OgcJUm7xmeQUgkV/jjHCrW5OqBNJxoeaKwXVOZa9xWy1DaYtPj4gYr9vV5nU7Y47Q
         esSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=NHksv65jeOXg8JoZnsDL7Xg4NX0ackod9NP5q5KQZpg=;
        b=oVNhGxyMaZZ5zNINKN7gQ24W2kZhB/NgB5uGpcrlDnItgIFlYKYfQTsLBqiYPPQydh
         955zwcjzDba8Znmr6W9Aya5TJ1lVYVylbVTmqhkCiZ1gu3ELp+OoHoOFlAuq9ffLtdNF
         qPXREdq+5FdS8qkMQEjWfc+iWUxaDe9Zjj+7HQUyrUJWVRxwUMOOOi96KmdtzS3vSh09
         PukS4DRCxVOGJ3wKSOgWez7gVjwpPA1j6kce44KX3JyEzNkpN/IgTJ4rZcx7jSnISs0j
         /Z39O3z+jhNFVc8KbmwfFmzIDR2Dhxlt5TOnA/0KQDB2HMdnnbxD6hf+AvOZMyMYGwbT
         0+8A==
X-Gm-Message-State: AHYfb5g1KPAvF/CvtQxtFmLd/bmN19RVdDOQmyyZxyHN4XU31NKhmLda
        SfM6mHZdx42QTOwHOhU=
X-Received: by 10.25.79.5 with SMTP id d5mr3156680lfb.160.1503081199655;
        Fri, 18 Aug 2017 11:33:19 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id r82sm813568lfd.45.2017.08.18.11.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2017 11:33:18 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v4 2/4] commit: replace the raw buffer with strbuf in read_graft_line
Date:   Fri, 18 Aug 2017 20:33:12 +0200
Message-Id: <f94a5bb774ef635924ea35895b2453aad329d069.1503079879.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503079879.git.patryk.obara@gmail.com>
References: <cover.1503020338.git.patryk.obara@gmail.com>
 <cover.1503079879.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503079879.git.patryk.obara@gmail.com>
References: <cover.1503079879.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This simplifies function declaration and allows for use of strbuf_rtrim
instead of modifying buffer directly.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 builtin/blame.c |  2 +-
 commit.c        | 23 +++++++++++------------
 commit.h        |  2 +-
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index bda1a78..d4472e9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -488,7 +488,7 @@ static int read_ancestry(const char *graft_file)
 		return -1;
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
-		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
+		struct commit_graft *graft = read_graft_line(&buf);
 		if (graft)
 			register_commit_graft(graft, 0);
 	}
diff --git a/commit.c b/commit.c
index 8b28415..1a0a9f2 100644
--- a/commit.c
+++ b/commit.c
@@ -134,34 +134,33 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 	return 0;
 }
 
-struct commit_graft *read_graft_line(char *buf, int len)
+struct commit_graft *read_graft_line(struct strbuf *line)
 {
 	/* The format is just "Commit Parent1 Parent2 ...\n" */
 	int i;
 	struct commit_graft *graft = NULL;
 	const int entry_size = GIT_SHA1_HEXSZ + 1;
 
-	while (len && isspace(buf[len-1]))
-		buf[--len] = '\0';
-	if (buf[0] == '#' || buf[0] == '\0')
+	strbuf_rtrim(line);
+	if (!line->len || line->buf[0] == '#')
 		return NULL;
-	if ((len + 1) % entry_size)
+	if ((line->len + 1) % entry_size)
 		goto bad_graft_data;
-	i = (len + 1) / entry_size - 1;
+	i = (line->len + 1) / entry_size - 1;
 	graft = xmalloc(st_add(sizeof(*graft), st_mult(GIT_SHA1_RAWSZ, i)));
 	graft->nr_parent = i;
-	if (get_oid_hex(buf, &graft->oid))
+	if (get_oid_hex(line->buf, &graft->oid))
 		goto bad_graft_data;
-	for (i = GIT_SHA1_HEXSZ; i < len; i += entry_size) {
-		if (buf[i] != ' ')
+	for (i = GIT_SHA1_HEXSZ; i < line->len; i += entry_size) {
+		if (line->buf[i] != ' ')
 			goto bad_graft_data;
-		if (get_sha1_hex(buf + i + 1, graft->parent[i/entry_size].hash))
+		if (get_sha1_hex(line->buf + i + 1, graft->parent[i/entry_size].hash))
 			goto bad_graft_data;
 	}
 	return graft;
 
 bad_graft_data:
-	error("bad graft data: %s", buf);
+	error("bad graft data: %s", line->buf);
 	free(graft);
 	return NULL;
 }
@@ -174,7 +173,7 @@ static int read_graft_file(const char *graft_file)
 		return -1;
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
-		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
+		struct commit_graft *graft = read_graft_line(&buf);
 		if (!graft)
 			continue;
 		if (register_commit_graft(graft, 1))
diff --git a/commit.h b/commit.h
index 6d857f0..baecc0a 100644
--- a/commit.h
+++ b/commit.h
@@ -247,7 +247,7 @@ struct commit_graft {
 };
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
-struct commit_graft *read_graft_line(char *buf, int len);
+struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(const struct object_id *oid);
 
-- 
2.9.5

