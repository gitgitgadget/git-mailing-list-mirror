Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B836BC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhLIFPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhLIFPn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:43 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AFBC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:10 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id 15so4292824ilq.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8E25A8tAjwczOiqSorFGM2mRYnPUVNLMmSzdPre3Jrs=;
        b=T58Or6GGy4bBLXpUn0+1OmQlhtRLBQWGgfc49SPt0IRx21TyiqlvtWaZTKwnw2fyRB
         DyOkeEcFLTCA96eHu5g5khpMr9cReDIPVkgaTpE5ADSERLCr/CX8dl465CccaW8ZUpAs
         +cLeAti0V+Y5ohgVsOFqDAHdVBMeZ57ksamFhv2gatlogAEj7HcNzlCdegh5xxuh6FQY
         2O4CfegRdZhy8cTxkXOkngiikV06dcWPg34jjGdnt8YLuF7jlX8hJpukAqcYHUpEMsVc
         8Qex5RJ0AI8cWMUq5rcczw9tCyyrgZPcjOUOMOKgUvm7hAMbzOoN05sEEcYkF16VLoCi
         4Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8E25A8tAjwczOiqSorFGM2mRYnPUVNLMmSzdPre3Jrs=;
        b=t1TB4Kv+i6kcnbK+9hzl8+3F3pyQPREBIKhmOwV+oWV5uBWmIL29Z/5MTIZn5VbFp3
         87l0mdGJS285DO9+KaoVhELukaHsXj0HLanVjJsOkfA9gVA7IgEh2zL7dP0e3ZcNe5bX
         O1Feu5GbV3OZ0hUMCk5MneDqQrD4Shp3AIP22LVKV/zp4pv+SrG3VWSHvaIA+dOEy8qc
         rLJG+CN6ewR2p59FZMk2g0oqa4rZV5NtjibHmJFszpXBWJiIPAIK3Y3IyiR3FYNO6dyz
         m17jnd8TCrbVV2Rm3CQKY+liBczI8rKNdCpb0b16ob4GiY3E3d0qJI2I14Gx4d+niAtU
         4J/A==
X-Gm-Message-State: AOAM530OVBOt+7fDAFFJnCyOv5b/73tFVUreO8HotBb4bL2KWJZkNoHc
        7ORLmyFZEHCXPiy0eMSqgkCq8vk5yeNcWA==
X-Google-Smtp-Source: ABdhPJx2rWkG7OZmz9hs5nC2YWLn/nV/a8Dc9TV7bn508pTv3xG30PFwqiXTxeuVu+uiAP/RF4llGg==
X-Received: by 2002:a05:6e02:1ba5:: with SMTP id n5mr12342669ili.61.1639026729772;
        Wed, 08 Dec 2021 21:12:09 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:09 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 02/19] t1010: fix unnoticed failure on Windows
Date:   Thu,  9 Dec 2021 00:10:58 -0500
Message-Id: <20211209051115.52629-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
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
Second, none of the tests in this script care about the actual directory
names or even the number of tree entries. They care only that the tree
synthesized in the index and created by `git write-tree` matches the
tree created by the output of `git ls-tree` fed into `git mktree`, and
the failure of `git add "a./one"` doesn't change that outcome.

Skipping these tests on Windows by, for instance, checking the
FUNNYNAMES predicate would avoid the problem, however, the funny-looking
name is not what is being tested here. Rather, the tests are about
checking that `git mktree` produces stable results for various input
conditions, such as when the input order is not consistent or when an
object is missing.

Therefore, resolve the problem simply by using a directory name which is
legal on Windows (i.e. "a-" rather than "a."). While at it, add the
missing `|| return 1` to the loop body in order to catch this sort of
problem in the future.

[1]: https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
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
2.34.1.307.g9b7440fafd

