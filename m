Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1331C12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 03:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E9F610C7
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 03:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhGSDvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 23:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbhGSDvA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 23:51:00 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A955C061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 20:48:01 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t143so19234684oie.8
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 20:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vhgLzeFRAcEhfjoLIg6ov88JLrnlyC+WeQ2z071OQA=;
        b=GLtFW8SrTqhvZAIaUz7vYee+P2R4FvujK6Wj3z5Vz4rwG0lO0YSlN5OCjbeXBPDsrc
         UzRQG7LAFjViffQaa5ZS/64ptu39aVv+OgW2nLYuvzFyaMpkjvteqyCKRsxV9Eb/uw16
         WtBwJSnktGaNO9JPF8WfmE0b69tgFzdr01gqdU9ptu7KKXcp+54jamg5FFFfX+/nS60c
         kbuUu//2Vh0ScNVid5H1CMxoMxuyQ3np6NFWJ625E92037JZfq2pXa7/R23/RqSjui83
         ZGTwuDLG01skBpgHXBNMFkZUiTOCXISfjQDR+NdodVZlSeSsrwnuJyI2A1HM1qg7m2Gf
         71BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vhgLzeFRAcEhfjoLIg6ov88JLrnlyC+WeQ2z071OQA=;
        b=qsxNpiu+LhJM5DE+KqforDBc0ocY+wARiduC/nXhSEeI7amziTcvFXgbnsg3CF9GF7
         Zfv3Ti/kLqRQteiM5g1IUAlzNf4t7nUVTbmPwju7P1ki1NISroMcM8QFNG4Q6brmVO5S
         oDprQEuNrL7WmYuQbWC5CEVFJUAXxTkGcw7wuDaYyfuPnItTga9TWkcCoKXvKsr85y8m
         snVNcnLbWUeMzAA5VyF0qJ3mXm624VCdfc4+ZfpijsKn2Pyek03FhFSV7DN3mgeq6dZj
         ffT270pg16gjjyo5PT2mztFAz+4cVfHHYpWcoN9E4+sCt4Bqt7mGy9uXgxuhZZ1Q9IdC
         Z7EA==
X-Gm-Message-State: AOAM530eH24SxsYNFMWbCrJrZMFXMDgqYw4M5G4Pe0qH+Kc4trKrFpRe
        sB5fbBigp/u3B4rAWgvP2AFDP62Gl0VAmg==
X-Google-Smtp-Source: ABdhPJy2RhPVR7vyVBR0/o28FMiJwThwlEqb5u9o472ima9rW/Rzd4ZlLNXpQcw1gyahql0MgnRJLQ==
X-Received: by 2002:aca:350a:: with SMTP id c10mr21231089oia.60.1626666480651;
        Sun, 18 Jul 2021 20:48:00 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id r24sm3415411otg.14.2021.07.18.20.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 20:47:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Mathias Kunter <mathiaskunter@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] push: fix default action
Date:   Sun, 18 Jul 2021 22:47:56 -0500
Message-Id: <20210719034758.1288766-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210714164900.606330-1-felipe.contreras@gmail.com>
References: <20210714164900.606330-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default action "simple" doesn't make sense. It's supposed to be the
same as "current", except with an extra safety in case the name of the
upstream branch doesn't match the name of the current branch (and we are
pushing to the same remote). But if there's no upstream configured
there's no need for any check.

If this works:

  git clone $central .
  ...
  git push

Then this should too:

  git clone $central .
  git checkout -b topic
  ...
  git push

Cloning automatically sets up an upstream branch for "master", and
therefore it passes the safety check, but that is much more dangerous
than pushing any other branch.

Why do we barf with "topic", but not "master"?

Instead of behaving like "current" if the current branch doesn't have an
upstream configured, `git push` fails like "upstream", so it's a
Frankensteinian action.

If the upstream branch isn't configured, "simple" should not abort, just
like "current".

Since v1 I changed get_upstream_ref to always be non-fatal, and die on
the only caller instead.

