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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E24C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75025233EB
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBuHmsNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgDFN5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:57:38 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37394 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgDFN5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 09:57:37 -0400
Received: by mail-wr1-f50.google.com with SMTP id w10so17649413wrm.4
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GczwqmMhMlAsF6vOl+pzB+tlGjL9CRkkYe2i+lVhiBo=;
        b=PBuHmsNijM81W0G63+N0xWH4HCVXO7WAJJN3QAqj+dhlwgBAXpKKyQRFmOWxpHiz6B
         5YwyhgpKPiQgdUOXfq5EhTYAOlOWZLAcdTopl0ALewQvmKpzUX5V1NYfnHzbsOwKjpFr
         tkQ/Cg+w9bBCo6/0qE6hHepIUt5PNZ6OR0pHCInWQ0SPspjWHFa9x9wBrMY3Y8P3JDBP
         SyRGykWRdinJSpV0CDhyCMpfxgsh697LqSrGugjRxGP3Yds7yLHYqUsfRLZB2SFe+Dxe
         NAqMwRIrBJ6UvYsYAO83o6dWoApOlBn6t61SG7z2u8usBEDA05Lp4edFtEepDHM6TMzl
         aAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GczwqmMhMlAsF6vOl+pzB+tlGjL9CRkkYe2i+lVhiBo=;
        b=WvQeCEBXpdK0/0O36EMrtSACSCjW0sjk43v2F/5ECb1tMY7LMZP0mEVGWB4FmCZDxd
         4nh8AkYq6OkF2jm/H9IgUuFR04g95JW+PAuWXTuQMZgFEsc05qhg7258b2KTYoykfhtd
         LAT4Gqfr1GoAqWcD+HNiMymrRvlLkIcvLFUwU0gRbiqiZeZ4sGA0e7WMchhnsdutxIkc
         GTefaZZzSkRREWNogVUdVPrglixtpNAXCPGXg3/p1Qp4oTXaVEgcPrfSto8/mBpIErfh
         3C40kOjQCsxKyDvx23gRkesmcvs75/eGsASaz8D8uwzQt/wC2L6dtQCvZsuVAfnpUmY+
         peAA==
X-Gm-Message-State: AGi0PubHhOlVhWdc4GNKlIQXEogCoRdaSbT9u69lxmVu6AnZpt/U6So/
        PaCAqNqopYY/lbC1HPLquGJuJRQogSY=
X-Google-Smtp-Source: APiQypJ2fWpnnX543+xGDbPvrzAVFlE3rSE1Yldj/ofrwcTaiVI8RVOqm65xPA8o6wzIC6/+xSZKMQ==
X-Received: by 2002:adf:e611:: with SMTP id p17mr10424471wrm.384.1586181455515;
        Mon, 06 Apr 2020 06:57:35 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id s13sm10414149wrw.20.2020.04.06.06.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:57:34 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v6 1/5] doc: list all commands affected by submodule.recurse
Date:   Mon,  6 Apr 2020 15:57:05 +0200
Message-Id: <20200406135709.60041-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
References: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
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
Patched on top of v2.26.0-106-g9fadedd637 (git version 2.26.0)

