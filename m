Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4345AC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhK2Whu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhK2WhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:37:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE6C06139A
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s13so39031881wrb.3
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=15k9lXMalMDDuO6ST/kXzKQhbRAYA014AAzGMQbUjm0=;
        b=h5ie+ZK9/Jjh1jkNa3GBSag9qR9JAXcgklRkoIbj+YI0I9hQX80d77z7ik33F3Kqn2
         Lja5QZkDvTMk/DAaRqpg78qO68D9JTARUE795BeKM9DWLFHTnc3qghqjIWy1pmrP58y+
         THTOPdKH88odeznV3smLXTIsWaXZqXo60tWhM9weudrG3Reyl4th+rtOw2icO5KfjBVV
         hzR6Spc50jUhgrUMFLViJRU6F3ZXHtbQDHDe5BtKq35WVsoNC9n3hkqmCEpyUY2YzBXg
         fYrjvSk8uiBiCMrMJhU0TNnlTTBXFuLdauAcHjaiEKkqA4HOBAjZTqmCcnFFaGxHVnng
         grRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=15k9lXMalMDDuO6ST/kXzKQhbRAYA014AAzGMQbUjm0=;
        b=PX/0OdilX+00si75MAbGHKPvSzGk4yRgdlO5FZePrqQ3udNBD78gcorfDJDVh398im
         X5Dsfr6LP2kGd+8eZEvCusCJlN2S9sFu9znGTV4mhV6v4iamlYTS9TyHLm7a4sI9b4tK
         tBBjBmOjmYzSIDmPDgg1Mb9FIwl2G96k/GxwT/s9K/2si+Hfz1P1yYp8a9GwzpVoS+P9
         I1kq9oS8h4YKEi8YBDkRoofeyIkcWtAvCZ0hhnb19jxHdA+A+Q1ZaOXwlfrAJCT07Tog
         2rQkTpFQaOWxCnniEhSqMBScyQ8oQ6OSetlO13NEYA3sEg1+qJjG2oo6Dt/czyJWj233
         pT2g==
X-Gm-Message-State: AOAM530bJ2iymcbef/dF8WkZTgqWFQ62ByEvrNfUcr5tQcCXGbrT1BeV
        RFP6/alrtzU1NASd7xrXldnmD+3VWwo=
X-Google-Smtp-Source: ABdhPJzrNhZClrLJT3bwlKL0bKPQt0WBtxWxfOsBFQlneSCSzQTTcXUTrIzuI8eSc9RE5JdoWkS3yA==
X-Received: by 2002:a5d:5445:: with SMTP id w5mr37095774wrv.163.1638211787059;
        Mon, 29 Nov 2021 10:49:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm500159wmf.2.2021.11.29.10.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:49:46 -0800 (PST)
Message-Id: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 18:49:40 +0000
Subject: [PATCH v2 0/6] Allow writing invalid OIDs into refs for testing purposes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this covers a few cases of direct filesystem access to the ref database in
tests.

v2 folds in more fixes for making t1430 reftable-proof.

 * add REF_SKIP_REFNAME_VERIFICATION as well
 * upgrade some more bits of t1430

Han-Wen Nienhuys (6):
  test-ref-store: plug memory leak in cmd_delete_refs
  refs: update comment.
  refs: allow skipping OID verification
  refs: add REF_SKIP_REFNAME_VERIFICATION flag
  t1430: remove refs using test-tool
  t1430: create valid symrefs using test-helper

 refs.c                    |  7 +--
 refs.h                    | 16 ++++++-
 refs/files-backend.c      | 53 ++++++++++++----------
 t/helper/test-ref-store.c |  6 ++-
 t/t1006-cat-file.sh       |  5 +--
 t/t1430-bad-ref-name.sh   | 95 ++++++++++++++++++++-------------------
 t/t3800-mktag.sh          |  6 ++-
 7 files changed, 108 insertions(+), 80 deletions(-)


base-commit: 35151cf0720460a897cde9b8039af364743240e7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1147%2Fhanwen%2Fskip-verification-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1147/hanwen/skip-verification-v2
Pull-Request: https://github.com/git/git/pull/1147

Range-diff vs v1:

 -:  ----------- > 1:  7fa5c247c8b test-ref-store: plug memory leak in cmd_delete_refs
 1:  b83bfda2443 = 2:  82971ddbfcf refs: update comment.
 2:  900cea2ade9 = 3:  93fe3f03fb2 refs: allow skipping OID verification
 -:  ----------- > 4:  0a297f0c3e8 refs: add REF_SKIP_REFNAME_VERIFICATION flag
 -:  ----------- > 5:  06c8ff7df15 t1430: remove refs using test-tool
 -:  ----------- > 6:  3c100702fda t1430: create valid symrefs using test-helper

-- 
gitgitgadget
