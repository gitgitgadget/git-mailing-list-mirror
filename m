Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBC5EB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 17:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbjFMRk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbjFMRkK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 13:40:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4EB92
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:40:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb2202e0108so7764349276.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686678008; x=1689270008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCvQSax/M6rNCGJpsd+8MhduTOwID7vOjT38OSx9zbE=;
        b=RLV06Q5rjGV39TjTtiMo7CgdJX+BzZCOXDGcMNlCbGGpcKSoRbnsvE1bOV8NsCt+ju
         lmI1HWPhPQtO+HcQNbaj3AgYFLzVbu2JNZHAIFiW5PUqPY5LOEvMsDxrlzlWu9QshzQX
         +6V08gPcRev0VL/74s5WuNBz+7HyjM9ofIdOgc/5xXFaANe73nU5QwcsEge2PLrcDm2V
         EI5FDR/r3HMxrpj162zUNzoLuJNF2AJa653koi0ErWf2ld8Q+2WR6b4ehLJfZAkHwFIl
         Ux3t/7syBDMW47W8t8B1ICqcH7lWdP0GHNQNa6ZvsUGpx1NVcuHM20QbZEEtVcbPaycs
         /NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678008; x=1689270008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCvQSax/M6rNCGJpsd+8MhduTOwID7vOjT38OSx9zbE=;
        b=hTH7XLxOtoPkbbJx1/5uOa8I+LO5n/JcEU5weKNFNleyBQwo5wlwvQRSk8q4Kc6UP0
         sIaf10ui1+wyFiTcPy8eKYrMzLus440VNkzVulJkdr35xS1/9xiMmlMm3PXxpA7CU+cr
         urhZKiFPMT8vT9MwU5Ip8y/ujfET4VhDVEcyn1IsKuzFmWSZgZNA3uAR0m4+S3H8xV66
         Sf+i9DLrhXnrF+MgTCDfCfcXeZO29GIoR6g8tWO+qiDFOqI7exhZtMC5VmrNL9KJ4OO4
         jYEHnGOuI1bEY5R/2sq47bAOQ7wM9MjvNik8rVJCz3Kt3AJjucxpG+HxVgLbTzpiqYRl
         BSyQ==
X-Gm-Message-State: AC+VfDydqqH3dlxpxRNfORF0LjXDr3MXgtSdFaa5IXcd5xFNrkPakJDu
        vifibkZoRi9c4Tq48bPoqtLsn8i71aDU6ofXYjrwja03TgstcPAemroiIufILRTZtOWG4jMaKQG
        FsK5sKpvVQleFdCV6B1E0hoHVaEpH4fXTg5PH+lQzW4eCw6BA6HelyPwQ04yggTrxXPBDL1u0b+
        m8
X-Google-Smtp-Source: ACHHUZ5f66xXq2iQy5P+cfZW9zFbXhVvxS0AuBHTxYtGHZCcwKBsCJDR0paHPILsgrHapMvhVELvaxkLehaoylsKln1X
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:5e39:4d58:c992:1db0])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2748:0:b0:bac:5d2c:844b with
 SMTP id n69-20020a252748000000b00bac5d2c844bmr468711ybn.8.1686678008042; Tue,
 13 Jun 2023 10:40:08 -0700 (PDT)
Date:   Tue, 13 Jun 2023 10:39:54 -0700
In-Reply-To: <cover.1684790529.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <cover.1686677910.git.jonathantanmy@google.com>
Subject: [PATCH v4 0/4] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Ramsay for spotting the errors and mentioning that I can use
octal escapes. Here's an update taking into account their comments.

Jonathan Tan (4):
  gitformat-commit-graph: describe version 2 of BDAT
  t4216: test changed path filters with high bit paths
  repo-settings: introduce commitgraph.changedPathsVersion
  commit-graph: new filter ver. that fixes murmur3

 Documentation/config/commitgraph.txt     | 16 ++++-
 Documentation/gitformat-commit-graph.txt |  9 ++-
 bloom.c                                  | 65 +++++++++++++++++++-
 bloom.h                                  |  8 ++-
 commit-graph.c                           | 29 +++++++--
 oss-fuzz/fuzz-commit-graph.c             |  2 +-
 repo-settings.c                          |  6 +-
 repository.h                             |  2 +-
 t/helper/test-bloom.c                    |  9 ++-
 t/t0095-bloom.sh                         |  8 +++
 t/t4216-log-bloom.sh                     | 77 ++++++++++++++++++++++++
 11 files changed, 210 insertions(+), 21 deletions(-)

Range-diff against v3:
1:  d4b63945f6 ! 1:  a3b52af4c9 gitformat-commit-graph: describe version 2 of BDAT
    @@ Documentation/gitformat-commit-graph.txt: All multi-byte numbers are in network
      	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
     -	in Probabilistic Verification"
     +	in Probabilistic Verification". Version 1 bloom filters have a bug that appears
    -+	when int is signed and the repository has path names that have characters >=
    ++	when char is signed and the repository has path names that have characters >=
     +	0x80; Git supports reading and writing them, but this ability will be removed
     +	in a future version of Git.
            - The number of times a path is hashed and hence the number of bit positions
