Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98F8C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5CD20767
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBJoFlIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCTVie (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:38:34 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40894 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTVi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 17:38:26 -0400
Received: by mail-wr1-f44.google.com with SMTP id f3so9236922wrw.7
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5e2TyOkpK8Wy9MHE3LZi568BbrGfyrDHQr4QzM0RXg=;
        b=TBJoFlIziVneN+nwQMj0LlYofpiO6Dnt+Tkcv7lvWpACps1/hJ3PCE7QrrUed62BL5
         m4fiNoEV7eBpNy5hExBda7fqTGEPcC11FNhoMG0kSmUplIdPGwUSr9bHvqLc4Woc3Egj
         ecbu31YOAW9013tVhPWu/3mZcVGd4h67XEY58INGBc4lBxE3HY4lzDRR8UgvCo7CFifD
         xD4YlT56oKB85ZNG9IZWnvex5jSRTiLZbflUNbRwnvJVCRzHtU0VCvrHUzI3VjVRrrVe
         CmP47HGoE86mi7xoxfjU1wtqhj+IPbT9yapMNLbGdstPm/g0yOUWVzKdrYRBiz8Qr+pr
         38gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5e2TyOkpK8Wy9MHE3LZi568BbrGfyrDHQr4QzM0RXg=;
        b=sNhksu0IKztAzCt3V0cK6Vk/1XMciIQlR1ENnBm+/b1AM+/GPVG+MUBr3FW0PeNps/
         JENMvrWIEC7cFZhXB5VP4E/bGCNGTZjeaeaS2F6bcF+rBa3nA78bfvcOLtkN0sSBc15c
         1dvr6ykig7v9D1LPf8VMQQZt9exD27R9zB9Fc+LhGhAOZcAuyT5a/Gw9BOXu9jKJvCvw
         7/DQKtaDfoLmWGB6XEKbOinEnDxG6lkpawNRpdA3cjLbRt7YQ5yajBAcVHjPf1FcSzcQ
         dTfO14BGcJjL0aQWkcbOABdF+GiMIboouWmll+BQGPwG19ESv5is2fl4piRLDK83ua6x
         qJsw==
X-Gm-Message-State: ANhLgQ1wTnCAfueZjtf8XwDEz49cStecMwAxv08KQnTWQH9IJpNFX1A8
        NA2EAbuh2kXamtXyL7QJKYSjQRHf6dU=
X-Google-Smtp-Source: ADFU+vtd3Gfh+/b8jP8wdZO7XUK0fpLOP4cMEOPZjgxzLFRzTabSxMWC7nM2KhaO6dQjACXjoL+NNQ==
X-Received: by 2002:adf:f310:: with SMTP id i16mr13164494wro.100.1584740304063;
        Fri, 20 Mar 2020 14:38:24 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id i1sm9742407wrq.89.2020.03.20.14.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:38:23 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v3 1/5] doc: list all commands affected by submodule.recurse
Date:   Fri, 20 Mar 2020 22:37:25 +0100
Message-Id: <20200320213729.571924-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that `ls-files` is not affected, even though it has a
`--recurse-submodules` option, so list it as an exception too.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/submodule.txt | 5 +++--
 Documentation/gitsubmodules.txt    | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index b33177151c..5962f41ead 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -59,8 +59,9 @@ submodule.active::
 
 submodule.recurse::
 	Specifies if commands recurse into submodules by default. This
-	applies to all commands that have a `--recurse-submodules` option,
-	except `clone`.
+	applies to all commands that have a `--recurse-submodules` option
+	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
+	`restore` and `switch`) except `clone` and `ls-files`.
 	Defaults to false.
 
 submodule.fetchJobs::
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index c476f891b5..f9f4e65c9e 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -271,7 +271,8 @@ will not be checked out by default; You can instruct 'clone' to recurse
 into submodules. The 'init' and 'update' subcommands of 'git submodule'
 will maintain submodules checked out and at an appropriate revision in
 your working tree. Alternatively you can set 'submodule.recurse' to have
-'checkout' recursing into submodules.
+'checkout' recursing into submodules (note that 'submodule.recurse' also
+affects other git commands, see linkgit:git-config[1] for a complete list).
 
 
 SEE ALSO
-- 
Patched on top of v2.26.0-rc2-27-gbe8661a328 (git version 2.25.2)

