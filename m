Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C19C433E3
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5533922D08
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUlqGGB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgHEUJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgHEQ3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:29:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E08C00869B
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 09:29:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y3so41301976wrl.4
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OMAanJ1sw+oWyqBNSs84aRYk7IjFBygeYZ0gO8A0iqc=;
        b=FUlqGGB+9DH/SQn7F/HUmH096mpOrDdOdZV32uBo288hBQpPj5b+RL/y0WLXU/e6pt
         dM6gQ7DJXUi6WyyEHYVha2HBXLrZvF7xE9LFOdRfgOYVJkccfLk5xChZwXoXnhTnR7AD
         LddO9boLKyeZyLq0tvmbQTyf0sVT1EDyGVHbROlQahZwDy3Xd2Oto3VfFxaAqqEph59L
         bmnaJZ0O/Ylz9P5LxtZckPk8gBVfovbSP9A0kirwRJ/FjUIYWnKXSd2EL0wNBiZtj/UE
         olxq2CDbLfZYhaylRQD8hyef1PZiC+GO/BFBlWqvutmP02dad7JqaHvHc3L9b4tCQcLF
         wzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OMAanJ1sw+oWyqBNSs84aRYk7IjFBygeYZ0gO8A0iqc=;
        b=Xv38FOxH+J/CxaQwhSpklSW4PisGOe6WwsmEnw5dqcOpZ/9J7UJhkjKXLUrG+y0obR
         Nf1RqYdq4ROt01OXxcktSe087DCVyXCEBDUDzpqPBLxTNI22zkrRw+aF9N7rBWJFOoNo
         1PNT9gwe+qlOYX3VEOM/fGiY5G3mnn4bsx1ytmZDXQQGrZnh9WcEgkywUQjqBSitEgiL
         H2KTk4pXYlBhRfHGQ+6z3nJLqhBGhgioMLMCI+n+7Y8X5eyZxqfBdyG99mdKTq/X7sH0
         Kwyyn6dovdjvHQ4X1zTsBgm7T339tPNoAhVrCi2afXP/8TueAN8xb4S6PpUUE3CeLpRJ
         S0rQ==
X-Gm-Message-State: AOAM5315sO7d2grMt7KxH5aCrHmYwRYMInom1sF5fuGg8IrQocuYym0j
        0Z1SZqVfJpbCECKTBlzmFCGJ+LgW
X-Google-Smtp-Source: ABdhPJx5BcEqWrSz5hPO6y1uJGoXmDdf/9cs678Vw+DAuoH+ZhocnOkqttFRfIBPxh0qWZHtIOCydA==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr3349210wrv.86.1596644953317;
        Wed, 05 Aug 2020 09:29:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g145sm4962167wmg.23.2020.08.05.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 09:29:12 -0700 (PDT)
Message-Id: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 16:29:12 +0000
Subject: [PATCH] Collect merge-related tests to t64xx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The tests for the merge machinery are spread over several places.
Collect them into t64xx for simplicity.  Some notes:

t60[234]*.sh:
  Merge tests started in t602*, overgrew bisect and remote tracking
  tests in t6030, t6040, and t6041, and nearly overtook replace tests
  in t6050.  This made picking out relevant tests that I wanted to run
  in a tighter loop slightly more annoying for years.

t303*.sh:
  These started out as tests for the 'merge-recursive' toplevel command,
  but did not restrict to that and had lots of overlap with the
  underlying merge machinery.
