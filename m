Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C89C2BA1E
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1F320659
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IStKyodh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgDEUQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:16:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52069 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgDEUQy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 16:16:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id z7so12591085wmk.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 13:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bYBe3OpuZ9n0K8eByYmAM/5gIOocBDpwe2ST+mZ+Pu4=;
        b=IStKyodhOVUdmNgNsRozznBvWPtgESf0fD3M8vCwJ936kYHmkxOzlWGjBUy+mEVEBh
         cUQuGdU+rnjkhmox0cS4LpADpdq7F0/MdcuzxaaQ7tETGVc9yctvKEzsvCoqfnSBPADq
         Qub5Ee9DsoP9PKXfNi9mTSt5XTn6pUSL35f5tWnkimYz8Wzo2V6T9TWqp24Bmbz2PdRh
         GoGrfTaH9ixHgNe5JauKwj2TCBJPENHXMwx7NdPdpoYT+L867f+gIj7a31DFDIi/HOgP
         6RF0Rro3j+/RCtXwjjKuZsbl3I+WAaH0lHVPkH4l3CPldSr4pcqQ/ozmYGLCld415ID9
         v9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bYBe3OpuZ9n0K8eByYmAM/5gIOocBDpwe2ST+mZ+Pu4=;
        b=mklREFP5KLolqmrpeZFce0ykW9bK0dj36ojLQggW6HL10Aa+qkmaWkVdMkIMwwIQAv
         NvrHdEGl2mRlkioCSsRlZlpoOW0iRD72UQsUgcWDvHcmzHlBoGa8ENfxTVOekHpqQxnX
         ukoDNVx4Tzo9x9/GX/+jXAZB5ait5h8olcOtcGiEgh2dTBg/hqH7X7wdPJzXnYXjDJbm
         SOWdwnYIg4B5/6lKBOz5BxXfYzkVmxpLEma5vONsxT0ehkLsHOG2t9kkVbMgjhUg07B/
         bvzmW6nYO8bimyqGs3Hu6jAsRNQb0ZQ6bbcdeE9jvaaID5w5jYnivwTJ0TiK43aa130K
         su3w==
X-Gm-Message-State: AGi0PuYKJ4/or7XcefhYxpsucWQbrHI5TJWj0O9z5HQVSsL0+PXknvYY
        E/2g0VHPCsHUELC0mRbVmnJgG2oYnS5KIg==
X-Google-Smtp-Source: APiQypKNOyxhapjxaMvAcprRMLauaczyubxuxPy/eEjEOWDPMAXX2GRsn2Yd5QYCishe+g5e9airAg==
X-Received: by 2002:a1c:6189:: with SMTP id v131mr19399341wmb.69.1586117812125;
        Sun, 05 Apr 2020 13:16:52 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id d7sm22468921wrr.77.2020.04.05.13.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 13:16:51 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v5 3/5] doc: explain how to deactivate submodule.recurse completely
Date:   Sun,  5 Apr 2020 22:16:31 +0200
Message-Id: <20200405201633.704987-4-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
References: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
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
index 5962f41ead..d7a63c8c12 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -63,6 +63,13 @@ submodule.recurse::
 	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
 	`restore` and `switch`) except `clone` and `ls-files`.
 	Defaults to false.
+	When set to true, it can be deactivated via the
+	`--no-recurse-submodules` option. Note that some Git commands
+	lacking this option may call some of the above commands affected by
+	`submodule.recurse`; for instance `git remote update` will call
+	`git fetch` but does not have a `--no-recurse-submodules` option.
+	For these commands a workaround is to temporarily change the
+	configuration value by using `git -c submodule.recurse=0`.
 
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
-- 
Patched on top of v2.26.0-106-g9fadedd637 (git version 2.26.0)