2:  aa4535776e ! 2:  f095e2b486 t4216: test changed path filters with high bit paths
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
     +}
     +
     +# chosen to be the same under all Unicode normalization forms
    -+CENT=$(printf "\xc2\xa2")
    ++CENT=$(printf "\302\242")
     +
    -+# Some systems (in particular, Linux on the CI running on GitHub at the time of
    -+# writing) store into CENT a literal backslash, then "x", and so on (instead of
    -+# the high-bit characters needed). In these systems, do not run the following
    -+# tests.
    -+if test "$(printf $CENT | perl -0777 -ne 'no utf8; print ord($_)')" = "194"
    -+then
    -+	test_set_prereq HIGH_BIT
    -+fi
    -+
    -+test_expect_success HIGH_BIT 'set up repo with high bit path, version 1 changed-path' '
    ++test_expect_success 'set up repo with high bit path, version 1 changed-path' '
     +	git init highbit1 &&
     +	test_commit -C highbit1 c1 "$CENT" &&
     +	git -C highbit1 commit-graph write --reachable --changed-paths
     +'
     +
    -+test_expect_success HIGH_BIT 'setup check value of version 1 changed-path' '
    ++test_expect_success 'setup check value of version 1 changed-path' '
     +	(cd highbit1 &&
     +		printf "52a9" >expect &&
     +		get_first_changed_path_filter >actual)
     +'
     +
    -+# expect will not match actual if int is unsigned by default. Write the test
    ++# expect will not match actual if char is unsigned by default. Write the test
     +# in this way, so that a user running this test script can still see if the two
     +# files match. (It will appear as an ordinary success if they match, and a skip
     +# if not.)
     +if test_cmp highbit1/expect highbit1/actual
     +then
    -+	test_set_prereq SIGNED_INT_BY_DEFAULT
    ++	test_set_prereq SIGNED_CHAR_BY_DEFAULT
     +fi
    -+test_expect_success SIGNED_INT_BY_DEFAULT 'check value of version 1 changed-path' '
    ++test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
     +	# Only the prereq matters for this test.
     +	true
     +'
     +
    -+test_expect_success HIGH_BIT 'version 1 changed-path used when version 1 requested' '
    ++test_expect_success 'version 1 changed-path used when version 1 requested' '
     +	(cd highbit1 &&
     +		test_bloom_filters_used "-- $CENT")
     +'
3:  d6982268a4 = 3:  6adfa53daf repo-settings: introduce commitgraph.changedPathsVersion
4:  e879483c42 ! 4:  5c65bf8a22 commit-graph: new filter ver. that fixes murmur3
    @@ t/t0095-bloom.sh: test_expect_success 'compute unseeded murmur3 hash for test st
      	Hashes:0x5615800c|0x5b966560|0x61174ab4|0x66983008|0x6c19155c|0x7199fab0|0x771ae004|
     
      ## t/t4216-log-bloom.sh ##
    -@@ t/t4216-log-bloom.sh: test_expect_success HIGH_BIT 'version 1 changed-path used when version 1 request
    +@@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when version 1 requested' '
      		test_bloom_filters_used "-- $CENT")
      '
      
    -+test_expect_success HIGH_BIT 'version 1 changed-path not used when version 2 requested' '
    ++test_expect_success 'version 1 changed-path not used when version 2 requested' '
     +	(cd highbit1 &&
     +		git config --add commitgraph.changedPathsVersion 2 &&
     +		test_bloom_filters_not_used "-- $CENT")
     +'
     +
    -+test_expect_success HIGH_BIT 'set up repo with high bit path, version 2 changed-path' '
    ++test_expect_success 'set up repo with high bit path, version 2 changed-path' '
     +	git init highbit2 &&
     +	git -C highbit2 config --add commitgraph.changedPathsVersion 2 &&
     +	test_commit -C highbit2 c2 "$CENT" &&
     +	git -C highbit2 commit-graph write --reachable --changed-paths
     +'
     +
    -+test_expect_success HIGH_BIT 'check value of version 2 changed-path' '
    ++test_expect_success 'check value of version 2 changed-path' '
     +	(cd highbit2 &&
     +		printf "c01f" >expect &&
     +		get_first_changed_path_filter >actual &&
     +		test_cmp expect actual)
     +'
     +
    -+test_expect_success HIGH_BIT 'version 2 changed-path used when version 2 requested' '
    ++test_expect_success 'version 2 changed-path used when version 2 requested' '
     +	(cd highbit2 &&
     +		test_bloom_filters_used "-- $CENT")
     +'
     +
    -+test_expect_success HIGH_BIT 'version 2 changed-path not used when version 1 requested' '
    ++test_expect_success 'version 2 changed-path not used when version 1 requested' '
     +	(cd highbit2 &&
     +		git config --add commitgraph.changedPathsVersion 1 &&
     +		test_bloom_filters_not_used "-- $CENT")
-- 
2.41.0.162.gfafddb0af9-goog

