Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E86C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 10:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhLKKAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 05:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhLKKAA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 05:00:00 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07CC061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 01:59:59 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c3so13017624iob.6
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 01:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOm+k+VqV/FqZGFp00l64U0hkcGvpNG+r9Y89xxz3Iw=;
        b=akr/AWNCTHwNTsvLieQUcij7hTOT9+2vhuKPYze5PM3pdwSZPlSj5SX9Qa7pHCnFKb
         RU7b7N+EwAs9PA+2KIWyhrU+8esXHCBeshWJeYtZQmp+8/xB+rx+/wGtAIsDYOP6bGCB
         qmC/t9yo7wf60GgscMxKjbwJsgbFB8gFTjIrrIrGAWcihOFc3gQXti5kN/9ht9lvDlpv
         /CKo0Fv9xtjQchTXWJuRvdv2kt/F9fAcThIIMlxCiM6cM0x/NmKEW6ESqv7aJ8bw4ee6
         O73GiH9CqWqzNDB2QzJwfnY0qHIeO17CATdK3ykrj3ms2O0pL4HLoi4dkI8GPJBhwEJ2
         EWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XOm+k+VqV/FqZGFp00l64U0hkcGvpNG+r9Y89xxz3Iw=;
        b=jItT9vyt8AgEQ2B5ng8KxbInzkvbqvwaQ/9Uu/KGzFkmellBC7ciRVlgdH8uwLV8CY
         bDRp1fVV8jB5ZYSyixYKv/h246VBElPcn0YUatJ1XohzFvr/p3FKeg6LkeuwylmjL/6D
         6FTLaFPmlarMet/av5hTHlIcOlAXvSaZyYJLUTAFGa22Gev3igqap9cJT529zFx5ybG8
         JiPeumOckOZTWcEhbsDb4FO0mvfwWqMSGEGMkv7g6CJdTjBz+jsoUH+ITZZfo8CJJo2c
         gBTIhlh5iFUdBFkmG3jwlDgJXLEdqLOLZi2AwaSJ+WXqaGgybM1hq8L+STbKNwhIoOej
         aOIA==
X-Gm-Message-State: AOAM531qAkid+o2/i7+LRupPOwHWacySlXJWcBokVd0BihGZtCglltpz
        9XuWSH2Pj9pOhRncPeI98U33n8GbofxSWA==
X-Google-Smtp-Source: ABdhPJzu+InAKQOiyPqG0dWDOHfzB3KiBRd5YGtSqYNlLngrKe4gTrbUBd4TBF/SncPAtPt+KUcTlQ==
X-Received: by 2002:a05:6638:224d:: with SMTP id m13mr22677216jas.86.1639216798613;
        Sat, 11 Dec 2021 01:59:58 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id h1sm4370037iow.31.2021.12.11.01.59.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Dec 2021 01:59:58 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v1.1 2/19] t1010: fix unnoticed failure on Windows
Date:   Sat, 11 Dec 2021 04:58:37 -0500
Message-Id: <20211211095837.26387-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Microsoft Windows, a directory name should never end with a period.
Quoting from Microsoft documentation[1]:

    Do not end a file or directory name with a space or a period.
    Although the underlying file system may support such names, the
    Windows shell and user interface does not.

Naming a directory with a trailing period is indeed perilous:

    % git init foo
    % cd foo
    % mkdir a.
    % git status
    warning: could not open directory 'a./': No such file or directory

The t1010 "setup" test:

    for d in a a. a0
    do
        mkdir "$d" && echo "$d/one" >"$d/one" &&
        git add "$d"
    done &&

runs afoul of this Windows limitation, as can be observed when running
the test verbosely:

    error: open("a./one"): No such file or directory
    error: unable to index file 'a./one'
    fatal: adding files failed

The reason this problem has gone unnoticed for so long is twofold.
First, the failed `git add` is swallowed silently because the loop is
not terminated explicitly by `|| return 1` to signal the failure.
Second, none of the tests in this script care about the literal
directory names ("a", "a.", "a0") or the specific number of tree
entries. They care instead about the order of entries in the tree, and
that the tree synthesized in the index and created by `git write-tree`
matches the tree created by the output of `git ls-tree` fed into `git
mktree`, thus the absence of "a./one" has no impact on the tests.

