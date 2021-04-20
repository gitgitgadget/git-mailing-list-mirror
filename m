Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BFDC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D5E61154
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhDTNhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTNhg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:37:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B2C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n4-20020a05600c4f84b029013151278decso8790449wmq.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2JvnX1hvP/mgl4FRRMDgNUGoXthwuOQD0lElMFbpUA=;
        b=K6s7oAKYqGnnyP8oWVinIhliI91lU3VztpXG0uP+v73a53nrQv8nd2ClzruJ1iYVYe
         u2GR1J6RovLz7/YUBaoKwZgscFcGZDXYC63LTKTSEvGvPvG040bBB9hZ5gPh4EgiUQBM
         mi5LvN1MTcPxOiYpS/8L0yCnGUXfzp1PBdE+l2Tpze4sFLCLcwopt1mZEavVBxfbN8Sh
         YnNUKf2a3ZlTDcx7wX9CdwW7j1AlR5iyLkHcRVaQgv88pZXUQjemYfX6pA8UCm5ijOKB
         WN7D0cc4H6YBluM04R26iVBwVsnt24+0+uoND0mK9Z8LX00gPplgaWYBqNPWTntrCpNj
         Yxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2JvnX1hvP/mgl4FRRMDgNUGoXthwuOQD0lElMFbpUA=;
        b=bRiij/Jc+/Chwf5KZQxELMdicbP6zfujF3LgeO7E5p2HaIhHoXyvAPrsBmRMQIcKV4
         jKtrb0vLYYAcXxdDfzSNk1TbHF6xjhKSZYIHWoNdLMfEeAbO/VnUQDD+mGB4kxGRa3mZ
         c1yQcTl2gus0YBBGf557dFJi+v++38V0271pVrcAUtCpByKtGcXcpzk+IwWqjlononEH
         l1ANLrGEJyMJuEgXN7FfoipMLYAmyf1VGfiX1u6KxeahxGcGaPmLGoH2bGGze4JPjTHM
         A6+GUmdOJUgxy70jyCeKpzIly/r5z2cFvmO4RX7YDUwxTzhE0Le0A6OLC5xIFtae6QLY
         WNXA==
X-Gm-Message-State: AOAM531plX6UFg5Gyu4oDREpBlGF29wOkMbIOocMiFba7r2wbu/MDh8g
        IXUwEcCIXPf33btXzOMMF00KB/NKe61DXQ==
X-Google-Smtp-Source: ABdhPJxPVJBTFwpI7hqMwCbZ0wlX/YfyrpmgcJ8EAYb77kiNrPlQ6qUvD8+yJqQ/G81nISvo/JkdRg==
X-Received: by 2002:a1c:a7c8:: with SMTP id q191mr4626192wme.6.1618925823342;
        Tue, 20 Apr 2021 06:37:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17705518wrr.3.2021.04.20.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:37:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] object.c: add and use "is expected" utility function + object_as_type() use
Date:   Tue, 20 Apr 2021 15:36:52 +0200
Message-Id: <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This relatively simple series builds on [1] and [2] to intorduce a
utility function for the "expected type X, got Y" error messages. See
[3] for the v1 of this series.

There was an embarrassing error in v1 where I left in some WIP
assertion code, and we'd print a nonsensical error message in the
lookup_commit_reference_gently() codepath.

That's now fixed gone, and there's a new test to assert the exact
output we get from a failure in
lookup_commit_reference_gently(). Aside from not reading my own
patches carefully enough before submission, I didn't catch that case
because nothing tested for the output.

1. https://lore.kernel.org/git/cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com/
3. https://lore.kernel.org/git/cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (8):
  tree.c: fix misindentation in parse_tree_gently()
  object.c: add a utility function for "expected type X, got Y"
  object.c: add and use oid_is_type_or_die_msg() function
  commit-graph: use obj->type, not object_as_type()
  branch tests: assert lookup_commit_reference_gently() error
  commit.c: don't use deref_tag() -> object_as_type()
  object.c: normalize brace style in object_as_type()
  object.c: remove "quiet" parameter from object_as_type()

 blob.c                     |  2 +-
 builtin/commit-graph.c     |  2 +-
 builtin/fsck.c             |  2 +-
 builtin/index-pack.c       |  9 +++----
 combine-diff.c             |  3 +--
 commit.c                   | 29 ++++++++++++++--------
 merge-recursive.c          |  5 +++-
 object.c                   | 51 +++++++++++++++++++++++++++++++-------
 object.h                   | 10 +++++++-
 refs.c                     |  2 +-
 t/helper/test-reach.c      |  2 +-
 t/t3201-branch-contains.sh |  8 +++++-
 tag.c                      |  2 +-
 tree.c                     | 15 +++++------
 14 files changed, 98 insertions(+), 44 deletions(-)

