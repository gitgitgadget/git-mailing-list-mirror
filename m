Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB60C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087222076A
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Duhe1ssf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgDUNMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUNMl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:12:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE73C061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:12:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y22so5233304pll.4
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbjunoraeX9VfPfmZqdgd15dB7xxu3AeaqbkoRLnoH4=;
        b=Duhe1ssfYAhzag/DCcedPP4A6ae8dLNb66Yb7thIFlFvf0ZOy7jdkaNL/0Q3GSmmBu
         F/YU4BASoh5+VelkpN/tTn5r2sC8hsqyzpzZbTRixNGYOfLrQUJ8cwvBJB9eLjiPGV1Q
         4v+TFvAIqFNlV5lIlplEsXoSb+ssP5EFMjYDDS7LFMNOdjhENsa57OL+CghB5aVXkHNu
         wS3/rldk8IuYAPge1ZT07IwVmFIC3Iv/5BHoRy5TxJr1AgqqmXzQCryXpgmUFrqk9ghp
         T237rjS6qeVMTvvt/CEWi5dx1LiL9eCNGoaIfr+JCbCU09lQT0K0RrWdhK16RL3a+v4Y
         P7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbjunoraeX9VfPfmZqdgd15dB7xxu3AeaqbkoRLnoH4=;
        b=RiqtqNLm3uh9x/n5MJ+r7thX3JmBp6YqYgSPdT74detssvyKwpleyj1jxDX6YgNA/c
         4kBZph6xaWYjKvSfzfKl810EIvY/oEaHpcMPDpgeCf0qn08zNaxnFSg4JGi6oUeHTsNq
         AQPxV/f2s87diU3vcD2kmDpqXw7xMQ3ndVERnacP0qXogDWpIZLJXKqp0Gp7YuolVQ5p
         3x/pQroak64D87PQjF8QE1eneimQa95UrtRvRpTgrlHPDnnDe0ki0f2Lb9u/Xrh6WQA+
         CySyGQ8l9+YC0IbR5YmJzknlScX6X+cqpBG6ON7gOP8q8dPQusMBLMZGEjho6rQ3SAgH
         idyA==
X-Gm-Message-State: AGi0PuYNQKKya0KinznvjgjFkTw720SBpbzZ773G7EoLgc9YHkRpn6oj
        vkBYLPPtM1y3LNWQSvCAg2lc4GrjdAU=
X-Google-Smtp-Source: APiQypK1QNb7GxpufV0K2F8XdlsVNM/3kzECPtk3T+Ba6mWL0ASGzhvUiYsiGPGfFxoyIKVM8mNEXQ==
X-Received: by 2002:a17:90b:1b05:: with SMTP id nu5mr5523310pjb.110.1587474760187;
        Tue, 21 Apr 2020 06:12:40 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id g2sm2451492pjd.9.2020.04.21.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:12:39 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v3 3/4] gitfaq: shallow cloning a repository
Date:   Tue, 21 Apr 2020 18:42:22 +0530
Message-Id: <20200421131223.29337-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common issue' section which covers issues with cloning
large repositories. Use shallow cloning to clone the repository in
a smaller size.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 13d37f96af..cea293cf07 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -275,6 +275,20 @@ I want to change the remote of my repository. How do I do that?::
 One can list the remotes of a repository using `git remote -v` command.
 The default name of a remote is 'origin'.
 
+[[shallow-cloning]]
+The repository I am trying to clone is too big. Is there an alternative
+way of cloning it in lesser space?::
+	One can clone a repository having a truncated history, meaning the
+	history	will span upto a specified number of commits instead of
+	the whole history of the repository. This is called 'Shallow Cloning'.
+	This helps to decrease the space taken up by the repository.
+	Shallow cloning can be done by using the `--depth` option
+	while cloning. Therefore, the command would look like:
+	`git clone --depth <n> <url>`.
+	Here, 'n' is the depth of the clone. For e.g., a depth of 1
+	would mean fetching only the top level commits of the repository
+	See linkgit:git-clone[1].
+
 Hooks
 -----
 
-- 
2.20.1

