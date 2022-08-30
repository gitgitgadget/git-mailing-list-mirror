Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4952ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiH3Jdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiH3Jcf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:35 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE0DB274A
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:23 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so14519281fac.4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vbg4T3709lqU4B0+MCq7YjsWAhF1cwjUXEVMTobpfY4=;
        b=W7BhaMMN9F0fC2QP9bMqlA6tzijKTa++kVFBRielAkDwUnxw4lORq5LVH7ESwY+Lau
         NolpevzTB+4oQT2ZxINptHu4JlNu04FJxGFKQCTvSIT82yFx0fYD4JUFmSUFEKvVkKnE
         eXdWZLdZL7MseGhMrHJnYXDZebu//U6LYXkFMhKcNVmimQpZKnngYNG3T/1Hq96wjBKw
         q34RnLHBMuNG6fzCpQAT+lgWcnYVIgtWCpHxo8gMFbqczBDE2FosFIEePRQNmbUtsDxb
         1CUHNqbZeki92TtijBCJPHbFtE72TaqnQZMHNPeRACOSe3jwrO7JazemVUDe6RXTfLZL
         HDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vbg4T3709lqU4B0+MCq7YjsWAhF1cwjUXEVMTobpfY4=;
        b=hr/xI984sSmobUiHwoyd/ivJr1aOxIlzdOLVex+MxtqJurVI7uBnNWGP4HknkNf23p
         f1MZKKBbAI6aRi7blJKqE1biip5UnJe4XNRJMqPX/0RIaOoq8Cu9pnenonFEzsSe6vba
         +XD1ND4ohD+2LP8UOgFf+E/xt9JAdofdK/69Rx0tenw69vp+kmdCFPDBqMjr5UDMH+ZO
         6/mXgmyr9aO0nBRkG1s2MybgIvuWfsPwaBWiunjHXHqPOCxpJi2eaNZIanavc9Qt6sln
         hZeBu5B99tSUW3U1oVhHpPjw1HipcEcYbKct4KnI4DzALyop0xHVDPtp+DVcjoWR/GP/
         FSSQ==
X-Gm-Message-State: ACgBeo3LNlFFMgL/c6KYymLGsJF1b1ijfX2p5DrnLLaHmYC4uuReNfk6
        eoogxif1zFSi4MhpVfIBZnLeoEePbBk=
X-Google-Smtp-Source: AA6agR4omMu0laT5AaaPXNn28oDvv4myUz6W6mCxve3tgfMw6ZCEIjzxKMHaOyC6irg/ispbmV+M7w==
X-Received: by 2002:a05:6808:138d:b0:344:973a:366c with SMTP id c13-20020a056808138d00b00344973a366cmr9145759oiw.134.1661851938261;
        Tue, 30 Aug 2022 02:32:18 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id by6-20020a056830608600b00638e49d4cadsm6944185otb.36.2022.08.30.02.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 22/51] completion: zsh: fix for undefined completions
Date:   Tue, 30 Aug 2022 04:31:09 -0500
Message-Id: <20220830093138.1581538-23-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parseopt helper can generate the completions even if the function is
unspecified.

  git version --<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 3 +++
 t/t9904-zsh-completion.sh             | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e771a2a53a..30607aa93d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -141,6 +141,9 @@ __git_complete_command ()
 	if (( $+functions[$completion_func] )); then
 		emulate ksh -c $completion_func
 		return 0
+	elif emulate ksh -c "__git_support_parseopt_helper $command"; then
+		emulate ksh -c "__git_complete_common $command"
+		return 0
 	else
 		return 1
 	fi
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index cd223b6e2a..14f5e5d9b8 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -1015,7 +1015,7 @@ test_expect_success 'completion used <cmd> completion for alias: !f() { : git <c
 	EOF
 '
 
-test_expect_failure 'completion without explicit _git_xxx function' '
+test_expect_success 'completion without explicit _git_xxx function' '
 	test_completion "git version --" <<-\EOF
 	--build-options Z
 	--no-build-options Z
-- 
2.37.2.351.g9bf691b78c.dirty

