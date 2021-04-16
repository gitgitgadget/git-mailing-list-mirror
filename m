Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27126C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 12:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29B9611AF
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 12:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhDPMub (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbhDPMu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 08:50:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111ADC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 05:50:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k26so10172501wrc.8
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J0a72htlgp12YciO2KxVeNFTf7g9IquoFxLDE7QLQa0=;
        b=uIgeRlpwS0SMezE2UE3fjsKMP8Alzx6WsAH+tkpjvPSGURCEJIU/MKGJrFeDAmv4px
         G9Wybxd2K1c3hfEcMgARIRkNY10VryAnGb+Nv7Jg2QvBnpsOvy05xwnU9sGR3yQH8Waz
         NsgOpcmWV4h+cm9QYdgcfuIqR5XFGa2E3m/OKZLDSdNNxuyjIJ2UNsX2W/I6F7UgtOB0
         f2v32RvIb4rn7wXZlVwltMrcS+yyLY44DfO/V28D3Dku4NFy3D6jRRJ/7XGTcMVYyGAY
         cZMH/lbqwUgQUpt8Dv/CvMMpED5O+X3FPzoEliEvn0gz52yEGWM6RK2wW6GA58g9qptd
         jSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J0a72htlgp12YciO2KxVeNFTf7g9IquoFxLDE7QLQa0=;
        b=jBnuIznebkV+U2SxffUbo1B5m6Fei/SEjvgs5COusCG2QICjfzCxZDMqQcz/wBhCmF
         Cc75RuuPZmuRE/9dEQzoic88wAtG2hGUPONW7dBE6PD0plG5NVHeEfImMeN/4gyE49lg
         Z9sfuUtyVyPIz65Vd7cTIkARaOnPPiiGOjisSfH4GMpc18+XhknxHfzhOyatjGDKzjRw
         PAvHcRs/V6jaIkm3DhTsD8JgptHglE3kasIAY5SYZks+pM2P5yxcitQkLqcN1Kyeonm1
         wZOhGutQiB9KBqYIEDqCunNZRPGNrm2oJpw0uSDAnFjB/aSV/NxQ39CRVwoGufw6qqpF
         izwg==
X-Gm-Message-State: AOAM531z2vE9BtwsISmFmYcB+FcFJy0zjb7pJNEbrCks6bAQkOOX41ad
        UfPm2okifk1qSD96rBJbswAEZxQwITU=
X-Google-Smtp-Source: ABdhPJygZBDqUT/uJcRIzvnvNlADKydu02Qi+ii92aIpH0o2LIZd/lQjnd1oCoxYSMw0BCzMH3LSaw==
X-Received: by 2002:adf:b642:: with SMTP id i2mr8713496wre.8.1618577400807;
        Fri, 16 Apr 2021 05:50:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm7643797wrt.0.2021.04.16.05.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 05:50:00 -0700 (PDT)
Message-Id: <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
References: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Apr 2021 12:49:55 +0000
Subject: [PATCH v4 0/4] Maintenance: adapt custom refspecs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tom Saeger rightly pointed out [1] that the prefetch task ignores custom
refspecs. This can lead to downloading more data than requested, and it
doesn't even help the future foreground fetches that use that custom
refspec.

[1]
https://lore.kernel.org/git/20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com/

This series fixes this problem by carefully replacing the start of each
refspec's destination with "refs/prefetch/". If the destination already
starts with "refs/", then that is replaced. Otherwise "refs/prefetch/" is
just prepended.

This happens inside of git fetch when a --prefetch option is given. This
allows us to maniuplate a struct refspec_item instead of a full refspec
string. It also simplifies our logic in testing the prefetch task.


Updates in V4
=============

 * Two bugs were fixed. Thanks, Ramsay and Tom, for pointing out the issues.
   Tests are added that prevent regressions.
 * A new patch is added to respect remote.<name>.skipFetchAll. This is added
   at the end to take advantage of the simpler test design after --prefetch
   is added.


Update in V3
============

 * The fix is almost completely rewritten as an update to 'git fetch'. See
   the new PATCH 2 for this update.

 * There was some discussion of rewriting test_subcommand, but that can be
   delayed until a proper solution is found to complications around softer
   matches.


Updates in V2
=============

Thanks for the close eye on this series. I appreciate the recommendations,
which I believe I have responded to them all:

 * Fixed typos.
 * Made refspec_item_format() re-entrant. Consumers must free the buffer.
 * Cleaned up style (quoting and tabbing).

Thanks, -Stolee

Derrick Stolee (4):
  maintenance: simplify prefetch logic
  fetch: add --prefetch option
  maintenance: use 'git fetch --prefetch'
  maintenance: respect remote.*.skipFetchAll

 Documentation/fetch-options.txt   |  5 +++
 Documentation/git-maintenance.txt |  6 ++--
 builtin/fetch.c                   | 59 ++++++++++++++++++++++++++++++-
 builtin/gc.c                      | 39 +++++++-------------
 t/t5582-fetch-negative-refspec.sh | 43 ++++++++++++++++++++++
 t/t7900-maintenance.sh            | 22 +++++++-----
 6 files changed, 134 insertions(+), 40 deletions(-)


base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-924%2Fderrickstolee%2Fmaintenance%2Frefspec-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-924/derrickstolee/maintenance/refspec-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/924

Range-diff vs v3:

 1:  4c0e983ba56f = 1:  4c0e983ba56f maintenance: simplify prefetch logic
 2:  7f488eea6dbd ! 2:  73b4e8496746 fetch: add --prefetch option
     @@ Commit message
          Finally, we add the 'force' option to ensure that prefetch refs are
          replaced as necessary.
      
     +    There are some interesting cases that are worth testing.
     +
     +    An earlier version of this change dropped the "i--" from the loop that
     +    deletes a refspec item and shifts the remaining entries down. This
     +    allowed some refspecs to not be modified. The subtle part about the
     +    first --prefetch test is that the "refs/tags/*" refspec appears directly
     +    before the "refs/heads/bogus/*" refspec. Without that "i--", this
     +    ordering would remove the "refs/tags/*" refspec and leave the last one
     +    unmodified, placing the result in "refs/heads/*".
     +
     +    It is possible to have an empty refspec. This is typically the case for
     +    remotes other than the origin, where users want to fetch a specific tag
     +    or branch. To correctly test this case, we need to further remove the
     +    upstream remote for the local branch. Thus, we are testing a refspec
     +    that will be deleted, leaving nothing to fetch.
     +
     +    Helped-by: Tom Saeger <tom.saeger@oracle.com>
     +    Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/fetch-options.txt ##
     @@ builtin/fetch.c: static void find_non_local_tags(const struct ref *refs,
      +				rs->raw[j - 1] = rs->raw[j];
      +			}
      +			rs->nr--;
     ++			i--;
      +			continue;
      +		}
      +
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       	if (rs->nr) {
       		struct refspec *fetch_refspec;
       
     +@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 			if (has_merge &&
     + 			    !strcmp(branch->remote_name, remote->name))
     + 				add_merge_config(&ref_map, remote_refs, branch, &tail);
     +-		} else {
     ++		} else if (!prefetch) {
     + 			ref_map = get_remote_ref(remote_refs, "HEAD");
     + 			if (!ref_map)
     + 				die(_("Couldn't find remote ref HEAD"));
      
       ## t/t5582-fetch-negative-refspec.sh ##
      @@ t/t5582-fetch-negative-refspec.sh: test_expect_success "push with matching +: and negative refspec" '
     @@ t/t5582-fetch-negative-refspec.sh: test_expect_success "push with matching +: an
       
      +test_expect_success '--prefetch correctly modifies refspecs' '
      +	git -C one config --unset-all remote.origin.fetch &&
     -+	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
      +	git -C one config --add remote.origin.fetch ^refs/heads/bogus/ignore &&
     ++	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
      +	git -C one config --add remote.origin.fetch "refs/heads/bogus/*:bogus/*" &&
      +
      +	git tag -a -m never never-fetch-tag HEAD &&
     @@ t/t5582-fetch-negative-refspec.sh: test_expect_success "push with matching +: an
      +	git -C one rev-parse refs/prefetch/bogus/fetched &&
      +	test_must_fail git -C one rev-parse refs/prefetch/bogus/ignore
      +'
     ++
     ++test_expect_success '--prefetch succeeds when refspec becomes empty' '
     ++	git checkout bogus/fetched &&
     ++	test_commit extra &&
     ++
     ++	git -C one config --unset-all remote.origin.fetch &&
     ++	git -C one config --unset branch.main.remote &&
     ++	git -C one config remote.origin.fetch "+refs/tags/extra" &&
     ++	git -C one config remote.origin.skipfetchall true &&
     ++	git -C one config remote.origin.tagopt "--no-tags" &&
     ++
     ++	git -C one fetch --prefetch
     ++'
      +
       test_done
 3:  ed055d772452 = 3:  565ed8a18929 maintenance: use 'git fetch --prefetch'
 -:  ------------ > 4:  92652fd9e6e1 maintenance: respect remote.*.skipFetchAll

-- 
gitgitgadget
