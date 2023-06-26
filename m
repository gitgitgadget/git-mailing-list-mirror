Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC43EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 17:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjFZRmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjFZRmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 13:42:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5DB1B0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 10:41:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fa08687246so2873864e87.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687801299; x=1690393299;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E9YfMj4BCgBaaub/ITcHqkwTlJjxSV/nTy0VRnQsibQ=;
        b=aXCWAl9US1Vh78C1TLA4HPh6RUiiWkAtkmms6CGlXSkTHC2Y+xh4LRbwn0f1jvxI2D
         HPviNfFJiS6G4dXOaBLhsMnBqGsXtbrWTxEo+PWJtQV3m42SvtuhZ23z8FSF3rNAkevC
         BHvSJTb12sznBo+/ZgEP48is7y3yVQb3SxV8k+oeC6wUzlWRBs67amJz77+ilFyCnsvG
         NaIt7roqJQW/H93vegJArw9s/6nyvXEfmJbh5sZkcOdqaisNfH/lvqLw48L5njZPVUpa
         lOk+RqlnqKPTbMg5vL5nPd4OHlc8fgSbjMgtjqMIxt1lZwg138YU6VzfnI0R5jr4fjBx
         sUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687801299; x=1690393299;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9YfMj4BCgBaaub/ITcHqkwTlJjxSV/nTy0VRnQsibQ=;
        b=HJ4Eq7KMK8fwOLWzbER9k1X/Fu11BDTRfHo3bj4AKBGTilxF6F3g0UMOhpkpDxdzc2
         aqa5u5UDfi7HxY2eVKvG7rdg5BsoLq3bLI6OCMIhbZC5H8IIL+Ig/HLYOOCRj/jgQIeB
         GPc0Vo9kcEn4P35BwGRnaaI8DO1aGSe7POBNwhJ69xlOqDOS4XFetJ08DcjT0DTwoi51
         ZfaNPWBz6zKYP3pdo1v9cT0Cx01MlQumk+aGD0c/N14LhK4GaWaY6dYeZS2Dei98OLvV
         NfkaiU+TV8dbNQ8plQIEKsy12nzg1XtAHCLGqiH2RyJy8rPmG02839d6qDd6GedbWEZC
         IpNw==
X-Gm-Message-State: AC+VfDw8Xf0iIendngP0WaxRiey5vrLNwliHRBay52saNbtV171Oj+ZR
        hIsullWYhINJVRLOKFrLmbeYJA2mYBk=
X-Google-Smtp-Source: ACHHUZ7L8JXsx0OSQiJziiXVA9NfpJGElKMtV0phBYRNZFzECaumBIb+rDK1CZ3ZSfNdzFtqQrnKpg==
X-Received: by 2002:a19:2d58:0:b0:4f8:5717:e41b with SMTP id t24-20020a192d58000000b004f85717e41bmr15402675lft.41.1687801298479;
        Mon, 26 Jun 2023 10:41:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10-20020a1cf00a000000b003f8fb02c413sm8366929wmb.8.2023.06.26.10.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:41:38 -0700 (PDT)
Message-Id: <pull.1535.git.git.1687801297404.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 17:41:37 +0000
Subject: [PATCH] config: don't BUG when both kvi and source are set
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jesse Kasky <jkasky@slack-corp.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

When iterating through config, we read config source metadata from
global values - either a "struct config_source + enum config_scope"
or a "struct key_value_info", using the current_config* functions. Prior
to the series starting from 0c60285147 (config.c: create config_reader
and the_reader, 2023-03-28), we weren't very picky about which values we
should read in which situation; we did note that both groups of values
generally shouldn't be set together, but if both were set,
current_config* preferentially reads key_value_info. When that series
added more structure, we enforced that either the former (when parsing a
config source) can be set, or the latter (when iterating a config set),
but *never* both at the same time. See 9828453ff0 (config.c: remove
current_config_kvi, 2023-03-28) and 5cdf18e7cd (config.c: remove
current_parsing_scope, 2023-03-28).

