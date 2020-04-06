Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965B0C2BA80
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1A5233EB
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rup6qgwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgDFN5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:57:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39890 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgDFN5j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 09:57:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so17580258wrt.6
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bYBe3OpuZ9n0K8eByYmAM/5gIOocBDpwe2ST+mZ+Pu4=;
        b=Rup6qgwNpCTR2Hsi9KZe2QTL9u82HYNxd2YQfQC5pBG2l7CQCw8mOpT5p+bdIVrY+6
         Gfx7MUVj3x9A7HCj2gQBEiLy/ctY+o2sKJCP7hrCZj7G6AiGONu+E3b8B8jNtw490WY0
         8F2jH/NpTzDIfFUyJYs9Gnwpl7sdDHfeLE8ZSnY1cro2J7zQsiZXvnustHccS7gLZ+pV
         AQ8lkXtTHSyQEpUowvgki2wgKlZ20my1nSEnSrTdddERkJP3p7/RWCxR26TDaMh4wdqV
         NxPyGuUW8apNAwk22YuC+C3jqiKamskJ26V9vgblvZbDDkvY/DjPTeHXfDHi1dsVvGqP
         6sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bYBe3OpuZ9n0K8eByYmAM/5gIOocBDpwe2ST+mZ+Pu4=;
        b=rtyD1gkSI0qvyPrd0CjLcLvlD49dTC40aAaXWropDigZqAgRLrDJl4L0UW5Nazg+6L
         pnts0UL47hySA2b+C94AAWmPkJpbHdB5+t0z/Maj1Mp28C2+3s2JjImCAuoU9rG7l05a
         gOLBJH4PhdGgXNVVMlDLAIDMAjkN6zQ9WsqbVRYLYmyqjNQMtSbfa2l4VC+jzODIQf44
         hm5b9/2ky/3NI1URNGBTfTylwF9+QxQS9UU2GMIzrjcDlS6oLc9gJuFX9D6IYy9vE31M
         KyBp3P81XzBnqWjxwqOQ7PUh3WIp9QVWj8McwO7QK69edxiFdZZ+xZR3c6nFaWSOXjjf
         E3dw==
X-Gm-Message-State: AGi0PubHNm3OwxdiJOCLP20aQhjclaBhZRXoAnZhfdfXv05QRICK99uQ
        +md+CRqLvUAzEGpO8LWaAXQEnRz1QoU=
X-Google-Smtp-Source: APiQypIRLzro+DKPd25ecWcaunah8l8PBY1BnSAQmm4r6qIS/VCC6K8ZNnOPzBj1nBeWFzssEm8+kA==
X-Received: by 2002:adf:eccd:: with SMTP id s13mr6739205wro.105.1586181457461;
        Mon, 06 Apr 2020 06:57:37 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id s13sm10414149wrw.20.2020.04.06.06.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:57:36 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v6 3/5] doc: explain how to deactivate submodule.recurse completely
Date:   Mon,  6 Apr 2020 15:57:07 +0200
Message-Id: <20200406135709.60041-4-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
References: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
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

