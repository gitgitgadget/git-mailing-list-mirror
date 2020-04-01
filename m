Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CEAC2BA14
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7982077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvfon5Vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgDAESE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:18:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40771 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbgDAER7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id u10so28876762wro.7
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2g6HZDyXL8V+yRc/RxFnIwIwC4idUv4fMD3QVL8RJLc=;
        b=Fvfon5VczJWVukkRiqmCN8xotpbDiXABjMkKPmOeCrCPMzP4mCn9ggkRJgFHPLnTvR
         VTTQpAOKpLlG01w7F93O6g6fCj8PSqlRphge7UYQQxj2NDjSkk/n5LQIaZKDHoPdc+8a
         7+b+wb9v2irW9JIFsf0MCK6q0l8jXOvAMveSR68FF0YMiQNl2SuXq2NmsQc6Eqd2+Nak
         si1ZD4QsSNTWSn/80hBIhfeBgNHqfDnZO0lEeELbr4ojoN9ANT/dm+cK45LbZRdlDjPY
         +cc8wKn6MzIkjG0WNIEcZOKNwJlzq+WwPR7FKNoQedTEjQEhb3wsvVJgpP66x7CjO79k
         kSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2g6HZDyXL8V+yRc/RxFnIwIwC4idUv4fMD3QVL8RJLc=;
        b=oMRGsSkfMp1KT/6e6lqRT2O6PXW7B2ARpijQf4KpPSV+nMtFG2Hss7WUzwkiVaCKan
         ArDOza9xn+Bnfs/l5RrS7hmkUyYNJ7/KXz33UfdmUkfy7yieQP9gPq7/NRdTjYfYXrTU
         /EdiApn/+AmLGs8dCBq2Z4tKKDF72v9hX43Yy/pB+zl8W/uOvEFc38y/5D1/nr10UPav
         szFDScifx1NEL4k8zERnui3avykShbBv6UylDLgv5ddxCXVXHe2gH897Ie1xym1dIA0a
         EPTqbNRrGnocpYg6yLx0ZEmKqZQ+OEWnxQtH59uhHl1ErPZf4SxF0kY/Uh0JBp5lKV/J
         i5mg==
X-Gm-Message-State: ANhLgQ38rHcMie5R6sq1aBA3TMaVBmD1nS7zExIfmYcizye4da6hv9Bo
        On5Xh+WJqavbUWPg590UoInkB4pi
X-Google-Smtp-Source: ADFU+vtXF3TpdILBAy4gUowgoaThlux1htfe90o5MNbAKBp3dLakyLWpBboSSVQZ9IJ2V8ggomJCfw==
X-Received: by 2002:adf:fdd2:: with SMTP id i18mr23370364wrs.165.1585714677560;
        Tue, 31 Mar 2020 21:17:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w67sm946913wmb.41.2020.03.31.21.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:57 -0700 (PDT)
Message-Id: <725adf0a9b89a5426579b73cc5a3a35999eac9a1.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:46 +0000
Subject: [PATCH v5 12/12] completion: fix 'git add' on paths under an
 untracked directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As reported on the git mailing list, since git-2.25,
    git add untracked-dir/
has been tab completing to
    git add untracked-dir/./

The cause for this was that with commit b9670c1f5e (dir: fix checks on
common prefix directory, 2019-12-19),
    git ls-files -o --directory untracked-dir/
(or the equivalent `git -C untracked-dir ls-files -o --directory`) began
reporting
    untracked-dir/
instead of listing paths underneath that directory.  It may also be
worth noting that the real command in question was
    git -C untracked-dir ls-files -o --directory '*'
which is equivalent to
    git ls-files -o --directory 'untracked-dir/*'
which behaves the same for the purposes of this issue (the '*' can match
the empty string), but becomes relevant for the proposed fix.

At first, based on the report, I decided to try to view this as a
regression and tried to find a way to recover the old behavior without
breaking other stuff, or at least breaking as little as possible.
However, in the end, I couldn't figure out a way to do it that wouldn't
just cause lots more problems than it solved.  The old behavior was a
bug:
  * Although older git would avoid cleaning anything with `git clean -f
    .git`, it would wipe out everything under that direcotry with `git
    clean -f .git/`.  Despite the difference in command used, this is
    relevant because the exact same change that fixed clean changed the
    behavior of ls-files.
  * Older git would report different results based solely on presence or
    absence of a trailing slash for $SUBDIR in the command `git ls-files
    -o --directory $SUBDIR`.
  * Older git violated the documented behavior of not recursing into
    directories that matched the pathspec when --directory was
    specified.
  * And, after all, commit b9670c1f5e (dir: fix checks on common prefix
    directory, 2019-12-19) didn't overlook this issue; it explicitly
    stated that the behavior of the command was being changed to bring
    it inline with the docs.

(Also, if it helps, despite that commit being merged during the 2.25
series, this bug was not reported during the 2.25 cycle, nor even during
most of the 2.26 cycle -- it was reported a day before 2.26 was
released.  So the impact of the change is at least somewhat small.)

Instead of relying on a bug of ls-files in reporting the wrong content,
change the invocation of ls-files used by git-completion to make it grab
paths one depth deeper.  Do this by changing '$DIR/*' (match $DIR/ plus
0 or more characters) into '$DIR/?*' (match $DIR/ plus 1 or more
characters).  Note that the '?' character should not be added when
trying to complete a filename (e.g. 'git ls-files -o --directory
"merge.c?*"' would not correctly return "merge.c" when such a file
exists), so we have to make sure to add the '?' character only in cases
where the path specified so far is a directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 t/t9902-completion.sh                  | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e4d9ff4a95c..1032b642297 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -504,7 +504,7 @@ __git_index_files ()
 {
 	local root="$2" match="$3"
 
-	__git_ls_files_helper "$root" "$1" "$match" |
+	__git_ls_files_helper "$root" "$1" "${match:-?}" |
 	awk -F / -v pfx="${2//\\/\\\\}" '{
 		paths[$1] = 1
 	}
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 93877ba9cd6..d9a6425671f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1581,6 +1581,11 @@ test_expect_success 'complete files' '
 	echo modify > modified &&
 	test_completion "git add " "modified" &&
 
+	mkdir -p some/deep &&
+	touch some/deep/path &&
+	test_completion "git add some/" "some/deep" &&
+	git clean -f some &&
+
 	touch untracked &&
 
 	: TODO .gitignore should not be here &&
-- 
gitgitgadget
