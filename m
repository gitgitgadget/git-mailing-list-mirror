Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAE3C433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 18:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF7E207E8
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 18:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj+jWSbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgGPSpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPSpo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 14:45:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27426C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 11:45:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so11197713wmh.4
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=whazwDLXBq8adBRBbNMrzNHWvDRVfl96dRlhiRkDakQ=;
        b=Gj+jWSbQ7S2d90O8phCrk1d69rXTM4wsiL5IPQRCKwew90yrSJWN3Y2RMl5JegEG4P
         kFFcBiOBxRykwighkxo8SUJBJjBNinKQV3vnGHZ0HyJGg87qA0sjk15PuOiReP+EOogY
         wZdj8MBc3roSb3ch1lbfJUT6IKGUtIX9vnazczk2QKEqqxPFpZguKfozw2Q1ZR/IXHgh
         Y4KNOq+tXJBULTKrZCS5ei2PvqdLEshmUzh/dscOPBQ8eEd6vvau2x6vX9Md1KdUV/Z8
         hLAm5t/BWIBZ4VqGXOp9ftxfJVByzDPRd5mJecQThE4IpDUwl1U2rYBuvvsV/czPU1Iq
         /ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=whazwDLXBq8adBRBbNMrzNHWvDRVfl96dRlhiRkDakQ=;
        b=s11m4YyPTDOKdxZHqwdrt+AGgZnXC+zmHbTNKP8hH14SEWMGgFLtMAfUPt9pOXxTr0
         5rpOzStpEhWsFodK9H9vZt6w3RS2uY0oc/7WQgZ+s7GkjKxnYpibG80OM1cbAdCVKTzL
         2AvNDXhuarMNZfVkTx6fLbF4N2jXZUf+73GOaD8C41ocFvzOLO1yR8VCU/l+iXXRfzLg
         jf+geyZ5YYfwMGvgERyAf/F1pIIcG042kJSOGj7TC2y1kM3p3Ltt7h9ng+e/pjyXPJTi
         NDEQDnezu5PEaqBpEpCG+MFlYbTCqZ6lERFaY7WjvxOI98BwG9rYcE+A5YQMZqwOQB62
         bNNw==
X-Gm-Message-State: AOAM532Hd1Bu/14+SrSaJ6rJMWPK9n5WjgCEfb6oCI9IUfzwWZmdwybd
        ieyMPWOWyCWviPVlPAQYOp4LXSOr
X-Google-Smtp-Source: ABdhPJwXyNewr6JTEdoc6WBmjUS+5nN6xIKvi0xb2kmamxktwuRtMUvHAdWBruFEkcOH6OjC8ddo5Q==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr5330538wmc.72.1594925142582;
        Thu, 16 Jul 2020 11:45:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 59sm10842757wrj.37.2020.07.16.11.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 11:45:41 -0700 (PDT)
Message-Id: <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jul 2020 18:45:38 +0000
Subject: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This gets rid of the special casing code for pseudorefs in refs.c

This is in preparation for reftable.

v3

 * tweak git-update-ref.txt description for logAllRefUpdates

Han-Wen Nienhuys (3):
  t1400: use git rev-parse for testing PSEUDOREF existence
  Modify pseudo refs through ref backend storage
  Make HEAD a PSEUDOREF rather than PER_WORKTREE.

 Documentation/git-update-ref.txt |  13 ++--
 refs.c                           | 127 +++----------------------------
 t/t1400-update-ref.sh            |  30 ++++----
 t/t1405-main-ref-store.sh        |   5 +-
 4 files changed, 36 insertions(+), 139 deletions(-)


base-commit: b6a658bd00c9c29e07f833cabfc0ef12224e277a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-673%2Fhanwen%2Fpseudoref-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-673/hanwen/pseudoref-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/673

Range-diff vs v2:

 1:  9c3dc4b2cb = 1:  28bd3534d0 t1400: use git rev-parse for testing PSEUDOREF existence
 2:  871b411517 ! 2:  79cd5dd480 Modify pseudo refs through ref backend storage
     @@ Commit message
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     + ## Documentation/git-update-ref.txt ##
     +@@ Documentation/git-update-ref.txt: still see a subset of the modifications.
     + 
     + LOGGING UPDATES
     + ---------------
     +-If config parameter "core.logAllRefUpdates" is true and the ref is one under
     +-"refs/heads/", "refs/remotes/", "refs/notes/", or the symbolic ref HEAD; or
     +-the file "$GIT_DIR/logs/<ref>" exists then `git update-ref` will append
     +-a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
     +-symbolic refs before creating the log name) describing the change
     +-in ref value.  Log lines are formatted as:
     ++If config parameter "core.logAllRefUpdates" is true and the ref is one
     ++under "refs/heads/", "refs/remotes/", "refs/notes/", or a pseudoref
     ++like HEAD or ORIG_HEAD; or the file "$GIT_DIR/logs/<ref>" exists then
     ++`git update-ref` will append a line to the log file
     ++"$GIT_DIR/logs/<ref>" (dereferencing all symbolic refs before creating
     ++the log name) describing the change in ref value.  Log lines are
     ++formatted as:
     + 
     +     oldsha1 SP newsha1 SP committer LF
     + 
     +
       ## refs.c ##
      @@ refs.c: long get_files_ref_lock_timeout_ms(void)
       	return timeout_ms;
 3:  1c2b9d5f17 = 3:  3ab9f2f04e Make HEAD a PSEUDOREF rather than PER_WORKTREE.

-- 
gitgitgadget