Range-diff against v1:
1:  4bf9a4f7a1 = 1:  c39b235035 tree.c: fix misindentation in parse_tree_gently()
2:  0be843e838 = 2:  1b472fcd85 object.c: add a utility function for "expected type X, got Y"
3:  fb2e4feb3d = 3:  22e7d9a3db object.c: add and use oid_is_type_or_die_msg() function
4:  995135c814 = 4:  8e43d44911 commit-graph: use obj->type, not object_as_type()
-:  ---------- > 5:  8982c42127 branch tests: assert lookup_commit_reference_gently() error
5:  754d5ae267 ! 6:  f337a5442d commit.c: don't use deref_tag() -> object_as_type()
    @@ Commit message
         of OBJ_{COMMIT,TREE,BLOB,TAG} here, not the bare-bones initialization
         object_as_type() might be called on to do.
     
    +    Even though we can read deref_tag() and see that it won't return
    +    OBJ_NONE and friends, let's add a BUG() assertion here to help future
    +    maintenance.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## commit.c ##
    @@ commit.c: const char *commit_type = "commit";
      		return NULL;
     -	return object_as_type(obj, OBJ_COMMIT, quiet);
     +
    ++	if (obj->type <= 0)
    ++		BUG("should have initialized obj->type = OBJ_{COMMIT,TREE,BLOB,TAG} from deref_tag()");
     +	if (obj->type != OBJ_COMMIT) {
    -+		enum object_type want = OBJ_COMMIT;
    -+		if (!quiet)
    -+			oid_is_type_or_error(oid, OBJ_COMMIT, &want);
    ++		if (!quiet) {
    ++			enum object_type have = obj->type;
    ++			oid_is_type_or_error(oid, OBJ_COMMIT, &have);
    ++		}
     +		return NULL;
     +	}
     +	return (struct commit *)obj;
6:  e414cfe40c = 7:  893b178573 object.c: normalize brace style in object_as_type()
7:  64360ac260 ! 8:  a47d23f1b1 object.c: remove "quiet" parameter from object_as_type()
    @@ blob.c
     @@ blob.c: struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
      	struct object *obj = lookup_object(r, oid);
      	if (!obj)
    - 		return create_object(r, oid, alloc_blob_node(r));
    + 		return create_blob(r, oid);
     -	return object_as_type(obj, OBJ_BLOB, 0);
     +	return object_as_type(obj, OBJ_BLOB);
      }
    - 
    - int parse_blob_buffer(struct blob *item)
     
      ## builtin/fsck.c ##
     @@ builtin/fsck.c: static void mark_unreachable_referents(const struct object_id *oid)
    @@ builtin/fsck.c: static void mark_unreachable_referents(const struct object_id *o
      	options.walk = mark_used;
     
      ## commit.c ##
    -@@ commit.c: struct commit *lookup_commit_reference_gently(struct repository *r,
    - 		return NULL;
    - 
    - 	if (obj->type != OBJ_COMMIT) {
    --		enum object_type want = OBJ_COMMIT;
    -+		if (obj->type <= 0)
    -+			BUG("noes");
    - 		if (!quiet)
    --			oid_is_type_or_error(oid, OBJ_COMMIT, &want);
    -+			fprintf(stderr, "noes ohes");/*
    -+			oid_is_type_or_error(oid, OBJ_COMMIT, &obj->type);*/
    - 		return NULL;
    - 	}
    - 	return (struct commit *)obj;
     @@ commit.c: struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
      	struct object *obj = lookup_object(r, oid);
      	if (!obj)
    - 		return create_object(r, oid, alloc_commit_node(r));
    + 		return create_commit(r, oid);
     -	return object_as_type(obj, OBJ_COMMIT, 0);
     +	return object_as_type(obj, OBJ_COMMIT);
      }
    @@ tag.c
     @@ tag.c: struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
      	struct object *obj = lookup_object(r, oid);
      	if (!obj)
    - 		return create_object(r, oid, alloc_tag_node(r));
    + 		return create_tag(r, oid);
     -	return object_as_type(obj, OBJ_TAG, 0);
     +	return object_as_type(obj, OBJ_TAG);
      }
    @@ tree.c
     @@ tree.c: struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
      	struct object *obj = lookup_object(r, oid);
      	if (!obj)
    - 		return create_object(r, oid, alloc_tree_node(r));
    + 		return create_tree(r, oid);
     -	return object_as_type(obj, OBJ_TREE, 0);
     +	return object_as_type(obj, OBJ_TREE);
      }
-- 
2.31.1.723.ga5d7868e4a

