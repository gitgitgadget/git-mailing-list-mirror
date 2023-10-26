Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88FD156DA
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrhFP/Ek"
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAA1183
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:11:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso115815066b.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698315075; x=1698919875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXKHnlQrLom9zQqUPsL6BzUbOulRAQ0PEZkxJrTaBaw=;
        b=VrhFP/EkBPAASSj6IHkZGPLN3ei2fXZXz2gP6+B8Qd5bJkTzM/hl6Q9KWGmob69C6j
         ctMIW7wNl7+rTB9CXRyT+9AhtZ2qiHKzgbd+ylKI6sTYe2c29QZsJpaQQAXvHLWcMq3c
         mgrhNWROc/iyaK2GD9hyXkYg3Ls5dlURPBYzIwABaexzRiZTBoX9iIsNoj/fhQ7fhhNO
         1DFItjqozYn9rBsiI8E9qKYSvuKZ9F8/+v38y0j15jQ3SSIy402pqWLV51XSBorjwIyF
         nud3AwV23uNeVRUl6UQja33dnlXMG01YDg6fU9BKAKK89vDS7fE2HESjMy5UsqsItgJE
         E/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315075; x=1698919875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXKHnlQrLom9zQqUPsL6BzUbOulRAQ0PEZkxJrTaBaw=;
        b=rv72FH7v6wW+NUw+Jh53KwDNZGeggpU16wWMW9r6P/nMHUkddmVxcFBeoVPTHeuD1/
         uM8i2GDBOxwh21Ze0YfmxRJPxRjefJtyl3s2P/kL535Qp56MvMCPQ8U0vLe3qCdl24SB
         GEFXiD5gRrvAiBmjQLDTcfefuLvfM76dXfGQgbSs8gvTArAoQzLcCj7ytZPDm/Q0PVwQ
         VRl/Zw1u3e7c4TpMsBckICM+vb019xbSdKyHf+euJL7Z9++S+bEZsWplmjUUVMv9y6e8
         EkvMZMkrFB5g/z22pE/hCd+rIMlBJYk7rFQRNXjwNch9U4WxOs/HSLbPhH1qFdLEJBqk
         SXqA==
X-Gm-Message-State: AOJu0YzT6/ld34fYqUb3IOlS9jEia+TkEhHYG7WFKcLmjwlXQbmKRMFN
	fMC0wxQq/axSiy52UcKQY5I=
X-Google-Smtp-Source: AGHT+IFkYcpDwV1CeLlILuVP1xl5gRGoSaNfBnTiRCfLRArbmUUdx5BvTSeeSr7MJWv8XnWyYMZyMA==
X-Received: by 2002:a17:907:8b8f:b0:9ce:ed5:d902 with SMTP id tb15-20020a1709078b8f00b009ce0ed5d902mr2252061ejc.1.1698315075022;
        Thu, 26 Oct 2023 03:11:15 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:561:c52d:5ce2:b147])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709065fcf00b00997d7aa59fasm11635390ejv.14.2023.10.26.03.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:11:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 0/3] rev-list: add support for commits in `--missing`
Date: Thu, 26 Oct 2023 12:11:06 +0200
Message-ID: <20231026101109.43110-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024122631.158415-1-karthik.188@gmail.com>
References: <20231024122631.158415-1-karthik.188@gmail.com>
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

V4 of the series can be found here: https://lore.kernel.org/git/20231024122631.158415-1-karthik.188@gmail.com/T/#ma7f07bc637e20e2a9558b23e8081957af61f63ce

Changes from v4:
- Rename `missing_objects` to `missing_commits` since we only deal
with commits.
- Fix incorrect indentation
- clear oidset after traversal in `release_revisions()` 

Range diff:

