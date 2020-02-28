Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DF2C3F2D3
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E28246A8
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkb6h6PK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgB1KhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:37:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52631 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1KhY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 05:37:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so2672331wmc.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 02:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrLPyaiaYxNr5VYOGRRmz8kobqodVrUtMllaIBOgXQ0=;
        b=Bkb6h6PKCpS/9Ruk27csOggALVQ5sefrBZhNNcBI5O1pf6jeBCivWgtkkeWQ7zqP5b
         zeGGODGQ8Fx9qWr0JDvR9JtI8inp4kXAJPTGf6YZkwdu+XLEDK535Zm3/aX6H9DMIKYK
         use2GccvgZOYkbz3p5vpL8L1HOkkQd6L/R6lI7Nsc1B+ErOS8k23dp4pE56ZOcwhWcSp
         IZthRZGRMtP8hfh37v/nYmwFJ8XG/ZAj7C46bUqkbgNx4DzOY/EFLrd0V6kE5NxJ8Hl0
         3NYHVfV2eYoX4ZdxZ9A66JYLBsTUVxf9FgR6OrZO6aDqI50OD6HL7X1G77PL4qGCHxhV
         VBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrLPyaiaYxNr5VYOGRRmz8kobqodVrUtMllaIBOgXQ0=;
        b=cxbm+e4ty11LLquRFZsCnoxrGYUw2A4kOw+xYLc3nj3/IR/l8zsBPStlTRemUBbjur
         FsJHmlR84rnr5KogGiHklATyF+xZ9xv7BeJKfffOUGmQUFhM9aZsuYpuigD41hd2Uubz
         QtCipcK4AT19GIlIa+Df8r2u89g1bdov+JfxeNw/aLnN+i9K5NjTlQqcukGKSYAJuJDs
         +4nTkNljc9Wal0wokdhoEFXMT2b1pN9xCjyYYCSW+upYXBljbBa3H1cCbT3bUxmM039W
         UqfiXd0cxNr6ZFL7CTNOkvduPnedmW2/408DWTeX4fa2F7uciAABQsc7tjyYJtchhtnc
         GV+Q==
X-Gm-Message-State: APjAAAUG0wi8MXDEHeRnYM7G3fhCYLG2/vrsKeKmLTJVKCxd3IO58NJp
        FtcgM1ekaUuVZd4G0/vSdoOMptFTDJw=
X-Google-Smtp-Source: APXvYqx+NZpqc7HcfGEeaL287JXpOIdB9+Ma2A+RmzjdF995L41ooZpGM+KMPdmq6ud6BqQCEnj/lQ==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr4471266wmk.65.1582886241934;
        Fri, 28 Feb 2020 02:37:21 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id c9sm12089032wrq.44.2020.02.28.02.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:37:20 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH 3/4] doc: explain how to deactivate recurse.submodule completely
Date:   Fri, 28 Feb 2020 11:35:57 +0100
Message-Id: <20200228103558.1684937-4-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/submodule.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 5962f41ead..f4edc6cad0 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -62,6 +62,12 @@ submodule.recurse::
 	applies to all commands that have a `--recurse-submodules` option
 	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
 	`restore` and `switch`) except `clone` and `ls-files`.
+	When set to true, it can be deactivated by calling
+	`--no-recurse-submodules`. But note that since `submodule.recurse`
+	also applies to internal calls to git commands (issued by other git
+	commands), adding `--no-recurse-submodules` might not be enough to
+	completely turn off the effect of that config. A solution is to use
+	`git -c submodule.recurse=0` instead.
 	Defaults to false.
 
 submodule.fetchJobs::
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

