Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CF1EB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGJVMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGJVMG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:06 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7141CBC
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b7474b0501so4398016a34.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023523; x=1691615523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qoWgDm+2eFFstezGVdl2Zw4We55hQ2JpVeP7lTnl6UI=;
        b=xpFhWmLHrl+y3VAT0oLtox2DVt1Plw1F6MuTZ1QFtS3zkfJkQ/AlDTyYTsCVCxyWqM
         IKAPPPPiIxUyesKPBNIbeVbiQaFZOyUmzokWYWdmu6U5hhGyGdgHW+1eqH41QrBwthGn
         PPMQj2u5SPW3iObJNphAD6lKy5+kQZhBM4bQ1+KqX/hD2bNl9w8EGu4Ape2q7qcyxMTe
         hIeHAMoYbhz7UXqaME46dLZ7eidebzpiWp45hYBm1AzUrM05nnf+wOoLNP/xgcO9hIBl
         hSeG0SkBKQaFOJ+m78TsvGWnU9t6bR3IMD6aJdKRNzD3dBxfzlXb764PUUzHApeNewmU
         MhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023523; x=1691615523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoWgDm+2eFFstezGVdl2Zw4We55hQ2JpVeP7lTnl6UI=;
        b=i8a4tV06vtJQZZo1sz/pJ+aah1LPDa3gGEmJM+5vggCIOrhfWKjRAcozqPiycGZl9E
         2WPCVgZTQFhwx+sondHUzrj+1Ipq1bXgqjX6RJcdyVQ4io5hIwQSgI8z/TC07x7LFHYN
         0nz5RcJ3vrNHb6U/SSQ7JxS2hNdkYnmjW9mDO61l8ZCyJDD6g3s8NhH0301txaLTxWal
         obf9H5bgdsJcQkJhOZBCq3lKzv4uVnopsW3CrMBh5uoa5H/hBDJw3zxevzVd6PZ956SX
         wCzZaslC5EN9p5+xHePhPdPW67btobji86u/XTZ701lxj4yU9i0FAQWNYr7jUKBu6zxP
         0j3g==
X-Gm-Message-State: ABy/qLbUiyWCamC6H9ZjUGRfTeUaSAtkMwYy7iuk/czfWkfsg+Xy8T4d
        uBR4MVPkTHewO/htVE+Aevo9BuTanS1vGSV26M+UKg==
X-Google-Smtp-Source: APBJJlFdOLHzd5QoNjQuElL0rKtvqysDeqTsk8rN9Ytd4mV1a01DfdWuHTnonZXrKuM0ufV9BLmL0A==
X-Received: by 2002:a05:6830:1503:b0:6b8:6a5b:3008 with SMTP id k3-20020a056830150300b006b86a5b3008mr12906005otp.11.1689023523371;
        Mon, 10 Jul 2023 14:12:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 199-20020a2505d0000000b00c4f175716fcsm144589ybf.20.2023.07.10.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:02 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/16] refs: implement jump lists for packed backend
Message-ID: <cover.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another reroll of my series to implement jump (née skip) lists
for the packed refs backend, based on top of the current 'master'.

This responds to a review of the entire series that Peff gave a couple
of weeks ago[1], which should satisfy all of the comments that he
raised, most of which were relatively minor.

The notable changes from last time are:

  - clarifying some commit messages, notably to explicitly state that
    certain clean-ups do not indicate existing bugs, but are defensive
    against potential future ones
  - polishing up some of the API changes, to avoid having
    `match_name_as_path()` take a ref_filter pointer.
  - more timing data and documentation in the first substantive patch
  - clean-up in the upload-pack.c to make the changes clearer

As usual, a range-diff is included below for convenience.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/20230703062925.GK3502534@coredump.intra.peff.net/

Jeff King (5):
  refs.c: rename `ref_filter`
  ref-filter.h: provide `REF_FILTER_INIT`
  ref-filter: clear reachable list pointers after freeing
  ref-filter: add `ref_filter_clear()`
  ref-filter.c: parameterize match functions over patterns

