Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A820ECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 04:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiIAE7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 00:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIAE7D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 00:59:03 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD94114C6A
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 21:59:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l5so12634828qvs.13
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 21:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ubk/h9kaQMkC/3ZClAritelwkXujKPgIB6NdC1aABl4=;
        b=cZK2p6TyqW65AaksXmnPoT4gZUBZU7e11qSrGrYkCzsVME1SdJrNE1f47C2jSzNrQr
         qZEqaaRvLpQEnsMo2k2Huea5+Wc8Bv8bF6PzppctwF7/7y+JqHWYsR/HHXnosIiJwuJz
         ZQQ/4yIDuXWJydE460z8p+c/8/eH9mxPr/BMeL1xs8ncJsKdqm6VysasH0WHBfXezR17
         tQ+Hsxm2FZqcBc50mofF23lWX/Wu7qEJ1wDePqverqnwXfo6DjwApABPMAUMERx9jXne
         n6AVPuXK3Mxc3slshYb/MsgoqDc+keNgy/M6TEAZCORDIfYIUUXDoHD65xrySeN8JpOk
         sMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ubk/h9kaQMkC/3ZClAritelwkXujKPgIB6NdC1aABl4=;
        b=duBrwmgC2ii2HWC6pZyvMVtr5LFxAsfPdQ07D0DijA6zxx9CR/QyYMnlH9FbkJPoYO
         wbv0L+0SOT6MEsUPhSN8LagbgxZaRhUZzQ+aHFaAUDRSl8iwc/Gpd9hnSUMTYRvIeGlI
         Kb68zQ4Mcd+kaadHayqfk0lgZK/Y/r+9jkxJgDP5MyjdNY3x9Q+8wzLpCdKSV56SFvbs
         wMaXt9QfvdPVNXUucbbTo44fUnUys+cnVJix97mQIhXU+rZlJfY3ADNaarTS+I6cDpJY
         jzX+jM2jcSl9Bh6IPLHQSchtqnPC8DZTide9wvcMWVRmQjECYpKLQH/IzXmBWmJqdn1B
         SEUg==
X-Gm-Message-State: ACgBeo3Vnp0ziqCWqC3Yz3obestRGXv5J8xllNRM1FsCZxuSCExJ38mI
        OHtNqzsHvRYE0+IOsC62MCEcRq3D45Y=
X-Google-Smtp-Source: AA6agR6l8M3QuQDP+32uqvQ7db299B+rnJbAuFJER489Vf/eIPQKT8A9+IIS1FeFTNJUrQ2/x2YMZw==
X-Received: by 2002:a0c:f1c3:0:b0:499:2b45:8b1c with SMTP id u3-20020a0cf1c3000000b004992b458b1cmr1475923qvl.19.1662008341494;
        Wed, 31 Aug 2022 21:59:01 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id i5-20020a375405000000b006bb2f555ba4sm10752245qkb.41.2022.08.31.21.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 21:59:01 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 0/3] grep: integrate with sparse index
Date:   Wed, 31 Aug 2022 21:57:33 -0700
Message-Id: <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Integrate `git-grep` with sparse-index and test the performance
improvement.

Changes since v2
----------------

* Modify the commit message for "builtin/grep.c: integrate with sparse
  index" to make it obvious that the perf test results are not from
  p2000 tests, but from manual perf runs.

* Add tree-walking logic as an extra (the third) patch to improve the
  performance when --sparse is used. This resolved the left-over-bit
  in v2 [1].

[1] https://lore.kernel.org/git/20220829232843.183711-1-shaoxuan.yuan02@gmail.com/

Changes since v1
----------------

* Rewrite the commit message for "builtin/grep.c: add --sparse option"
  to be clearer.

* Update the documentation (both in-code and man page) for --sparse.

* Add a few tests to test the new behavior (when _only_ --cached is
  supplied).

* Reformat the perf test results to not look like directly from p2000
  tests.

* Put the "command_requires_full_index" lines right after parse_options().

* Add a pathspec test in t1092, and reword a few test documentations.

Shaoxuan Yuan (3):
  builtin/grep.c: add --sparse option
  builtin/grep.c: integrate with sparse index
  builtin/grep.c: walking tree instead of expanding index with --sparse

 Documentation/git-grep.txt               |  5 ++-
 builtin/grep.c                           | 46 +++++++++++++++++++++---
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++
 t/t7817-grep-sparse-checkout.sh          | 34 ++++++++++++++----
 5 files changed, 92 insertions(+), 12 deletions(-)

Range-diff against v2:
1:  ab5ff488a1 = 1:  db1f5a5409 builtin/grep.c: add --sparse option
2:  68c7ecee73 ! 2:  af566c7862 builtin/grep.c: integrate with sparse index
    @@ Commit message
     
         Turn on sparse index and remove ensure_full_index().
     
    -    Change it to only expands the index when using --sparse.
    +    Change it to only expand the index when using --sparse.
     
    -    The p2000 tests demonstrate a ~99.4% execution time reduction for
    +    The p2000 tests do not demonstrate a significant improvement,
    +    because the index read is a small portion of the full process
    +    time, compared to the blob parsing. The times below reflect the
    +    time spent in the "do_read_index" trace region as shown using
    +    GIT_TRACE2_PERF=1.
    +
    +    The tests demonstrate a ~99.4% execution time reduction for
         `git grep` using a sparse index.
     
    -    Test                                  Before       After
    +    Test                                  HEAD~        HEAD
         -----------------------------------------------------------------------------
         git grep --cached bogus (full-v3)     0.019        0.018  (-5.2%)
         git grep --cached bogus (full-v4)     0.017        0.016  (-5.8%)
    @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
      		int fallback = 0;
      		git_config_get_bool("grep.fallbacktonoindex", &fallback);
     
    - ## t/perf/p2000-sparse-operations.sh ##
    -@@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git read-tree -mu HEAD
    - test_perf_on_all git checkout-index -f --all
    - test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
    - test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
    -+test_perf_on_all git grep --cached bogus
    - 
    - test_done
    -
      ## t/t1092-sparse-checkout-compatibility.sh ##
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is not expanded: rm' '
      	ensure_not_expanded rm -r deep
-:  ---------- > 3:  757ac7ddee builtin/grep.c: walking tree instead of expanding index with --sparse

base-commit: d42b38dfb5edf1a7fddd9542d722f91038407819
-- 
2.37.0

