Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B47C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36D861406
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFJJQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:16:40 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:50997 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJJQj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:16:39 -0400
Received: by mail-wm1-f41.google.com with SMTP id d184so5742842wmd.0
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XzaDEiYjN+Z0eNIon4Bw8BoebyWaHBkSUaLpvNqvRTE=;
        b=bs5wscd3VXDQz4OHuwIDDP/bpowUurCQTmoncp+uEa5olIhokEmitj2t8S/gIvzsvT
         LlhLVgFdm8vJMsMnJSwY+okDrA2TJ4s/7jCxFdGua8AkN1BfO/OD9AZy4rFGfMPMQa/o
         sbYcpXs84kiChJQxAS83HuMjdKFct8cDCmaXZrE+c652/hb50pn4ZR1fbB9q2G8q2eW1
         Qy9JbPMF8q46KN6UMfttgskQbnFjXLHo31PZyUbB8d2g+86s9tZpVYTU77NPJocLGPDO
         fR5lAMyVMc/OsvgvJ2jhj+M76xmIBdHnvLZ6EkUC5HRAKGmKiJbEGzvg+1LiCgDrJvDS
         fpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XzaDEiYjN+Z0eNIon4Bw8BoebyWaHBkSUaLpvNqvRTE=;
        b=byrDwKhmKjiHoxyPnpS0piI2Ecr4jG0aCehba9iTBHRVOzLGcQbBIQqn5tzosCfTx4
         oWfrMeF8sbAWwNPff5YzwaUe//DgUXDNqGkgqHPO886Xf0e8GOciNfEILOby9i9ABLHw
         VrX3ihWBp4Ok4MDazJfy5eBz1aJ7qVenxBco3jkgcGeKvs3EqWDadw9QK74aMAE5kkn3
         bzrjtJnFTZiHfYjQA6Sp4g24QEMxwAXvSLbiO7RZUU9rR4FXaMzzhx27QqDjKwnrKmZT
         WsqrGF5KraaUnISnt5V9kkVIV6j0uBPXZFys+JnSxxbZm2s0iY/zVOPqq6rau5cqZpU0
         jHEQ==
X-Gm-Message-State: AOAM532iD05+Oe5Rgqvno4yaKDD0JBoxTxHZcJKcp3sulYa5P770APf0
        gr6U7qGx99fRo0uq+D6uCY6a9EtwRoI=
X-Google-Smtp-Source: ABdhPJyb3BlvwC5nqqzTphwcZ9XHpPTkshpfyU7OqVkzewirMdIDseD5Zx7LArmE7LD2F3nzM8SeWQ==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr14115182wmd.177.1623316412795;
        Thu, 10 Jun 2021 02:13:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20sm2263153wmq.24.2021.06.10.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:13:32 -0700 (PDT)
Message-Id: <pull.978.git.1623316412.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 09:13:29 +0000
Subject: [PATCH 0/2] Fix git subtree on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the topic branch ls/subtree, we saw a lot of improvements of the git
subtree command, and some cleaning up, too. For example, 22d550749361
(subtree: don't fuss with PATH, 2021-04-27) carefully laid out a history of
changes intended to work around issues where the git-subtree script was not
in the intended location, and removed a statement modifying PATH in favor of
a conditional warning (contingent on the PATH being in an unexpected shape).

This particular condition, however, was never tested on Windows, and it
broke git subtree in Git for Windows v2.32.0, as reported here
[https://github.com/git-for-windows/git/issues/3260]. Now, every invocation
of git subtree, with or without command-line arguments, results in output
like this:

It looks like either your git installation or your
git-subtree installation is broken.

Tips:
 - If `git --exec-path` does not print the correct path to
   your git install directory, then set the GIT_EXEC_PATH
   environment variable to the correct directory.
 - Make sure that your `git-core\git-subtree` file is either in your
   PATH or in your git exec path (`C:/Users/harry/Downloads/PortableGit/mingw64/libexec/git-core`).
 - You should run git-subtree as `git core\git-subtree`,
   not as `git-core\git-subtree`.


This patch series provides a band-aid to that symptom, and is based on
ls/subtree.

Johannes Schindelin (2):
  subtree: fix the GIT_EXEC_PATH sanity check to work on Windows
  subtree: fix assumption about the directory separator

 contrib/subtree/git-subtree.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)


base-commit: 9a3e3ca2ba869f9fef9f8be390ed45457565ccd1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-978%2Fdscho%2Ffix-subtree-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-978/dscho/fix-subtree-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/978
-- 
gitgitgadget
