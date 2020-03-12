Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07989C2BB1D
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F9920716
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKc+hcev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCLRKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:10:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56006 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgCLRKS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:10:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so6934493wmi.5
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6iTEOGbcuaNJkI7z78gVwCX/ED05WFASlMWbAj+JFWc=;
        b=eKc+hcevRBCEUL0exeP6zX12PfxoAisBJ0CoZYEbh7ehixXAIYM5C9ui7CEeRdh/52
         OPhCFO77i5O/7tQST10EbVOU6al4CFHoN0PkaJcVdUsLI8vHNT6F/AcwhseIjsJ28vbh
         RU7pYf1D+wt9EldUNJcD8DBCdawW8E8Qx9VH1HcFdfxX+9JWsZuo9zVhDuBEASsxQbWQ
         57hzDEkmzpJx7CDxaSKZTjFHsymW/kTtg/8/XcuESkWo/bqncVNJAIFvjsgWCPEtAW8v
         TtSeqE/cbAJmbxcSPBfvlYJXFrx4FEJrHHobEpiHREyhcfhkTPldsz6Ad89XJT0GXPBV
         gV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iTEOGbcuaNJkI7z78gVwCX/ED05WFASlMWbAj+JFWc=;
        b=CuHG98gkjeEq84b3twbws8zA/+voqThue3lpdZoOa8r9bd28Dj6wn+gSZc54+3YUHY
         i8TskgsUfD7HAevlnrV4eMoGxNXuepgItt1w+B3YboliI3/pOfxRzydtMRKvBaPphmo8
         TOgneXMLOaKJeVZqoXYXnJc7BTRq+ZzwUPd2gJQ0guik3yHwOFCZmV/Z/QVVX2YIrIAk
         8Es9JhX9q2+I40zgZJ8N7prqZo2RTKloK1MchoWDPHDMHqBzXVs2RSUdivx+1QTTLPfr
         atFcLwvVWQphOMfgU9Y5PCCY9JjC3byPbWkFa+ZWXUoDW0agLgiCs13bGwR3J558mUGL
         qiJA==
X-Gm-Message-State: ANhLgQ3zn5nYa//w3grpdgTh8PIqcl+HF3Fs7hYkfQv8uTHPL2N0Yf8E
        js1jwmhIWwEWTCd/G33BRgg=
X-Google-Smtp-Source: ADFU+vsjTlv6Hre9SW0nYc2cAIDUFHJY1uyJjKm52TZkziM94Mllq6jdL2ldi7/AZzF+IQ1D0jk3kA==
X-Received: by 2002:a05:600c:2306:: with SMTP id 6mr5722119wmo.86.1584033016396;
        Thu, 12 Mar 2020 10:10:16 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id r12sm21593430wrx.26.2020.03.12.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:10:15 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 3/3] doc: add a short explanation for git-repack options
Date:   Thu, 12 Mar 2020 18:09:31 +0100
Message-Id: <20200312170931.2392490-4-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312170931.2392490-1-damien.olivier.robert+git@gmail.com>
References: <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
 <20200312170931.2392490-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some git-repack options passed on to git-pack-objects, there was
only a link to git-pack-objects(1). Add a short documentation explaining
their meaning so that the reader does not have to consult another man
page.

We also explain that unreachable objects are not packed.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/git-repack.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0962562c17..8f7f1140c3 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -14,9 +14,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-This command is used to combine all objects that do not currently
-reside in a "pack", into a pack.  It can also be used to re-organize
-existing packs into a single, more efficient pack.
+This command is used to combine all objects (except unreachable ones) that
+do not currently reside in a "pack", into a pack.  It can also be used to
+re-organize existing packs into a single, more efficient pack.
 
 A pack is a collection of objects, individually compressed, with
 delta compression applied, stored in a single file, with an
@@ -66,18 +66,27 @@ to the new separate pack will be written.
 -l::
 	Pass the `--local` option to 'git pack-objects'. See
 	linkgit:git-pack-objects[1].
+	This causes an object that is borrowed from an alternate
+	object store to be ignored even if it would have otherwise been
+	packed.
 
 -f::
 	Pass the `--no-reuse-delta` option to `git pack-objects`, see
 	linkgit:git-pack-objects[1].
+	The repack will not reuse existing deltas but compute them from
+	scratch.
 
 -F::
 	Pass the `--no-reuse-object` option to `git pack-objects`, see
 	linkgit:git-pack-objects[1].
+	The repack will not reuse existing object data at all, including
+	non deltified object, forcing recompression of everything.
 
 -q::
 	Pass the `-q` option to 'git pack-objects'. See
 	linkgit:git-pack-objects[1].
+	This flag makes the command not to report its progress
+	on the standard error stream.
 
 -n::
 	Do not update the server information with
-- 
Patched on top of v2.26.0-rc1-6-ga56d361f66 (git version 2.25.1)

