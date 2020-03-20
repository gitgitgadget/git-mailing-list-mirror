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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB6BC43332
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B11820658
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyIPxX9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgCTVi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:38:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38686 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCTVi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 17:38:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id l20so7987920wmi.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqK8D7Sgft+kmqobyPShgbUrJQrCVGXLReptz3dyxUQ=;
        b=pyIPxX9OCQFvpkik/ysTqkaR8wBPvCjjts3UTns4XgL6vk1CHfzChVjlP6afbNILOe
         UL94/Un6SPVlgZLt88xfmRsX2LWbiCS08iYz7lae/rpD5TDd9NhVgQQlh8yiQEVUdB2r
         zEfoj+mrz6Geb+1CmFta+5oD0ZWjfmbmxNjFP21g2tNKpehmpC9baTUbhGZa01PQn7yf
         VSLOQ639Z+1xEB8CGWYca2coVDbHgzudpecdaT0s5FVfBlAYa45YvYEi6sYvNcRV1dbv
         UYka5FCd8vP4x5QIZZL90v8H6y8iDfQu7wXOhTo4bXGdLwben6oocdDqYOVg87WeATbg
         7XEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqK8D7Sgft+kmqobyPShgbUrJQrCVGXLReptz3dyxUQ=;
        b=DG6U3x8JHyF522IVqh/snOmNCa1oIHxcmziV24de9MOQFI83XZeTo5200O7b4NIH12
         75CUEHUprlPFnYskYmrm4lpRTHIPWwjmH2NFxfpAL/letxClJIBzDznRbYbcpdkLmlLy
         zeqYcpuoKY4nj+fhuLyiBux9ex7W+snrSuBu/lwH5Bx1zkmCgamAaAskG5kqPdhkTCHP
         BcJPnDXKwXApWJsV+tlqcBWab904rGoqOkI0dhmx9HLc7x0zbjIVcZx343woeIZbkfFZ
         zRqd3hjPPPE9XmSYrxWlj0asBzThjzzYi3kY5bvRXveZ1NNGNv8U4NPgxK2KOE8V+n7B
         oL7Q==
X-Gm-Message-State: ANhLgQ04sRPgz6ATEK9KHNAwKLqV+UiZO3XRsz+BWvXlFjX6vhOVspoX
        XbDo4CXHMUNiCHUaRSsU6+mIoO0DXsI=
X-Google-Smtp-Source: ADFU+vuPs+txlqrlDeS3FgF3cIoXmEqRRn68cE4KUWwfp0A2wX0/WmqNF7JczN6sZMxC0c89y/pRiA==
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr3694004wme.47.1584740306052;
        Fri, 20 Mar 2020 14:38:26 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id i1sm9742407wrq.89.2020.03.20.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:38:25 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v3 3/5] doc: explain how to deactivate submodule.recurse completely
Date:   Fri, 20 Mar 2020 22:37:27 +0100
Message-Id: <20200320213729.571924-4-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/submodule.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 5962f41ead..900d374385 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -63,6 +63,13 @@ submodule.recurse::
 	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
 	`restore` and `switch`) except `clone` and `ls-files`.
 	Defaults to false.
+	When set to true, it can be deactivated via the
+	`--no-recurse-submodules` option. Note that some Git commands
+	without this option may call some of the above commands affected by
+	`submodule.recurse`; for instance `git remote update` will call
+	`git fetch` but does not have a `--no-recurse-submodules` option.
+	In this case a solution is to temporary change the configuration
+	value by using `git -c submodule.recurse=0`.
 
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
-- 
Patched on top of v2.26.0-rc2-27-gbe8661a328 (git version 2.25.2)