1:  8c469cf479 = 1:  8c469cf479 revision: rename bit to `do_not_die_on_missing_objects`
2:  76ce43d973 = 2:  76ce43d973 rev-list: move `show_commit()` to the bottom
3:  d892f0b82d ! 3:  6f0c74f888 rev-list: add commit object support in `--missing` option
    @@ Commit message
         between the main and alternate object directory.
     
         Helped-by: Patrick Steinhardt <ps@pks.im>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/rev-list.c ##
    @@ builtin/rev-list.c: static void show_commit(struct commit *commit, void *data)
      	display_progress(progress, ++progress_counter);
      
     +	if (revs->do_not_die_on_missing_objects &&
    -+	    oidset_contains(&revs->missing_objects, &commit->object.oid)) {
    ++	    oidset_contains(&revs->missing_commits, &commit->object.oid)) {
     +		finish_object__ma(&commit->object);
     +		return;
     +	}
    @@ list-objects.c: static void do_traverse(struct traversal_context *ctx)
      		if (!ctx->revs->tree_objects)
      			; /* do not bother loading tree */
     +		else if (ctx->revs->do_not_die_on_missing_objects &&
    -+			 oidset_contains(&ctx->revs->missing_objects, &commit->object.oid))
    ++			 oidset_contains(&ctx->revs->missing_commits, &commit->object.oid))
     +			;
      		else if (repo_get_commit_tree(the_repository, commit)) {
      			struct tree *tree = repo_get_commit_tree(the_repository,
    @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *com
      	if (commit->object.flags & ADDED)
      		return 0;
     +	if (revs->do_not_die_on_missing_objects &&
    -+		oidset_contains(&revs->missing_objects, &commit->object.oid))
    ++	    oidset_contains(&revs->missing_commits, &commit->object.oid))
     +		return 0;
      	commit->object.flags |= ADDED;
      
    @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *com
      			}
     -			return -1;
     +
    -+			if (!revs->do_not_die_on_missing_objects)
    -+				return -1;
    ++			if (revs->do_not_die_on_missing_objects)
    ++				oidset_insert(&revs->missing_commits, &p->object.oid);
     +			else
    -+				oidset_insert(&revs->missing_objects, &p->object.oid);
    ++				return -1; /* corrupt repository */
      		}
      		if (revs->sources) {
      			char **slot = revision_sources_at(revs->sources, p);
    +@@ revision.c: void release_revisions(struct rev_info *revs)
    + 	clear_decoration(&revs->merge_simplification, free);
    + 	clear_decoration(&revs->treesame, free);
    + 	line_log_free(revs);
    ++	oidset_clear(&revs->missing_commits);
    + }
    + 
    + static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
     @@ revision.c: int prepare_revision_walk(struct rev_info *revs)
      				       FOR_EACH_OBJECT_PROMISOR_ONLY);
      	}
      
     +	if (revs->do_not_die_on_missing_objects)
    -+		oidset_init(&revs->missing_objects, 0);
    ++		oidset_init(&revs->missing_commits, 0);
     +
      	if (!revs->reflog_info)
      		prepare_to_use_bloom_filter(revs);
    @@ revision.h: struct rev_info {
      	/* Location where temporary objects for remerge-diff are written. */
      	struct tmp_objdir *remerge_objdir;
     +
    -+	/* Missing objects to be tracked without failing traversal. */
    -+	struct oidset missing_objects;
    ++	/* Missing commits to be tracked without failing traversal. */
    ++	struct oidset missing_commits;
      };
      
      /**


Karthik Nayak (3):
  revision: rename bit to `do_not_die_on_missing_objects`
  rev-list: move `show_commit()` to the bottom
  rev-list: add commit object support in `--missing` option

 builtin/reflog.c            |  2 +-
 builtin/rev-list.c          | 93 +++++++++++++++++++------------------
 list-objects.c              |  5 +-
 revision.c                  | 17 ++++++-
 revision.h                  | 21 +++++----
 t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++
 6 files changed, 156 insertions(+), 56 deletions(-)
 create mode 100755 t/t6022-rev-list-missing.sh

-- 
2.42.0