Skipping these tests on Windows by, for instance, checking the
FUNNYNAMES predicate would avoid the problem, however, the funny-looking
name is not what is being tested here. Rather, the tests are about
checking that `git mktree` produces stable results for various input
conditions, such as when the input order is not consistent or when an
object is missing.

Therefore, resolve the problem simply by using a directory name which is
legal on Windows and sorts the same as "a.". While at it, add the
missing `|| return 1` to the loop body in order to catch this sort of
problem in the future.

[1]: https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---

This is a re-roll of patch 2/19 of es/test-chain-lint[1] to improve the
commit message in response to Elijah's review comments[2,3] since the v1
commit message was perhaps a bit too subtle[4].

Rather than spamming the list with a full v2 re-roll, I decided to
re-roll just this one patch with its minor commit message rewrite since
it was the only change requested, thus should be less of a burden on
reviewers, though perhaps a bit more burden on Junio (but it's such a
minor change that the original commit message is probably good enough
should Junio not pick up this single-patch re-roll).

[1]: https://lore.kernel.org/git/20211209051115.52629-1-sunshine@sunshineco.com/
[2]: https://lore.kernel.org/git/CABPp-BGBZ6_CqbUg3=sK2b4yELC5NHHyH68_df22n=t=hARH_g@mail.gmail.com/
[3]: https://lore.kernel.org/git/CABPp-BFM5ZbFAzVfvDE3=zm6Q4LN2fWthPP8WH5kbgVPSxomtA@mail.gmail.com/
[4]: https://lore.kernel.org/git/CAPig+cR0eKhz+ncWb4v9dSY0A03P+K0+WT90J2cBKvLqT8DXrA@mail.gmail.com/

Range-diff against v1:
1:  4e7d8e8c7e ! 1:  95d419ed90 t1010: fix unnoticed failure on Windows
    @@ Commit message
         The reason this problem has gone unnoticed for so long is twofold.
         First, the failed `git add` is swallowed silently because the loop is
         not terminated explicitly by `|| return 1` to signal the failure.
    -    Second, none of the tests in this script care about the actual directory
    -    names or even the number of tree entries. They care only that the tree
    -    synthesized in the index and created by `git write-tree` matches the
    -    tree created by the output of `git ls-tree` fed into `git mktree`, and
    -    the failure of `git add "a./one"` doesn't change that outcome.
    +    Second, none of the tests in this script care about the literal
    +    directory names ("a", "a.", "a0") or the specific number of tree
    +    entries. They care instead about the order of entries in the tree, and
    +    that the tree synthesized in the index and created by `git write-tree`
    +    matches the tree created by the output of `git ls-tree` fed into `git
    +    mktree`, thus the absence of "a./one" has no impact on the tests.
     
         Skipping these tests on Windows by, for instance, checking the
         FUNNYNAMES predicate would avoid the problem, however, the funny-looking
    @@ Commit message
         object is missing.
     
         Therefore, resolve the problem simply by using a directory name which is
    -    legal on Windows (i.e. "a-" rather than "a."). While at it, add the
    +    legal on Windows and sorts the same as "a.". While at it, add the
         missing `|| return 1` to the loop body in order to catch this sort of
         problem in the future.
     
         [1]: https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file
     
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
    +    Reviewed-by: Elijah Newren <newren@gmail.com>
     
      ## t/t1010-mktree.sh ##
     @@ t/t1010-mktree.sh: TEST_PASSES_SANITIZE_LEAK=true

 t/t1010-mktree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 48bfad07ab..3c08194526 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -6,10 +6,10 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-	for d in a a. a0
+	for d in a a- a0
 	do
 		mkdir "$d" && echo "$d/one" >"$d/one" &&
-		git add "$d"
+		git add "$d" || return 1
 	done &&
 	echo zero >one &&
 	git update-index --add --info-only one &&
-- 
2.34.1.397.gfae76fe5da

