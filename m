Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D1C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244710AbiCWOUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244695AbiCWOUU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:20:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5540F7C799
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so33651wms.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCxgYGY5sx044c3hn7+9Re/0syPBMtAsicc7ETFjbG4=;
        b=cRlOfryIQNmgoIUjrVyxnp30ZzMqcG/mSwDtucidlJ75Ip4jUqgXOzQ77FyZIIgcwg
         dIfFl3zYStP+l2UshRv6C1Z5bSPxe2rYK1nY6BIL8bvNIdAdJ4lyI8kHVoFKR3EHvNbq
         LV79mQ1wcl9tf728HpNPJDmvNjnGTK1HNCvc1zSRNuFCCqO8Hdf7hoGVUeDsoMFeyHd0
         0E0E8CCTsGLmyt5zVGLqSCkLerw+7lVB3OXKXAz91cxEQWmI3X1hSuaJm8DUTKPiVZul
         43T7q7deAlb9imd11vhVvC0bTR5C+Xi09AsOyB3AE8EtQ+i5woOs7LZ/k9XEEEgnQUNd
         HhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCxgYGY5sx044c3hn7+9Re/0syPBMtAsicc7ETFjbG4=;
        b=noqfyin+dIw8BaunMCR9WpiVllFNDplaWWMOBL63daFMMnMGKYVcFGGB8rSQlgiJhn
         nsHMTkVLmUdj44Inpg1I8zqkDn1Now4dwWGm98w7AGovbEITSj1I/M6xHVnr5m1H+68J
         yclhsKzvgUPwIoupbhTYBFvL+magkrIyxY+BIpoOwO0spWNy1I/b/W/Ri5x1uKBAgeLc
         6iQElC1BGwUX8bqJChbrAC00b9D9ifelTP0iZb0cecqRyCwaimd1nrMWMCYUajXIWGcz
         R/5FBH3E2hm3hfhNOekSRFUG7awjVBaypJUGPPPzFDzRGqIDB4risLlQ68I3SChTlXGk
         gyeQ==
X-Gm-Message-State: AOAM532ArARvKd0T/MJQbAILHG0/Uzb1dPPD/ueqELyQNkMsZ/6KaEhP
        3VAT8p3OC734rnBh+6cm8+E/R3Q0ldBXwA==
X-Google-Smtp-Source: ABdhPJw/Nci8rhY+tEroNZmZsQkF+JLBC3snTrSCJih8MhibpH1SltOCsqdLQsrUXYcEyziAnFXokg==
X-Received: by 2002:a05:600c:1f17:b0:38b:b2b3:9faa with SMTP id bd23-20020a05600c1f1700b0038bb2b39faamr9678652wmb.190.1648045127547;
        Wed, 23 Mar 2022 07:18:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm30592wmq.46.2022.03.23.07.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:18:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 4/7] update-index: have the index fsync() flush the loose objects
Date:   Wed, 23 Mar 2022 15:18:28 +0100
Message-Id: <RFC-patch-v2-4.7-61f4f3d7ef4-20220323T140753Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
References: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com> <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with unpack-objects in a preceding commit have update-index.c make
use of the HASH_N_OBJECTS{,_{FIRST,LAST}} flags. We now have a "batch"
mode again for "update-index".

