Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D8DC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 18:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIZSsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiIZSsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 14:48:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E952780527
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 11:48:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so3871080wrb.13
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=paFM5VXeBU5RdTUdf17vN2cG3ZmaabSUyVD6JMdJ484=;
        b=GuAbICcDe2AX5aw5nnylLXkxcAubdukh+82IHFoVrorViKADuhtQY0V0JFb+u5d6nT
         LoFy6LP68gtZvBBPMZKi8UyV5Ja0Wl+RIEKuGu02M1FVNQW+b4t5jr7cqEnKvb+FVuZZ
         q1sdBeK50dCZv44nouCNKPaDV3ercuogY9dv3cwrLRRFqNkocbEIjodAiiegge3MnV+X
         DfdmulbzG8jRKVMvjOBqylIiBZg7MlUvU48YLGg/hbExM2NIs8KAT8QZE/YC8mrE9yWp
         aacpaQMh2wbSJOGbUJxIXJfpaaG3B9S+/IV6XCZOEVXmSpTMGxvT62K4gArXZfkZJJlD
         PIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=paFM5VXeBU5RdTUdf17vN2cG3ZmaabSUyVD6JMdJ484=;
        b=VaR0cJSrj9qvpFZl8vYt7htSwvc6uMh+mcfyTDER29RHHV52gG564ekwJqZThT690J
         AI8jh6rPZHJAHSRcyRsF0MkElJm8BXmRBWLhBCRrBJIODaxbzleCVWLEB4nnZf1f1ToZ
         YrwTmff1PPh4+ZpVN+gRMBhzQU9EMaAISfZZf26ROaApEAxP24qSf0WUCYMUu6lcp2Pj
         rX9++Eq8RyDrv5OORYBCZx+UJMILbITbERPrzuw83/tVWvN9u3uq3W8OgEHszFUqKI/0
         /rE5oXE2/Vr5pqVZVt2u1HF8+XxDQ5HALNPnKX0wNs0vUNlJLeTWpHtNQpihb7/cvg3T
         Cd8A==
X-Gm-Message-State: ACrzQf1t1LoZdbDR5DrvMpR6Q4N4yt726hTA0dbU1Vfv7eU1X6K7OAH9
        wwU2GUSGHGeabKIQZI4WSrIUnXURr3A=
X-Google-Smtp-Source: AMsMyM7UpxkjuF1zkB7OnYk6fHUXUS+W+oeSN67doJVIYIHylzR8FSCNlaSLWTi/7kuSfsCCOITSUQ==
X-Received: by 2002:a05:6000:1ac7:b0:22a:906d:3577 with SMTP id i7-20020a0560001ac700b0022a906d3577mr14970288wry.33.1664218088069;
        Mon, 26 Sep 2022 11:48:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d5449000000b0022ca921dc67sm2564639wrv.88.2022.09.26.11.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:48:07 -0700 (PDT)
Message-Id: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 18:48:03 +0000
Subject: [PATCH v3 0/3] scalar: make unregister idempotent
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed this while we were updating the microsoft/git fork to include
v2.38.0-rc0. I don't think 'git maintenance unregister' was idempotent
before, but instead some change in 'scalar unregister' led to it relying on
the return code of 'git maintenance unregister'. Our functional tests expect
'scalar unregister' to be idempotent, and I think that's a good pattern for
'git maintenance unregister', so I'm fixing it at that layer.

Despite finding this during the 2.38.0-rc0 integration, this isn't critical
to the release.

Perhaps an argument could be made that "failure means it wasn't registered
before", but I think that isn't terribly helpful.

Our functional tests are running the unregister subcommand to disable
maintenance in order to run tests on the object store (such as running
maintenance commands in the foreground and checking the object store
afterwards). This is a form of automation using 'unregister' as a check that
maintenance will not run at the same time, and it doesn't care if
maintenance was already disabled. I can imagine other scripting scenarios
wanting that kind of guarantee.


Updates in v3
=============

 * The --force option now uses OPT_FORCE and is hidden from autocomplete.
 * A new commit is added that removes the use of Git subprocesses in favor
   of git_config_set_multivar_in_file_gently().


Updates in v2
=============

 * This is now a two-patch series.
 * I rebased onto v2.38.0-rc1 for two reasons: Scalar is now merged, and the
   usage for 'git maintenance unregister' removed its translation markers.
 * Instead of making git maintenance unregister idempotent, add a --force
   option for those who do not want to require that the repository is
   already registered.
 * Make scalar unregister idempotent, with reasons argued in patch 2.

Thanks, -Stolee

Derrick Stolee (3):
  maintenance: add 'unregister --force'
  scalar: make 'unregister' idempotent
  gc: replace config subprocesses with API calls

 Documentation/git-maintenance.txt |  6 +-
 builtin/gc.c                      | 95 +++++++++++++++++++++----------
 scalar.c                          |  5 +-
 t/t7900-maintenance.sh            |  6 +-
 t/t9210-scalar.sh                 |  5 +-
 5 files changed, 82 insertions(+), 35 deletions(-)


base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1358%2Fderrickstolee%2Fmaintenance-unregister-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1358/derrickstolee/maintenance-unregister-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1358

Range-diff vs v2:

 1:  69c74f52eef ! 1:  8a8bffaec89 maintenance: add 'unregister --force'
     @@ builtin/gc.c: done:
       {
      +	int force = 0;
       	struct option options[] = {
     -+		OPT_BOOL(0, "force", &force,
     -+			 N_("return success even if repository was not registered")),
     ++		OPT__FORCE(&force,
     ++			   N_("return success even if repository was not registered"),
     ++			   PARSE_OPT_NOCOMPLETE),
       		OPT_END(),
       	};
      -	int rc;
 2:  f5d8d6e4901 = 2:  06d5ef3fc57 scalar: make 'unregister' idempotent
 -:  ----------- > 3:  260d7bee36e gc: replace config subprocesses with API calls

-- 
gitgitgadget
