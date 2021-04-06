Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505A7C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A9A613D4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbhDFSsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbhDFSsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 14:48:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E00AC061756
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 11:47:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d191so7851864wmd.2
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kZ8JUP37r7QRm0riiRt6ZSR922pK+Pe00f7sn1WEXR4=;
        b=myVNM7T5QMePfjuh3iK5UZJ7kVcolTtKuzV/OqARXq+nyQvN0RbZJhMgGmuP0GuLmW
         FbR3N7WoduXYaiTgWg0Sm07gtirq9WXNfFRDse4mapRVQf5PVfVkQ1d4xe1Tvm5P9f4m
         vV4wzBnZmOLVmk6OiMSqrR1RbvPkROquxrviKM6VQgz0w/PU3vYlhMlMd143IpYWNhY0
         VpOeDr399S1oT8U8apadswdUFQoAPpLR0L5821FGvbPczNaQDgIoVSpIM80J+7kUKJ1L
         AvUwRUC/jtEh8bYlQLaJTc2FtVCSHepat91cDHu3A7y7MBCNTB8tSOYkziPg757kMXa2
         3zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kZ8JUP37r7QRm0riiRt6ZSR922pK+Pe00f7sn1WEXR4=;
        b=oXsJFwOeTJxeXXKDYcYz+uQgI2GG4gCJk3F6K+2RTK6fgfXlghyt8NYYzcSr9EVv9u
         MZsaE5hLYCeqp6CjZPInnsyiZErVIH18yc2t4QLKvHpNaf+9mqBqfW4a5dQeA6k1LNPI
         2Wo7/OEr3oc6ZoMQ6IpUmG51t0SbkLLYBo7KyWb/LhqBQqG3A4c1NNfp8fCwsYuIgyND
         cKvSD8kdpHHgRSfcSU46fG7Men91046NmB8TmhoHbU76owSpxTnaIY6pvEBrbGkWuekA
         o0XHQ3QMQ6YcqHmc8XAgPYFaX4jkAo6243RR5m/ExpUKtKg+ZBrlT2V2ZGtV46eqc3hq
         0YrA==
X-Gm-Message-State: AOAM531IVOAiVRaUj7jS+tUw56EHOVIs5F9cF1MvbMpWKj1nIFXNaHnf
        ExC7rDMWPj5NcwRx4re8T/pkpxaVOGQ=
X-Google-Smtp-Source: ABdhPJzC0sxjWXrEoPZiKrL7rxGEL0YakRs9h5yoJUbtayz9URqRNfjf/5mAohf9P0d2IHJD8DGC8A==
X-Received: by 2002:a05:600c:4fc2:: with SMTP id o2mr5273240wmq.25.1617734872032;
        Tue, 06 Apr 2021 11:47:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g21sm3919799wmk.34.2021.04.06.11.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:47:51 -0700 (PDT)
Message-Id: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.git.1617627856.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Apr 2021 18:47:45 +0000
Subject: [PATCH v2 0/5] Maintenance: adapt custom refspecs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
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

In order to accomplish this safely, a new refspec_item_format() method is
created and tested.

Patch 1 is just a preparation patch that makes the code simpler (and in
hindsight it should have been written this way from the start).

Patch 2 is a simplification of test_subcommand that removes the need for
escaping glob characters. Thanks, Eric Sunshine, for the tip of why my tests
were failing on FreeBSD.

Patches 3-4 add refspec_item_format().

Patch 5 finally modifies the logic in the prefetch task to translate these
refspecs.


Updates in V2
=============

Thanks for the close eye on this series. I appreciate the recommendations,
which I believe I have responded to them all:

 * Fixed typos.
 * Made refspec_item_format() re-entrant. Consumers must free the buffer.
 * Cleaned up style (quoting and tabbing).

Thanks, -Stolee