Adding the t/* directory from git.git on a Linux ramdisk is a bit
faster than with the tmp-objdir indirection:

	$ git hyperfine -L rev ns/batched-fsync,HEAD -s 'make CFLAGS=-O3 && rm -rf repo && git init repo && cp -R t repo/ && git ls-files -- t >repo/.git/to-add.txt' -p 'rm -rf repo/.git/objects/* repo/.git/index' './git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' --warmup 1 -r 10Benchmark 1: ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'ns/batched-fsync
	  Time (mean ± σ):     281.1 ms ±   2.6 ms    [User: 186.2 ms, System: 92.3 ms]
	  Range (min … max):   278.3 ms … 287.0 ms    10 runs

	Benchmark 2: ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'HEAD
	  Time (mean ± σ):     265.9 ms ±   2.6 ms    [User: 181.7 ms, System: 82.1 ms]
	  Range (min … max):   262.0 ms … 270.3 ms    10 runs

	Summary
	  './git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'HEAD' ran
	    1.06 ± 0.01 times faster than './git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'ns/batched-fsync'

And as before running that with "strace --summary-only" slows things
down a bit (probably mimicking slower I/O a bit). I then get:

	Summary
	  'strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'HEAD' ran
	    1.19 ± 0.03 times faster than 'strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'ns/batched-fsync'

This one has a twist though, instead of fsync()-ing on the last object
we write we'll not do that, and instead defer the fsync() until we
write the index itself. This is outlined in [1] (as "METHOD THREE").

Because of this under FSYNC_METHOD_BATCH we'll do the N
objects (possibly only one, because we're lazy) as HASH_N_OBJECTS, and
we'll even now support doing this via N arguments on the command-line.

Then we won't fsync() any of it, but we will rename it
in-place (which, if we were still using the tmp-objdir, would leave it
"staged" in the tmp-objdir).

We'll then have the fsync() for the index update "flush" that out, and
thus avoid two fsync() calls when one will do.

Running this with the "git hyperfine" command mentioned in a preceding
commit with "strace --summary-only" shows that we do 1 fsync() now
instead of 2, and have one more sync_file_range(), as expected.

We also go from ~51k syscalls to ~39k, with ~2x the number of link()
and unlink() in ns/batched-fsync, and of course one fsync() instead of
two()>

The flow of this code isn't quite set up for re-plugging the
tmp-objdir back in. In particular we no longer pass
HASH_N_OBJECTS_FIRST (but doing so would be trivial)< and there's no
HASH_N_OBJECTS_LAST.

So this and other callers would need some light transaction-y API, or
to otherwise pass down a "yes, I'd like to flush it" down to
finalize_hashfile(), but doing so will be trivial.

And since we've started structuring it this way it'll become easy to
do any arbitrary number of things down the line that would "bulk
fsync" before the final fsync(). Now we write some objects and fsync()
on the index, but between those two could do any number of other
things where we'd defer the fsync().

This sort of thing might be especially interesting for "git repack"
when it writes e.g. a *.bitmap, *.rev, *.pack and *.idx. In that case
we could skip the fsync() on all of those, and only do it on the *.idx
before we renamed it in-place. I *think* nothing cares about a *.pack
without an *.idx, but even then we could fsync *.idx, rename *.pack,
rename *.idx and still safely do only one fsync(). See "git show
--first-parent" on 62874602032 (Merge branch
'tb/pack-finalize-ordering' into maint, 2021-10-12) for a good
overview of the code involved in that.

1. https://lore.kernel.org/git/220323.86sfr9ndpr.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/update-index.c |  7 ++++---
 cache.h                |  1 +
 read-cache.c           | 29 ++++++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 34aaaa16c20..6cfec6efb38 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1142,7 +1142,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
-			update_one(p, 0);
+			update_one(p, HASH_N_OBJECTS);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
 			free(p);
@@ -1187,7 +1187,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			update_one(p, 0);
+			update_one(p, HASH_N_OBJECTS);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
 			free(p);
@@ -1263,7 +1263,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				exit(128);
 			unable_to_lock_die(get_index_file(), lock_error);
 		}
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(&the_index, &lock_file,
+				       COMMIT_LOCK | WLI_NEED_LOOSE_FSYNC))
 			die("Unable to write new index file");
 	}
 
diff --git a/cache.h b/cache.h
index 2f3831fa853..7542e009a34 100644
--- a/cache.h
+++ b/cache.h
@@ -751,6 +751,7 @@ void ensure_full_index(struct index_state *istate);
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
 #define SKIP_IF_UNCHANGED	(1 << 1)
+#define WLI_NEED_LOOSE_FSYNC	(1 << 2)
 
 /*
  * Write the index while holding an already-taken lock. Close the lock,
diff --git a/read-cache.c b/read-cache.c
index 3e0e7d41837..275f6308c32 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2860,6 +2860,33 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
+	unsigned int wflags = FSYNC_COMPONENT_INDEX;
+
+
+	/*
+	 * TODO: This is abuse of the API recently modified
+	 * finalize_hashfile() which reveals a shortcoming of its
+	 * "fsync" design.
+	 * 
+	 * I.e. It expects a "enum fsync_component component" label,
+	 * but here we're passing it an OR of the two, knowing that
+	 * it'll call fsync_component_or_die() which (in
+	 * write-or-die.c) will do "(fsync_components & wflags)" (to
+	 * our "wflags" here).
+	 *
+	 * But the API really should be changed to explicitly take
+	 * such flags, because in this case we'd like to fsync() the
+	 * index if we're in the bulk mode, *even if* our
+	 * "core.fsync=index" isn't configured.
+	 *
+	 * That's because at this point we've been queuing up object
+	 * writes that we didn't fsync(), and are going to use this
+	 * fsync() to "flush" the whole thing. Doing it this way
+	 * avoids redundantly calling fsync() twice when once will do.
+	 */
+	if (fsync_method == FSYNC_METHOD_BATCH && 
+	    flags & WLI_NEED_LOOSE_FSYNC)
+		wflags |= FSYNC_COMPONENT_LOOSE_OBJECT;
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
@@ -3094,7 +3121,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (!alternate_index_output && (flags & COMMIT_LOCK))
 		csum_fsync_flag = CSUM_FSYNC;
 
-	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
+	finalize_hashfile(f, istate->oid.hash, wflags,
 			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
 
 	if (close_tempfile_gently(tempfile)) {
-- 
2.35.1.1428.g1c1a0152d61

