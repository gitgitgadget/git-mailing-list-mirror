Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF46C43460
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576AB611AC
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 12:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbhDPMui (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240466AbhDPMua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 08:50:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7348DC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 05:50:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so13981973wmg.0
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HE12G6V73P2wpzFjvAsIcvPdDLTtD//otndchoX56Ng=;
        b=QhKvmOj+KccZ5K416T1dM5+O0AMD/Q1AAqSuzsBShgvapxAUfYEOZymYMcZ6VoOxx1
         bXYYg6DdCuQCZUCF11sf51Wi+uSSXoXjwgCfIxQXGMPKmU/OvUfWH08cP198+eHdxKFc
         eUOMJWltSVecSnl1oZWv9f9RMKxtcKmABrds9vIYe8IFYqZSmt5LdjnTqhB6Xe+ktsf0
         AOCKCq+nmiDfCfMJE8IMc8n6VnTMquBQlw7gXaYw0sduW0nDdENdNDza849BCTI2V7DR
         g64TPeuV4Kys/FwCil7yFxQ4FEQbz5P9cVFlP4BM7HA1WGLZ+5AJUeZeyW9ESEM0XW7+
         H3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HE12G6V73P2wpzFjvAsIcvPdDLTtD//otndchoX56Ng=;
        b=BPtuT/wcJtlvA6ozSleJQsnjR0sLVUw335Z8JG/jkuhd+nwnbE187pFeEwuAAIi85Y
         Cy1NldlePpFXlnX+mfzp4P121wZzwrZZc6+kb1UqAoCEUmVWnX2LD8dTX4ppMvDolRVB
         vCucaxojmSIbuegZkM9UNXlT3FTB3m/dxMmNcOuN5TKRCnn5qSicorrGHtfDEet0r8Z7
         W1mJkCSWIelKJoW+Bm22Fkft5aoc4IRPFPg23Vnp7ynIM4uBHk0o1Fhj01TTNEd//j+t
         W5ctF2RRLo2hmcbUPToHHPNiJ5EEah9OZ8/K/o84gJyagsvimENlzbZvc8h6devALiS5
         vXFA==
X-Gm-Message-State: AOAM531hcK5NctW8glEkvrScDOUDMWO+2LJRpGCcOBLEpya5UnKQlabF
        +KBWW3WE6Z16ybrwC6NyaFshj/0bW+Y=
X-Google-Smtp-Source: ABdhPJzCT290Rup+K+UGH+SNOf1Kl4PGFz/2VBfvz/qCR1JVuOhF7XOUDQ0BC7rr44SYviqY70/apA==
X-Received: by 2002:a1c:f618:: with SMTP id w24mr8031796wmc.93.1618577403300;
        Fri, 16 Apr 2021 05:50:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8sm10689220wrp.34.2021.04.16.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 05:50:03 -0700 (PDT)
Message-Id: <92652fd9e6e17654abdb30625c85937b6b56c38e.1618577399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
References: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
        <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Apr 2021 12:49:59 +0000
Subject: [PATCH v4 4/4] maintenance: respect remote.*.skipFetchAll
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
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a remote has the skipFetchAll setting enabled, then that remote is
not intended for frequent fetching. It makes sense to not fetch that
data during the 'prefetch' maintenance task. Skip that remote in the
iteration without error. The skip_default_update member is initialized
in remote.c:handle_config() as part of initializing the 'struct remote'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           | 3 +++
 t/t7900-maintenance.sh | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 9d35f7da50d8..98a803196b88 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -878,6 +878,9 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 	struct maintenance_run_opts *opts = cbdata;
 	struct child_process child = CHILD_PROCESS_INIT;
 
+	if (remote->skip_default_update)
+		return 0;
+
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "fetch", remote->name,
 		     "--prefetch", "--prune", "--no-tags",
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index eadb800c08cc..b93ae014ee58 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -153,7 +153,13 @@ test_expect_success 'prefetch multiple remotes' '
 
 	test_cmp_config refs/prefetch/ log.excludedecoration &&
 	git log --oneline --decorate --all >log &&
-	! grep "prefetch" log
+	! grep "prefetch" log &&
+
+	test_when_finished git config --unset remote.remote1.skipFetchAll &&
+	git config remote.remote1.skipFetchAll true &&
+	GIT_TRACE2_EVENT="$(pwd)/skip-remote1.txt" git maintenance run --task=prefetch 2>/dev/null &&
+	test_subcommand ! git fetch remote1 $fetchargs <skip-remote1.txt &&
+	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
 '
 
 test_expect_success 'prefetch and existing log.excludeDecoration values' '
-- 
gitgitgadget
