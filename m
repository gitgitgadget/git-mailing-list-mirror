Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE8E11731
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo8DR+z1"
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB3EF9
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 05:26:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so642664066b.1
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698150397; x=1698755197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dneRz8ReNMikBaoVQuvwszwVYZuWq4uV2WLm0z+wt6M=;
        b=eo8DR+z1LEpJoiNucVs0RdhqJiMzOBp6J9Icimf4wv88Fp76fbdJ7hbH/3AgJC2Iu6
         ix8bUJIqVzlCy8pDOdYEwhVcex1AeZIBITBDAVdLBlRJcnRB+tMV+mjTaYCFAJBM+xI5
         TMpiMY8cJ0+LO6926VD7C8h1ZqWpmWkNGTCZ0ly42l4He0YdwMPVNBJb2zIMYg8CI+ln
         lAZ96RXfLx3Id8LwCXXExg4io+E+JWxCppaJIEAjh5Jvx2ZMFfuLP3N7r/bvHq3DRU1+
         5Vzqn7poDOHsZSooKcuf7S3X/QpM9vEq6dcDEH3sPgtlJ5LAKUe4i6Gx6AheZIfLgrNM
         E1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698150397; x=1698755197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dneRz8ReNMikBaoVQuvwszwVYZuWq4uV2WLm0z+wt6M=;
        b=Jss8u03WRGOHKjPdqUocrs4kY1obKs3hnSr7KPS1J0sYq5mK9Mipohps/gFTvEHxZZ
         3gEdYUFIhmDuX7hv7WqKy96qcvuhfgsiizk1Ue1Es1DW3fR5dybiZacUCEWuH9mbjoOh
         40M00njTuxb7at8/lStkb+4OfNj01to+4VBk6aJc/xnqpcHxKUqsrn0kCv6yJVSu10W5
         mYWZhvAVma2piIMuu+M0FVHIPZkN4wVl6XEqFYA+GlyjGp/BeCY/MzkQWqirENtkJYVE
         g3jXM/wF32i3enUKUZa7y5uDId1kYUH/iKoCTRrlBioXqaOY3mLJNHRlFMQ54IqL6KK9
         1/uQ==
X-Gm-Message-State: AOJu0YyZxX5ARtZ+ahuyEX8xkaUD+cG66paHCrkzzoQYLNa4oFajzp77
	bCxCwYFmLTB5aN0f2/qPRLCAV3OC9gPVNA==
X-Google-Smtp-Source: AGHT+IH60NBV6j8aJxOTfRoHgm07AQLxPUS9wrim6Z4lpIzqLk3v7EmfRMuMwOoTrqc2M/LSMdVGLg==
X-Received: by 2002:a17:907:720f:b0:9bd:804a:5601 with SMTP id dr15-20020a170907720f00b009bd804a5601mr8738349ejc.54.1698150396732;
        Tue, 24 Oct 2023 05:26:36 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:be13:9408:ebb5:e370])
        by smtp.gmail.com with ESMTPSA id jl24-20020a17090775d800b0099315454e76sm8102726ejc.211.2023.10.24.05.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:26:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 0/3] rev-list: add support for commits in `--missing`