Felipe Contreras (2):
  push: reorganize get_upstream_ref
  push: make default consistent

 Documentation/config/push.txt |  5 +++--
 Documentation/git-push.txt    |  6 +++---
 builtin/push.c                | 25 +++++++++++++++----------
 t/t5528-push-default.sh       |  2 +-
 4 files changed, 22 insertions(+), 16 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  7031b26f28 push: reorganize get_upstream_ref
1:  20bc9059f9 ! 2:  964b3c4289 push: make default consistent
    @@ Commit message
         pushing to the same remote). But if there's no upstream configured
         there's no need for any check.
     
    -    If this works:
    -
    -      git clone $central .
    -      ...
    -      git push
    -
    -    Then this should too:
    -
    -      git clone $central .
    -      git checkout -b fix-1
    -      ...
    -      git push
    -
    -    Cloning automatically sets up an upstream branch for "master", and
    -    therefore it passes the safety check, but that is much more dangerous
    -    than pushing any other branch.
    -
    -    Why do we barf with "fix-1", but not "master"?
    -
         Instead of behaving like "current" if the current branch doesn't have an
         upstream configured, `git push` fails like "upstream", so it's a
         Frankensteinian action.
    @@ Documentation/git-push.txt: what to push (See linkgit:git-config[1] for the mean
      
     
      ## builtin/push.c ##
    -@@ builtin/push.c: static const char message_detached_head_die[] =
    - 	   "\n"
    - 	   "    git push %s HEAD:<name-of-remote-branch>\n");
    - 
    --static const char *get_upstream_ref(struct branch *branch, const char *remote_name)
    -+static const char *get_upstream_ref(struct branch *branch, const char *remote_name, int fatal)
    - {
    --	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
    -+	if (!branch->merge_nr || !branch->merge || !branch->remote_name) {
    -+		if (!fatal)
    -+			return NULL;
    - 		die(_("The current branch %s has no upstream branch.\n"
    - 		    "To push the current branch and set the remote as upstream, use\n"
    - 		    "\n"
    -@@ builtin/push.c: static const char *get_upstream_ref(struct branch *branch, const char *remote_na
    - 		    branch->name,
    - 		    remote_name,
    - 		    branch->name);
    -+	}
    - 	if (branch->merge_nr != 1)
    - 		die(_("The current branch %s has multiple upstream branches, "
    - 		    "refusing to push."), branch->name);
     @@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
    - 	switch (push_default) {
    - 	default:
    - 	case PUSH_DEFAULT_UNSPECIFIED:
    --	case PUSH_DEFAULT_SIMPLE:
    -+	case PUSH_DEFAULT_SIMPLE: {
    -+		const char *upstream;
    -+
      		if (!same_remote)
      			break;
    --		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
    -+		upstream = get_upstream_ref(branch, remote->name, 0);
    -+		if (upstream && strcmp(branch->refname, upstream))
    + 		dst = get_upstream_ref(branch);
    +-		if (!dst)
    +-			die(_("The current branch %s has no upstream branch.\n"
    +-			    "To push the current branch and set the remote as upstream, use\n"
    +-			    "\n"
    +-			    "    git push --set-upstream %s %s\n"),
    +-			    branch->name,
    +-			    remote->name,
    +-			    branch->name);
    +-		if (strcmp(branch->refname, dst))
    ++		if (dst && strcmp(branch->refname, dst))
      			die_push_simple(branch, remote);
    ++		if (!dst)
    ++			dst = branch->refname;
      		break;
    -+	}
      
      	case PUSH_DEFAULT_UPSTREAM:
    - 		if (!same_remote)
    -@@ builtin/push.c: static void setup_default_push_refspecs(struct remote *remote)
    - 			      "your current branch '%s', without telling me what to push\n"
    - 			      "to update which remote branch."),
    - 			    remote->name, branch->name);
    --		dst = get_upstream_ref(branch, remote->name);
    -+		dst = get_upstream_ref(branch, remote->name, 1);
    - 		break;
    - 
    - 	case PUSH_DEFAULT_CURRENT:
     
      ## t/t5528-push-default.sh ##
     @@ t/t5528-push-default.sh: test_expect_success 'push from/to new branch with current creates remote branch'
-- 
2.32.0.40.gb9b36f9b52

