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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE212C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 00:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7E761378
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 00:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhFBANV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 20:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBANV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 20:13:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CBEC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 17:11:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dj8so712007edb.6
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 17:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDvAEKkhLc6xo7VKVnVIIcE3JsBCkiHyrgkDDJNyc8Y=;
        b=grYDZ69axDvEc1afMy2jRsWJ7/vf44LR3BPutAfmuaDNshqTJP5L8yg63Wf9xDcnS3
         kWool3U2D3h8bkpKuuu8YuKeIcc8XqO82Hj3YQwm7l8/vbO3mx+5CxiBffI4sZSowqcN
         4PVsWkVqa6u/Th7D3r/sOvDcxMsQvITDN5QhfxL9JxxMnaB5AkpxhxsJ3iAB64MRM/RN
         d3dLiKCY0tyefoxZXWcBrMvTTaLQJU2kgOUeAmPQjfDdohwl0egPZNpZKMR+rnvbyrdO
         2C9egaNGOK+gRXYBZHBUspp4S+amDkk7ysvt53p+UjbR3OmwhZtI13S1XsEwW4V94lz5
         NkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDvAEKkhLc6xo7VKVnVIIcE3JsBCkiHyrgkDDJNyc8Y=;
        b=fUjSeNtlOnJaaftmSi1NqJKxQLB4cRAIyU+0CFCPfBdDAyLG55CIg5Ma7HT/woARAx
         XlkrvwvNuvV9G/tBDfi25Ii1/cIQ6aT9RfXYUxuwjvO8q9fu6j2QnwKH0wOOuEIeEwTm
         d7YpPlhW/AZwsTyZynBtrI/RHGMFo1JHs4XqhZ6HZcZmwscEKuxEWXt5TzrinJHpjD4L
         OUZmDiLj5/y37eCLj1u39xnZr2Hsl07nAEfWipBTZkYSH9cWMhZJKlq6LsTL9e8yKEin
         KA9FV78kPbdueMKWT6zU/nMRznJK7zYn2tqwTSxtLGasTriqO7qtqkNVDnQGvnNqKVPG
         y8mA==
X-Gm-Message-State: AOAM533B/gcHUKlUNKs18nli6KojuYT40xu8YXlqqlquMOST0rWCR02N
        M7oLirvlOinYtqsCDZRMI2dgTxlrDmMKkvF6wBE=
X-Google-Smtp-Source: ABdhPJzDpLpYbI5GIewT4FllxVT8bqskYkQlFP3z+3+yEfrqVr7BXOuNWKG3zcaN3ouPJIta3DAdAA==
X-Received: by 2002:aa7:c787:: with SMTP id n7mr35376415eds.309.1622592696768;
        Tue, 01 Jun 2021 17:11:36 -0700 (PDT)
Received: from localhost.localdomain ([138.199.18.74])
        by smtp.gmail.com with ESMTPSA id hb14sm7785468ejb.118.2021.06.01.17.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 17:11:36 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     Andrei Rybak <rybak.a.v@gmail.com>
Subject: [PATCH] config doc: indent descriptions of feature.* variables
Date:   Wed,  2 Jun 2021 02:11:32 +0200
Message-Id: <20210602001132.459705-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Config variables feature.experimental and feature.manyFiles are grouped
together under "feature.*".  However, this is not easily visible when
scanning the help page of git-config.

Indent the descriptions of individual feature.* config variables to help
the reader distinguish this group of variables.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/config/feature.txt | 40 +++++++++++++++++---------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index cdecd04e5b..2c4dee170b 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -3,24 +3,26 @@ feature.*::
 	a group of other config settings. These groups are created by the Git
 	developer community as recommended defaults and are subject to change.
 	In particular, new config options may be added with different defaults.
-
-feature.experimental::
-	Enable config options that are new to Git, and are being considered for
-	future defaults. Config settings included here may be added or removed
-	with each release, including minor version updates. These settings may
-	have unintended interactions since they are so new. Please enable this
-	setting if you are interested in providing feedback on experimental
-	features. The new default values are:
 +
-* `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
-skipping more commits at a time, reducing the number of round trips.
+--
+	feature.experimental::
+		Enable config options that are new to Git, and are being considered for
+		future defaults. Config settings included here may be added or removed
+		with each release, including minor version updates. These settings may
+		have unintended interactions since they are so new. Please enable this
+		setting if you are interested in providing feedback on experimental
+		features. The new default values are:
+	+
+	* `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
+	skipping more commits at a time, reducing the number of round trips.
 
-feature.manyFiles::
-	Enable config options that optimize for repos with many files in the
-	working directory. With many files, commands such as `git status` and
-	`git checkout` may be slow and these new defaults improve performance:
-+
-* `index.version=4` enables path-prefix compression in the index.
-+
-* `core.untrackedCache=true` enables the untracked cache. This setting assumes
-that mtime is working on your machine.
+	feature.manyFiles::
+		Enable config options that optimize for repos with many files in the
+		working directory. With many files, commands such as `git status` and
+		`git checkout` may be slow and these new defaults improve performance:
+	+
+	* `index.version=4` enables path-prefix compression in the index.
+	+
+	* `core.untrackedCache=true` enables the untracked cache. This setting assumes
+	that mtime is working on your machine.
+--
-- 
2.31.1

