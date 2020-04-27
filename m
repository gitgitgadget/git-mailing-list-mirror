Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059D8C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDAE5216FD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uACWU3Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD0R7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726269AbgD0R7x (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 13:59:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41575C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:59:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so638908wmh.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R1jNqJ078yqepFQXNLKs1Oc8ApSsvXqmzUQJ/zkTY6k=;
        b=uACWU3AdZZH+yENNc7H4qE4V//wFT8Uh4aiBnznm4uiD06WmBoT+8NoGUU5VgBxByY
         4mt/V9tfz3u6bt0xK/d9hwjPhweuMl+zyLPT8449aMCOl6lwN7Jkt/A9Y5wOPxla61fy
         DHJMay1oRzRe/VjGqdoovhTPjj3S4BUONxlbGc/Omr4QXhTf5kmmqrfABJpAyVPg9t/P
         ZxK3xWcZXJoLn/UIqyItdoBb8ETX2jCSjIwuqAPk3uoqounJwOU/WnYXoSkVmRatFw/4
         CvEawXol8Zt+bWmANGubR/29GSanOOwHA6gtAYyaLPYjXqSLaxsCLLNAOABe+/WZFFRj
         NwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R1jNqJ078yqepFQXNLKs1Oc8ApSsvXqmzUQJ/zkTY6k=;
        b=SjdHPNK8Iiwbiw/0ap9Q0zGOvk8ofQCHdF2Mgg1EJnnt9D1luWtkxCRNt8+/0ttY0h
         kCH3dXH5V1bOAObepLVNYuwVbH7jU4DIfU3vqrUcaNcaF6VUD0FLLtOhxu9Hk3RJkWX9
         lp0RcmerHryKGCSeVydv3Pc771pEZv+kSxEfR0vKUlsIHm0sfMM8/HtNXPN9YksH5RW/
         1pJ5XXKEXqDViXwINFsBa8F0x06SbTM7z+vzKueqkFeyPhnWkd9XCodm+UDwNS08naK9
         bAWZUeGAS6+iFMrvxZtIW7PPDAljlxybUvIqpWyzlGIQ4WaEPHJNb9T6bBpd+BvAPwI/
         57cQ==
X-Gm-Message-State: AGi0PuZF898+P7X6MZml+ThZ+dZqahkA6Vri31S97D/Wyj2WGQCONPnV
        CPgGNziukd1swjD3a0oUn+tJJBXC
X-Google-Smtp-Source: APiQypL3qg3vP+8H/R1u4h3sKTnzh5rKzBzMaZzmbvHe24GiAcs1zy/jVqnvSgDnPzALCT06hN0i3A==
X-Received: by 2002:a1c:e087:: with SMTP id x129mr694370wmg.127.1588010391787;
        Mon, 27 Apr 2020 10:59:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm21626539wrv.12.2020.04.27.10.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 10:59:51 -0700 (PDT)
Message-Id: <pull.771.v2.git.git.1588010390778.gitgitgadget@gmail.com>
In-Reply-To: <pull.771.git.git.1588004500766.gitgitgadget@gmail.com>
References: <pull.771.git.git.1588004500766.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 17:59:49 +0000
Subject: [PATCH v2] rebase: display an error if --root and --fork-point are
 both provided
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     alexander.berg@atos.net, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--root implies we want to rebase all commits since the beginning of
history.  --fork-point means we want to use the reflog of the specified
upstream to find the best common ancestor between <upstream> and
<branch> and only rebase commits since that common ancestor.  These
options are clearly contradictory, so throw an error (instead of
segfaulting on a NULL pointer) if both are specified.

Reported-by: Alexander Berg <alexander.berg@atos.net>
Documentation-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    rebase: display an error if --root and --fork-point are both provided

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-771%2Fnewren%2Frebase-fork-point-root-error-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-771/newren/rebase-fork-point-root-error-v2
Pull-Request: https://github.com/git/git/pull/771

Range-diff vs v1:

 1:  c4508c7ddae ! 1:  307124b00d4 rebase: display an error if --root and --fork-point are both provided
     @@ Commit message
          segfaulting on a NULL pointer) if both are specified.
      
          Reported-by: Alexander Berg <alexander.berg@atos.net>
     +    Documentation-by: Alban Gruin <alban.gruin@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## Documentation/git-rebase.txt ##
     +@@ Documentation/git-rebase.txt: When --fork-point is active, 'fork_point' will be used instead of
     + <branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
     + ends up being empty, the <upstream> will be used as a fallback.
     + +
     +-If either <upstream> or --root is given on the command line, then the
     +-default is `--no-fork-point`, otherwise the default is `--fork-point`.
     ++If <upstream> is given on the command line, then the default is
     ++`--no-fork-point`, otherwise the default is `--fork-point`.
     + +
     + If your branch was based on <upstream> but <upstream> was rewound and
     + your branch contains commits which were dropped, this option can be used
     + with `--keep-base` in order to drop those commits from your branch.
     +++
     ++See also INCOMPATIBLE OPTIONS below.
     + 
     + --ignore-whitespace::
     + --whitespace=<option>::
     +@@ Documentation/git-rebase.txt: In addition, the following pairs of options are incompatible:
     +  * --preserve-merges and --empty=
     +  * --keep-base and --onto
     +  * --keep-base and --root
     ++ * --fork-point and --root
     + 
     + BEHAVIORAL DIFFERENCES
     + -----------------------
     +
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       			die(_("cannot combine '--keep-base' with '--root'"));


 Documentation/git-rebase.txt | 7 +++++--
 builtin/rebase.c             | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607f..fbad356c68e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -414,12 +414,14 @@ When --fork-point is active, 'fork_point' will be used instead of
 <branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
 ends up being empty, the <upstream> will be used as a fallback.
 +
-If either <upstream> or --root is given on the command line, then the
-default is `--no-fork-point`, otherwise the default is `--fork-point`.
+If <upstream> is given on the command line, then the default is
+`--no-fork-point`, otherwise the default is `--fork-point`.
 +
 If your branch was based on <upstream> but <upstream> was rewound and
 your branch contains commits which were dropped, this option can be used
 with `--keep-base` in order to drop those commits from your branch.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --ignore-whitespace::
 --whitespace=<option>::
@@ -600,6 +602,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --empty=
  * --keep-base and --onto
  * --keep-base and --root
+ * --fork-point and --root
 
 BEHAVIORAL DIFFERENCES
 -----------------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index bff53d5d167..287ac1aa21b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1652,6 +1652,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("cannot combine '--keep-base' with '--root'"));
 	}
 
+	if (options.root && fork_point > 0)
+		die(_("cannot combine '--root' with '--fork-point'"));
+
 	if (action != ACTION_NONE && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);

base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
-- 
gitgitgadget