Derrick Stolee (5):
  maintenance: simplify prefetch logic
  test-lib: use exact match for test_subcommand
  refspec: output a refspec item
  test-tool: test refspec input/output
  maintenance: allow custom refspecs during prefetch

 Documentation/git-maintenance.txt |  3 +-
 Makefile                          |  1 +
 builtin/gc.c                      | 66 ++++++++++++++++++++-----------
 refspec.c                         | 23 +++++++++++
 refspec.h                         |  2 +
 t/helper/test-refspec.c           | 44 +++++++++++++++++++++
 t/helper/test-tool.c              |  1 +
 t/helper/test-tool.h              |  1 +
 t/t5511-refspec.sh                | 41 +++++++++++++++++++
 t/t7900-maintenance.sh            | 43 +++++++++++++++++---
 t/test-lib-functions.sh           |  4 +-
 11 files changed, 195 insertions(+), 34 deletions(-)
 create mode 100644 t/helper/test-refspec.c


base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-924%2Fderrickstolee%2Fmaintenance%2Frefspec-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-924/derrickstolee/maintenance/refspec-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/924

Range-diff vs v1:

 1:  3a94ff80657c ! 1:  5aa0cb06c3f2 maintenance: simplify prefetch logic
     @@ Commit message
          The previous logic filled a string list with the names of each remote,
          but instead we could simply run the appropriate 'git fetch' data
          directly in the remote iterator. Do this for reduced code size, but also
     -    becuase it sets up an upcoming change to use the remote's refspec. This
     +    because it sets up an upcoming change to use the remote's refspec. This
          data is accessible from the 'struct remote' data that is now accessible
          in fetch_remote().
      
 2:  2b74889c2a32 ! 2:  d58a3e042ee8 test-lib: use exact match for test_subcommand
     @@ Commit message
      
          The use of 'grep' inside test_subcommand uses general patterns, leading
          to sometimes needing escape characters to avoid incorrect matches.
     -    Further, some platforms interpret different glob characters differently.
     +    Further, some platforms interpret regular expression metacharacters
     +    differently. Furthermore, it can be difficult to know which characters
     +    need escaping since the actual regular expression language implemented
     +    by various `grep`s differs between platforms; for instance, some may
     +    employ pure BRE, whereas others a mix of BRE & ERE.
      
     -    Use 'grep -F' to use an exact match. This requires removing escape
     -    characters from existing callers. Luckily, this is only one test that
     -    expects refspecs as part of the subcommand.
     +    Sidestep this difficulty by using `grep -F` to use an exact match. This
     +    requires removing escape characters from existing callers. Luckily,
     +    this is only one test that expects refspecs as part of the subcommand.
      
     -    Reported-by: Eric Sunshine <sunshine@sunshineco.com>
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
       	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
      -	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
      -	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
     -+	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remote1/* <run-prefetch.txt &&
     -+	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remote2/* <run-prefetch.txt &&
     ++	test_subcommand git fetch remote1 $fetchargs "+refs/heads/*:refs/prefetch/remote1/*" <run-prefetch.txt &&
     ++	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remote2/*" <run-prefetch.txt &&
       	test_path_is_missing .git/refs/remotes &&
       	git log prefetch/remote1/one &&
       	git log prefetch/remote2/two &&
 3:  e10007e1cf8f ! 3:  96388d949b98 refspec: output a refspec item
     @@ refspec.c: void refspec_item_clear(struct refspec_item *item)
       	item->exact_sha1 = 0;
       }
       
     -+const char *refspec_item_format(const struct refspec_item *rsi)
     ++char *refspec_item_format(const struct refspec_item *rsi)
      +{
     -+	static struct strbuf buf = STRBUF_INIT;
     -+
     -+	strbuf_reset(&buf);
     ++	struct strbuf buf = STRBUF_INIT;
      +
      +	if (rsi->matching)
     -+		return ":";
     ++		return xstrdup(":");
      +
      +	if (rsi->negative)
      +		strbuf_addch(&buf, '^');
     @@ refspec.c: void refspec_item_clear(struct refspec_item *item)
      +		strbuf_addstr(&buf, rsi->dst);
      +	}
      +
     -+	return buf.buf;
     ++	return strbuf_detach(&buf, NULL);
      +}
      +
       void refspec_init(struct refspec *rs, int fetch)
     @@ refspec.h: int refspec_item_init(struct refspec_item *item, const char *refspec,
       void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
       			      int fetch);
       void refspec_item_clear(struct refspec_item *item);
     -+/*
     -+ * Output a given refspec item to a string.
     -+ */
     -+const char *refspec_item_format(const struct refspec_item *rsi);
     ++char *refspec_item_format(const struct refspec_item *rsi);
      +
       void refspec_init(struct refspec *rs, int fetch);
       void refspec_append(struct refspec *rs, const char *refspec);
 4:  c8d1de06f844 ! 4:  bf296282323a test-tool: test refspec input/output
     @@ t/helper/test-refspec.c (new)
      +
      +	while (strbuf_getline(&line, stdin) != EOF) {
      +		struct refspec_item rsi;
     ++		char *buf;
      +
      +		if (!refspec_item_init(&rsi, line.buf, fetch)) {
      +			printf("failed to parse %s\n", line.buf);
      +			continue;
      +		}
      +
     -+		printf("%s\n", refspec_item_format(&rsi));
     ++		buf = refspec_item_format(&rsi);
     ++		printf("%s\n", buf);
     ++		free(buf);
     ++
      +		refspec_item_clear(&rsi);
      +	}
      +
     ++	strbuf_release(&line);
      +	return 0;
      +}
      
     @@ t/t5511-refspec.sh: test_refspec fetch "refs/heads/${good}"
       
      +test_expect_success 'test input/output round trip' '
      +	cat >input <<-\EOF &&
     -+		+refs/heads/*:refs/remotes/origin/*
     -+		refs/heads/*:refs/remotes/origin/*
     -+		refs/heads/main:refs/remotes/frotz/xyzzy
     -+		:refs/remotes/frotz/deleteme
     -+		^refs/heads/secrets
     -+		refs/heads/secret:refs/heads/translated
     -+		refs/heads/secret:heads/translated
     -+		refs/heads/secret:remotes/translated
     -+		secret:translated
     -+		refs/heads/*:remotes/xxy/*
     -+		refs/heads*/for-linus:refs/remotes/mine/*
     -+		2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
     -+		HEAD
     -+		@
     -+		:
     ++	+refs/heads/*:refs/remotes/origin/*
     ++	refs/heads/*:refs/remotes/origin/*
     ++	refs/heads/main:refs/remotes/frotz/xyzzy
     ++	:refs/remotes/frotz/deleteme
     ++	^refs/heads/secrets
     ++	refs/heads/secret:refs/heads/translated
     ++	refs/heads/secret:heads/translated
     ++	refs/heads/secret:remotes/translated
     ++	secret:translated
     ++	refs/heads/*:remotes/xxy/*
     ++	refs/heads*/for-linus:refs/remotes/mine/*
     ++	2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
     ++	HEAD
     ++	@
     ++	:
      +	EOF
      +	cat >expect <<-\EOF &&
     -+		+refs/heads/*:refs/remotes/origin/*
     -+		refs/heads/*:refs/remotes/origin/*
     -+		refs/heads/main:refs/remotes/frotz/xyzzy
     -+		:refs/remotes/frotz/deleteme
     -+		^refs/heads/secrets
     -+		refs/heads/secret:refs/heads/translated
     -+		refs/heads/secret:heads/translated
     -+		refs/heads/secret:remotes/translated
     -+		secret:translated
     -+		refs/heads/*:remotes/xxy/*
     -+		refs/heads*/for-linus:refs/remotes/mine/*
     -+		2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
     -+		HEAD
     -+		HEAD
     -+		:
     ++	+refs/heads/*:refs/remotes/origin/*
     ++	refs/heads/*:refs/remotes/origin/*
     ++	refs/heads/main:refs/remotes/frotz/xyzzy
     ++	:refs/remotes/frotz/deleteme
     ++	^refs/heads/secrets
     ++	refs/heads/secret:refs/heads/translated
     ++	refs/heads/secret:heads/translated
     ++	refs/heads/secret:remotes/translated
     ++	secret:translated
     ++	refs/heads/*:remotes/xxy/*
     ++	refs/heads*/for-linus:refs/remotes/mine/*
     ++	2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
     ++	HEAD
     ++	HEAD
     ++	:
      +	EOF
      +	test-tool refspec <input >output &&
      +	test_cmp expect output &&
 5:  7f6c127dac48 ! 5:  9592224e3d42 maintenance: allow custom refspecs during prefetch
     @@ builtin/gc.c: static int fetch_remote(struct remote *remote, void *cbdata)
      +		struct refspec_item *rsi = &remote->fetch.items[i];
      +		struct strbuf new_dst = STRBUF_INIT;
      +		size_t ignore_len = 0;
     ++		char *replace_string;
      +
      +		if (rsi->negative) {
      +			strvec_push(&child.args, remote->fetch.raw[i]);
     @@ builtin/gc.c: static int fetch_remote(struct remote *remote, void *cbdata)
      +		free(replace.dst);
      +		replace.dst = strbuf_detach(&new_dst, NULL);
      +
     -+		strvec_push(&child.args, refspec_item_format(&replace));
     ++		replace_string = refspec_item_format(&replace);
     ++		strvec_push(&child.args, replace_string);
     ++		free(replace_string);
      +
      +		refspec_item_clear(&replace);
      +	}
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
       	test_commit -C clone2 two &&
       	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
       	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
     --	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remote1/* <run-prefetch.txt &&
     --	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remote2/* <run-prefetch.txt &&
     -+	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote1/* <run-prefetch.txt &&
     -+	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote2/* <run-prefetch.txt &&
     +-	test_subcommand git fetch remote1 $fetchargs "+refs/heads/*:refs/prefetch/remote1/*" <run-prefetch.txt &&
     +-	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remote2/*" <run-prefetch.txt &&
     ++	test_subcommand git fetch remote1 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote1/*" <run-prefetch.txt &&
     ++	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote2/*" <run-prefetch.txt &&
       	test_path_is_missing .git/refs/remotes &&
      -	git log prefetch/remote1/one &&
      -	git log prefetch/remote2/two &&
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
      +	git -C clone1 branch -f special/secret/not-fetched HEAD &&
      +
      +	# create multiple refspecs for remote1
     -+	git config --add remote.remote1.fetch +refs/heads/special/fetched:refs/heads/fetched &&
     -+	git config --add remote.remote1.fetch ^refs/heads/special/secret/not-fetched &&
     ++	git config --add remote.remote1.fetch "+refs/heads/special/fetched:refs/heads/fetched" &&
     ++	git config --add remote.remote1.fetch "^refs/heads/special/secret/not-fetched" &&
      +
      +	GIT_TRACE2_EVENT="$(pwd)/prefetch-refspec.txt" git maintenance run --task=prefetch 2>/dev/null &&
      +
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
      +	rs2="+refs/heads/special/fetched:refs/prefetch/heads/fetched" &&
      +	rs3="^refs/heads/special/secret/not-fetched" &&
      +
     -+	test_subcommand git fetch remote1 $fetchargs $rs1 $rs2 $rs3 <prefetch-refspec.txt &&
     -+	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote2/* <prefetch-refspec.txt &&
     ++	test_subcommand git fetch remote1 $fetchargs "$rs1" "$rs2" "$rs3" <prefetch-refspec.txt &&
     ++	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote2/*" <prefetch-refspec.txt &&
      +
      +	# first refspec is overridden by second
      +	test_must_fail git rev-parse refs/prefetch/special/fetched &&

-- 
gitgitgadget
