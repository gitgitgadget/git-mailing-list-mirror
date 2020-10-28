Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49204C56201
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BE8246CD
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWf5XZqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgJ1WOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgJ1WOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:14:54 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F088CC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:14:53 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id o70so518900ybc.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBKckM6il9kb+4KT8vgXFLgwEP4Ax9Qy3RPZQeDM0FI=;
        b=HWf5XZqbJCjpR3gYdjXCgfgnXGEBIz7ldtwSsBnU0+yzmAp2Efkp1kDVO74Vyd9t9Y
         qij804jNh0AZl4hY5/EZv2iUyTunCkH7UQKNl7DKYo98OllUcrQz+tu97BlAPlpdX7t/
         2vxiPgRGc71IDMyXXruEV6sVjzKVjoW+srCTs9sZ3ltYJHuvXLjAcfS/XmOZnRAm6GDn
         cdVSTg2v8rDhC+NFYokGIvpE8zQikir64t7gmgMGDowZLxak/fNvG0cVmnq13NYtBbkq
         DEPicyzLgsbCA2TfdQGXLiUBJ7KQQ7/zuXHIKjBt7EdaLy9J8Fgauo5LLkuYAL9j6LIr
         dKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBKckM6il9kb+4KT8vgXFLgwEP4Ax9Qy3RPZQeDM0FI=;
        b=m75JXUKR2P6CLhHE/6TOcNk+JfihAxkrk8oE87iVhWVpCgv0iYuCxFSta/YZmRqzIO
         X2IduPVEQGoaurWuuPYlXL8wA9AklTFWFW+UM+bCcSCXn0YpNvilUhp/Z+fYJsHZn5gk
         7QtuUf4UEuEsoTihH8lRYLR8xnjUMgImuwxkG3+MKmWCVb8CSLImh8e6Dgy6izlt83a5
         3gUAxQqHu0Se2AQVxlkvlL/3c4YG9GDMPpwI3Pzp+KSor4d0rPKQYxxOJUp2/YztMhbf
         AZI62OxxePF3Smp45PEHBCWfX23sv2QH7eoHFL9+FoFuS2nvJ4tTEW9yD03ZqR/+ezXp
         lifA==
X-Gm-Message-State: AOAM531rMXtd7G9naFLKZgLI7Mq58VfH3ZmqtXKYp+j5beVZ/on1+LEl
        5L+M+HmaWl75s1VxgvItUvBhPloqWb/z3Q==
X-Google-Smtp-Source: ABdhPJxAXQAI6l2Gi5Q2FzbJ5RwLNLAF9LtXluaygsf9yha5WMpYkg/yFw0CpWPmXskI7ZcldsWUbQ==
X-Received: by 2002:a4a:e5ce:: with SMTP id r14mr4135135oov.11.1603850834450;
        Tue, 27 Oct 2020 19:07:14 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id c128sm2384036oob.23.2020.10.27.19.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 00/29] completion: zsh: latest patches
Date:   Tue, 27 Oct 2020 20:06:43 -0600
Message-Id: <20201028020712.442623-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've been carrying around these patches for quite some time, many have already
been sent, others I refactored to make them more clear.

These patches correspond to version 1.1 of git-completion:

https://github.com/felipec/git-completion

Changes since v2:

 * Silenced pkg-config command in case of errors
 * Improved loading of bash script so it's backwards compatible

Cheers.

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 26538efb80..49a6ef4236 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3474,7 +3474,6 @@ __git_func_wrap ()
 # This is NOT a public function; use at your own risk.
 __git_complete ()
 {
-	test -n "$ZSH_VERSION" && return
 	local wrapper="__git_wrap${2}"
 	eval "$wrapper () { __git_func_wrap $2 ; }"
 	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d25f8691ef..e0fda27f4c 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -27,19 +27,26 @@ zstyle -T ':completion:*:*:git:*' tag-order && \
 zstyle -s ":completion:*:*:git:*" script script
 if [ -z "$script" ]; then
 	local -a locations
-	local e
+	local e bash_completion
+
+	bash_completion=$(pkg-config --variable=completionsdir bash-completion 2>/dev/null) ||
+		bash_completion='/usr/share/bash-completion/completions/'
+
 	locations=(
 		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
 		"$HOME/.local/share/bash-completion/completions/git"
-		"$(pkg-config --variable=completionsdir bash-completion)"/git
-		'/usr/share/bash-completion/completions/git'
+		"$bash_completion/git"
 		'/etc/bash_completion.d/git' # old debian
 		)
 	for e in $locations; do
 		test -f $e && script="$e" && break
 	done
 fi
+
+local old_complete="$functions[complete]"
+functions[complete]=:
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
+functions[complete]="$old_complete"
 
 __gitcomp ()
 {
@@ -129,7 +136,7 @@ __gitcomp_file_direct ()
 
 _git_zsh ()
 {
-	__gitcomp "v1.0"
+	__gitcomp "v1.1"
 }
 
 __git_complete_command ()


Felipe Contreras (29):
  completion: zsh: fix __gitcomp_direct()
  completion: zsh: fix name due to broken autoloading
  completion: zsh: fix bash script extension
  completion: zsh: reorganize install instructions
  completion: zsh: fix for directories with spaces
  completion: zsh: update slave script locations
  completion: prompt: fix color for Zsh
  completion: zsh: fix for command aliasing
  completion: bash: synchronize zsh wrapper
  completion: bash: remove zsh wrapper
  completion: zsh: fix completion for --no-.. options
  completion: fix conflict with bashcomp
  completion: zsh: add missing direct_append
  completion: zsh: fix splitting of words
  completion: zsh: simplify compadd functions
  completion: zsh: simplify direct compadd
  completion: zsh: trivial cleanup
  completion: zsh: simplify nl_append
  completion: zsh: simplify file_direct
  completion: zsh: shuffle functions around
  completion: zsh: refactor command completion
  completion: zsh: improve command tags
  completion: zsh: add alias descriptions
  completion: zsh: trivial simplification
  completion: zsh: add simple version check
  completion: bash: trivial cleanup
  completion: bash: cleanup cygwin check
  completion: bash: remove old compat wrappers
  Update copyright notices

 contrib/completion/git-completion.bash | 113 ++------------------
 contrib/completion/git-completion.zsh  | 141 ++++++++++++++++---------
 contrib/completion/git-prompt.sh       |  11 +-
 t/t9902-completion.sh                  |   2 +-
 4 files changed, 112 insertions(+), 155 deletions(-)

-- 
2.29.1

