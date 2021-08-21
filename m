Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901DDC4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 01:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619E761154
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 01:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbhHUBh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 21:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhHUBh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 21:37:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739B5C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 18:36:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t1so10937646pgv.3
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 18:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbhIuLPnDbNgjo3H2S1aS5YjvQdmsPfZcYR8jjmSM4U=;
        b=npsPTdMm/qmU+NECHU8XDnG2FGOSxCyaqni+h6gp2866/Bppq8zCGKDWiyZ5Si02BL
         uruYvho2z4GbcbKIg38Ytg5sJXR8l0MDqF6Lm0JF2hCZg0URseJH1nG7zBN2B3bHh7ny
         iUd6LMhjeVi/vCcmTpeCgJbVvrEZ1TKf2BlphUCuGWEWXOk7EgmDABaw9fmuU+dq9T23
         5EQIpw063CdksjoU0xtmQh1xVrOGp1fUBYMIbbrZjXWEKdM/QZiUHRGITXxUKmk/ynJ1
         I87knuHyxb5GrpegMg+t6KOZfPwFMjrF7oCa4+FLKDCbbwhFHNYp1neMLlCio/IugPN2
         Jztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbhIuLPnDbNgjo3H2S1aS5YjvQdmsPfZcYR8jjmSM4U=;
        b=DElKNmWzOub/p0dD1GqY10bDJipejcQOKbpnpQJolCpqVxxhu/FGhps1ngTmk+RxBn
         9YuKb/gLYa/tvZk+krdYkIZTkcF4S+jxsvNPZ/ZfRBpcJqrULvrKxloUuvPW3ijxYo2B
         7czsg7ytEaZRjXoJb85yNouTcj6hfT2NKO3715kLJav2ABA9xt+x/7mY+D2/6cHBvEFw
         n9GrqVak6tt81wuo3mo0o1HiBldrbKTaaM3UMztBHN46d89/bAak4myEol9560sagLCT
         B361H4C3l9aumiNmu9YQ3p+m3Hcl1UZWXAa14brvjkxYnwTu1V9K/X0uLVra1BWBQKx4
         ApFQ==
X-Gm-Message-State: AOAM532lQEMrdSy/A98VMnRIjNrxENg0F5zeItK9T8qdw48rYAUj3OjM
        I9C/m/zb17dOR+S7DBbMMzWTi7TSHtfNZg==
X-Google-Smtp-Source: ABdhPJwI6XStVNpeu9bQhysUrXvdfAMKrQ88TRsmpmr973sUsqGtkSir0E0CctLApx0l+ERSotXyBA==
X-Received: by 2002:aa7:9117:0:b029:35c:4791:ff52 with SMTP id 23-20020aa791170000b029035c4791ff52mr21987091pfh.76.1629509809860;
        Fri, 20 Aug 2021 18:36:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63b8:c1e5:7ba1:cab2:978b:f7f6])
        by smtp.gmail.com with ESMTPSA id j7sm4132257pjf.39.2021.08.20.18.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 18:36:49 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] t6300: clear warning when running without gpg
Date:   Sat, 21 Aug 2021 08:36:32 +0700
Message-Id: <cover.1629509530.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.33.0.254.g68ee769121
In-Reply-To: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com>
References: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com>, <cover.1629263759.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running t6300 in an environment without gpg(1),
we'll see those warnings:

	fatal: Not a valid object name refs/tags/signed-empty
	fatal: Not a valid object name refs/tags/signed-short
	fatal: Not a valid object name refs/tags/signed-long

Because, those objects will be created only when GPG is satistified.
This series try to clean those errors.

Change in v3 from v2:
* Fix grammar in 1/2 commit's message
* Let tail open input file instead of using shell redirection.

Change in v2 from v1:
* Make 1/2 as near pure-code-move; and
* Use 2/2 as a code change to preserve status code for cat-file
* Mention reasons that 1/2 couldn't be pure-code-move.


Đoàn Trần Công Danh (2):
  t6300: don't run cat-file on non-existent object
  t6300: check for cat-file exit status code

 t/t6300-for-each-ref.sh | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

Range-diff against v2:
1:  b813d6f2ad ! 1:  b1b9771913 t6300: don't run cat-file on non-existent object
    @@ Commit message
     
         In t6300, some tests are guarded behind some prerequisites.
         Thus, objects created by those tests ain't available if those
    -    prerequisites is unsatistified.  Attempting to run "cat-file"
    +    prerequisites are unsatistified.  Attempting to run "cat-file"
         on those objects will run into failure.
     
         In fact, running t6300 in an environment without gpg(1),
    @@ Commit message
         * check their exit status code
     
         The expected value for objects with type: commit needs to be
    -    computed outside the test because we can't relies on "$3" there.
    +    computed outside the test because we can't rely on "$3" there.
         Furthermore, to prevent the accidental usage of that computed
         expected value, BUG out on unknown object's type.
     
2:  68ee769121 ! 2:  83d532528b t6300: check for cat-file exit status code
    @@ t/t6300-for-each-ref.sh: test_atom() {
      				# We cannot use $3 as it expects sanitize_pgp to run
     -				expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
     +				git cat-file tag $ref >out &&
    -+				expect=$(tail -n +6 <out | wc -c) &&
    ++				expect=$(tail -n +6 out | wc -c) &&
     +				rm -f out ;;
      			tree | blob)
      				expect="" ;;
-- 
2.33.0.254.g68ee769121

