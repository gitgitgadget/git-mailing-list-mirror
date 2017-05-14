Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D2E20188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758549AbdENDQR (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:17 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35090 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757197AbdENDQO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:14 -0400
Received: by mail-oi0-f65.google.com with SMTP id m17so14323946oik.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aUdma3IGoAzUf4PEXq9kgY59YMhLESEflhtE0ihlJKI=;
        b=qGBNODdwwh7w5MqzTliO4gc+wAsacB4J0HjEpPqaCSsnseV+nw5E1MmlWhDrSHm1fG
         GePVdb/aWJtLHN+XWzVbf96L00keo9gAZrbzzr1Jk/GYsMh5xtejw9bkqZP2CUKfYcLX
         SRBnnpNCGzBXj6VC2n41kwpkozEMsaNBOi+Xj1U/jp/gfzq6M4FFUusgnZOszmgRPlwQ
         P+CPgQj5V87+I4lFjVMyD8C6qr0X5E94DwwVQ9hrzvWnxaI/B6HuxasjFmgv1jd1f0w8
         XxrqwWY6wPD35TGnLKDrxyW6zaJPjpoO98aQ7VZLQyQ1Mkp5SgAmKsVbOW9qtCy3+BSP
         0y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aUdma3IGoAzUf4PEXq9kgY59YMhLESEflhtE0ihlJKI=;
        b=GH7JEV9OpGlVlLUqn646fFw7d7M744eaT+QlDqNX+bbBlCySpgeqIWQm69sx47pZ8F
         u0J2QYtTqSTF/XIN9qZ7hCmwXAR6pX2Xf/RLNxyxOWApHqn++zjbIn9e7MCx0FmyQV6K
         vCM7U4wOHCYv8DvZnl3kFTKhAJYiY2E5eWyl5RxZpUJZef/DrZQvdBJAwoQo/Fsb1+JQ
         yjlYTbU9iJfMHmvN1DIDvr5GdepytKsbqoBFPbbnd4olGYWvtfHgpxVzmVJtWTxEaGmV
         Jg04ZLubn0mLkc1Sf+Y7EI90QP7a7++/yCePAs5mZOpr4ogHY2qLgeCCsXmDsuf1b3rv
         4EEA==
X-Gm-Message-State: AODbwcBjBhTWSf2mBjmqAXCUzt6CnzGv3adNu8K05k2o5ccW6aE6m0bB
        mhguNmLA7O4VlA==
X-Received: by 10.202.186.11 with SMTP id k11mr5012754oif.53.1494731773446;
        Sat, 13 May 2017 20:16:13 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:12 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 06/22] blame: move stat counters to scoreboard
Date:   Sat, 13 May 2017 22:14:57 -0500
Message-Id: <20170514031513.9042-7-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Statistic counters are used in parts of blame that are being moved to
libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         |  5 +++++
 builtin/blame.c | 29 ++++++++++++-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/blame.h b/blame.h
index 8d6a6fd..3438052 100644
--- a/blame.h
+++ b/blame.h
@@ -110,6 +110,11 @@ struct blame_scoreboard {
 	/* look-up a line in the final buffer */
 	int num_lines;
 	int *lineno;
+
+	/* stats */
+	int num_read_blob;
+	int num_get_patch;
+	int num_commits;
 };
 
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 4a1da53..12add06 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -62,11 +62,6 @@ static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 #define DEBUG 0
 #endif
 
-/* stats */
-static int num_read_blob;
-static int num_get_patch;
-static int num_commits;
-
 #define PICKAXE_BLAME_MOVE		01
 #define PICKAXE_BLAME_COPY		02
 #define PICKAXE_BLAME_COPY_HARDER	04
@@ -108,13 +103,13 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
  * diff machinery
  */
 static void fill_origin_blob(struct diff_options *opt,
-			     struct blame_origin *o, mmfile_t *file)
+			     struct blame_origin *o, mmfile_t *file, int *num_read_blob)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
 		unsigned long file_size;
 
-		num_read_blob++;
+		(*num_read_blob)++;
 		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
 		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
 			;
@@ -830,9 +825,9 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	d.offset = 0;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
-	fill_origin_blob(&sb->revs->diffopt, target, &file_o);
-	num_get_patch++;
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
+	sb->num_get_patch++;
 
 	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d))
 		die("unable to generate diff (%s -> %s)",
@@ -1036,7 +1031,7 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
 	if (!file_p.ptr)
 		return;
 
@@ -1165,7 +1160,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 			norigin = get_origin(parent, p->one->path);
 			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
-			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p);
+			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p, &sb->num_read_blob);
 			if (!file_p.ptr)
 				continue;
 
@@ -1330,7 +1325,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 		}
 	}
 
-	num_commits++;
+	sb->num_commits++;
 	for (i = 0, sg = first_scapegoat(revs, commit);
 	     i < num_sg && sg;
 	     sg = sg->next, i++) {
@@ -2714,7 +2709,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&o->blob_oid),
 			    path);
 	}
-	num_read_blob++;
+	sb.num_read_blob++;
 	lno = prepare_lines(&sb);
 
 	if (lno && !range_list.nr)
@@ -2795,9 +2790,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_stats) {
-		printf("num read blob: %d\n", num_read_blob);
-		printf("num get patch: %d\n", num_get_patch);
-		printf("num commits: %d\n", num_commits);
+		printf("num read blob: %d\n", sb.num_read_blob);
+		printf("num get patch: %d\n", sb.num_get_patch);
+		printf("num commits: %d\n", sb.num_commits);
 	}
 	return 0;
 }
-- 
2.9.3

