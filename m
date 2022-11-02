Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE8FC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiKBHyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiKBHyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:54:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CEB2649F
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:54:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sc25so43017396ejc.12
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFZ77tukz9FFlCxL0WJBIl0rwyzYulb6XeqaAAB6WsE=;
        b=Xihz4K8izYj2GIXxUs9LIs7Cja3V/geeXi67SKYNGmFgVrjoEYDoOb1QZ7gYlIlYVH
         mxeLpMFt0pB8jidyzSGf6J0naU17sHTI5k8Z+c5qkVxaoK5d9PBnSuVfA0UeUY/MO7wz
         wchCHwcB+n/tRgGfdO5cSKYRr/WGL8jBLNsKvyZ7ZZew+U4RVF97xcaT424x8IpgZici
         +nmoJ0jSjG9oJCd+OUAWv7FlxaOuQpwD4/4Zx/vCc/DqVYuCa9RXojoMqR6wYgGJJc+F
         sI41/RFhJNiAVLadJ3aoypMlLTnVO1qLyYMBRZISb8yWC0gZhqwV/QYzyPFGG/Bxywhj
         OU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFZ77tukz9FFlCxL0WJBIl0rwyzYulb6XeqaAAB6WsE=;
        b=RSSqakjupqCx8sJlcu8TQ8UoAabYG9lxSi6shmW9EN9rw7gOtpeQC4umX/HpTKG6d6
         tcJlA0WK4JiMopTEjEFQC5SOmLH0IIgpAoX0WfX7ravuOnPAtuEU/eHWy61DVg38FXKt
         FV/8hSpJz5JRRCJHllIDmjx1rkXOVx/PFWkpY5zVh8p5W7/tLlTO+d1rdmTsskiYAGfm
         pBHU24oy0rS8co5vbnWQP8fClU9N8grZbmNm+pZxVqmEZaXTrnfBJ96g2NULVtelXD9R
         W3TsuP+lJgnt7HVuaTejjqes2ilkFQarkB7omK4TIfmYvVkR2suyu5LYnB0KA3/NQ47U
         8f0Q==
X-Gm-Message-State: ACrzQf1IbfuSue8g25s1UahfuxckfUelvwQms1gFHc7UP8w0N1Dw/NF4
        WGUYb6UWbqZTmw8GK1Oh4bctWBQZa9Sztw==
X-Google-Smtp-Source: AMsMyM6ne9U4vhxuP+4VBy2VVI68HqIvDUSVzJXjqiQdMxNTi04Gol40NRoPtvFkJQChWteYvT/XPw==
X-Received: by 2002:a17:906:446:b0:7ad:f0af:5c66 with SMTP id e6-20020a170906044600b007adf0af5c66mr6807664eja.441.1667375653652;
        Wed, 02 Nov 2022 00:54:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0073d84a321c8sm5045466ejc.166.2022.11.02.00.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:54:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/8] submodule--helper: remove --prefix from "absorbgitdirs"
Date:   Wed,  2 Nov 2022 08:54:03 +0100
Message-Id: <patch-6.8-91208241070-20221102T074148Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's pass the "-C <prefix>" option instead to "absorbgitdirs" from
its only caller.

When it was added in f6f85861400 (submodule: add absorb-git-dir
function, 2016-12-12) there were other "submodule--helper" subcommands
that were invoked with "-C <prefix>", so we could have done this all
along.

Suggested-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 ---
 git-submodule.sh            | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8b4af8430dc..6bbefd34374 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2830,9 +2830,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	struct option embed_gitdir_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
diff --git a/git-submodule.sh b/git-submodule.sh
index 5e5d21c010f..d359f171379 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -557,7 +557,7 @@ cmd_sync()
 
 cmd_absorbgitdirs()
 {
-	git submodule--helper absorbgitdirs --prefix "$wt_prefix" "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper absorbgitdirs "$@"
 }
 
 # This loop parses the command line arguments to find the
-- 
2.38.0.1280.g8136eb6fab2

