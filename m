Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61853C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 06:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiGLGvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiGLGvA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 02:51:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AE44B0FC
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:50:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f11so5886555pgj.7
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8eAVJbO/W2w3HiXOnQuCYH7QZOfwj/BYZSBR0m9f4Xw=;
        b=VmrJHFofqbOxRe0OLl274OEwYfi0WarThh1A5dFzB5Fb5akuSPRK42/P+ZCBhrF36J
         /yFEZYSaL3Dp5i+xJE3X1B1w0YqMU9o02358+EcmveL1l5Px5GdskgXgi0ey0lEuL1Q6
         UrRCeop/Kd+s5c9gvR3oAULpqVPmMAKsM3yGZK+sJGEAmUa89623QJjYCQ2oK4CDDKyc
         dLBg+OCUZHX7gqJ3jp1Xio9HyLDJ0xfwFy+HBDGPg8z0CCzsrNrHtZlEMysIOnKQI8V9
         ONre/zsDKp/lLPuFuJIPt+60SMr1Q5+2pY/EPNNecZCPYmvXxlI24kK01ks+bijgK7Tu
         3K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8eAVJbO/W2w3HiXOnQuCYH7QZOfwj/BYZSBR0m9f4Xw=;
        b=QqZzuWraVPy9MBWq+grYTDFBwAaPE1W360zmUZGXQXj+rT/5Bg9kSRBVqVTuoN7W0B
         AtZgEGuyMgz+6HIzSyj+2HIvuzAMFS2ClsuEYl2Lhlhww9dk6lRjeGTXXLtQ9bas9YCP
         1PHZu6FiXFpXDvOzvRsy6/Ps9H67S+ke/8dmXGuCM2FJQb4hFqOegx20vTXSsYte5lfE
         jP4gIiyQZ1WPkkH1BbkujonPi9g6NJ3PinvtvyhIwT4G/3rCPj8nBdAYuC9Q0x4J/xys
         lhEjoAmPMop0Toqxc1/f9Xkoi9rtVGGfJyca7t7DKBlQUjdqfo/9K9WLKn6cBUzpBk02
         R3gQ==
X-Gm-Message-State: AJIora+1pO5RJP682FRYlFxMYdWevx5VjhMBQr0j42D7GyQAllwGestI
        EiiMJVzeKv19P2cvnlRpdyGiSw==
X-Google-Smtp-Source: AGRyM1tCgVBhUevUbPkw43IlzQKkZKD+LjhsM0HYH6Ja0Ywk6P5vwLjt8A7tR3M/+cfsBymRvXGkiA==
X-Received: by 2002:a63:74f:0:b0:415:c8a5:4561 with SMTP id 76-20020a63074f000000b00415c8a54561mr15480653pgh.267.1657608658731;
        Mon, 11 Jul 2022 23:50:58 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b0016c5b2a16ffsm781054plb.142.2022.07.11.23.50.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Jul 2022 23:50:58 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, peff@peff.net, git@grubix.eu,
        me@ttaylorr.com, Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: [PATCH v5 0/1] no lazy fetch in lookup_commit_in_graph()
Date:   Tue, 12 Jul 2022 14:50:46 +0800
Message-Id: <cover.1657604799.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656593279.git.hanxin.hx@bytedance.com>
References: <cover.1656593279.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch fixes the following issue:
When we found the commit in the graph in lookup_commit_in_graph(), 
but the commit is missing from the repository, we will try
promisor_remote_get_direct() and then enter another loop.

Then we will go into an endless loop:
  git fetch -> deref_without_lazy_fetch() ->
    lookup_commit_in_graph() -> repo_has_object_file() ->
      promisor_remote_get_direct() -> fetch_objects() ->
        git fetch (a new loop round)

Changes since v4:

* Remove run_with_limited_processses() as it can be catched by CI
  settings and developer workstation. Keeping it will make a trouble
  when there are too many prcesses or stress is used.

Han Xin (1):
  commit-graph.c: no lazy fetch in lookup_commit_in_graph()

 commit-graph.c                             |  2 +-
 t/t5330-no-lazy-fetch-with-commit-graph.sh | 47 ++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100755 t/t5330-no-lazy-fetch-with-commit-graph.sh

Range-diff against v4:
1:  96d4bb7150 ! 1:  3ffeed50de commit-graph.c: no lazy fetch in lookup_commit_in_graph()
    @@ t/t5330-no-lazy-fetch-with-commit-graph.sh (new)
     +
     +. ./test-lib.sh
     +
    -+run_with_limited_processses () {
    -+	# bash and ksh use "ulimit -u", dash uses "ulimit -p"
    -+	if test -n "$BASH_VERSION"
    -+	then
    -+		ulimit_max_process="-u"
    -+	elif test -n "$KSH_VERSION"
    -+	then
    -+		ulimit_max_process="-u"
    -+	fi
    -+	(ulimit ${ulimit_max_process-"-p"} 512 && "$@")
    -+}
    -+
    -+test_lazy_prereq ULIMIT_PROCESSES '
    -+	run_with_limited_processses true
    -+'
    -+
    -+if ! test_have_prereq ULIMIT_PROCESSES
    -+then
    -+	skip_all='skipping tests for no lazy fetch with the commit-graph, ulimit processes not available'
    -+	test_done
    -+fi
    -+
     +test_expect_success 'setup: prepare a repository with a commit' '
     +	git init with-commit &&
     +	test_commit -C with-commit the-commit &&
    @@ t/t5330-no-lazy-fetch-with-commit-graph.sh (new)
     +	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
     +	test_commit -C with-commit any-commit &&
     +	anycommit=$(git -C with-commit rev-parse HEAD) &&
    -+
    -+	run_with_limited_processses env GIT_TRACE="$(pwd)/trace.txt" \
    ++	GIT_TRACE="$(pwd)/trace.txt" \
     +		git -C with-commit-graph fetch origin $anycommit 2>err &&
     +	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
     +	grep "git fetch origin" trace.txt >actual &&
-- 
2.36.1