t7405, t7613:
  submodule-specific merge logic started out in submodule.c but was
  moved to merge-recursive.c in commit 18cfc08866 ("submodule.c: move
  submodule merging to merge-recursive.c", 2018-05-15).  Since these
  tests are about the logic found in the merge machinery, moving these
  tests to be with the merge tests makes sense.

t7607, t7609:
  Having tests spread all over the place makes it more likely that
  additional tests related to a certain piece of logic grow in all those
  other places.  Much like t303*.sh, these two tests were about the
  underlying merge machinery rather than outer levels.

Tests that were NOT moved:

t76[01]*.sh:
  Other than the four tests mentioned above, the remaining tests in
  t76[01]*.sh are related to non-recursive merge strategies, parameter
  parsing, and other stuff associated with the highlevel builtin/merge.c
  rather than the recursive merge machinery.

t3[45]*.sh:
  The rebase testcases in t34*.sh also test the merge logic pretty
  heavily; sometimes changes I make only trigger failures in the rebase
  tests.  The rebase tests are already nicely coupled together, though,
  and I didn't want to mess that up.  Similar comments apply for the
  cherry-pick tests in t35*.sh.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    Collect merge machinery related tests into t64*.sh
    
    Although there are a couple in-flight topics that modify some of these
    tests (en/eol-attr-gotchas and bc/sha-256-part-3), since this commit
    only contains 100% renames, it merges cleanly and automatically with
    both next and seen.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-827%2Fnewren%2Fmerge-test-rename-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-827/newren/merge-test-rename-v1
Pull-Request: https://github.com/git/git/pull/827

 t/{t6020-merge-df.sh => t6400-merge-df.sh}                        | 0
 t/{t6021-merge-criss-cross.sh => t6401-merge-criss-cross.sh}      | 0
 t/{t6022-merge-rename.sh => t6402-merge-rename.sh}                | 0
 t/{t6023-merge-file.sh => t6403-merge-file.sh}                    | 0
 t/{t6024-recursive-merge.sh => t6404-recursive-merge.sh}          | 0
 t/{t6025-merge-symlinks.sh => t6405-merge-symlinks.sh}            | 0
 t/{t6026-merge-attr.sh => t6406-merge-attr.sh}                    | 0
 t/{t6027-merge-binary.sh => t6407-merge-binary.sh}                | 0
 t/{t6028-merge-up-to-date.sh => t6408-merge-up-to-date.sh}        | 0
 t/{t6029-merge-subtree.sh => t6409-merge-subtree.sh}              | 0
 t/{t6031-merge-filemode.sh => t6411-merge-filemode.sh}            | 0
 t/{t6032-merge-large-rename.sh => t6412-merge-large-rename.sh}    | 0
 t/{t6033-merge-crlf.sh => t6413-merge-crlf.sh}                    | 0
 ...6034-merge-rename-nocruft.sh => t6414-merge-rename-nocruft.sh} | 0
 ...6035-merge-dir-to-symlink.sh => t6415-merge-dir-to-symlink.sh} | 0
 ...-recursive-corner-cases.sh => t6416-recursive-corner-cases.sh} | 0
 t/{t6037-merge-ours-theirs.sh => t6417-merge-ours-theirs.sh}      | 0
 t/{t6038-merge-text-auto.sh => t6418-merge-text-auto.sh}          | 0
 t/{t6039-merge-ignorecase.sh => t6419-merge-ignorecase.sh}        | 0
 ...-rename-corner-cases.sh => t6422-merge-rename-corner-cases.sh} | 0
 ...ge-rename-directories.sh => t6423-merge-rename-directories.sh} | 0
 ...ed-index-changes.sh => t6424-merge-unrelated-index-changes.sh} | 0
 t/{t6045-merge-rename-delete.sh => t6425-merge-rename-delete.sh}  | 0
 ...p-unneeded-updates.sh => t6426-merge-skip-unneeded-updates.sh} | 0
 ...-diff3-conflict-markers.sh => t6427-diff3-conflict-markers.sh} | 0
 t/{t3030-merge-recursive.sh => t6430-merge-recursive.sh}          | 0
 t/{t3031-merge-criscross.sh => t6431-merge-criscross.sh}          | 0
 ...ve-space-options.sh => t6432-merge-recursive-space-options.sh} | 0
 t/{t3033-merge-toplevel.sh => t6433-merge-toplevel.sh}            | 0
 ...-rename-options.sh => t6434-merge-recursive-rename-options.sh} | 0
 t/{t3035-merge-sparse.sh => t6435-merge-sparse.sh}                | 0
 t/{t7607-merge-overwrite.sh => t6436-merge-overwrite.sh}          | 0
 t/{t7405-submodule-merge.sh => t6437-submodule-merge.sh}          | 0
 ...e-submodule.sh => t6438-submodule-directory-file-conflicts.sh} | 0
 t/{t7609-merge-co-error-msgs.sh => t6439-merge-co-error-msgs.sh}  | 0
 35 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t6020-merge-df.sh => t6400-merge-df.sh} (100%)
 rename t/{t6021-merge-criss-cross.sh => t6401-merge-criss-cross.sh} (100%)
 rename t/{t6022-merge-rename.sh => t6402-merge-rename.sh} (100%)
 rename t/{t6023-merge-file.sh => t6403-merge-file.sh} (100%)
 rename t/{t6024-recursive-merge.sh => t6404-recursive-merge.sh} (100%)
 rename t/{t6025-merge-symlinks.sh => t6405-merge-symlinks.sh} (100%)
 rename t/{t6026-merge-attr.sh => t6406-merge-attr.sh} (100%)
 rename t/{t6027-merge-binary.sh => t6407-merge-binary.sh} (100%)
 rename t/{t6028-merge-up-to-date.sh => t6408-merge-up-to-date.sh} (100%)
 rename t/{t6029-merge-subtree.sh => t6409-merge-subtree.sh} (100%)
 rename t/{t6031-merge-filemode.sh => t6411-merge-filemode.sh} (100%)
 rename t/{t6032-merge-large-rename.sh => t6412-merge-large-rename.sh} (100%)
 rename t/{t6033-merge-crlf.sh => t6413-merge-crlf.sh} (100%)
 rename t/{t6034-merge-rename-nocruft.sh => t6414-merge-rename-nocruft.sh} (100%)
 rename t/{t6035-merge-dir-to-symlink.sh => t6415-merge-dir-to-symlink.sh} (100%)
 rename t/{t6036-recursive-corner-cases.sh => t6416-recursive-corner-cases.sh} (100%)
 rename t/{t6037-merge-ours-theirs.sh => t6417-merge-ours-theirs.sh} (100%)
 rename t/{t6038-merge-text-auto.sh => t6418-merge-text-auto.sh} (100%)
 rename t/{t6039-merge-ignorecase.sh => t6419-merge-ignorecase.sh} (100%)
 rename t/{t6042-merge-rename-corner-cases.sh => t6422-merge-rename-corner-cases.sh} (100%)
 rename t/{t6043-merge-rename-directories.sh => t6423-merge-rename-directories.sh} (100%)
 rename t/{t6044-merge-unrelated-index-changes.sh => t6424-merge-unrelated-index-changes.sh} (100%)
 rename t/{t6045-merge-rename-delete.sh => t6425-merge-rename-delete.sh} (100%)
 rename t/{t6046-merge-skip-unneeded-updates.sh => t6426-merge-skip-unneeded-updates.sh} (100%)
 rename t/{t6047-diff3-conflict-markers.sh => t6427-diff3-conflict-markers.sh} (100%)
 rename t/{t3030-merge-recursive.sh => t6430-merge-recursive.sh} (100%)
 rename t/{t3031-merge-criscross.sh => t6431-merge-criscross.sh} (100%)
 rename t/{t3032-merge-recursive-space-options.sh => t6432-merge-recursive-space-options.sh} (100%)
 rename t/{t3033-merge-toplevel.sh => t6433-merge-toplevel.sh} (100%)
 rename t/{t3034-merge-recursive-rename-options.sh => t6434-merge-recursive-rename-options.sh} (100%)
 rename t/{t3035-merge-sparse.sh => t6435-merge-sparse.sh} (100%)
 rename t/{t7607-merge-overwrite.sh => t6436-merge-overwrite.sh} (100%)
 rename t/{t7405-submodule-merge.sh => t6437-submodule-merge.sh} (100%)
 rename t/{t7613-merge-submodule.sh => t6438-submodule-directory-file-conflicts.sh} (100%)
 rename t/{t7609-merge-co-error-msgs.sh => t6439-merge-co-error-msgs.sh} (100%)

