Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2B4C433ED
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 14:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF58610CB
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 14:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhDROA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 10:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhDROA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 10:00:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B403C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 06:59:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id bx20so36440390edb.12
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLxcTgfSERz0VXtTTuFGcs90rc2UFSN/3EYVKjbO1Cs=;
        b=nXm+sO1c7oKvz1bEpc2EkN//8YUbwN9HfRp5SrjhlWgiBHsp1pfPhEYQwtSM4riBjl
         +HxUrtYlF6UgTKlFrvhEoIicsEfm2aD9Yg/ufUA9AfXncO1A4PUFETUgvfUZzAPdAPC0
         HMnznZJAJr7LoDaMidm/0T4IEbknAjyzMH2/wavJR8slVvqZVJP64AZ1X4j2CQRQRUGD
         xDk95cWmCiWrvxNru1SvBHzOIHR1n2QfsjYGYtZQwXNAR+DtQeFCi9UWSj++fCRmeamu
         qEXXjAs1Syuf2jRlhpNJJrwtGrVwvGC2hhrbZFMJxZ4TfhGFSFhqm0VumdL5FLiX+unt
         AmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLxcTgfSERz0VXtTTuFGcs90rc2UFSN/3EYVKjbO1Cs=;
        b=Jl9BKFU3s7P+u1jCSIRQCEq+iuPEy+z4GW7LGhhMIg7R2XGiBJdX9K8ecVlALrnSkm
         YdbHvDUg3a8FZoTBxwuLHi9s9uy6iWqoAvpl/AIt6igSi2oZCarhmZk/awCATz123UPA
         hd1WRKpCuegaU9UrmjG6L3tQtvObPtRpiLDriPES0cRw6CuKzRISskT18pEbeoQaSqoM
         PQXv7kccOkr/pbSt+hu0xFfWIJDTUC8IELiH/pLcpM0hr9/gUpHYsHtsF3W1Z/1l1yTt
         v4fYtD4Al0LMlgicBTmA/msikPPBkHMg38jQsu2z7vljnm9q32sUS36RwiMgYTR2M/xk
         /wwQ==
X-Gm-Message-State: AOAM533WmqcZvOzjvrS6sMNge9z7AxPh1KBllHoWlNqof32TSbbVTUy8
        vFmnzMnQ4Wqsl6/LkOEx8xMtKMFgPMCTgZmo
X-Google-Smtp-Source: ABdhPJz/sZXbgiV5jaYCNNPmxoAI5SU3Hk0MXer7n5WepVTftwgS3B7J+2qnDz5uTSuunxo6Q6kgmA==
X-Received: by 2002:a05:6402:51d4:: with SMTP id r20mr20535656edd.112.1618754397596;
        Sun, 18 Apr 2021 06:59:57 -0700 (PDT)
Received: from localhost.localdomain ([79.140.115.143])
        by smtp.gmail.com with ESMTPSA id w13sm9823415edx.80.2021.04.18.06.59.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Apr 2021 06:59:56 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 0/1] prevent `repack` to unpack and delete promisor objects
Date:   Sun, 18 Apr 2021 15:57:48 +0200
Message-Id: <20210418135749.27152-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.31.0.699.g8849f49b87
In-Reply-To: <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
References: <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's the v2, sorry for the delay.

This series is built on top of jk/promisor-optim (now graduated to next). It
conflicts with changes on p5600 otherwise.

