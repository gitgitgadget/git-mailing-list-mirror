Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5338FC433E9
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427CE20659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="i04MJ5Id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgEMV7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730473AbgEMV73 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:59:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B255C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s69so3381651pjb.4
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KvMaDb4K6VWilOnQCyZFT0swgmlQhjNizqmtC9pGmnw=;
        b=i04MJ5IdXb4w5M9bTtZ9VWkTYaNarYJR/xHVp1lEY39LCkY1h5WSiOadUFPbNdAVXL
         mQdqipzsnMHn/NLCLetZafg8K5RYWqgC0dfGJF6d9UuwvzMul61X6Cu/5iyyQn1W9uAs
         mn4WOMj8HqHqh5BS2TaOIySg+DFF2tv/iEPq5fFuSFxUTCv59NvJa1K8225nooNb2ReJ
         9XI/Me5K28dNjenk0ey6qbW9AFjRa1A9UpWD7HLGPaQcQnYKpIKb00VtuGwUqRlcJHTC
         vmK4PZn6QptmHj+rB/SwfDn/S6ZVb4Yu9DrzgN7fUd+PAzoqS56+i7E6Qr0tM/aQZYoo
         ieXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KvMaDb4K6VWilOnQCyZFT0swgmlQhjNizqmtC9pGmnw=;
        b=BOwxXqysM3c9lsttCp4VLsdVU5XGrkriLDOMHNcmtyX3UxtXULUwkEiO8vDH6Rpymc
         aGLpFdgL0Lx/R8gZnoE+6Ndl9Y8kMmM0kF6K2YZobRAWFDkiJNOofWd7vkIUHMlloRGJ
         MOdESd9f/raNKIHMiOEAMyuWCg5V7/TzsxmETlEVvxMK9/pdyWwvXEQ/gGXyUEC5kc+N
         EMNT0Z0AlbgYePp+nJ26WOwL/UmCeFlafHh3PfOc3gdE5FQDC4OCJZsDVbcWj816zhBx
         k+XOhrBPzREpdn8SRzUpti/vdOnaZj1LnPq0CtT1NkmyPWpxYYHhhHPQtw3fqyA+Z+jP
         L9tQ==
X-Gm-Message-State: AGi0PuZ4lHczluDNzBHne0k6ZQr/rMFDd7vAWClp0qWLbYXTXqdEYCYE
        xxHJwu3mmJPp6JHBk/Cs3TygY36HA/U=
X-Google-Smtp-Source: APiQypIFWePaHEjHuSGXR/DwuE0ZYJXkDUtLP0EF5z8i/S/SfcNE9Gr2fDA327bHJT9m/BAY0LlHvw==
X-Received: by 2002:a17:90a:f68d:: with SMTP id cl13mr36511678pjb.107.1589407168256;
        Wed, 13 May 2020 14:59:28 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 10sm440975pfn.204.2020.05.13.14.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:59:27 -0700 (PDT)
Date:   Wed, 13 May 2020 15:59:25 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 0/8] commit-graph: drop CHECK_OIDS, peel in callers
Message-ID: <cover.1589407014.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is a tiny reroll to my series to drop the commit-graph's behavior
of complaining about non-commit OIDs on input with '--stdin-commits'. I
promised this reroll after Peff's review beginning in [1].

Not a great deal has changed, but I mostly took every suggestion that
Peff put forward (in the sub-thread beginning at [1]). The "big deals"
since last time are:

  - 'add_ref_to_set()' got cleaned up to use 'oid_object_info'.

  - progress meter updates moved after their action

  - 'graph_write()' got cleaned up to break the loop into two loops
    executed conditionally (based on which of '--stdin-packs' or
    '--stdin-commits' was passed) , as well as a cleanup label was
    introduced and some UNLEAK cruft was cleaned up.

For convenience, a range-diff since v2 (with the changes on master
applied since then elided out) is included below.

Thanks again for your review.

-Taylor

[1]: https://lore.kernel.org/git/20200507195441.GA29683@coredump.intra.peff.net/

Taylor Blau (8):
  commit-graph.c: extract 'refs_cb_data'
  commit-graph.c: show progress of finding reachable commits
  commit-graph.c: peel refs in 'add_ref_to_set'
  builtin/commit-graph.c: extract 'read_one_commit()'
  builtin/commit-graph.c: dereference tags in builtin
  commit-graph.c: simplify 'fill_oids_from_commits'
  t5318: reorder test below 'graph_read_expect'
  commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag

 Documentation/git-commit-graph.txt |  6 ++-
 builtin/commit-graph.c             | 73 +++++++++++++++++++-----------
 commit-graph.c                     | 62 +++++++++++--------------
 commit-graph.h                     |  4 +-
 t/t5318-commit-graph.sh            | 25 ++++++----
 5 files changed, 95 insertions(+), 75 deletions(-)

