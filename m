Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF92C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E8422525
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408868AbgLNTTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408560AbgLNTRq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 14:17:46 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB6C0613D3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:17:06 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w5so13818488wrm.11
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0jEoKCH97+nWF/8mJQniFfc3/Vn4TKkj05rYH77xXs=;
        b=T1j1u/Okq6caQPyQYpXOdfVEi/tQwIfpGrujQCd6xM1w9N50O1geLfXyyPUjiWW5Ew
         6x7sPPZQ1AUSMUMMw5VbRk1F/vKmFraxt6ec1NcTJ6JP4+CNJ1oApb1y2E7TqQt+rQ0+
         9kHHyFRRdqX+Pks5en3zYTabuQj6rxkVMFgkI3d0kNvEpyIyA/j+NXSKNI9QHXrZqJXK
         SMMZFYkcel2u3JsHsfhgU5X5T5lsZA6rm808oQp5eweenRGt0pvJgc3LyOgdbmGHx9SO
         It5DE9rkM9pvyC8bS0AWuigqFx2nWpQg/zmoXmFbQmg/TPUYGELkNRkpZrqnK1IDffP2
         ADgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0jEoKCH97+nWF/8mJQniFfc3/Vn4TKkj05rYH77xXs=;
        b=A1bMNt3rJ5crQBhnUNgokYIJmRYof4AeamRjrSbIi2/Xku3L0lwOAZSfLaBGN+xm9D
         EwlqrSfSRWECGwz7zQOPb73sCw6bUef85Y2W5SkBtNzoPhbs/zcrEFiNbOUDA8/HswR9
         DAEEXM1VqpRf68/G5E0MNH8WcmB22S60n8Puisrti1jKM0n2AAvYOGFf3SRds6i10Ol6
         wOkCOHi9wFoe+cVeUykYpgryE5jUfMCosaeTKcmS0Bz1BSrEZxenVvCHoTc9ODQJskV2
         qgbGbib9ubgv1LdGn/wy8FM+kWR5O5qEdYS5UJrrlb1qeZqm7SzguJYOZHeR8hsv9VKu
         Tcjw==
X-Gm-Message-State: AOAM5302WNcMdQ929fsT68ch2ny76RxxwUyquvKp0u6Q64PytSAOtVeJ
        0q1JI48CQacgbDbQ8RxP2dVFgqgz8DePrg==
X-Google-Smtp-Source: ABdhPJxM53F+X8lHUaNgr3peZXOr6sFpLj9Cr7DpFneIU2PlyG+8jjYHcSiT0de6cZNNOHHoqZ10vw==
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr29764111wrw.129.1607973424729;
        Mon, 14 Dec 2020 11:17:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm32078616wmj.28.2020.12.14.11.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:17:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] warn on non-pseudoref looking .git/<file> refs
Date:   Mon, 14 Dec 2020 20:16:58 +0100
Message-Id: <20201214191700.16405-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201210125321.19456-2-avarab@gmail.com>
References: <20201210125321.19456-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now with a cover letter to show the range-diff. I addressed all of
Eric's comments, and found some other minor issues myself. The check
for whether we need to warn has also been simplified, we just needed
to check if we have "/" in the resolved "r" variable.

Ævar Arnfjörð Bjarmason (2):
  refs: move is_pseudoref_syntax() earlier in the file
  refs: warn on non-pseudoref looking .git/<file> refs

 Documentation/config/core.txt | 11 ++++++++
 cache.h                       |  1 +
 config.c                      |  5 ++++
 environment.c                 |  1 +
 refs.c                        | 50 ++++++++++++++++++++++-------------
 t/t1430-bad-ref-name.sh       | 41 ++++++++++++++++++++++++++++
 6 files changed, 90 insertions(+), 19 deletions(-)

