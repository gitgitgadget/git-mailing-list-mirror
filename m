Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC791F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeEQWw2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:28 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:40819 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeEQWwX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:23 -0400
Received: by mail-pf0-f169.google.com with SMTP id f189-v6so2780819pfa.7
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DOXsCj9i7gNrjC7GaoCBIpDVwKInOx06lRlv4awgBkE=;
        b=QT4OzQ4NA5a+7uoRba+Lfr4sF5PJ+Xx07AUn/8Ru5DhixPsvmB1Ey1XovVZ8JdGd0d
         NkQ6Ao+sDvUWfRZtbp+4k/210EmRYf9Xht7USWfsmiayqHsdIiJQedoUYIrobPsLDVna
         yLNBYmGQ2SkG7u36fHZWNJDAaa3kMFlm7C62WaKy9K/CJ75n9w9/MUsXrPH9y41G2qUi
         jI0zaV8mBpMw9rkHR6VGtzgX+RFzs2FFUwyxbu9/Ztj9BJHNQdWxz+DkN6TXkQHBBqlJ
         eP7sL1TYZy9keRhuovCzOmzCm4z/YzZSDd+5+zT/bBuSJf7l9w/DwjHIU2V/z7PDj18V
         wPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DOXsCj9i7gNrjC7GaoCBIpDVwKInOx06lRlv4awgBkE=;
        b=pM5iv9W4GgW/uo5BajUCZSF8c1JMeX27CDYQmh9C88mV352MB5G0ueBHdKTWCHGwOc
         NnECBDORXCrsynzEQxX/dcRLGwbmLJVa1Lsv2hcesPLTwSxTfejOJ2uyO9tMeSWG/O0x
         /DoZI5QYor5rn/cyncPix1w96sYW0e3D4OHntXsY6kyoz4R3ucPfWs8Oju2dTsOPnDix
         EpFrWRGMaB67EGdvr3/AP2nwPaQWYuGrGds2G9PpUxgNvoPLV1vcHLoTCjt367oMiNLB
         4WaWbhdvBabJmNoFeWWUvXighfSAV7cNT+jmrkNPZSmI72g6n+6G/u38/TUnE3k4NS54
         q1AA==
X-Gm-Message-State: ALKqPwd68fOnwJfbV1KYHiL/G9OY9BTvfR0zlaazSR9vggw+XYRCKWaJ
        S73F6tDUmAHj6xyfIGwLsB9KvT6oRgk=
X-Google-Smtp-Source: AB8JxZqpvlsi5cZBmcrI81XbstjiSVOm0pJ7xiY0J9HcPUA8tHg+gKYQsKcUQjsm1cYBoAbO5elAPA==
X-Received: by 2002:a63:7b1d:: with SMTP id w29-v6mr5447693pgc.417.1526597542002;
        Thu, 17 May 2018 15:52:22 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id n25-v6sm9215105pgd.5.2018.05.17.15.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 09/19] shallow: add repository argument to register_shallow
Date:   Thu, 17 May 2018 15:51:44 -0700
Message-Id: <20180517225154.9200-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of register_shallow
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/pack-objects.c | 2 +-
 builtin/receive-pack.c | 2 +-
 commit.h               | 3 ++-
 fetch-pack.c           | 2 +-
 shallow.c              | 4 ++--
 upload-pack.c          | 7 ++++---
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d65eb4a9478..97a5963efb6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2875,7 +2875,7 @@ static void get_object_list(int ac, const char **av)
 				struct object_id oid;
 				if (get_oid_hex(line + 10, &oid))
 					die("not an SHA-1 '%s'", line + 10);
-				register_shallow(&oid);
+				register_shallow(the_repository, &oid);
 				use_bitmap_index = 0;
 				continue;
 			}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 36906fd5e98..c666820b69a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -906,7 +906,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	 * not lose these new roots..
 	 */
 	for (i = 0; i < extra.nr; i++)
-		register_shallow(&extra.oid[i]);
+		register_shallow(the_repository, &extra.oid[i]);
 
 	si->shallow_ref[cmd->index] = 0;
 	oid_array_clear(&extra);
diff --git a/commit.h b/commit.h
index f88c854e2f6..59346de5512 100644
--- a/commit.h
+++ b/commit.h
@@ -191,7 +191,8 @@ extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n,
 
 struct oid_array;
 struct ref;
-extern int register_shallow(const struct object_id *oid);
+#define register_shallow(r, o) register_shallow_##r(o);
+extern int register_shallow_the_repository(const struct object_id *oid);
 extern int unregister_shallow(const struct object_id *oid);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
 extern int is_repository_shallow(void);
diff --git a/fetch-pack.c b/fetch-pack.c
index a1535b37b9b..e3e99e44962 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -428,7 +428,7 @@ static int find_common(struct fetch_pack_args *args,
 			if (skip_prefix(line, "shallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
 					die(_("invalid shallow line: %s"), line);
-				register_shallow(&oid);
+				register_shallow(the_repository, &oid);
 				continue;
 			}
 			if (skip_prefix(line, "unshallow ", &arg)) {
diff --git a/shallow.c b/shallow.c
index 73cb11a9162..0fadd5330d2 100644
--- a/shallow.c
+++ b/shallow.c
@@ -29,7 +29,7 @@ void set_alternate_shallow_file_the_repository(const char *path, int override)
 	alternate_shallow_file = xstrdup_or_null(path);
 }
 
-int register_shallow(const struct object_id *oid)
+int register_shallow_the_repository(const struct object_id *oid)
 {
 	struct commit_graft *graft =
 		xmalloc(sizeof(struct commit_graft));
@@ -70,7 +70,7 @@ int is_repository_shallow(void)
 		struct object_id oid;
 		if (get_oid_hex(buf, &oid))
 			die("bad shallow line: %s", buf);
-		register_shallow(&oid);
+		register_shallow(the_repository, &oid);
 	}
 	fclose(fp);
 	return is_shallow;
diff --git a/upload-pack.c b/upload-pack.c
index a11c6d192ce..4e4ac0f0d95 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -663,7 +663,7 @@ static void send_shallow(struct commit_list *result)
 		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
 			packet_write_fmt(1, "shallow %s",
 					 oid_to_hex(&object->oid));
-			register_shallow(&object->oid);
+			register_shallow(the_repository, &object->oid);
 			shallow_nr++;
 		}
 		result = result->next;
@@ -700,7 +700,7 @@ static void send_unshallow(const struct object_array *shallows)
 			add_object_array(object, NULL, &extra_edge_obj);
 		}
 		/* make sure commit traversal conforms to client */
-		register_shallow(&object->oid);
+		register_shallow(the_repository, &object->oid);
 	}
 }
 
@@ -912,7 +912,8 @@ static void receive_needs(void)
 		if (shallows.nr > 0) {
 			int i;
 			for (i = 0; i < shallows.nr; i++)
-				register_shallow(&shallows.objects[i].item->oid);
+				register_shallow(the_repository,
+						 &shallows.objects[i].item->oid);
 		}
 
 	shallow_nr += shallows.nr;
-- 
2.17.0.582.gccdcbd54c44.dirty

