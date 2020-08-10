Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC6FC433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B69C2073E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXFNRq6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgHJW3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgHJW3X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C45C06174A
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a15so9603379wrh.10
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qsr+0k0FdxfHS6wtIs2Amt2/HVLO+5yswaysguJ8B9Y=;
        b=rXFNRq6lmwvbM0zkaBy5owj+352+C+gNPAEG0eIksPqcdFgdu+v/7syoU0vL7fK6iK
         44p+eG2vU/7HrNLLdLT4YmWDkdtcO/2G2VsfqY4AO0d6ffTwqR77MFV9JduQdDWa0luc
         oXpsQmBdYXBKB6FD1OIur2HmopFr2bDx61c69w7tRwyaX3DxCTm9wTmtrfdsPUrmTVbm
         IipxpcxfO5voRSVZefFov7n76EAhI7AZiVZkVjxA/lNACUnFNQZaC17sxhtxGRD9LS30
         mkNOTowDbjV76FPz9bWL7j9vweEL+Mg589GapXl1ihrxzaulwX3z3njks2UNjEMmLMUN
         rDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qsr+0k0FdxfHS6wtIs2Amt2/HVLO+5yswaysguJ8B9Y=;
        b=i+XCVcH8dA/QJBsTPMYBH557p86DJTxj+Si6zIu2en0MaaoLcVDgZnAehSoBRrZ0Zk
         jQ76ITOwYl/QXCAJhO9DRFhRp2bC8sKzcqxGnl++/w0Ss5LNymoyiv+DaApl029NbjHh
         2/YaqfQt5qh3YqbyBdJ0jFH9vXwwgPi0K1keTwvNV+27WC8sX8FzGTOHficJuVR8k/uQ
         1rILPo+1CIa0Rs9UbdVR00HA2ZSG05wlyjh5wo3ZIyUO8+PF6kIskOxReNRyOublaCiN
         CiQl6szSzOjrmMWJixYeYOjPDLg1G/BDhV62sccr2zOgvCfW5leduuc3wnYNcnAYu6Jm
         L5Vw==
X-Gm-Message-State: AOAM533Uj3worPy5Qjgy0jNq/W2EsgoIKLjbuPxawPF1wBxXWrBcTCkm
        nssHT20S2ZkDdOQwqUqF7YIt6jvM
X-Google-Smtp-Source: ABdhPJwCXXoJGN3SWfk5Urit0sURyK5jkG85fJJ5aHdmPKHyugAHciqoxQEiz3Omf8phxCZMaQvbDg==
X-Received: by 2002:a5d:4a41:: with SMTP id v1mr28833129wrs.371.1597098561076;
        Mon, 10 Aug 2020 15:29:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm22174203wrp.92.2020.08.10.15.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:20 -0700 (PDT)
Message-Id: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:08 +0000
Subject: [PATCH v3 00/11] Start preparing merge-related tests to work with multiple merge backends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series starts preparing the merge related tests to work with multiple
backends: merge-recursive or merge-ort. Further work will be coming.

Changes since v2:

 * fix typos pointed out by Eric
 * reworded another commit message for clarify

The greater flexibility patches at the end of the series also previews some
of the design changes being brought by merge-ort.

Merges cleanly with next and seen, despite the pile of testcase renames.