Taylor Blau (11):
  builtin/for-each-ref.c: add `--exclude` option
  refs: plumb `exclude_patterns` argument throughout
  refs/packed-backend.c: refactor `find_reference_location()`
  refs/packed-backend.c: implement jump lists to avoid excluded
    pattern(s)
  refs/packed-backend.c: add trace2 counters for jump list
  revision.h: store hidden refs in a `strvec`
  refs.h: let `for_each_namespaced_ref()` take excluded patterns
  refs.h: implement `hidden_refs_to_excludes()`
  builtin/receive-pack.c: avoid enumerating hidden references
  upload-pack.c: avoid enumerating hidden refs where possible
  ls-refs.c: avoid enumerating hidden refs where possible

 Documentation/git-for-each-ref.txt |   6 +
 builtin/branch.c                   |   4 +-
 builtin/for-each-ref.c             |   7 +-
 builtin/receive-pack.c             |   8 +-
 builtin/tag.c                      |   4 +-
 http-backend.c                     |   2 +-
 ls-refs.c                          |   7 +-
 ref-filter.c                       |  66 +++++++---
 ref-filter.h                       |  12 ++
 refs.c                             |  85 ++++++++----
 refs.h                             |  29 +++-
 refs/debug.c                       |   5 +-
 refs/files-backend.c               |   5 +-
 refs/packed-backend.c              | 204 +++++++++++++++++++++++++----
 refs/refs-internal.h               |   7 +-
 revision.c                         |   4 +-
 revision.h                         |   5 +-
 t/helper/test-reach.c              |   2 +-
 t/helper/test-ref-store.c          |  10 ++
 t/t0041-usage.sh                   |   1 +
 t/t1419-exclude-refs.sh            | 122 +++++++++++++++++
 t/t3402-rebase-merge.sh            |   1 +
 t/t6300-for-each-ref.sh            |  35 +++++
 trace2.h                           |   2 +
 trace2/tr2_ctr.c                   |   5 +
 upload-pack.c                      |  47 +++++--
 26 files changed, 579 insertions(+), 106 deletions(-)
 create mode 100755 t/t1419-exclude-refs.sh