Range-diff:
-:  ----------- > 1:  e86e55f2828 refs: move is_pseudoref_syntax() earlier in the file
1:  cad73aba664 ! 2:  0573da1d381 refs: warn on non-pseudoref looking .git/<file> refs
    @@ Commit message
     
         The refs parsing machinery will first try to parse arbitrary
         .git/<name> for a given <name>, before moving onto refs/<name>,
    -    refs/tags/<name> etc. See "ref_rev_parse_rules" in refs.c, but
    -    e.g. "for-each-ref" and other things that list references ignore these
    -    ancient-style refs.
    +    refs/tags/<name> etc. See "ref_rev_parse_rules" in refs.c. Things that
    +    list references such as "for-each-ref" ignore these on the assumption
    +    that they're pseudorefs such as "HEAD".
     
         Thus if you end up in a repository that contains e.g. .git/master the
         likes of "checkout" can emit seemingly nonsensical error
    @@ Commit message
         .git/MERGE_HEAD and other non-pseudoref looking refs at the top-level.
     
         Let's help the user in this case by doing a very loose check for
    -    whether the ref name looks like a pseudoref such as "HEAD" (i.e. only
    -    has upper case, dashes, underbars), and if not issue a warning:
    +    whether the ref name looks like a special pseudoref such as
    +    "HEAD" (i.e. only has upper case, dashes, underbars), and if not issue
    +    a warning:
     
             $ git rev-parse master
             warning: matched ref .git/master doesn't look like a pseudoref
    @@ Commit message
         instead of "warning" passes with this approach.
     
         Our own test suite makes use of a few refs in .git/ that aren't
    -    produced by git itself, e.g. "FOO", "TESTSYMREFTWO" etc, external
    +    produced by git itself, e.g. "FOO", "TESTSYMREFTWO" etc. External
         tools probably rely on this as well, so I don't think it's viable to
    -    e.g. have a whitelist of "HEAD", "MERGE_HEAD" etc. As an aside that
    -    list is quite large, I counted 12 names used in the C code before I
    -    abandoned that approach.
    +    e.g. have a whitelist of them. That list is quite large just fr
    +    git.git, I counted 12 names used in the C code before I abandoned that
    +    approach.
     
         This approach of checking the case of e.g. "master" is not an issue on
         case-insensitive filesystems, since we're not checking against the
    @@ Commit message
         without warning on that system. Now we'll warn about that.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Modified-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/config/core.txt ##
     @@ Documentation/config/core.txt: core.warnAmbiguousRefs::
    @@ Documentation/config/core.txt: core.warnAmbiguousRefs::
     ++
     +These references are ignored by linkgit:for-each-ref[1], but resolved
     +by linkgit:git-show[1], linkgit:git-rev-parse[1] etc. So it can be
    -+confusing to have e.g. an errant `.git/master` being confused with
    -+`.git/refs/heads/master`.
    ++confusing to have e.g. an errant `.git/mybranch` being confused with
    ++`.git/refs/heads/mybranch`.
     +
      core.compression::
      	An integer -1..9, indicating a default compression level.
    @@ refs.c: int expand_ref(struct repository *repo, const char *str, int len,
      					    this_result, &flag);
      		if (r) {
     +			if (warn_non_pseudo_refs &&
    -+			    !starts_with(fullref.buf, "refs/") &&
    -+			    !starts_with(r, "refs/") &&
     +			    !strchr(r, '/') &&
     +			    !is_any_pseudoref_syntax(r) &&
    -+			    !warned_on_non_pseudo_ref++) {
    -+				/*
    -+				 * TRANSLATORS: The 1st argument is
    -+				 * e.g. "master", and the 2nd can be
    -+				 * e.g. "master~10".
    -+				 */
    -+				warning(_("matched ref name .git/%s doesn't look like a pseudoref"), r);
    -+			}
    ++			    !warned_on_non_pseudo_ref++)
    ++				warning(_(".git/%s doesn't look like a pseudoref"), r);
      			if (!refs_found++)
      				*ref = xstrdup(r);
      			if (!warn_ambiguous_refs)
    @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -m can rename refs/heads/-d
      
     +test_expect_success 'warn on non-pseudoref syntax refs in .git/' '
     +	test_when_finished "
    -+		rm -f .git/mybranch &&
    -+		rm -rf .git/a-dir &&
    -+		rm -rf .git/MY-BRANCH_NAME &&
    -+		rm -rf .git/MY-branch_NAME
    ++		rm -rf .git/mybranch \
    ++			.git/a-dir \
    ++			.git/MY-BRANCH_NAME \
    ++			.git/MY-branch_NAME
     +	" &&
     +
     +	# Setup
    -+	git rev-parse master >expect &&
    ++	git rev-parse HEAD >expect &&
    ++	mkdir .git/a-dir &&
     +
     +	# We ignore anything with slashes
    -+	mkdir .git/a-dir &&
     +	cp expect .git/a-dir/mybranch &&
     +	git rev-parse a-dir/mybranch >hash 2>err &&
     +	test_must_be_empty err &&
    @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -m can rename refs/heads/-d
     +
     +	# We do not ignore lower-case
     +	cp expect .git/mybranch &&
    -+	git rev-parse mybranch >hash 2>err &&
    ++	env GIT_TEST_GETTEXT_POISON=false \
    ++		git rev-parse mybranch >hash 2>err &&
     +	test_cmp expect hash &&
    -+	GIT_TEST_GETTEXT_POISON=false grep "like a pseudoref" err &&
    ++	grep "like a pseudoref" err &&
     +	git -c core.warnNonPseudoRefs=false rev-parse mybranch >hash 2>err &&
     +	test_cmp expect hash &&
    -+	test_must_be_empty err &&
    -+	rm .git/mybranch
    ++	test_must_be_empty err
     +'
     +
      test_done
-- 
2.29.2.222.g5d2a92d10f8