Elijah Newren (11):
  Collect merge-related tests to t64xx
  t6418: tighten delete/normalize conflict testcase
  t6422: fix bad check against missing file
  t6416, t6422: fix incorrect untracked file count
  t6423: fix test setup for a couple tests
  t6422: fix multiple errors with the mod6 test expectations
  t6416, t6423: clarify some comments and fix some typos
  t6423: add an explanation about why one of the tests does not pass
  t6422, t6426: be more flexible for add/add conflicts involving renames
  t642[23]: be more flexible for add/add conflicts involving pair
    renames
  t6425: be more flexible with rename/delete conflict messages

 t/{t6020-merge-df.sh => t6400-merge-df.sh}    |  0
 ...ss-cross.sh => t6401-merge-criss-cross.sh} |  0
 ...-merge-rename.sh => t6402-merge-rename.sh} |  0
 ...6023-merge-file.sh => t6403-merge-file.sh} |  0
 ...sive-merge.sh => t6404-recursive-merge.sh} |  0
 ...ge-symlinks.sh => t6405-merge-symlinks.sh} |  0
 ...6026-merge-attr.sh => t6406-merge-attr.sh} |  0
 ...-merge-binary.sh => t6407-merge-binary.sh} |  0
 ...p-to-date.sh => t6408-merge-up-to-date.sh} |  0
 ...erge-subtree.sh => t6409-merge-subtree.sh} |  0
 ...ge-filemode.sh => t6411-merge-filemode.sh} |  0
 ...-rename.sh => t6412-merge-large-rename.sh} |  0
 ...6033-merge-crlf.sh => t6413-merge-crlf.sh} |  0
 ...cruft.sh => t6414-merge-rename-nocruft.sh} |  0
 ...mlink.sh => t6415-merge-dir-to-symlink.sh} |  0
 ...ses.sh => t6416-recursive-corner-cases.sh} |  4 +-
 ...s-theirs.sh => t6417-merge-ours-theirs.sh} |  0
 ...-text-auto.sh => t6418-merge-text-auto.sh} |  3 +-
 ...gnorecase.sh => t6419-merge-ignorecase.sh} |  0
 ....sh => t6422-merge-rename-corner-cases.sh} | 68 +++++++++++--------
 ...s.sh => t6423-merge-rename-directories.sh} | 39 +++++++----
 ...=> t6424-merge-unrelated-index-changes.sh} |  0
 ...delete.sh => t6425-merge-rename-delete.sh} |  3 +-
 ...h => t6426-merge-skip-unneeded-updates.sh} |  2 +-
 ...ers.sh => t6427-diff3-conflict-markers.sh} |  0
 ...-recursive.sh => t6430-merge-recursive.sh} |  0
 ...-criscross.sh => t6431-merge-criscross.sh} |  0
 ...=> t6432-merge-recursive-space-options.sh} |  0
 ...ge-toplevel.sh => t6433-merge-toplevel.sh} |  0
 ...> t6434-merge-recursive-rename-options.sh} |  0
 ...-merge-sparse.sh => t6435-merge-sparse.sh} |  0
 ...-overwrite.sh => t6436-merge-overwrite.sh} |  0
 ...dule-merge.sh => t6437-submodule-merge.sh} |  0
 ...438-submodule-directory-file-conflicts.sh} |  0
 ...r-msgs.sh => t6439-merge-co-error-msgs.sh} |  0
 35 files changed, 71 insertions(+), 48 deletions(-)
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
 rename t/{t6036-recursive-corner-cases.sh => t6416-recursive-corner-cases.sh} (99%)
 rename t/{t6037-merge-ours-theirs.sh => t6417-merge-ours-theirs.sh} (100%)
 rename t/{t6038-merge-text-auto.sh => t6418-merge-text-auto.sh} (99%)
 rename t/{t6039-merge-ignorecase.sh => t6419-merge-ignorecase.sh} (100%)
 rename t/{t6042-merge-rename-corner-cases.sh => t6422-merge-rename-corner-cases.sh} (94%)
 rename t/{t6043-merge-rename-directories.sh => t6423-merge-rename-directories.sh} (98%)
 rename t/{t6044-merge-unrelated-index-changes.sh => t6424-merge-unrelated-index-changes.sh} (100%)
 rename t/{t6045-merge-rename-delete.sh => t6425-merge-rename-delete.sh} (72%)
 rename t/{t6046-merge-skip-unneeded-updates.sh => t6426-merge-skip-unneeded-updates.sh} (99%)
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


base-commit: 4f0a8be78499454eac3985b6e7e144b8376ab0a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-827%2Fnewren%2Fmerge-test-rename-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-827/newren/merge-test-rename-v3
Pull-Request: https://github.com/git/git/pull/827

Range-diff vs v2:

  1:  3a2b7e9743 =  1:  8fec657942 Collect merge-related tests to t64xx
  2:  621c9a159e =  2:  b35b61007e t6418: tighten delete/normalize conflict testcase
  3:  7f408b7d40 =  3:  d35d4b1922 t6422: fix bad check against missing file
  4:  9ce80f2f94 !  4:  78df85aee5 t6416, t6422: fix incorrect untracked file count
     @@ Metadata
       ## Commit message ##
          t6416, t6422: fix incorrect untracked file count
      
     -    Apparently I don't know how to count untracked files, and since the tests
     -    in question were marked as test_expect_failure, no one every noticed it
     -    until know.  Correct the count, as these tests clearly creates three
     -    untracked files ('out', 'err', and 'file_count').
     +    Apparently I don't know how to count untracked files, and since the
     +    tests in question were marked as test_expect_failure, no one ever
     +    noticed it until now.  Correct the count, as these tests clearly create
     +    three untracked files ('out', 'err', and 'file_count').
      
          (I believe this problem arose because earlier incarnations counted lines
          via a pipe to 'wc -l'.  Reviewers asked that it be replaced by writing
  5:  382d65649d =  5:  8ac78dc71b t6423: fix test setup for a couple tests
  6:  56e169b1d8 =  6:  6674ae9de4 t6422: fix multiple errors with the mod6 test expectations
  7:  7b534d123a =  7:  783ebb6576 t6416, t6423: clarify some comments and fix some typos
  8:  f2d7e744fc !  8:  82e1b0e696 t6423: add an explanation about why one of the tests does not pass
     @@ Metadata
       ## Commit message ##
          t6423: add an explanation about why one of the tests does not pass
      
     -    While we're at it, document why one of the two tests doesn't pass (since
     -    I had long since forgotten it)...though the reasoning makes me question
     -    why it's considered a failure at all.  Maybe I had a good reason when I
     -    introduced it, or maybe I just wasn't looking at it clearly?  Either
     -    way, the explanation may help a future reader.
     +    I had long since forgotten the idea behind this test and why it failed,
     +    and took a little while to figure it out.  To prevent others from having
     +    to spend a similar time on it, add an explanation in the comments.
     +    However, the reasoning in the explanation makes me question why I
     +    considered it a failure at all.  I'm not sure if I had a better reason
     +    when I originally wrote it, but for now just add commentary about the
     +    possible expectations and why it behaves the way it does right now.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
  9:  b4e165eca4 =  9:  42e3f699f1 t6422, t6426: be more flexible for add/add conflicts involving renames
 10:  a9a02a0ca5 = 10:  456160f3a7 t642[23]: be more flexible for add/add conflicts involving pair renames
 11:  38f6573511 = 11:  0c8dcbf01c t6425: be more flexible with rename/delete conflict messages

-- 
gitgitgadget
