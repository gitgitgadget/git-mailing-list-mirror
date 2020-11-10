Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02160C2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96947206D8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdFJfNVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgKJAxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJAxe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 19:53:34 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E89CC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 16:53:34 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id j14so10935400ots.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 16:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7Yj2+jBIayrs2nPpltl73iKeDfEQyzK6R5BIpEG7W0=;
        b=tdFJfNVh9FVa84AwXMrHmtGH3vtKx5qaQC6L5OxWmeygp7V9/kvo8E9KRWtz3ZNyEZ
         CODyagGOlGekuV+7hI1UdgsCve+GvDbjQyHO0/lwbjQZCHSWIGSNmx94C+IPiGV/woiq
         A5ADnyf5KtOnbf+FiwY+yhkrlBsSUGUX55zNN4R2SlKUk11SscCgsoCH9webtwemewWs
         rr9zdU77/YrY+HnbM9fsOsCux4YaR6zWK0zMJwKx9gAEehMDX5nK7IvffxZ9Tcha5TJ3
         EkJzum3w1eEKnz4A8JmFKIfe4osuh5q3+t55ZyWEJkESdafPPvFJgs1xIIVyGgPLrx9p
         wRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7Yj2+jBIayrs2nPpltl73iKeDfEQyzK6R5BIpEG7W0=;
        b=W2+FVQIedlch7/uMzNpoSFdZ3kjMtxPbPc6VBN9RsJUBNp0e3zbD0TMzvz34eICnXj
         CPqDD5le6IZSKBGX93zvdxQ+iQSQ5tmbuciMijnGqD6z0zOwOeHHs5BMJSTwqQfPZ8Hm
         X2okH6VO8vG2GTQaQgD3Tcnzd+F5JirEQSnbp1BjaqLl1qTouH0WqJNr8z6iR4VD1dCI
         nRDvibFTOpUbYkZGSwFZ8wrl1PZzvV9DYVtI484iHjWPrEOwN3VOjrG+xAN148eL7/XO
         GdB87uDCGxS3veJsgOPvUjfRSf90kHhiKxiKL/ZmZk7bpJw9L97Z5S7NpV5ycdYCGgz1
         MgyA==
X-Gm-Message-State: AOAM533aq1S0fndHSFSnw3PyS2t7LNUJFr44icJ/7HpOUsdYO/3GzYuI
        Xv4RtwxdRvojYZY4M4cmedMy9QWb0xCoQQ==
X-Google-Smtp-Source: ABdhPJzyDf2QVLUbvJI4UtFBjU7t+wyAq7rRqEpojxTbxupYoipHO/7M7y4AsrJTfW4GJMWY8FhmVQ==
X-Received: by 2002:a05:6830:150d:: with SMTP id k13mr11709752otp.26.1604969613284;
        Mon, 09 Nov 2020 16:53:33 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id n62sm2912905ota.74.2020.11.09.16.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 16:53:32 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/3] completion: bash: support for recursive/nested aliases
Date:   Mon,  9 Nov 2020 18:53:28 -0600
Message-Id: <20201110005331.532678-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

As Philippe reported, aliases of aliases are not completed correctly in the
Bash completion. This patch series attempts to fix that problem.

Since v1:

 * Use a loop instead of recursive calls
 * Add a check to detect alias loops


Felipe Contreras (3):
  completion: bash: support recursive aliases
  completion: bash: check for alias loop
  completion: bash: simplify __git_aliased_command

 contrib/completion/git-completion.bash | 53 +++++++++++++++++---------
 t/t9902-completion.sh                  | 19 +++++++++
 2 files changed, 54 insertions(+), 18 deletions(-)

-- 
2.29.2

