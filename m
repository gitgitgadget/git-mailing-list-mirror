Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A039C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C18E61039
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbhJZVD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbhJZVD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:03:27 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A5C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:03 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h2so632662ili.11
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=eXzeR1+cGQUVVXBaqZKE3rMR1MzqWVxS5JHQsCEePsM=;
        b=jxpclTPl5GE9XzMe8QclAV+P14zMBIcqydU4DUBxSLX+KvwLWMwZv8AlpljJi41YBY
         cm+Xej4ii6W3KuA6ZJY2SNdfK507c4QHfMoPY45QbyOHe0zrr8dI4/txnd2OY4Hn6Wug
         Ofket3rGqaCJg6DmT4ERUgb3Gj7ZzqJwjyZjlwG/mSwVqlOOaB9gSCZ7NTYu4HGq4iiq
         Vlvpv3PNpx91qBu+x0C3+s2EwZMdQEeVJM94ioBULMVARCC4CNCnxVf7NNt9gq2C5bXj
         aL/OpmWyGTQRKXNCmzMdOTA8x3s6atIi3YYqkwp3fK4zzvA8v13GEYY8/qodqqKmaB3x
         yBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=eXzeR1+cGQUVVXBaqZKE3rMR1MzqWVxS5JHQsCEePsM=;
        b=dPOI0fiO1tiWyP4OIt2X+GH0Lmw3JNa4USrJaGMZFo2sC3t2/JMFGooC9bpIi6b0E9
         E98DLWmeeS0NIjcLh879Fs9kQh7AyBFfd1hc81fnbJbAKL5tIh7Gauqyxb+Gn5rCRy+k
         tuPGEKq580VbEMMlM0ONPjiRNSszxqOAdPlQbaCK4Ngg2fdBZ4hS5Go1Z32B722GeQ97
         K2s76cglIug9j3XYwAuQ7950SyXcJ8XHpfgYjdp5pVBeCbyQztfYh79qH4z6g1dKX8wV
         YxZ2XzApTxX7F8WJXNpUjYdXFtRdSvRoKhnVj+L+UW+6wCdjIwLuAqcUyam1jyF376Ly
         CyjQ==
X-Gm-Message-State: AOAM533DTbvh9A6TusMQU9UQbIuvQylgO+O1QHJTHErKx/b/XTLaVmSA
        WKmpOp24LAVEo2qvxSSQE8ErZFNDcSMQfQ==
X-Google-Smtp-Source: ABdhPJzQK+Um3FGCo9bMP16vROT/Ml94UESgAYy8jyt8rODKzKDLRmO1bLYMpMsCPLtaNNQqO3wndA==
X-Received: by 2002:a05:6e02:1749:: with SMTP id y9mr3390541ill.278.1635282061895;
        Tue, 26 Oct 2021 14:01:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y6sm11707805ilu.70.2021.10.26.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:01:01 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:01:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH v2 0/9] midx: clean up t5319 under 'SANITIZE=leak'
Message-ID: <cover.1635282024.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small-ish update to my series which makes t5319 leak-free (i.e., it
passes even when Git is compiled with SANITIZE=leak). It is based on
ab/only-single-progress-at-once (so I dropped the cherry-picked patch towards
the end from Ævar).

Most of the fixes are straightforward from review, but the biggest change is in
7/10, which converts get_midx_filename() to write its result to a strbuf per
Junio's helpful suggestion.

Thinking ahead, there are a few things I noted while reading through replies for
future improvements to the MIDX and pack bitmap code. From my ~/notes, they are:

  - load_multi_pack_index() should not die when missing the packfile names chunk,
    instead should pretend that no MIDX exists (maybe warn?)
  - double-close when reaching the cleanup_fail codepath after xmmap returns
  - static `verify_midx_error` is ugly
  - load_bitmap() does not clean up after itself very well (e.g.,
    bitmap_git->trees and others)

I'm pretty happy with the state of this topic, and I'll plan on taking on the
above in separate series in the future.

