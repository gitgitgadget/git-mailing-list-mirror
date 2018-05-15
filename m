Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A561F406
	for <e@80x24.org>; Tue, 15 May 2018 23:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeEOXmw (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:42:52 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:40973 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbeEOXmu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:50 -0400
Received: by mail-pg0-f45.google.com with SMTP id w4-v6so723470pgq.8
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UDFELDQoFx2EtI2fRl7LN1m9S09tRccxy4jfApXsXnw=;
        b=G5EJPMQFsRUK5se0nx/NfJZU89NRk2RgXfEqLNcMyjWxOf/2/rBYIcTCKqFD30SUcL
         6pQofXtjNdgTneGNrqpIL23P2Gc19dUDM3BtYc2XPSV4ANmiqojhFEOxA/oYUVJczwZO
         GpZX/6Xs0QD2VjWuOPVDMpJnrRAv57xcciXL2BIzNK2rdyzd3iP6z/n6R+odJxrIRJpI
         nos7qI9eOJfBZqGWlMyLklDUyvZIZSfl2Ms4W0U59T+hpZRB7LqyGtiEJmPCn1GVtTUt
         sNpjGN4WXgZgfwXarY3u0CLHhdCPkIiDNBJTIVXtXYHwyGTUYbBRnWqvip7Itg4EfS0B
         Ya5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UDFELDQoFx2EtI2fRl7LN1m9S09tRccxy4jfApXsXnw=;
        b=XAGcD7zioiwFDTViHlZSpRuNtWLCoYpwFrw0m1gVZaBGbfD0D0Wrf3mjShyZ21Uzu5
         oRcbqJkQdRnqXIp2iIGal01T1tj6SOMq37s8cjl8MARuMr5sx80C0bc2CzZ/IhrlWAfX
         Ht1dQfSOqk3WnE1aXW60v/7t8ValVRtFOW/lY4NbtQ4d2CUap7lgMlROd5nSLpvvf5j2
         Qj2qCYFyaMZhvbPlAMSlrulfWojoVFzEtHCsh3eoITTxcWhVuAzdMuKKFpxbcI6FB/T6
         fLindCYAKGN4x1U0Kg1TYfgXLKJ+h3JRwbekiBXYBpXyGtIGJ1LorJT1j+BH7wQWe7iF
         iFww==
X-Gm-Message-State: ALKqPwfiQN2Ntm8ldmtFRtkKsrF8YHQZcSF6zEwZFFDbClvuPnzJFeYA
        t3HaNlwLHhvmdOJvLDD8F2LMwl2hGDo=
X-Google-Smtp-Source: AB8JxZoMbu1nuK7x+gKqtWR92hq01SxFIr2gYfQR+P7C5v5Ylki0pioJ6BLU/OEbx/+rioL30FbNLQ==
X-Received: by 2002:a63:9846:: with SMTP id l6-v6mr13724153pgo.217.1526427769148;
        Tue, 15 May 2018 16:42:49 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 184-v6sm1390099pfg.89.2018.05.15.16.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/19] shallow: add repository argument to register_shallow
Date:   Tue, 15 May 2018 16:42:23 -0700
Message-Id: <20180515234233.143708-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

