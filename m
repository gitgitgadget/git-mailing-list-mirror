Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E71DECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiH3JcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiH3JcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:01 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBC3A2A8A
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:56 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11eb8b133fbso10952411fac.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=M+Pt1uQuHUMFRJBB0vBLFZiCog1k6TOqVBpaZWmgXAI=;
        b=RJg8fHLnj3Uazecrj+iGoD++RlVy+oEetzbKbAeL9NvMi7gCfLpBNZ1uNwrtMO0GgC
         wj+bnRaAlA6/80YFlMRhk5TaNIN4dfFUZcgH2Pm7dlU76u6c+GAOOZDhz0UQ71FtaNQ3
         X8HPH7PVeqiCf1/qSQTWslsfwrfTZJfGYSVaLEOfg4lwPXlpk/ZQyrq+67rNvHZXGmJE
         sW2WQhchZGLORVpqG5vw6tU0vHmA82b5cOudDi3cv445GAAg5adbq7QkSCb2CSI80LE9
         yT5w/AflWb/ZfWPtYpw6TjpsLY8tsbAwBBPnNwA5bEgt1/txj3UbdLOLqpHGuFcQ2LtQ
         jNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=M+Pt1uQuHUMFRJBB0vBLFZiCog1k6TOqVBpaZWmgXAI=;
        b=U/K8xik7oEaNtMHyWkMLz3SfGl8aNtyG8A4v+JmC+AfsiQ2hFcql5ZAj0PJURn6VSU
         cOnR8GXLi5laAY4/CBvJ3h5XEbxlXsufAoeuIyXTsTtqR8rfhKX0h51hqQ8QeTuD/M0X
         LwXMcQmhHH71xGniHnfP7a9NaqGxslyeueHz9NHpTY1nELMu2fht79WryvzcmA3VLi82
         ueeMpP9uh2mCOQKpQX5aIvngyw5K3TuASYPOP5t2O3ezsnrfYOyDg7p/ewFBmGNgiDpx
         AjIHeEiZo90S6CbvpLhu9i525oIOBky5d8jiY7SU91e7K8X2jGzYP7gKNk0gvFMqegRi
         PxxA==
X-Gm-Message-State: ACgBeo22woTmoxjypDTf4HPxeu3KibTbu2F5l49vZAHeSL5ebNY67KWg
        WiYMl3Uv9jqOd66dAtnauAmXowrWEUM=
X-Google-Smtp-Source: AA6agR6iFSgWUqioJM3cCos8yQL3kd9xwZSOi2NKdWec8Az6ONoK4Y4AHdbs6JCUmaa73eshO8JC2Q==
X-Received: by 2002:a05:6870:2041:b0:10d:c70:42c4 with SMTP id l1-20020a056870204100b0010d0c7042c4mr9488473oad.150.1661851915362;
        Tue, 30 Aug 2022 02:31:55 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id m4-20020a4ad504000000b00425678b9c4bsm6474114oos.0.2022.08.30.02.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/51] completion: prompt: use generic colors
Date:   Tue, 30 Aug 2022 04:30:56 -0500
Message-Id: <20220830093138.1581538-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the prompt command mode was introduced in 1bfc51ac81 (Allow
__git_ps1 to be used in PROMPT_COMMAND, 2012-10-10) the assumption was
that it was necessary in order to properly add colors to PS1 in bash,
but this wasn't true.

It's true that the \[ \] markers add the information needed to properly
calculate the width of the prompt, and they have to be added directly to
PS1, a function returning them doesn't work.

But that is because bash coverts the \[ \] markers in PS1 to \001 \002,
which is what readline ultimately needs in order to calculate the width.

We don't need bash to do this conversion, we can use \001 \002
ourselves, and then the prompt command mode is not necessary to display
colors.

This is what functions returning colors are supposed to do [1].

[1] http://mywiki.wooledge.org/BashFAQ/053

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 19 +++++++------------
 t/t9903-bash-prompt.sh           |  8 ++++----
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 1435548e00..01bd807657 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -96,9 +96,7 @@
 #
 # If you would like a colored hint about the current dirty state, set
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
-# the colored output of "git status -sb" and are available only when
-# using __git_ps1 for PROMPT_COMMAND or precmd in Bash,
-# but always available in Zsh.
+# the colored output of "git status -sb".
 #
 # If you would like __git_ps1 to do nothing in the case when the current
 # directory is set up to be ignored by git, then set
@@ -255,12 +253,12 @@ __git_ps1_colorize_gitstring ()
 		local c_lblue='%F{blue}'
 		local c_clear='%f'
 	else
-		# Using \[ and \] around colors is necessary to prevent
+		# Using \001 and \002 around colors is necessary to prevent
 		# issues with command line editing/browsing/completion!
-		local c_red='\[\e[31m\]'
-		local c_green='\[\e[32m\]'
-		local c_lblue='\[\e[1;34m\]'
-		local c_clear='\[\e[0m\]'
+		local c_red=$'\001\e[31m\002'
+		local c_green=$'\001\e[32m\002'
+		local c_lblue=$'\001\e[1;34m\002'
+		local c_clear=$'\001\e[0m\002'
 	fi
 	local bad_color=$c_red
 	local ok_color=$c_green
@@ -564,11 +562,8 @@ __git_ps1 ()
 		b="\${__git_ps1_branch_name}"
 	fi
 
-	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
 	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
-			__git_ps1_colorize_gitstring
-		fi
+		__git_ps1_colorize_gitstring
 	fi
 
 	local f="$h$w$i$s$u$p"
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index c94c351e23..fb396ff3a7 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -13,10 +13,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
-c_red='\\[\\e[31m\\]'
-c_green='\\[\\e[32m\\]'
-c_lblue='\\[\\e[1;34m\\]'
-c_clear='\\[\\e[0m\\]'
+c_red='\001\e[31m\002'
+c_green='\001\e[32m\002'
+c_lblue='\001\e[1;34m\002'
+c_clear='\001\e[0m\002'
 
 unset GIT_PS1_SHOWDIRTYSTATE
 unset GIT_PS1_SHOWSTASHSTATE
-- 
2.37.2.351.g9bf691b78c.dirty

