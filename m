Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B30C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDB520863
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW+DgnKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgCCRI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:08:27 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33015 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbgCCRI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:08:26 -0500
Received: by mail-wr1-f53.google.com with SMTP id x7so5373289wrr.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIFenohnjfQAv12M1MidGiPc+9p5o8qGnJzR+B81NtI=;
        b=lW+DgnKtHGfFsUJwjVyy4pU7/PYR+ox4gJBdeBNWVJNKtEp5N4Tf7SxjKRPU8RJlSh
         EVQq1sqDAMuH7vDUNPkdmhjF59/C+J1s++7pHSc4pEQa3ft4n8VybaVUTXhdj3npRTgm
         pFqX7awbcZryZdEI3MoyPP4NvDnAlRzpDQ41Yr85FPKUEQ5Io7/B+biT5fvBbVyFJHG0
         t2AXSFNoDGxfE0TK5biMmpjzvjBA7qj/Fm+l919emKJ2g+/c+Bn6n5sVQoe9AhJlF0VA
         37d3eNW7awOI/Lm7bXOwCD8QrtLdYD8df/0Mf5ioJ0DfE0MzRzMtkDHmghOe4GQCmWDb
         rSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIFenohnjfQAv12M1MidGiPc+9p5o8qGnJzR+B81NtI=;
        b=C53rMdgX6Ymmh7E/+8/KDmFcgBqQD0vUOFAdW/yWDteFAADQwOdQwKX0j5KJcRnj5G
         ikfqLyqhhpDnzhB9dMOTWmXiXUG5lSKeUwGlTr4RXYHDYA06yGxaw3lyro/0QCsJ1FHm
         6jzXN8gnc77e0TVb7/npZjJNqGYnO4d7IH24qJJljrNjHZ1mvcxKECf3aelyB6sU1rzj
         KuxR9QoX2sNu4+khE0aKZLj/QMlqWU1a+CvvFNhrvXLwehimbw3IVO07LMbPdDV43J2Q
         9B/IkTRQMj9YwCRCTfwQ3DcfTPl/ZCvQyDPhZ+6XcuROk/8P3LLKhXpQCsnge1ALeWrs
         XakQ==
X-Gm-Message-State: ANhLgQ2IZYIwrwVKrcusaf73x7r2Z3nxwIzsfTEsAM+0k88u9apCDxOS
        b/IeQMgz9eHj8i6TsiOn5mSA4qiZ+tA=
X-Google-Smtp-Source: ADFU+vu6W6cfiihT/b3gzlvxl8UzPlj5AFgA8XcRubgbHCCZ6eXcOUs6HhMM76y+XKLs59OYI3suAQ==
X-Received: by 2002:adf:a50b:: with SMTP id i11mr6987474wrb.60.1583255304350;
        Tue, 03 Mar 2020 09:08:24 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 16sm4746576wmi.0.2020.03.03.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:08:23 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 1/5] doc: list all commands affected by submodule.recurse
Date:   Tue,  3 Mar 2020 18:07:36 +0100
Message-Id: <20200303170740.1879432-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
 <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
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
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

