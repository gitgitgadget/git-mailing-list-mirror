Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F093C1FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 08:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbcHPIRw (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 04:17:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33820 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbcHPIRu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 04:17:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so15045909wma.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 01:17:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=abxkV6K87/DWJhAf42KGBOpvZHJgAKkOk1K+99ezvrs=;
        b=O+MNynHnanr9Kw0ySEGWZgexhT5KYR5HTHRv59sDCo7jkVAWmVJ6TDYs48Q1H/qWSv
         luks+Oepus2CFqlgnTfLRJrNhb9JCGg5nuT2Zpr7N8Q77pEhNIQEmSMSEMy1TOqiId/O
         PLXd7uJQGJ95iKttFF6AXhdmPe29TnB30mCW4aUyk+UBYWuA7HxiveKAbTMFuYl76w7Y
         LFdssuVg51JFqX+Nrn+2r7yuNgektDvXvt8B19IhxmwZ8kVn/hDMt5AfA2uIf4i7aYm0
         wZ86ekSKFVU43pnopy8DuE+rAhy/Mx8n/5ica04SzzupOZd4Bkc5u3nNCgfmVBco6ljL
         Ctmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=abxkV6K87/DWJhAf42KGBOpvZHJgAKkOk1K+99ezvrs=;
        b=MB1EanDZzGbO56a9qFPXtpzJvHdFWWN8IPsdCYwRVI1MrDA09ISp4BtxISbv5DsvYd
         qvV/DSEi6v5/jrWjY86q1+jV//CXt5bcVF6ar9g1xr98y8P0NPw5bf6UionMR9uWpzYW
         jHwGKHK6TyjKM1JAV349sdHlVP2IOZbrFLy1BnCBT5+Dz9uZbtYH+6U7BEluzrJ7fgYX
         z5OTJsfmvPLXAYmXtKZXisB3mww3XfKnWc4dVOFPT9v/tSgd/R+LJEUKaOkrk3U0mvgo
         wFPUcE04AIE0vhWUEKXdjHTKt6uXqgOsG9VKi7U6QELwBQ2m1Sec81qHu+rurKQZ3kMT
         mgGg==
X-Gm-Message-State: AEkoouvaxXrDaJLOcED8Sqie8MrjgSu5jSlo7a8muZgjT39UFPAyf2RDZL7TiIVVFYMIpA==
X-Received: by 10.194.117.41 with SMTP id kb9mr4810974wjb.188.1471335468988;
        Tue, 16 Aug 2016 01:17:48 -0700 (PDT)
Received: from localhost.localdomain ([80.215.5.33])
        by smtp.gmail.com with ESMTPSA id 142sm20461121wmh.12.2016.08.16.01.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Aug 2016 01:17:48 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] unpack-objects: add --max-input-size=<size> option
Date:	Tue, 16 Aug 2016 10:17:00 +0200
Message-Id: <20160816081701.29949-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.3.g8535b4c
In-Reply-To: <20160816081701.29949-1-chriscool@tuxfamily.org>
References: <20160816081701.29949-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When receiving a pack-file, it can be useful to abort the
`git unpack-objects`, if the pack-file is too big.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-unpack-objects.txt | 3 +++
 builtin/unpack-objects.c             | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 3e887d1..b3de50d 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -44,6 +44,9 @@ OPTIONS
 --strict::
 	Don't write objects with broken content or links.
 
+--max-input-size=<size>::
+	Die, if the pack is larger than <size>.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 172470b..4532aa0 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -19,6 +19,7 @@ static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]
 static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
+static off_t max_input_size;
 static git_SHA_CTX ctx;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
@@ -87,6 +88,8 @@ static void use(int bytes)
 	if (signed_add_overflows(consumed_bytes, bytes))
 		die("pack too large for current definition of off_t");
 	consumed_bytes += bytes;
+	if (max_input_size && consumed_bytes > max_input_size)
+		die(_("pack exceeds maximum allowed size"));
 }
 
 static void *get_data(unsigned long size)
@@ -550,6 +553,10 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				len = sizeof(*hdr);
 				continue;
 			}
+			if (skip_prefix(arg, "--max-input-size=", &arg)) {
+				max_input_size = strtoumax(arg, NULL, 10);
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
-- 
2.10.0.rc0.3.g8535b4c

