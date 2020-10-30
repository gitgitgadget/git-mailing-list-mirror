Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C558AC5517A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CB520796
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WshNP+dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgJ3Dmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJ3Dme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:34 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45933C0613D2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:44 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 9so5384849oir.5
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjCL1x/UCD1jtyn3E5ybdEdjSXu+u08PNMRbOq34jhU=;
        b=WshNP+dYm9sYhIANqVCrKK6uMArPmXkPklYfsIsVDLsUGs2WRMJM50wEsmcR4nxpoo
         eJHnqbbBqZhl/FXPBP6/HlQVoJcH+Q6CAO5CntVbTxfituwGnIy8DvHHgICngz7D8Xss
         KNAtKi8PS1h3WtHhl+ge/cZVH9StjvyZe5X8QJU0800gcNwrkcW0FTCxBzmct+pSANC1
         jlAvrnXWn67jou66yPzrryTko5tfnrnCPyk/nFNMobJMSZX12a2n0SNPVxZK2Rj/M500
         zs2gPMF3DpbubIRHQJPSkoGW3TOm8YLVagSBybPu3F4aCWC0PIC+2+MjDXxw+Qu82kgK
         UALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjCL1x/UCD1jtyn3E5ybdEdjSXu+u08PNMRbOq34jhU=;
        b=nmrnL1yLJF35HrU35n5C3KBaT7qRKjCm2VbrSVsCDKHpfCu4SaMvE2lgsR5yUUyoHc
         pW6U5Ybzu32rmHMLTRYVPCFt94PzQ/q0uQD/ZbmV43fUqMozjIICVYNC+Hx7Sr1z8xM7
         GN4bf0v7UP63P7eV61dYwczXVE95SeqT2CBzxw/7zRbahASlxRVxAg+Ng892U5+ehuuV
         J+eTOcWlzi90dD08WHF7QpioYXLO9ToW9NSzHCG4HI0I/N7snfDscBAqjRWyQXEwNgGV
         lPRzJ69P/K2gFhJKDKVOJTDxjZihDvDDkj3kBFd0PzrMtO1R1XAxnD/IIltStCwi3jNr
         9ixA==
X-Gm-Message-State: AOAM533DTzALU87Fp/iyZdCsLedpI9RHvGwQLjBEmT80ztzjCWKowNSZ
        jlfisY6bFsVeee4Li665LfCnLqJllEAUYw==
X-Google-Smtp-Source: ABdhPJwjdbd9J1/Upjo0EviQqPdjZ3CJzjO5E231qjkGokxo6fYNWXvm/eYMBV3ZodmXadV76MIBnQ==
X-Received: by 2002:aca:5515:: with SMTP id j21mr272363oib.150.1604029303112;
        Thu, 29 Oct 2020 20:41:43 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:42 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 01/20] merge-ort: setup basic internal data structures
Date:   Thu, 29 Oct 2020 20:41:12 -0700
Message-Id: <20201030034131.1479968-2-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set up some basic internal data structures.  The only carry-over from
merge-recursive.c is call_depth, though needed_rename_limit will be
added later.

The central piece of data will definitely be the strmap "paths", which
will map every relevant pathname under consideration to either a
merged_info or a conflict_info.  ("unmerged" is a strmap that is a
subset of "paths".)

merged_info contains all relevant information for a non-conflicted
entry.  conflict_info contains a merged_info, plus any additional
information about a conflict such as the higher orders stages involved
and the names of the paths those came from (handy once renames get
involved).  If an entry remains conflicted, the merged_info portion of a
conflict_info will later be filled with whatever version of the file
should be placed in the working directory (e.g. an as-merged-as-possible
variation that contains conflict markers).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index b487901d3e..9d5ea0930d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,46 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "strmap.h"
+
+struct merge_options_internal {
+	struct strmap paths;    /* maps path -> (merged|conflict)_info */
+	struct strmap unmerged; /* maps path -> conflict_info */
+	const char *current_dir_name;
+	int call_depth;
+};
+
+struct version_info {
+	struct object_id oid;
+	unsigned short mode;
+};
+
+struct merged_info {
+	struct version_info result;
+	unsigned is_null:1;
+	unsigned clean:1;
+	size_t basename_offset;
+	 /*
+	  * Containing directory name.  Note that we assume directory_name is
+	  * constructed such that
+	  *    strcmp(dir1_name, dir2_name) == 0 iff dir1_name == dir2_name,
+	  * i.e. string equality is equivalent to pointer equality.  For this
+	  * to hold, we have to be careful setting directory_name.
+	  */
+	const char *directory_name;
+};
+
+struct conflict_info {
+	struct merged_info merged;
+	struct version_info stages[3];
+	const char *pathnames[3];
+	unsigned df_conflict:1;
+	unsigned path_conflict:1;
+	unsigned filemask:3;
+	unsigned dirmask:3;
+	unsigned match_mask:3;
+};
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
-- 
2.29.1.56.ga287c268e6.dirty

