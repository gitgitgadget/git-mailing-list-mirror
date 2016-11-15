Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4E42042F
	for <e@80x24.org>; Tue, 15 Nov 2016 23:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935110AbcKOXHO (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:07:14 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33828 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933888AbcKOXHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:07:09 -0500
Received: by mail-pf0-f169.google.com with SMTP id c4so26603141pfb.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3TOBruuBezdKLjCHPZsCa7YVRPxCjIrDc3vZRpaS3Ng=;
        b=e47exxkWPujkZfPSY8mN+yTl9Rf7JgTfUq2zVk/A8cfFaBGpMKNGW3GPTUu+rNIrHP
         xxKzunCC1I/VhocBii8doFkaHCl3vaDZaBR1mJN2wuaqbusKAzyqqtYNvAHZ/cTayPwr
         NMG2i/flA6/ite0JGf/sQlyPhMul65TbZhOsR9dsh5eXB01NPK/CNW3Owu7L3nqj5FhX
         jLEty+ZEzzjwFQzkc5gLsR35BKZDpWlK5ccaWW+3Hv4jYRoEZLwk9A9jeT+5GQuwhk5Q
         L7raE6q2TT3whe+BDcrkv61ikkGuquX0KisRdWmOgmx03KRphtSSdLIVxUTQgS6F1Do9
         j/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3TOBruuBezdKLjCHPZsCa7YVRPxCjIrDc3vZRpaS3Ng=;
        b=GqUzwrmDVZtzWDb8lbIwfmvRnCEaX709BpU8g6QPR/cgjFy2n88S/84SmIQptaMk0c
         C5hAEAQp4QoNTJHLuTtDq4rQO1hqyK3fsfDE8dsbEtFkTZznwEILWyX607t5U5ywLiag
         vKrSXudg1VxxOBR+VVw8FQAgYzGthEbIlEwGDnIws6jBKJuaBoOx173mzDSHIadoyVZ9
         M5BQxnrxwPwwT5B+FETy0uwkPctfL2FGnsfeqLawlBQxKMt0s8g4pAPachM5cw9zHQx/
         QTbpuuRhOiE2ZAMYn8OnapeBXLlKH1unjQhjCVTsWL7FiOnC5u87O+X8gOpFWLayDTB/
         /0vw==
X-Gm-Message-State: ABUngvcpCz7FwjQS7j706FAq8rzjaizjmuSYdl+tNVbH/wWchboi5OhWgGguBFGRAsdHKzTF
X-Received: by 10.99.45.7 with SMTP id t7mr1150344pgt.86.1479251228666;
        Tue, 15 Nov 2016 15:07:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id r194sm46222292pfr.94.2016.11.15.15.07.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/16] entry: write_entry to write populate submodules
Date:   Tue, 15 Nov 2016 15:06:47 -0800
Message-Id: <20161115230651.23953-13-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/entry.c b/entry.c
index 019826b..2330b6e 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "submodule.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -211,6 +212,7 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create temporary submodule %s", path);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
+		schedule_submodule_for_update(ce, 1);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
-- 
2.10.1.469.g00a8914

