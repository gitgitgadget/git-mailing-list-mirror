Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEDCC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiGAKhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiGAKhv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:37:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72E370E4E
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:37:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so3037828wmc.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kn8kUekyrJqqubUc4KOsyZmAY40K/RN1GlFoISGdFHg=;
        b=iQ06+Sze0c0TWhsvoHdj+gbOEnwECxrtZCjK9CgpSv/JklGBEcfwZC8QuaRpPmPaoy
         6idf1P189F5mFfgIZv1JqSNN4SZUH/Q92oAabfQPWS38oQ7p5h4bxHnd7wIsb7uPJttk
         VeKLvZQnsiASyHc5UKbWBqjd0cRl+WPdsTnztyLAZMuaC17CB09CTlF1o4OO6O1p2/x2
         8f6hfBQrNJbitjicYUJpz710gl7IS4dTf/XRsPJ0zMjvbH539u86n6EhMTTb+CqaPCy5
         UHi6vPJ8YM5JjEA5383pmDiAlu0hege1hFFgvq9HAsAtkOQDw8LIYsbqIRb1SPCfSqGx
         q/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kn8kUekyrJqqubUc4KOsyZmAY40K/RN1GlFoISGdFHg=;
        b=25cGYVQ3QGVgf3kBUfrJ3bQcLOCVsOlAYO9pEdCbcg2WtO2qfXubdPz1g2RVgQGqlY
         DGF/f+lIg8ydbDd+UmseyBmeu+wnz+AiF2YLbv3q8U3nU4DkKDRO0l+tFRLEvwU/46XJ
         al4lvueXvpAdntKrZ46jKWZXfKIti0YyWUjjvKM4mT6hmsk6A4JurqdF9iqcxNiKzwnw
         Iw1mbEQCuvY1mCJiWgEjiKZqPp1CPqwmO4DekZDnqBskI59Trc6e9QyyJmusQqYJDNK+
         ds0NG8IyOuKYnzA7RkUt7s7ni1GQvavCBG3xA8sbkbceBjnaiJAR6iDTeIqk3Y4XDhNH
         LcPA==
X-Gm-Message-State: AJIora+qW4mNdpocX7yPgzBysUM5M9hIuc4QFAqHsihnyH7prs/wp69s
        0ISTBeLK6c0c5EUbhAQp9HYEbsyevCyWvw==
X-Google-Smtp-Source: AGRyM1vfL6G3HK7EfixbGnX4qv2w2e0aj4e/ryVMw9AR2xZGxBF8AU2d+EyEAQVY0j2bzvgEoQMtDw==
X-Received: by 2002:a1c:a1c4:0:b0:3a0:48dc:defa with SMTP id k187-20020a1ca1c4000000b003a048dcdefamr14689754wme.59.1656671867835;
        Fri, 01 Jul 2022 03:37:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00397393419e3sm6229871wmq.28.2022.07.01.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:37:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/9] test-tool: fix memory leaks
Date:   Fri,  1 Jul 2022 12:37:31 +0200
Message-Id: <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks in "test-tool", see the v1 CL for a general summary:
https://lore.kernel.org/git/cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com/

Changes since v1:

 * Use a less stupid "to_free" pattern in 2/9 (thanks Eric!)
 * Don't go overboard with freeing memory before die() in 5/9, thanks
   Junio.
 * Fix the commit message of 7/9 as suggested by Eric.

Ævar Arnfjörð Bjarmason (9):
  test-tool test-hash: fix a memory leak
  test-tool path-utils: fix a memory leak
  test-tool {dump,scrap}-cache-tree: fix memory leaks
  test-tool urlmatch-normalization: fix a memory leak
  test-tool regex: call regfree(), fix memory leaks
  test-tool json-writer: fix memory leaks
  test-tool bloom: fix memory leaks
  test-tool ref-store: fix a memory leak
  test-tool delta: fix a memory leak

 t/helper/test-bloom.c                  |  2 ++
 t/helper/test-delta.c                  | 21 ++++++++++++++-------
 t/helper/test-dump-cache-tree.c        |  7 ++++++-
 t/helper/test-hash.c                   |  1 +
 t/helper/test-json-writer.c            | 16 ++++++++++++----
 t/helper/test-path-utils.c             | 11 +++++++----
 t/helper/test-ref-store.c              |  1 +
 t/helper/test-regex.c                  |  9 ++++++---
 t/helper/test-scrap-cache-tree.c       |  1 +
 t/helper/test-urlmatch-normalization.c | 11 ++++++++---
 t/t0015-hash.sh                        |  3 ++-
 t/t0019-json-writer.sh                 |  2 ++
 t/t0060-path-utils.sh                  |  1 +
 t/t0090-cache-tree.sh                  |  2 ++
 t/t0095-bloom.sh                       |  2 +-
 t/t0110-urlmatch-normalization.sh      |  2 ++
 t/t5303-pack-corruption-resilience.sh  |  2 ++
 t/t5308-pack-detect-duplicates.sh      |  2 ++
 t/t5309-pack-delta-cycles.sh           |  2 ++
 t/t5321-pack-large-objects.sh          |  2 ++
 t/t7812-grep-icase-non-ascii.sh        |  1 +
 21 files changed, 77 insertions(+), 24 deletions(-)