Range-diff against v2:
 1:  43286c3c45 = 60:  0efbcfcf3a commit-graph.c: extract 'refs_cb_data'
 2:  cb56a9a73b ! 61:  773522c745 commit-graph.c: show progress of finding reachable commits
    @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_cont

      static int add_ref_to_set(const char *refname,
     @@ commit-graph.c: static int add_ref_to_set(const char *refname,
    - {
      	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;

    -+	display_progress(data->progress, oidset_size(data->commits) + 1);
    -+
      	oidset_insert(data->commits, oid);
    ++
    ++	display_progress(data->progress, oidset_size(data->commits));
    ++
      	return 0;
      }
    +
     @@ commit-graph.c: int write_commit_graph_reachable(struct object_directory *odb,

      	memset(&data, 0, sizeof(data));
 3:  85c388a077 <  -:  ---------- commit-graph.c: peel refs in 'add_ref_to_set'
 -:  ---------- > 62:  74b424f1ac commit-graph.c: peel refs in 'add_ref_to_set'
 4:  cef441b465 ! 63:  c37e94907b builtin/commit-graph.c: extract 'read_one_commit()'
    @@ builtin/commit-graph.c: static int write_option_parse_split(const struct option
      	return 0;
      }

    -+static int read_one_commit(struct oidset *commits, char *hash)
    ++static int read_one_commit(struct oidset *commits, const char *hash)
     +{
     +	struct object_id oid;
     +	const char *end;
     +
    -+	if (parse_oid_hex(hash, &oid, &end)) {
    -+		error(_("unexpected non-hex object ID: %s"), hash);
    -+		return 1;
    -+	}
    ++	if (parse_oid_hex(hash, &oid, &end))
    ++		return error(_("unexpected non-hex object ID: %s"), hash);
     +
     +	oidset_insert(commits, &oid);
     +	return 0;
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      	}

     -	string_list_init(&lines, 0);
    -+	string_list_init(&pack_indexes, 0);
    - 	if (opts.stdin_packs || opts.stdin_commits) {
    - 		struct strbuf buf = STRBUF_INIT;
    --
    --		while (strbuf_getline(&buf, stdin) != EOF)
    +-	if (opts.stdin_packs || opts.stdin_commits) {
    +-		struct strbuf buf = STRBUF_INIT;
    ++	struct strbuf buf = STRBUF_INIT;
    ++	if (opts.stdin_packs) {
    ++		string_list_init(&pack_indexes, 0);
    +
    + 		while (strbuf_getline(&buf, stdin) != EOF)
     -			string_list_append(&lines, strbuf_detach(&buf, NULL));
    --
    ++			string_list_append(&pack_indexes,
    ++					   strbuf_detach(&buf, NULL));
    ++	} else if (opts.stdin_commits) {
    ++		oidset_init(&commits, 0);
    ++		flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
    +
     -		if (opts.stdin_packs)
     -			pack_indexes = &lines;
    - 		if (opts.stdin_commits) {
    +-		if (opts.stdin_commits) {
     -			struct string_list_item *item;
     -			oidset_init(&commits, lines.nr);
     -			for_each_string_list_item(item, &lines) {
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
     -				}
     -
     -				oidset_insert(&commits, &oid);
    --			}
    -+			oidset_init(&commits, 0);
    - 			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
    - 		}
    -
     +		while (strbuf_getline(&buf, stdin) != EOF) {
    -+			char *line = strbuf_detach(&buf, NULL);
    -+			if (opts.stdin_commits) {
    -+				int result = read_one_commit(&commits, line);
    -+				if (result)
    -+					return result;
    -+			} else
    -+				string_list_append(&pack_indexes, line);
    -+		}
    -+
    - 		UNLEAK(buf);
    ++			if (read_one_commit(&commits, buf.buf)) {
    ++				result = 1;
    ++				goto cleanup;
    + 			}
    +-			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
    + 		}
    +-
    +-		UNLEAK(buf);
      	}

      	if (write_commit_graph(odb,
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      		result = 1;

     -	UNLEAK(lines);
    ++cleanup:
     +	UNLEAK(pack_indexes);
    ++	strbuf_release(&buf);
      	return result;
      }

 5:  d449d83ce2 <  -:  ---------- builtin/commit-graph.c: dereference tags in builtin
 -:  ---------- > 64:  56403dd377 builtin/commit-graph.c: dereference tags in builtin
 6:  61887870c7 = 65:  6afb08a927 commit-graph.c: simplify 'fill_oids_from_commits'
 7:  e393b16097 = 66:  8fdd2792df t5318: reorder test below 'graph_read_expect'
 8:  ad373f05ff ! 67:  3cb0bd306c commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
    @@ Commit message
         If callers do wish to retain this behavior, they can easily work around
         this change by doing the following:

    -        git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
    -        awk '/commit/ { print $1 }' |
    -        git commit-graph write --stdin-commits
    +         git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
    +         awk '
    +           !/commit/ { print "not-a-commit:"$1 }
    +            /commit/ { print $1 }
    +         ' |
    +         git commit-graph write --stdin-commits

         To make it so that valid OIDs that refer to non-existent objects are
         indeed an error after loosening the error handling, perform an extra
         lookup to make sure that object indeed exists before sending it to the
         commit-graph internals.

    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## Documentation/git-commit-graph.txt ##
    @@ Documentation/git-commit-graph.txt: with `--stdin-commits` or `--reachable`.)
      commits starting at all refs. (Cannot be combined with `--stdin-commits`

      ## builtin/commit-graph.c ##
    -@@ builtin/commit-graph.c: static int read_one_commit(struct oidset *commits, struct progress *progress,
    +@@
    + #include "commit-graph.h"
    + #include "object-store.h"
    + #include "progress.h"
    ++#include "tag.h"

    - 	display_progress(progress, oidset_size(commits) + 1);
    + static char const * const builtin_commit_graph_usage[] = {
    + 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
    +@@ builtin/commit-graph.c: static int write_option_parse_split(const struct option *opt, const char *arg,
    + static int read_one_commit(struct oidset *commits, struct progress *progress,
    + 			   const char *hash)
    + {
    +-	struct commit *result;
    ++	struct object *result;
    + 	struct object_id oid;
    + 	const char *end;

    -+	if (oid_object_info(the_repository, &oid, NULL) < 0) {
    -+		error(_("object %s does not exist"), hash);
    -+		return 1;
    -+	}
    -+
    - 	result = lookup_commit_reference_gently(the_repository, &oid, 1);
    - 	if (result)
    - 		oidset_insert(commits, &result->object.oid);
    --	else {
    --		error(_("invalid commit object id: %s"), hash);
    --		return 1;
    --	}
    - 	return 0;
    - }
    + 	if (parse_oid_hex(hash, &oid, &end))
    + 		return error(_("unexpected non-hex object ID: %s"), hash);
    +
    +-	result = lookup_commit_reference_gently(the_repository, &oid, 1);
    +-	if (result)
    +-		oidset_insert(commits, &result->object.oid);
    +-	else
    +-		return error(_("invalid commit object id: %s"), hash);
    ++	result = deref_tag(the_repository, parse_object(the_repository, &oid),
    ++			   NULL, 0);
    ++	if (!result)
    ++		return error(_("invalid object: %s"), hash);
    ++	else if (object_as_type(the_repository, result, OBJ_COMMIT, 1))
    ++		oidset_insert(commits, &result->oid);
    +
    + 	display_progress(progress, oidset_size(commits));

     @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
    - 		struct strbuf buf = STRBUF_INIT;
    - 		if (opts.stdin_commits) {
    - 			oidset_init(&commits, 0);
    --			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
    - 			if (opts.progress)
    - 				progress = start_delayed_progress(
    - 					_("Collecting commits from input"), 0);
    + 					   strbuf_detach(&buf, NULL));
    + 	} else if (opts.stdin_commits) {
    + 		oidset_init(&commits, 0);
    +-		flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
    + 		if (opts.progress)
    + 			progress = start_delayed_progress(
    + 				_("Collecting commits from input"), 0);

      ## commit-graph.c ##
     @@ commit-graph.c: struct write_commit_graph_context {
    @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      	ctx->total_bloom_filter_data_size = 0;

      ## commit-graph.h ##
    -@@ commit-graph.h: struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
    - int generation_numbers_enabled(struct repository *r);
    -
    - enum commit_graph_write_flags {
    --	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
    --	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
    --	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
    +@@ commit-graph.h: enum commit_graph_write_flags {
    + 	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
    + 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
    + 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
     -	/* Make sure that each OID in the input is a valid commit OID. */
     -	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
     -	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
    -+	COMMIT_GRAPH_WRITE_APPEND        = (1 << 0),
    -+	COMMIT_GRAPH_WRITE_PROGRESS      = (1 << 1),
    -+	COMMIT_GRAPH_WRITE_SPLIT         = (1 << 2),
    -+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 3)
    ++	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 3),
      };

      enum commit_graph_split_flags {
    @@ t/t5318-commit-graph.sh: graph_read_expect() {
     +	# non-existent OID
     +	echo $ZERO_OID >in &&
     +	test_expect_code 1 git commit-graph write --stdin-commits <in 2>stderr &&
    -+	test_i18ngrep "does not exist" stderr &&
    ++	test_i18ngrep "invalid object" stderr &&
     +	# valid commit and tree OID
     +	git rev-parse HEAD HEAD^{tree} >in &&
     +	git commit-graph write --stdin-commits <in &&
--
2.26.0.113.ge9739cdccc