Date: Tue, 24 Oct 2023 14:26:28 +0200
Message-ID: <20231024122631.158415-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019121024.194317-1-karthik.188@gmail.com>
References: <20231019121024.194317-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--missing` option in git-rev-list(1) was introduced intitally
to deal with missing blobs in the context of promissory notes.
Eventually the option was extended to also support tree objects in
7c0fe330d5 (rev-list: handle missing tree objects properly,2018-10-05).

This patch series extends the `--missing` option to also add support for
commit objects. We do this by introducing a new flag `MISSING` which is
added whenever we encounter a missing commit during traversal. Then in
`builtin/rev-list` we check for this flag and take the appropriate
action based on the `--missing=*` option used.

This series is an alternate to the patch series I had posted earlier:
https://lore.kernel.org/git/20230908174208.249184-1-karthik.188@gmail.com/.
In that patch, we introduced an option `--ignore-missing-links` which
was added to expose the `ignore_missing_links` bit to the user. The
issue in that patch was that, the option `--ignore-missing-links` didn't
play well the pre-existing `--missing` option. This series avoids that
route and just extends the `--missing` option for commits to solve the
same problem.

V3 of the series can be found here: https://lore.kernel.org/git/20231019121024.194317-1-karthik.188@gmail.com/T/#mf6a442e06f323a78a45af086ddd353998bab0052

Changes from v3:
- Instead of using flags on the object level as in the previous vesrions, we
add and use a missing_objects oidset in rev_info. This avoids flag bit-collision
since we were using an existing bit and doesn't require extending the flag size
as done in v3. 

Changelog vs v3:

1:  8c469cf479 = 1:  8c469cf479 revision: rename bit to `do_not_die_on_missing_objects`
2:  76ce43d973 = 2:  76ce43d973 rev-list: move `show_commit()` to the bottom
3:  4c640f9ab4 ! 3:  d892f0b82d rev-list: add commit object support in `--missing` option
    @@ Commit message
         a fatal error.
     
         Let's extend the functionality of `--missing` option to also support
    -    commit objects. This is done by adding a new `MISSING` flag that the
    -    revision walker sets whenever it encounters a missing tree/commit. The
    -    revision walker will now continue the traversal and call `show_commit()`
    -    even for missing commits. In rev-list we can then check for this flag
    -    and call the existing code for parsing `--missing` objects.
    +    commit objects. This is done by adding a `missing_objects` field to
    +    `rev_info`. This field is an `oidset` to which we'll add the missing
    +    commits as we encounter them. The revision walker will now continue the
    +    traversal and call `show_commit()` even for missing commits. In rev-list
    +    we can then check if the commit is a missing commit and call the
    +    existing code for parsing `--missing` objects.
     
         A scenario where this option would be used is to find the boundary
         objects between different object directories. Consider a repository with
    @@ Commit message
         alternate object directory allows us to find the boundary objects
         between the main and alternate object directory.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/rev-list.c ##
    @@ builtin/rev-list.c: static void show_commit(struct commit *commit, void *data)
      	display_progress(progress, ++progress_counter);
      
     +	if (revs->do_not_die_on_missing_objects &&
    -+	    commit->object.flags & MISSING) {
    ++	    oidset_contains(&revs->missing_objects, &commit->object.oid)) {
     +		finish_object__ma(&commit->object);
     +		return;
     +	}
    @@ builtin/rev-list.c: static void show_commit(struct commit *commit, void *data)
     
      ## list-objects.c ##
     @@ list-objects.c: static void do_traverse(struct traversal_context *ctx)
    - 		 * an uninteresting boundary commit may not have its tree
    - 		 * parsed yet, but we are not going to show them anyway
      		 */
    --		if (!ctx->revs->tree_objects)
    -+		if (!ctx->revs->tree_objects || commit->object.flags & MISSING)
    + 		if (!ctx->revs->tree_objects)
      			; /* do not bother loading tree */
    ++		else if (ctx->revs->do_not_die_on_missing_objects &&
    ++			 oidset_contains(&ctx->revs->missing_objects, &commit->object.oid))
    ++			;
      		else if (repo_get_commit_tree(the_repository, commit)) {
      			struct tree *tree = repo_get_commit_tree(the_repository,
    -
    - ## object.h ##
    -@@ object.h: void object_array_init(struct object_array *array);
    - 
    - /*
    -  * object flag allocation:
    -- * revision.h:               0---------10         15             23------27
    -+ * revision.h:               0---------10         15             22------28
    -  * fetch-pack.c:             01    67
    -  * negotiator/default.c:       2--5
    -  * walker.c:                 0-2
    -@@ object.h: void object_array_init(struct object_array *array);
    -  * builtin/show-branch.c:    0-------------------------------------------26
    -  * builtin/unpack-objects.c:                                 2021
    -  */
    --#define FLAG_BITS  28
    -+#define FLAG_BITS  29
    - 
    - #define TYPE_BITS 3
    - 
    + 								 commit);
     
      ## revision.c ##
    +@@
    + #include "object-name.h"
    + #include "object-file.h"
    + #include "object-store-ll.h"
    ++#include "oidset.h"
    + #include "tag.h"
    + #include "blob.h"
    + #include "tree.h"
     @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *commit,
    - 	struct commit_list *parent = commit->parents;
    - 	unsigned pass_flags;
      
    --	if (commit->object.flags & ADDED)
    -+	if (commit->object.flags & (ADDED | MISSING))
    + 	if (commit->object.flags & ADDED)
      		return 0;
    ++	if (revs->do_not_die_on_missing_objects &&
    ++		oidset_contains(&revs->missing_objects, &commit->object.oid))
    ++		return 0;
      	commit->object.flags |= ADDED;
      
    + 	if (revs->include_check &&
     @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *commit,
      	for (parent = commit->parents; parent; parent = parent->next) {
      		struct commit *p = parent->item;
    @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *com
     +			if (!revs->do_not_die_on_missing_objects)
     +				return -1;
     +			else
    -+				p->object.flags |= MISSING;
    ++				oidset_insert(&revs->missing_objects, &p->object.oid);
      		}
      		if (revs->sources) {
      			char **slot = revision_sources_at(revs->sources, p);
    +@@ revision.c: int prepare_revision_walk(struct rev_info *revs)
    + 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
    + 	}
    + 
    ++	if (revs->do_not_die_on_missing_objects)
    ++		oidset_init(&revs->missing_objects, 0);
    ++
    + 	if (!revs->reflog_info)
    + 		prepare_to_use_bloom_filter(revs);
    + 	if (!revs->unsorted_input)
     
      ## revision.h ##
     @@
    - #define ANCESTRY_PATH	(1u<<27)
    - #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | PULL_MERGE)
    + #include "commit.h"
    + #include "grep.h"
    + #include "notes.h"
    ++#include "oidset.h"
    + #include "pretty.h"
    + #include "diff.h"
    + #include "commit-slab-decl.h"
    +@@ revision.h: struct rev_info {
      
    -+#define MISSING (1u<<28)
    + 	/* Location where temporary objects for remerge-diff are written. */
    + 	struct tmp_objdir *remerge_objdir;
     +
    - #define DECORATE_SHORT_REFS	1
    - #define DECORATE_FULL_REFS	2
    ++	/* Missing objects to be tracked without failing traversal. */
    ++	struct oidset missing_objects;
    + };
      
    + /**
     
      ## t/t6022-rev-list-missing.sh (new) ##
     @@


Karthik Nayak (3):
  revision: rename bit to `do_not_die_on_missing_objects`
  rev-list: move `show_commit()` to the bottom
  rev-list: add commit object support in `--missing` option

 builtin/reflog.c            |  2 +-
 builtin/rev-list.c          | 93 +++++++++++++++++++------------------
 list-objects.c              |  5 +-
 revision.c                  | 16 ++++++-
 revision.h                  | 21 +++++----
 t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++
 6 files changed, 155 insertions(+), 56 deletions(-)
 create mode 100755 t/t6022-rev-list-missing.sh

-- 
2.42.0

