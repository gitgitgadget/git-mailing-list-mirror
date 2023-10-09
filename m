Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3381EE95A9E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 16:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377104AbjJIQGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377102AbjJIQGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 12:06:48 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10DA99
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 09:06:46 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so59071651fa.3
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696867605; x=1697472405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dk3Kl39hp1nHMtTh3nJOxbATWEQvZhJlFKft4pP6JSw=;
        b=inzjDjX8QRbMlGPOsbtN5/w1jt1+1UwOd67l6sNko0LOhlkQBaHIG4Gt8kBJLRmq0x
         oY/prxOUn8/HF5SrFHg+zXmiSppaobp3pujmopFRrSfNldV1C0bSL8x0f/ctKO8SIdPq
         8zK+k7rPuBrMRjC+VRwG5P/kNfEF67DqVYDHo5KpXNqFBYaf3ZfGjzsTH5OzTWDrx4Mk
         3cnZ2LM5nbkztDocXoMmoD09DwP5vdqzIOcEZ9MiGxi/A5rmrU7pik31rXp4JloC5P4F
         xm6N4x3nPcbo+ZHrCT57FBc8eV+r/i2G0NWqEx/3L+AtQG1fQaI9oocX8MCHm6wwN+oF
         7xVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867605; x=1697472405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dk3Kl39hp1nHMtTh3nJOxbATWEQvZhJlFKft4pP6JSw=;
        b=IAQH0LsKnPChBcKTNTCs7WnAXdOoENHuwuODl8TxyiAB76qMo6jFI734meUjtOkK3F
         E6W4plAEVc9ipqFJ0dlFGMxyUKsLxy0mfoBFlQWvZqcAg/2XCxMm+ZFEqqEQT6nXFCIr
         PqecNv3/RNxbU8H2YcjTU5AisrtO+nsHAoqPkTAhj+GJOt27EFEgK4ZU872OyPGbiGwH
         xacNsV3uxGAYkT9TIPHjREZa6weweUHiPFNjj4tyjauxdupY2Lcig97PWvNd8sK02Iq1
         xiekBa9dPwQP7DIY19MhI6MtDVj7OLO7cEQSkJTqpmq8o9myoQmAfdyzVAVjbobNH2xM
         5pHw==
X-Gm-Message-State: AOJu0Yw40HHBQ805UIaxWbmFJWdMxv+xNmyUo4K00HVg1ITKkh/t/bH7
        E1RPu8reFsDxFY212WPiklY=
X-Google-Smtp-Source: AGHT+IFhjl53QlL2tE2h3nVyFAaeT4YImm+VxxhWEcJvMyu3vxX3JXcPmNqALHLeP7uykb8dZ5Ro7A==
X-Received: by 2002:a2e:9542:0:b0:2bf:ff17:8122 with SMTP id t2-20020a2e9542000000b002bfff178122mr11675216ljh.17.1696867604441;
        Mon, 09 Oct 2023 09:06:44 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j22-20020a2e8256000000b002b6daa3fa2csm2019715ljh.69.2023.10.09.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:06:44 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v4 0/3] diff-merges: introduce '--dd' option
Date:   Mon,  9 Oct 2023 19:05:32 +0300
Message-Id: <20231009160535.236523-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230909125446.142715-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new convenience option requests full diff with respect to first
parent, so that

  git log --dd

will output diff with respect to first parent for every commit,
universally, no matter how many parents the commit turns out to have.

Gives user quick and universal way to see what changes, exactly, were
brought to a branch by merges as well as by regular commits.

'--dd' is implemented as pure synonym for "--diff-merges=first-parent
--patch".

The first commit in the series tweaks diff-merges documentation a bit,
and is valuable by itself. It's put here as '--dd' implementation
commit depends on it in its documentation part.

Note: the need for this new convenience option mostly emerged from
denial by the community of patches that modify '-m' behavior to imply
'-p' as the rest of similar options (such as --cc) do. So, basically,
'--dd' is what '-m' should have been to be more useful.

Updates in v4:

  * Removed "(which see)" reference from documentation that caused
    confusion.

  * Removed explanation why it's --dd and not simply -d from commit
    message.

  * Refined --remerge-diff short description according to Junio and
    Elijah comments.

  * Added explanation of --dd purpose.

  * Fixed style and syntax of "on,m::" description.

Updates in v3:

  * Option renamed from '-d' to '--dd' due to Junio overpowering
    request to keep short-and-sweet '-d' reserved for another (yet
    unspecified) use.

  * Added completion of '--dd' to git-completion.bash.

Updates in v2:

  * Reordered documentation for diff-merges formats in accordance with
    Junio recommendation.

  * Removed clarification of surprising -m behavior due to controversy
    with Junio on how exactly it should look like.

Sergey Organov (3):
  diff-merges: improve --diff-merges documentation
  diff-merges: introduce '--dd' option
  completion: complete '--dd'

 Documentation/diff-options.txt         | 105 ++++++++++++++-----------
 Documentation/git-log.txt              |   4 +-
 contrib/completion/git-completion.bash |   2 +-
 diff-merges.c                          |   3 +
 t/t4013-diff-various.sh                |   8 ++
 5 files changed, 73 insertions(+), 49 deletions(-)

Interdiff against v3:
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f80d493dd4c8..23f95e6172b9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -45,7 +45,7 @@ endif::git-format-patch[]
 ifdef::git-log[]
 -m::
 	Show diffs for merge commits in the default format. This is
-	similar to '--diff-merges=on' (which see) except `-m` will
+	similar to '--diff-merges=on', except `-m` will
 	produce no output unless `-p` is given as well.
 
 -c::
@@ -62,7 +62,7 @@ ifdef::git-log[]
 	Shortcut for '--diff-merges=first-parent -p'.
 
 --remerge-diff::
-	Produce diff against re-merge.
+	Produce remerge-diff output for merge commits.
 	Shortcut for '--diff-merges=remerge -p'.
 
 --no-diff-merges::
@@ -83,7 +83,7 @@ off, none::
 on, m::
 	Make diff output for merge commits to be shown in the default
 	format. The default format could be changed using
-	`log.diffMerges` configuration parameter, which default value
+	`log.diffMerges` configuration variable, whose default value
 	is `separate`.
 +
 first-parent, 1::
-- 
2.25.1