Taylor Blau (9):
  midx.c: clean up chunkfile after reading the MIDX
  midx.c: don't leak MIDX from verify_midx_file
  t/helper/test-read-midx.c: free MIDX within read_midx_file()
  builtin/pack-objects.c: don't leak memory via arguments
  builtin/repack.c: avoid leaking child arguments
  builtin/multi-pack-index.c: don't leak concatenated options
  midx.c: write MIDX filenames to strbuf
  pack-bitmap.c: don't leak type-level bitmaps
  pack-bitmap.c: more aggressively free in free_bitmap_index()

 builtin/multi-pack-index.c |  4 +++
 builtin/pack-objects.c     | 11 ++++---
 builtin/repack.c           | 23 +++++++++----
 midx.c                     | 66 ++++++++++++++++++++++----------------
 midx.h                     |  4 +--
 pack-bitmap.c              | 29 ++++++++++++++---
 pack-revindex.c            |  8 ++---
 t/helper/test-read-midx.c  |  3 +-
 8 files changed, 97 insertions(+), 51 deletions(-)

Range-diff against v1:
 1:  30f6f23daf =  1:  dcc5998072 midx.c: clean up chunkfile after reading the MIDX
 2:  b0c79904ab !  2:  258a9e2e57 midx.c: don't leak MIDX from verify_midx_file
    @@ Metadata
      ## Commit message ##
         midx.c: don't leak MIDX from verify_midx_file
     
    -    The function midx.c:verify_midx_file() allocate a MIDX struct by calling
    -    load_multi_pack_index(). But when cleaning up, it calls free() without
    -    freeing any resources associated with the MIDX.
    +    The function midx.c:verify_midx_file() allocates a MIDX struct by
    +    calling load_multi_pack_index(). But when cleaning up, it calls free()
    +    without freeing any resources associated with the MIDX.
     
         Call the more appropriate close_midx() which does free those resources,
         which causes t5319.3 to pass when Git is compiled with SANITIZE=leak.
 3:  5157edb41e =  3:  84859d5b53 t/helper/test-read-midx.c: free MIDX within read_midx_file()
 4:  dd3b9a949e =  4:  aedb1713b4 builtin/pack-objects.c: don't leak memory via arguments
 5:  a68c77c006 !  5:  bcd12ecab8 builtin/repack.c: avoid leaking child arguments
    @@ Commit message
         In none of these cases do we bother to call child_process_clear(), which
         frees the memory associated with each child's arguments and environment.
     
    -    In order to do so, tweak each function that spawns a child process to
    -    have a `cleanup` label that we always visit before returning from each
    -    function. Then, make sure that we call child_process_clear() as a part
    -    of that label.
    +    Make sure that we call child_process_clear() in any functions which
    +    initialize a struct child_process before returning along a path which
    +    did not call finish_command().
    +
    +    In cmd_repack(), take a slightly different approach to use a cleanup
    +    label to clear the child_process, unless finish_command() was called.
    +    This allows us to free other memory allocated during the lifetime of
    +    that function. But it avoids calling child_process_clear() twice (the
    +    other call coming from inside of finish_command()) to avoid assuming the
    +    function's implementation is idempotent.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/repack.c ##
     @@ builtin/repack.c: static void repack_promisor_objects(const struct pack_objects_args *args,
    - 	struct child_process cmd = CHILD_PROCESS_INIT;
    - 	FILE *out;
    - 	struct strbuf line = STRBUF_INIT;
    -+	int ret = 0;
    + 	for_each_packed_object(write_oid, &cmd,
    + 			       FOR_EACH_OBJECT_PROMISOR_ONLY);
      
    - 	prepare_pack_objects(&cmd, args);
    - 	cmd.in = -1;
    -@@ builtin/repack.c: static void repack_promisor_objects(const struct pack_objects_args *args,
    - 
    - 	if (cmd.in == -1)
    +-	if (cmd.in == -1)
    ++	if (cmd.in == -1) {
      		/* No packed objects; cmd was never started */
    --		return;
    -+		goto cleanup;
    ++		child_process_clear(&cmd);
    + 		return;
    ++	}
      
      	close(cmd.in);
      
    -@@ builtin/repack.c: static void repack_promisor_objects(const struct pack_objects_args *args,
    - 		free(promisor_name);
    - 	}
    - 	fclose(out);
    --	if (finish_command(&cmd))
    -+	ret = finish_command(&cmd);
    -+
    -+cleanup:
    -+	child_process_clear(&cmd);
    -+
    -+	if (ret)
    - 		die(_("could not finish pack-objects to repack promisor objects"));
    - }
    - 
    -@@ builtin/repack.c: static int write_midx_included_packs(struct string_list *include,
    - 	struct string_list_item *item;
    - 	struct packed_git *largest = get_largest_active_pack(geometry);
    - 	FILE *in;
    --	int ret;
    -+	int ret = 0;
    - 
    - 	if (!include->nr)
    --		return 0;
    -+		goto cleanup;
    - 
    - 	cmd.in = -1;
    - 	cmd.git_cmd = 1;
     @@ builtin/repack.c: static int write_midx_included_packs(struct string_list *include,
    + 		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
      
      	ret = start_command(&cmd);
    - 	if (ret)
    --		return ret;
    -+		goto cleanup;
    +-	if (ret)
    ++	if (ret) {
    ++		child_process_clear(&cmd);
    + 		return ret;
    ++	}
      
      	in = xfdopen(cmd.in, "w");
      	for_each_string_list_item(item, include)
    - 		fprintf(in, "%s\n", item->string);
    - 	fclose(in);
    - 
    --	return finish_command(&cmd);
    -+	ret = finish_command(&cmd);
    -+
    -+cleanup:
    -+	child_process_clear(&cmd);
    -+
    -+	return ret;
    - }
    - 
    - int cmd_repack(int argc, const char **argv, const char *prefix)
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
      	struct pack_geometry *geometry = NULL;
      	struct strbuf line = STRBUF_INIT;
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     +	int i, ext, ret = 0;
      	FILE *out;
      	int show_progress = isatty(2);
    ++	int cmd_cleared = 0;
      
    + 	/* variables to be filled by option parsing */
    + 	int pack_everything = 0;
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
      
      	ret = start_command(&cmd);
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      	if (geometry) {
      		FILE *in = xfdopen(cmd.in, "w");
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    + 	}
      	fclose(out);
      	ret = finish_command(&cmd);
    ++	cmd_cleared = 1;
      	if (ret)
     -		return ret;
     +		goto cleanup;
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      	string_list_clear(&existing_kept_packs, 0);
      	clear_pack_geometry(geometry);
      	strbuf_release(&line);
    -+	child_process_clear(&cmd);
    ++	if (!cmd_cleared)
    ++		child_process_clear(&cmd);
      
     -	return 0;
     +	return ret;
 6:  ffded80c7d =  6:  0d252cd323 builtin/multi-pack-index.c: don't leak concatenated options
 7:  f3897c3afc <  -:  ---------- pack-bitmap.c: avoid leaking via midx_bitmap_filename()
 -:  ---------- >  7:  0f293ab638 midx.c: write MIDX filenames to strbuf
 8:  29920e7735 =  8:  77a4454632 pack-bitmap.c: don't leak type-level bitmaps
 9:  e65ac7deb5 !  9:  c1e7e6cc92 pack-bitmap.c: more aggressively free in free_bitmap_index()
    @@ Commit message
         The function free_bitmap_index() is somewhat lax in what it frees. There
         are two notable examples:
     
    -      - While it does call kh_destroy_oid_map on the "bitmaps" map (which
    -        maps) commit OIDs to their corresponding bitmaps, the bitmaps
    +      - While it does call kh_destroy_oid_map on the "bitmaps" map, which
    +        maps commit OIDs to their corresponding bitmaps, the bitmaps
             themselves are not freed. Note here that we recycle already-freed
             ewah_bitmaps into a pool, but these are handled correctly by
             ewah_pool_free().
10:  cb30aa67c0 <  -:  ---------- pack-bitmap-write.c: don't return without stop_progress()
11:  f1bb8b73ff <  -:  ---------- t5319: UNLEAK() the remaining leaks
-- 
2.33.0.96.g73915697e6