Range-diff against v4:
 1:  c12def5a30a !  1:  5b5ccc40d6b refs.c: rename `ref_filter`
    @@ Commit message
         refs.c: rename `ref_filter`
     
         The refs machinery has its own implementation of a `ref_filter` (used by
    -    `for-each-ref`), which is distinct from the `ref-filler.h` API (also
    +    `for-each-ref`), which is distinct from the `ref-filter.h` API (also
         used by `for-each-ref`, among other things).
     
         Rename the one within refs.c to more clearly indicate its purpose.
 2:  7ce82b6a5a4 !  2:  0c4e995f1d3 ref-filter.h: provide `REF_FILTER_INIT`
    @@ Commit message
         Provide a sane initialization value for `struct ref_filter`, which in a
         subsequent patch will be used to initialize a new field.
     
    -    In the meantime, fix a case in test-reach.c where its `ref_filter` is
    -    not even zero-initialized.
    +    In the meantime, ensure that the `ref_filter` struct used in the
    +    test-helper's `cmd__reach()` is zero-initialized. The lack of
    +    initialization is OK, since `commit_contains()` only looks at the single
    +    `with_commit_tag_algo` field that *is* initialized directly above.
    +
    +    So this does not fix a bug, but rather prevents one from biting us in
    +    the future.
     
         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
 3:  7e6bf7766d0 !  3:  cea1e88d358 ref-filter: clear reachable list pointers after freeing
    @@ Metadata
      ## Commit message ##
         ref-filter: clear reachable list pointers after freeing
     
    -    In reach_filter(), we pop all commits from the reachable lists, leaving
    -    them empty. But because we're operating on a list pointer that was
    -    passed by value, the original filter.reachable_from pointer is left
    -    dangling.
    +    In `reach_filter()`, we pop all commits from the reachable lists,
    +    leaving them empty. But because we're operating on a list pointer that
    +    was passed by value, the original `filter.reachable_from` and
    +    `filter.unreachable_from` pointers are left dangling.
    +
    +    As is the case with the previous commit, nobody touches either of these
    +    fields after calling `reach_filter()`, so leaving them dangling is OK.
    +    But this future proofs against dangerous situations.
     
         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
 4:  777e71004d6 =  4:  00a4532d54d ref-filter: add `ref_filter_clear()`
 5:  39e9b0f50d0 !  5:  3ab03ac20df ref-filter.c: parameterize match functions over patterns
    @@ ref-filter.c: static int get_ref_atom_value(struct ref_array_item *ref, int atom
       */
     -static int match_pattern(const struct ref_filter *filter, const char *refname)
     +static int match_pattern(const char **patterns, const char *refname,
    -+			 const int ignore_case)
    ++			 int ignore_case)
      {
     -	const char **patterns = filter->name_patterns;
      	unsigned flags = 0;
    @@ ref-filter.c: static int match_pattern(const struct ref_filter *filter, const ch
       * wildcard (e.g. the same ref matches "refs/heads/m*", too).
       */
     -static int match_name_as_path(const struct ref_filter *filter, const char *refname)
    -+static int match_name_as_path(const struct ref_filter *filter,
    -+			      const char **pattern,
    -+			      const char *refname)
    ++static int match_name_as_path(const char **pattern, const char *refname,
    ++			      int ignore_case)
      {
     -	const char **pattern = filter->name_patterns;
      	int namelen = strlen(refname);
      	unsigned flags = WM_PATHNAME;
      
    +-	if (filter->ignore_case)
    ++	if (ignore_case)
    + 		flags |= WM_CASEFOLD;
    + 
    + 	for (; *pattern; pattern++) {
     @@ ref-filter.c: static int filter_pattern_match(struct ref_filter *filter, const char *refname)
      	if (!*filter->name_patterns)
      		return 1; /* No pattern always matches */
      	if (filter->match_as_path)
     -		return match_name_as_path(filter, refname);
     -	return match_pattern(filter, refname);
    -+		return match_name_as_path(filter, filter->name_patterns, refname);
    ++		return match_name_as_path(filter->name_patterns, refname,
    ++					  filter->ignore_case);
     +	return match_pattern(filter->name_patterns, refname,
     +			     filter->ignore_case);
      }
 6:  c4fd47fd750 !  6:  aa881ca06fa builtin/for-each-ref.c: add `--exclude` option
    @@ ref-filter.c: static int filter_pattern_match(struct ref_filter *filter, const c
     +	if (!filter->exclude.nr)
     +		return 0;
     +	if (filter->match_as_path)
    -+		return match_name_as_path(filter, filter->exclude.v, refname);
    ++		return match_name_as_path(filter->exclude.v, refname,
    ++					  filter->ignore_case);
     +	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
     +}
     +
 7:  e6b50c50219 =  7:  81e223de0c8 refs: plumb `exclude_patterns` argument throughout
 8:  a0990b2916c =  8:  25c099a528c refs/packed-backend.c: refactor `find_reference_location()`
 9:  386ed468fa7 !  9:  af0ce43cc90 refs/packed-backend.c: implement jump lists to avoid excluded pattern(s)
    @@ Commit message
     
             $ hyperfine \
               'git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"' \
    +          'git.prev for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"' \
               'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"'
             Benchmark 1: git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"
    -          Time (mean ± σ):     802.7 ms ±   2.1 ms    [User: 691.6 ms, System: 147.0 ms]
    -          Range (min … max):   800.0 ms … 807.7 ms    10 runs
    +          Time (mean ± σ):     798.1 ms ±   3.3 ms    [User: 687.6 ms, System: 146.4 ms]
    +          Range (min … max):   794.5 ms … 805.5 ms    10 runs
     
    -        Benchmark 2: git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"
    -          Time (mean ± σ):       4.7 ms ±   0.3 ms    [User: 0.7 ms, System: 4.0 ms]
    -          Range (min … max):     4.3 ms …   6.7 ms    422 runs
    +        Benchmark 2: git.prev for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"
    +          Time (mean ± σ):      98.9 ms ±   1.4 ms    [User: 93.1 ms, System: 5.7 ms]
    +          Range (min … max):    97.0 ms … 104.0 ms    29 runs
    +
    +        Benchmark 3: git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"
    +          Time (mean ± σ):       4.5 ms ±   0.2 ms    [User: 0.7 ms, System: 3.8 ms]
    +          Range (min … max):     4.1 ms …   5.8 ms    524 runs
     
             Summary
               'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"' ran
    -          172.03 ± 9.60 times faster than 'git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"'
    +           21.87 ± 1.05 times faster than 'git.prev for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"'
    +          176.52 ± 8.19 times faster than 'git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"'
    +
    +    (Comparing stock git and this patch isn't quite fair, since an earlier
    +    commit in this series adds a naive implementation of the `--exclude`
    +    option. `git.prev` is built from the previous commit and includes this
    +    naive implementation).
     
         Using the jump list is fairly straightforward (see the changes to
         `refs/packed-backend.c::next_record()`), but constructing the list is
    @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
      
      /*
     
    + ## refs.h ##
    +@@ refs.h: int for_each_ref(each_ref_fn fn, void *cb_data);
    +  */
    + int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
    + 
    ++/*
    ++ * references matching any pattern in "exclude_patterns" are omitted from the
    ++ * result set on a best-effort basis.
    ++ */
    + int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
    + 			     const char **exclude_patterns,
    + 			     each_ref_fn fn, void *cb_data);
    +
      ## refs/packed-backend.c ##
     @@ refs/packed-backend.c: static int cmp_packed_ref_records(const void *v1, const void *v2)
       * Compare a snapshot record at `rec` to the specified NUL-terminated
    @@ refs/packed-backend.c: struct packed_ref_iterator {
     +		iter->jump_cur++;
     +		if (iter->pos < curr->end) {
     +			iter->pos = curr->end;
    ++			/* jumps are coalesced, so only one jump is necessary */
     +			break;
     +		}
     +	}
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +
     +	for (pattern = excluded_patterns; *pattern; pattern++) {
     +		struct jump_list_entry *e;
    ++		const char *start, *end;
     +
     +		/*
     +		 * We can't feed any excludes with globs in them to the
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +		if (has_glob_special(*pattern))
     +			continue;
     +
    ++		start = find_reference_location(snapshot, *pattern, 0);
    ++		end = find_reference_location_end(snapshot, *pattern, 0);
    ++
    ++		if (start == end)
    ++			continue; /* nothing to jump over */
    ++
     +		ALLOC_GROW(iter->jump, iter->jump_nr + 1, iter->jump_alloc);
     +
     +		e = &iter->jump[iter->jump_nr++];
    -+		e->start = find_reference_location(snapshot, *pattern, 0);
    -+		e->end = find_reference_location_end(snapshot, *pattern, 0);
    ++		e->start = start;
    ++		e->end = end;
     +	}
     +
     +	if (!iter->jump_nr) {
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +
     +	for (i = 1, j = 1; i < iter->jump_nr; i++) {
     +		struct jump_list_entry *ours = &iter->jump[i];
    -+
    -+		if (ours->start == ours->end) {
    -+			/* ignore empty regions (no matching entries) */
    -+			continue;
    -+		} else if (ours->start <= last_disjoint->end) {
    ++		if (ours->start <= last_disjoint->end) {
     +			/* overlapping regions extend the previous one */
     +			last_disjoint->end = last_disjoint->end > ours->end
     +				? last_disjoint->end : ours->end;
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +			/* otherwise, insert a new region */
     +			iter->jump[j++] = *ours;
     +			last_disjoint = ours;
    -+
     +		}
     +	}
     +
10:  49c8f5173aa ! 10:  e150941c1d1 refs/packed-backend.c: add trace2 counters for jump list
    @@ Commit message
     
      ## refs/packed-backend.c ##
     @@
    - #include "../chdir-notify.h"
    + #include "../statinfo.h"
      #include "../wrapper.h"
      #include "../write-or-die.h"
     +#include "../trace2.h"
    @@ refs/packed-backend.c: static int next_record(struct packed_ref_iterator *iter)
      		if (iter->pos < curr->end) {
      			iter->pos = curr->end;
     +			trace2_counter_add(TRACE2_COUNTER_ID_PACKED_REFS_JUMPS, 1);
    + 			/* jumps are coalesced, so only one jump is necessary */
      			break;
      		}
    - 	}
     
      ## t/t1419-exclude-refs.sh ##
     @@ t/t1419-exclude-refs.sh: TEST_PASSES_SANITIZE_LEAK=true
11:  dd856a3982b = 11:  a5093d52008 revision.h: store hidden refs in a `strvec`
12:  845904853ee <  -:  ----------- refs/packed-backend.c: ignore complicated hidden refs rules
13:  8d4d7cc22ee ! 12:  7e72c23c8a4 refs.h: let `for_each_namespaced_ref()` take excluded patterns
    @@ refs.h: int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
      
      int head_ref_namespaced(each_ref_fn fn, void *cb_data);
     -int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
    ++/*
    ++ * references matching any pattern in "exclude_patterns" are omitted from the
    ++ * result set on a best-effort basis.
    ++ */
     +int for_each_namespaced_ref(const char **exclude_patterns,
     +			    each_ref_fn fn, void *cb_data);
      
 -:  ----------- > 13:  f99d89d53b9 refs.h: implement `hidden_refs_to_excludes()`
14:  49c665f9f8f ! 14:  96aada36f9b builtin/receive-pack.c: avoid enumerating hidden references
    @@ builtin/receive-pack.c: static void write_head_info(void)
      
     -	for_each_ref(show_ref_cb, &seen);
     +	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
    -+				 hidden_refs.v, show_ref_cb, &seen);
    ++				 hidden_refs_to_excludes(&hidden_refs),
    ++				 show_ref_cb, &seen);
      	for_each_alternate_ref(show_one_alternate_ref, &seen);
      	oidset_clear(&seen);
      	if (!sent_capabilities)
15:  19bf4a52d69 ! 15:  8544a647798 upload-pack.c: avoid enumerating hidden refs where possible
    @@ upload-pack.c: static int get_common_commits(struct upload_pack_data *data,
      
     +static int allow_hidden_refs(enum allow_uor allow_uor)
     +{
    -+	return allow_uor & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1);
    ++	if ((allow_uor & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1)
    ++		return 1;
    ++	return !(allow_uor & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
     +}
     +
     +static void for_each_namespaced_ref_1(each_ref_fn fn,
     +				      struct upload_pack_data *data)
     +{
    ++	const char **excludes = NULL;
     +	/*
     +	 * If `data->allow_uor` allows fetching hidden refs, we need to
     +	 * mark all references (including hidden ones), to check in
    @@ upload-pack.c: static int get_common_commits(struct upload_pack_data *data,
     +	 * hidden references.
     +	 */
     +	if (allow_hidden_refs(data->allow_uor))
    -+		for_each_namespaced_ref(NULL, fn, data);
    -+	else
    -+		for_each_namespaced_ref(data->hidden_refs.v, fn, data);
    ++		excludes = hidden_refs_to_excludes(&data->hidden_refs);
    ++
    ++	for_each_namespaced_ref(excludes, fn, data);
     +}
    ++
     +
      static int is_our_ref(struct object *o, enum allow_uor allow_uor)
      {
     -	int allow_hidden_ref = (allow_uor &
     -				(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
     -	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
    -+	return o->flags & ((allow_hidden_refs(allow_uor) ? HIDDEN_REF : 0) | OUR_REF);
    ++	return o->flags & ((allow_hidden_refs(allow_uor) ? 0 : HIDDEN_REF) | OUR_REF);
      }
      
      /*
16:  ea6cbaf292f ! 16:  dff068c469f ls-refs.c: avoid enumerating hidden refs where possible
    @@ ls-refs.c: int ls_refs(struct repository *r, struct packet_reader *request)
      	refs_for_each_fullref_in_prefixes(get_main_ref_store(r),
      					  get_git_namespace(), data.prefixes.v,
     -					  NULL, send_ref, &data);
    -+					  data.hidden_refs.v, send_ref, &data);
    ++					  hidden_refs_to_excludes(&data.hidden_refs),
    ++					  send_ref, &data);
      	packet_fflush(stdout);
      	strvec_clear(&data.prefixes);
      	strbuf_release(&data.buf);
-- 
2.41.0.343.gdff068c469f