That was a good simplifying constraint that helped us reason about the
global state, but it turns out that there is at least one situation
where we need both to be set at the same time: in a blobless partial
clone where .gitmodules is missing. "git fetch" in such a repo will
start a config parse over .gitmodules (setting the config_source), and
Git will attempt to lazy-fetch it from the promisor remote. However,
when we try to read the promisor configuration, we start iterating a
config set (setting the key_value_info), and we BUG() out because that's
not allowed any more.

Teaching config_reader to gracefully handle this is somewhat
complicated, but fortunately, there are proposed changes to the config.c
machinery to get rid of this global state, and make the BUG() obsolete
[1]. We should rely on that as the eventual solution, and avoid doing
yet another refactor in the meantime.

Therefore, fix the bug by removing the BUG() check. We're reverting to
an older, less safe state, but that's generally okay since
key_value_info is always preferentially read, so we'd always read the
correct values when we iterate a config set in the middle of a config
parse (like we are here). The reverse would be wrong, but extremely
unlikely to happen since very few callers parse config without going
through a config set.

[1] https://lore.kernel.org/git/pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com

Signed-off-by: Glen Choo <chooglen@google.com>
---
    config: don't BUG when both kvi and source are set
    
    Here's a quick fix for the bug reported at [1]. As noted in the commit
    message and that thread, I think the real fix to take [2], which
    simplifies the config.c state and makes this a non-issue, so this is
    just a band-aid while we wait for that.
    
    [1]
    https://lore.kernel.org/git/CAJSLrw6qhHj8Kxrqhp7xN=imTHgg79QB9Fxa9XpdZYFnBKhkvA@mail.gmail.com/
    [2]
    https://lore.kernel.org/git/pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1535%2Fchooglen%2Fpush-ppuusrxwqpkt-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1535/chooglen/push-ppuusrxwqpkt-v1
Pull-Request: https://github.com/git/git/pull/1535

 config.c                 |  6 ------
 t/t5616-partial-clone.sh | 10 ++++++++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index f5bdac0aeed..3edb9d72dd3 100644
--- a/config.c
+++ b/config.c
@@ -106,8 +106,6 @@ static struct config_reader the_reader;
 static inline void config_reader_push_source(struct config_reader *reader,
 					     struct config_source *top)
 {
-	if (reader->config_kvi)
-		BUG("source should not be set while iterating a config set");
 	top->prev = reader->source;
 	reader->source = top;
 }
@@ -125,16 +123,12 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 static inline void config_reader_set_kvi(struct config_reader *reader,
 					 struct key_value_info *kvi)
 {
-	if (kvi && (reader->source || reader->parsing_scope))
-		BUG("kvi should not be set while parsing a config source");
 	reader->config_kvi = kvi;
 }
 
 static inline void config_reader_set_scope(struct config_reader *reader,
 					   enum config_scope scope)
 {
-	if (scope && reader->config_kvi)
-		BUG("scope should only be set when iterating through a config source");
 	reader->parsing_scope = scope;
 }
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index f519d2a87a7..8759fc28533 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -257,8 +257,8 @@ test_expect_success 'partial clone with transfer.fsckobjects=1 works with submod
 	test_commit -C submodule mycommit &&
 
 	test_create_repo src_with_sub &&
-	test_config -C src_with_sub uploadpack.allowfilter 1 &&
-	test_config -C src_with_sub uploadpack.allowanysha1inwant 1 &&
+	git -C src_with_sub config uploadpack.allowfilter 1 &&
+	git -C src_with_sub config uploadpack.allowanysha1inwant 1 &&
 
 	test_config_global protocol.file.allow always &&
 
@@ -270,6 +270,12 @@ test_expect_success 'partial clone with transfer.fsckobjects=1 works with submod
 	test_when_finished rm -rf dst
 '
 
+test_expect_success 'lazily fetched .gitmodules works' '
+	git clone --filter="blob:none" --no-checkout "file://$(pwd)/src_with_sub" dst &&
+	git -C dst fetch &&
+	test_when_finished rm -rf dst
+'
+
 test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack --fsck-objects' '
 	git init src &&
 	test_commit -C src x &&

base-commit: 6640c2d06d112675426cf436f0594f0e8c614848
-- 
gitgitgadget