diff --git a/t/t6020-merge-df.sh b/t/t6400-merge-df.sh
similarity index 100%
rename from t/t6020-merge-df.sh
rename to t/t6400-merge-df.sh
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6401-merge-criss-cross.sh
similarity index 100%
rename from t/t6021-merge-criss-cross.sh
rename to t/t6401-merge-criss-cross.sh
diff --git a/t/t6022-merge-rename.sh b/t/t6402-merge-rename.sh
similarity index 100%
rename from t/t6022-merge-rename.sh
rename to t/t6402-merge-rename.sh
diff --git a/t/t6023-merge-file.sh b/t/t6403-merge-file.sh
similarity index 100%
rename from t/t6023-merge-file.sh
rename to t/t6403-merge-file.sh
diff --git a/t/t6024-recursive-merge.sh b/t/t6404-recursive-merge.sh
similarity index 100%
rename from t/t6024-recursive-merge.sh
rename to t/t6404-recursive-merge.sh
diff --git a/t/t6025-merge-symlinks.sh b/t/t6405-merge-symlinks.sh
similarity index 100%
rename from t/t6025-merge-symlinks.sh
rename to t/t6405-merge-symlinks.sh
diff --git a/t/t6026-merge-attr.sh b/t/t6406-merge-attr.sh
similarity index 100%
rename from t/t6026-merge-attr.sh
rename to t/t6406-merge-attr.sh
diff --git a/t/t6027-merge-binary.sh b/t/t6407-merge-binary.sh
similarity index 100%
rename from t/t6027-merge-binary.sh
rename to t/t6407-merge-binary.sh
diff --git a/t/t6028-merge-up-to-date.sh b/t/t6408-merge-up-to-date.sh
similarity index 100%
rename from t/t6028-merge-up-to-date.sh
rename to t/t6408-merge-up-to-date.sh
diff --git a/t/t6029-merge-subtree.sh b/t/t6409-merge-subtree.sh
similarity index 100%
rename from t/t6029-merge-subtree.sh
rename to t/t6409-merge-subtree.sh
diff --git a/t/t6031-merge-filemode.sh b/t/t6411-merge-filemode.sh
similarity index 100%
rename from t/t6031-merge-filemode.sh
rename to t/t6411-merge-filemode.sh
diff --git a/t/t6032-merge-large-rename.sh b/t/t6412-merge-large-rename.sh
similarity index 100%
rename from t/t6032-merge-large-rename.sh
rename to t/t6412-merge-large-rename.sh
diff --git a/t/t6033-merge-crlf.sh b/t/t6413-merge-crlf.sh
similarity index 100%
rename from t/t6033-merge-crlf.sh
rename to t/t6413-merge-crlf.sh
diff --git a/t/t6034-merge-rename-nocruft.sh b/t/t6414-merge-rename-nocruft.sh
similarity index 100%
rename from t/t6034-merge-rename-nocruft.sh
rename to t/t6414-merge-rename-nocruft.sh
diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
similarity index 100%
rename from t/t6035-merge-dir-to-symlink.sh
rename to t/t6415-merge-dir-to-symlink.sh
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
similarity index 100%
rename from t/t6036-recursive-corner-cases.sh
rename to t/t6416-recursive-corner-cases.sh
diff --git a/t/t6037-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
similarity index 100%
rename from t/t6037-merge-ours-theirs.sh
rename to t/t6417-merge-ours-theirs.sh
diff --git a/t/t6038-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
similarity index 100%
rename from t/t6038-merge-text-auto.sh
rename to t/t6418-merge-text-auto.sh
diff --git a/t/t6039-merge-ignorecase.sh b/t/t6419-merge-ignorecase.sh
similarity index 100%
rename from t/t6039-merge-ignorecase.sh
rename to t/t6419-merge-ignorecase.sh
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
similarity index 100%
rename from t/t6042-merge-rename-corner-cases.sh
rename to t/t6422-merge-rename-corner-cases.sh
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
similarity index 100%
rename from t/t6043-merge-rename-directories.sh
rename to t/t6423-merge-rename-directories.sh
diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
similarity index 100%
rename from t/t6044-merge-unrelated-index-changes.sh
rename to t/t6424-merge-unrelated-index-changes.sh
diff --git a/t/t6045-merge-rename-delete.sh b/t/t6425-merge-rename-delete.sh
similarity index 100%
rename from t/t6045-merge-rename-delete.sh
rename to t/t6425-merge-rename-delete.sh
diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
similarity index 100%
rename from t/t6046-merge-skip-unneeded-updates.sh
rename to t/t6426-merge-skip-unneeded-updates.sh
diff --git a/t/t6047-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
similarity index 100%
rename from t/t6047-diff3-conflict-markers.sh
rename to t/t6427-diff3-conflict-markers.sh
diff --git a/t/t3030-merge-recursive.sh b/t/t6430-merge-recursive.sh
similarity index 100%
rename from t/t3030-merge-recursive.sh
rename to t/t6430-merge-recursive.sh
diff --git a/t/t3031-merge-criscross.sh b/t/t6431-merge-criscross.sh
similarity index 100%
rename from t/t3031-merge-criscross.sh
rename to t/t6431-merge-criscross.sh
diff --git a/t/t3032-merge-recursive-space-options.sh b/t/t6432-merge-recursive-space-options.sh
similarity index 100%
rename from t/t3032-merge-recursive-space-options.sh
rename to t/t6432-merge-recursive-space-options.sh
diff --git a/t/t3033-merge-toplevel.sh b/t/t6433-merge-toplevel.sh
similarity index 100%
rename from t/t3033-merge-toplevel.sh
rename to t/t6433-merge-toplevel.sh
diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t6434-merge-recursive-rename-options.sh
similarity index 100%
rename from t/t3034-merge-recursive-rename-options.sh
rename to t/t6434-merge-recursive-rename-options.sh
diff --git a/t/t3035-merge-sparse.sh b/t/t6435-merge-sparse.sh
similarity index 100%
rename from t/t3035-merge-sparse.sh
rename to t/t6435-merge-sparse.sh
diff --git a/t/t7607-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
similarity index 100%
rename from t/t7607-merge-overwrite.sh
rename to t/t6436-merge-overwrite.sh
diff --git a/t/t7405-submodule-merge.sh b/t/t6437-submodule-merge.sh
similarity index 100%
rename from t/t7405-submodule-merge.sh
rename to t/t6437-submodule-merge.sh
diff --git a/t/t7613-merge-submodule.sh b/t/t6438-submodule-directory-file-conflicts.sh
similarity index 100%
rename from t/t7613-merge-submodule.sh
rename to t/t6438-submodule-directory-file-conflicts.sh
diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
similarity index 100%
rename from t/t7609-merge-co-error-msgs.sh
rename to t/t6439-merge-co-error-msgs.sh

base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
-- 
gitgitgadget
