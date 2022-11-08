Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7348CC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiKHSSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiKHSSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889DF59FEC
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:18:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k2so40835627ejr.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX4FqUwyj24yZF8OFf5X4mD8kLhg39d/pRtfUqb6YxY=;
        b=ChcII3SskghPAu07NU83FZxVFnGreIxkn7hqQwRYnZ1QjX6VWrw28LitB2ppaO9Gnv
         H6/qdX+fLuJWilEB3uFGGRkiaU0U7d6nxBGxAlmpfIOhs4ltHo1WsmSUmNOuvpSDX3BX
         JUpdNW9UWzA2dQH3Tu/UHa/9lVEzm66Qpds7vsWeAMut5iWfmwKM6X4gwIMjAFLPRMgI
         LNUh9YJHpRbg4Yjyg7+AcnWFxUHreSmJQLlcuJtErBT5aNsqqqiopWu+kJbmlLd9leT1
         +8KHtMZh4c6hdmvG0B5+ExBpFXEmNnSquYjodYLbn6UoY6o2VCn+jgS4Voehsp6AFubb
         ix+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX4FqUwyj24yZF8OFf5X4mD8kLhg39d/pRtfUqb6YxY=;
        b=AqHFqNoHRIS8NP1wWj5ZMH9WxD8JZwLxnMwjCqdmeyuD2hR8ze1kCQwbu63tFZXcxk
         IAHim19omaKObetNcVzTSTV6FH0NFFY/cHIv29E9TTlj5drtUUKqwcEmPzdSgpss/by0
         rHfvUEfMHq8Dh+gHTWFm38IWSFxMT8N6XY2NXnkQKz8RhM3kVlchcMAJTDI0slWz7zIm
         osGPHudc/VFuSzzhClQ2XC1NHugg/3nRiOgJ1I54ah/r+MD0nnT+Ekmyo1h6dTftA7fI
         du7D+pHbahQfbeT02NAsmUa+h8AaZeCcPG0yH4T3NzM2ASOgFedGGmRv6ARIy7NCJZeD
         XUpw==
X-Gm-Message-State: ACrzQf3EudjwYV4nuWB6A4chSrvil7u81VZDzA+Htl7BGvVp/pibtosP
        n7uZBOsfgMEO2ogdFS2srW+yeyi1d56YKw==
X-Google-Smtp-Source: AMsMyM4NhHjCx9WYIOyXSax/t0QHmeShgCalnMTqW9JtmMmGoXITo0Y5zTRJudrsR90LUwUV+ih+Zg==
X-Received: by 2002:a17:906:a1d2:b0:7ad:a792:a511 with SMTP id bx18-20020a170906a1d200b007ada792a511mr53021474ejb.247.1667931483691;
        Tue, 08 Nov 2022 10:18:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:18:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/15] rebase: don't leak on "--abort"
Date:   Tue,  8 Nov 2022 19:17:48 +0100
Message-Id: <patch-v2-12.15-f6d76250174-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in the recent 6159e7add49 (rebase --abort: improve reflog
message, 2022-10-12). Before that commit we'd strbuf_release() the
reflog message we were formatting, but when that code was refactored
to use "ropts.head_msg" the strbuf_release() was omitted.

Ideally the three users of "ropts" in cmd_rebase() should use
different "ropts" variables, in practice they're completely separate,
as this and the other user in the "switch" statement will "goto
cleanup", which won't touch "ropts".

The third caller after the "switch" is then unreachable if we take
these two branches, so all of them are getting a "{ 0 }" init'd
"ropts".

So it's OK that we're leaving a stale pointer in "ropts.head_msg",
cleaning it up was our responsibility, and it won't be used again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c          | 1 +
 t/t7517-per-repo-email.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6a831320313..3f360eb2f37 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1322,6 +1322,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (reset_head(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head->object.oid));
+		strbuf_release(&head_msg);
 		remove_branch_state(the_repository, 0);
 		ret = finish_rebase(&options);
 		goto cleanup;
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index 163ae804685..efc6496e2b2 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -9,6 +9,7 @@ test_description='per-repo forced setting of email address'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a likely user.useConfigOnly use case' '
-- 
2.38.0.1467.g709fbdff1a9