The following patches fixes the issue where we unnecessarily turn loose
all the promisor objects and deletes them right after when running
`git repack -A -d ..` (via `git gc) for a partial repository. 

Special thanks to Peff, for proposing a better approach for managing
the situation and for Jonathan Tan for earlier interaction on the
solution. Previously, I thought we should skip the promisor objects
by just adding a check in loosened_object_can_be_discarded(). However,
Peff pointed out that we can do better by realizing much sooner that
we should not even consider loosening the objects for the _old_ promisor
packs.

===============
Changes from v1:

    * v2 contains only patch instead of two from the previous round.

    * I include Jonathan's suggestion throughout the entire patch, most
      notably the commit message that was confused and a misleading. Sorry
      for that. Special thanks to him for helping suggesting a _much better_
      commit message among other suggested improvements and corrections.

    * The [Patch 1/2] from v1 is dropped. It was adding a user-visible
      option to `repack` in order to skip the call to `prune-packed` and
      prevent destroying the evidence of the bug so it can be tested.
      However, Peff raised some concerns about adding a user-visible option
      (that is unclear whether the user will ever want) just for the sake
      of testing it - honestly, I wasn't too happy with this either. In v2, we
      now teach `pack-objects` to count the objects of interest
      (loosened objects) and emit this information via trace2, which allows
      checking the debugging logging for the evidence.

    * Test is modified to rely on the the added trace2 event information.

    * Updates on the performance numbers, including adding one execution
      for a bigger repository (linux.git).

Even though the v2 is 1-patch long, I thought it make thing clear to read if
a re-send the cover-letter as the [Patch v2 1/1] is already a bit lengthy,
and explaining the whole story here.

Rafael Silva (1):
  repack: avoid loosening promisor objects in partial clones

 builtin/pack-objects.c        | 8 +++++++-
 builtin/repack.c              | 9 +++++++--
 t/perf/p5600-partial-clone.sh | 4 ++++
 t/t5616-partial-clone.sh      | 8 ++++++++
 4 files changed, 26 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  2431f8b75d < -:  ---------- repack: teach --no-prune-packed to skip `git prune-packed`
2:  1331049a86 ! 1:  9d996393c9 repack: avoid loosening promisor pack objects in partial clones
    @@ Metadata
     Author: Rafael Silva <rafaeloliveira.cs@gmail.com>
     
      ## Commit message ##
    -    repack: avoid loosening promisor pack objects in partial clones
    -
    -    When `-A` and `-d` are used together, besides packing all objects (-A)
    -    and removing redundant packs (-d), it also unpack all unreachable
    -    objects and deletes them by calling `git pruned-packed`. For a partial
    -    clone, that contains unreferenced objects, this results in unpacking
    -    all "promisor" objects and deleting them right after, which
    -    unnecessarily increases the `repack` execution time and disk usage
    -    during the unpacking of the objects.
    -
    -    For instance, a partially cloned repository that filters all the blob
    -    objects (e.g. "--filter=blob:none"), `repack` ends up unpacking all
    -    blobs into the filesystem that, depending on the repo size, makes
    -    nearly impossible to repack the operation before running out of disk.
    -
    -    For a partial clone, `git repack` calls `git pack-objects` twice: (1)
    -    for handle the "promisor" objects and (2) for performing the repack
    -    with --exclude-promisor-objects option, that results in unpacking and
    -    deleting of the objects. Given that we actually should keep the
    -    promisor objects, let's teach `repack` to tell `pack-objects` to
    -    --keep the old "promisor" pack file.
    -
    -    The --keep-pack option takes only a packfile name, but we concatenate
    -    both the path and the name in a single string. Instead, let's split
    -    them into separate string in order to easily pass the packfile name
    -    later.
    -
    -    Additionally, add a new perf test to evaluate the performance
    -    impact made by this changes (tested on git.git):
    -
    -        Test            HEAD^                 HEAD
    -        ------------------------------------------------------------
    -        5600.5: gc      137.67(42.48+93.64)   8.08(6.91+1.45) -94.1%
    -
    -    In this particular script, the improvement is big because every
    -    object in the newly-cloned partial repository is a promisor object.
    +    repack: avoid loosening promisor objects in partial clones
    +
    +    When `git repack -A -d` is run in a partial clone, `pack-objects`
    +    is invoked twice: once to repack all promisor objects, and once to
    +    repack all non-promisor objects. The latter `pack-objects` invocation
    +    is with --exclude-promisor-objects and --unpack-unreachable, which
    +    loosens all unused objects. Unfortunately, this includes promisor
    +    objects.
    +
    +    Because the -d argument to `git repack` subsequently deletes all loose
    +    objects also in packs, these just-loosened promisor objects will be
    +    immediately deleted. However, this extra disk churn is unnecessary in
    +    the first place.  For example, a newly-clone partial repo that filters
    +    all blob objects (e.g. `--filter=blob:none`), `repack` ends up
    +    unpacking all trees and commits into the filesystem because every
    +    object, in this particular case, is a promisor object. Depending on
    +    the repo size, this increases the disk usage considerably: In my copy
    +    of the linux.git, the object directory peaked 26GB of more disk usage.
    +
    +    In order to avoid this extra disk churn, pass the names of the promisor
    +    packfiles as --keep-pack arguments to the second invocation of
    +    `pack-objects`. This informs `pack-objects` that the promisor objects
    +    are already in a safe packfile and, therefore, do not need to be
    +    loosened. The --keep-pack option takes only a packfile name, but we
    +    concatenate both the path and the name in a single string. Instead,
    +    let's split them into separate string in order to easily pass the
    +    packfile name later.
    +
    +    For testing, we need to validate whether any object was loosened.
    +    However, the "evidence" (loosened objects) is deleted during the
    +    process which prevents us from inspecting the object directory.
    +    Instead, let's teach `pack-objects` to count loosened objects and
    +    emit via trace2 thus allowing inspecting the debug events after the
    +    process is finished. This new event is used on the added regression
    +    test.
    +
    +    Lastly, add a new perf test to evaluate the performance impact
    +    made by this changes (tested on git.git):
    +
    +         Test          HEAD^                 HEAD
    +         ----------------------------------------------------------
    +         5600.3: gc    134.38(41.93+90.95)   7.80(6.72+1.35) -94.2%
    +
    +    For a bigger repository, such as linux.git, the improvement is
    +    even bigger:
    +
    +         Test          HEAD^                     HEAD
    +         -------------------------------------------------------------------
    +         5600.3: gc    6833.00(918.07+3162.74)   268.79(227.02+39.18) -96.1%
    +
    +    These improvements are particular big because every object in the
    +    newly-cloned partial repository is a promisor object.
     
         Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
         Helped-by: Jeff King <peff@peff.net>
    +    Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +
    + ## builtin/pack-objects.c ##
    +@@ builtin/pack-objects.c: static void loosen_unused_packed_objects(void)
    + {
    + 	struct packed_git *p;
    + 	uint32_t i;
    ++	uint32_t loosened_objects_nr = 0;
    + 	struct object_id oid;
    + 
    + 	for (p = get_all_packs(the_repository); p; p = p->next) {
    +@@ builtin/pack-objects.c: static void loosen_unused_packed_objects(void)
    + 			nth_packed_object_id(&oid, p, i);
    + 			if (!packlist_find(&to_pack, &oid) &&
    + 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
    +-			    !loosened_object_can_be_discarded(&oid, p->mtime))
    ++			    !loosened_object_can_be_discarded(&oid, p->mtime)) {
    + 				if (force_object_loose(&oid, p->mtime))
    + 					die(_("unable to force loose object"));
    ++				loosened_objects_nr++;
    ++			}
    + 		}
    + 	}
    ++
    ++	trace2_data_intmax("pack-objects", the_repository,
    ++			   "loosen_unused_packed_objects/loosened", loosened_objects_nr);
    + }
    + 
    + /*
     
      ## builtin/repack.c ##
     @@ builtin/repack.c: static int delta_base_offset = 1;
    @@ t/t5616-partial-clone.sh: test_expect_success 'fetch from a partial clone, proto
      	grep "version 2" trace
      '
      
    -+test_expect_success 'repack does not loose all objects' '
    -+	rm -rf client &&
    ++test_expect_success 'repack does not loosen promisor objects' '
    ++	rm -rf client trace &&
     +	git clone --bare --filter=blob:none "file://$(pwd)/srv.bare" client &&
    -+	test_when_finished "rm -rf client" &&
    -+	git -C client repack -A -l -d --no-prune-packed &&
    -+	git -C client count-objects -v >object-count &&
    -+	grep "^prune-packable: 0" object-count
    ++	test_when_finished "rm -rf client trace" &&
    ++	GIT_TRACE2_PERF="$(pwd)/trace" git -C client repack -A -d &&
    ++	grep "loosen_unused_packed_objects/loosened:0" trace
     +'
     +
      . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
2.31.0.699.g8849f49b87