Range-diff against v1:
 -:  ----------- >  1:  4406fedba80 test-tool test-hash: fix a memory leak
 1:  06b2dcf4f12 !  2:  050766e6fa2 test-tool path-utils: fix a memory leak
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/helper/test-path-utils.c ##
    -@@ t/helper/test-path-utils.c: static int protect_ntfs_hfs_benchmark(int argc, const char **argv)
    - int cmd__path_utils(int argc, const char **argv)
    - {
    +@@ t/helper/test-path-utils.c: int cmd__path_utils(int argc, const char **argv)
      	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
    --		char *buf = xmallocz(strlen(argv[2]));
    -+		char *to_free = NULL;
    -+		char *buf = to_free = xmallocz(strlen(argv[2]));
    + 		char *buf = xmallocz(strlen(argv[2]));
      		int rv = normalize_path_copy(buf, argv[2]);
    - 		if (rv)
    - 			buf = "++failed++";
    - 		puts(buf);
    -+		free(to_free);
    +-		if (rv)
    +-			buf = "++failed++";
    +-		puts(buf);
    ++		puts(rv ? "++failed++" : buf);
    ++		free(buf);
      		return 0;
      	}
      
 2:  7a0064860ad =  3:  5f9f34629c4 test-tool {dump,scrap}-cache-tree: fix memory leaks
 3:  a450aff8904 =  4:  3f9f7bbdeb2 test-tool urlmatch-normalization: fix a memory leak
 4:  fe2a8d898f6 !  5:  940cd5378ad test-tool regex: call regfree(), fix memory leaks
    @@ Commit message
         routines, 2012-09-01), as a result we can mark a test as passing with
         SANITIZE=leak using "TEST_PASSES_SANITIZE_LEAK=true".
     
    +    We could regfree() on the die() paths here, which would make some
    +    invocations of valgrind(1) happy, but let's just target SANITIZE=leak
    +    for now. Variables that are still reachable when we die() are not
    +    reported as leaks.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/helper/test-regex.c ##
     @@ t/helper/test-regex.c: static int test_regex_bug(void)
    - 	char *str = "={}\nfred";
    - 	regex_t r;
    - 	regmatch_t m[1];
    -+	int err = 0;
    - 
    - 	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
    - 		die("failed regcomp() for pattern '%s'", pat);
    --	if (regexec(&r, str, 1, m, 0))
    --		die("no match of pattern '%s' to string '%s'", pat, str);
    -+	if (regexec(&r, str, 1, m, 0)) {
    -+		err = error("no match of pattern '%s' to string '%s'", pat, str);
    -+		goto cleanup;
    -+	}
    + 	if (m[0].rm_so == 3) /* matches '\n' when it should not */
    + 		die("regex bug confirmed: re-build git with NO_REGEX=1");
      
    - 	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3957  */
    --	if (m[0].rm_so == 3) /* matches '\n' when it should not */
    --		die("regex bug confirmed: re-build git with NO_REGEX=1");
    -+	if (m[0].rm_so == 3) { /* matches '\n' when it should not */
    -+		err = error("regex bug confirmed: re-build git with NO_REGEX=1");
    -+		goto cleanup;
    -+	}
    - 
    --	return 0;
    -+cleanup:
     +	regfree(&r);
    -+	return err < 0 ? 1 : 0;
    + 	return 0;
      }
      
    - int cmd__regex(int argc, const char **argv)
    - {
    - 	const char *pat;
    - 	const char *str;
    --	int ret, silent = 0, flags = 0;
    -+	int silent = 0, flags = 0;
    - 	regex_t r;
    - 	regmatch_t m[1];
    - 	char errbuf[64];
    -+	int ret = 0;
    - 
    - 	argv++;
    - 	argc--;
     @@ t/helper/test-regex.c: int cmd__regex(int argc, const char **argv)
    - 	}
    - 	git_setup_gettext();
    - 
    --	ret = regcomp(&r, pat, flags);
    --	if (ret) {
    -+	if (regcomp(&r, pat, flags)) {
    - 		if (silent)
    --			return ret;
    -+			return 1;
    - 
    - 		regerror(ret, &r, errbuf, sizeof(errbuf));
      		die("failed regcomp() for pattern '%s' (%s)", pat, errbuf);
      	}
      	if (!str)
     -		return 0;
     +		goto cleanup;
      
    --	ret = regexec(&r, str, 1, m, 0);
    --	if (ret) {
    -+	if (regexec(&r, str, 1, m, 0)) {
    -+		ret = 1;
    + 	ret = regexec(&r, str, 1, m, 0);
    + 	if (ret) {
      		if (silent || ret == REG_NOMATCH)
     -			return ret;
     +			goto cleanup;
      
      		regerror(ret, &r, errbuf, sizeof(errbuf));
    --		die("failed regexec() for subject '%s' (%s)", str, errbuf);
    -+		error("failed regexec() for subject '%s' (%s)", str, errbuf);
    -+		goto cleanup;
    + 		die("failed regexec() for subject '%s' (%s)", str, errbuf);
      	}
      
     -	return 0;
 5:  97448b9056e =  6:  24022fc2b3f test-tool json-writer: fix memory leaks
 6:  bdb467d1414 !  7:  0957c99817b test-tool bloom: fix a memory leak
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-tool bloom: fix a memory leak
    +    test-tool bloom: fix memory leaks
     
         Fix memory leaks introduced with these tests in f1294eaf7fb (bloom.c:
         introduce core Bloom filter constructs, 2020-03-30), as a result we
 7:  6becefc754e =  8:  937b4cdf07e test-tool ref-store: fix a memory leak
 8:  5341b413bda =  9:  0968f549957 test-tool delta: fix a memory leak
-- 
2.37.0.900.g4d0de1cceb2

