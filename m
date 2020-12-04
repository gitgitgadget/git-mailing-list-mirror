Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66442C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F55522583
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgLDGRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGRO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:14 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B24C061A51
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:27 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 11so4206368oty.9
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6aTBf0SDpHve48rTJ5EpUCFxp9EXKC/Z1a9387wUXY=;
        b=eTqn5LLIGef+pKr92kag6Yv6+YmC1Ow35lTfqla1AhzKQZaKQeb2iVe7xU1dIP3PuB
         YOIuMy+WBY+4i9neNE8dAH4LhSCcNP7U4R9AT7z3iHcrl61PYe+vuC0EsHojcsL4f1mq
         v6+Q9kEBaa0obuuYmR8fhpCqhFVbYtg8oXhTGktIhJsgwq15ELqCNT18qsoXMZmkwheI
         BgzJ4KekHjXue1AffvjEEUTXXfz9WB3RDYSabYtfNJi1uqJIQQ7/rY5F2xyDH7H950Bm
         pA8MIXPh4tX97wRK1OB+c2TtMUPTekefRDAcQP3ILhaQRe5Saj+Lv22YNU/ccTTC0KsL
         xRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6aTBf0SDpHve48rTJ5EpUCFxp9EXKC/Z1a9387wUXY=;
        b=Bi6RsBt9w2qXgWvGv8ecgCuD0cHC2eh2GN3nwGq59d9uc7wDBDHdKJNcJKVCDP0fd/
         P+RY53/SyOJohO1Uul8UFu4fMCt9xwJ7dX+1bNpm2pC3dttO1pTxEeo1OZHqoYLo8qgC
         FD4RWWfKi8AUHXYgL2+88t+K+t92YNR48/LRauFna3vR2Z/UxDGEH17+oKW9dWMKopXC
         F4Hxwq5OLHy89c3urONfp5r0YWlNysZNJZVjL1quwr9l2zI8kwd5EjhZyHDyCo2/m1D4
         suiA69dchzLDcrCQ4Idl9+FptzN+YCdvnrZ/qC4WqbaTVIW2OUGWXYBvIzDI3AATOAjN
         a8zA==
X-Gm-Message-State: AOAM532mdW9tLtW9wk5XYwjRFBhUP30mQjlksy9Yf9zRLS00BM2RnL0z
        7WZ58FrH3g9a1os5yk8RQ+m7JtYHMeiaeg==
X-Google-Smtp-Source: ABdhPJwkndzOnr9tAhw3KKwahF0QtDkNJ/VXT6K6WiS+xZyWJatX0BsFCakEzc7rvt9rSAXcabmf5Q==
X-Received: by 2002:a9d:6a46:: with SMTP id h6mr2355625otn.270.1607062587140;
        Thu, 03 Dec 2020 22:16:27 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k20sm448598oig.35.2020.12.03.22.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:26 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/14] doc: pull: explain what is a fast-forward
Date:   Fri,  4 Dec 2020 00:16:10 -0600
Message-Id: <20201204061623.1170745-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want users to know what is a fast-forward in order to understand the
default warning.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..dc812139f4 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -38,6 +38,20 @@ as set by linkgit:git-branch[1] `--track`.
 Assume the following history exists and the current branch is
 "`master`":
 
+------------
+	  A---B---C master on origin
+	 /
+    D---E master
+------------
+
+Then `git pull` will merge in a fast-foward way up to the new master.
+
+------------
+    D---E---A---B---C master, origin/master
+------------
+
+However, a non-fast-foward case looks very different.
+
 ------------
 	  A---B---C master on origin
 	 /
-- 
2.29.2

