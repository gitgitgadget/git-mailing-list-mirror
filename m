Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E68C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F6F6108B
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhIIX0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349824AbhIIX0I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:26:08 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4A1C061768
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:24:51 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l10so90107ilh.8
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YuS+c34GpEkv6uyewZNPiRjnuUT1cG2SH2pGnbUWU6A=;
        b=GViBO+8jRyO99UDOpzLT39MARq/aHEKHLXhxt+gSaiRwq9Yqfl+U3d38lVn3IDLV1j
         LRd7XErHneu0pFu6pk2eOYjDva/K8iUsNKXHNjvufW2Fi47A5tiAxNGhmEAw5IMFtnJn
         KJkmQIZx5vLO4o+itUl8gP8WFsjn8vP4KUkdum6b8s+9rEn3DCaCfNo5FdsHJ4E6g12r
         SmFzvoCIdLv/v6U9SLcV5ryuxXSLouT2r3GnSkdpGH76L9r158+1rQI9jcYat8W9Ly0R
         bewOh+zj6G+CqA8iAfsimIyHChWQqygv5gAZRz2LPVbHg3zAYW56uBYcgvqEWEZP/BkI
         tqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YuS+c34GpEkv6uyewZNPiRjnuUT1cG2SH2pGnbUWU6A=;
        b=eEp3rL30RvZ5uTSYuqgYn9hjVPdtNVLS/cQbQCLBWD2e/iwDptFAUP9gzKUw51s8tq
         uN2YwfigkVOGvzEVAmYqCUXzHrvu1+374mZ3djIFZzFhtDuCdrVWtwn1yOBtc0bL3n3C
         mJv1vsq5ok7bb2IldgdqqLUaV5s1IkdeMi5tW+5aTwfkAeGPRO1Ap8Xv1t4vILky2A96
         xgtgLXTQd1AwnxYqw7HSvdTsdMCDs8NVeGojzYvswCZliSqd7xAoDKSXdptHtNXcn8Y1
         FYlEbU/2FQMIMLh9RQEeXlZ6BP9ZVYWb1S+faEl5iHZDiH6vMx2s00ZR6HqW5HthdL1D
         jw3g==
X-Gm-Message-State: AOAM533K2TkENmeJ+wGEBUjmQyXwCGQYw+UMGKqb3r9C9ieUgdX3mxfr
        gTvtXyKJkzcXeK0Yd9HLTM2F3MFcGI7Pdxx7
X-Google-Smtp-Source: ABdhPJwjdfH18h42Dl2wrbfzLVthQiZZkkkCg2zcjoig2X0WXmiMhz16X2iL1ZHX66sz0YW134ub7A==
X-Received: by 2002:a05:6e02:1a87:: with SMTP id k7mr4334034ilv.122.1631229891140;
        Thu, 09 Sep 2021 16:24:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e12sm1612748ile.14.2021.09.09.16.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:24:50 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:24:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 6/9] index-pack: refactor renaming in final()
Message-ID: <1e4d0ea0f398ba48cf1b1f87122ab343bdb296e2.1631228928.git.me@ttaylorr.com>
References: <cover.1631157880.git.me@ttaylorr.com>
 <cover.1631228928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631228928.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Refactor the renaming in final() into a helper function, this is
similar in spirit to a preceding refactoring of finish_tmp_packfile()
in pack-write.c.

Before e37d0b8730b (builtin/index-pack.c: write reverse indexes,
2021-01-25) it probably wasn't worth it to have this sort of helper,
due to the differing "else if" case for "pack" files v.s. "idx" files.

But since we've got "rev" as well now, let's do the renaming via a
helper, this is both a net decrease in lines, and improves the
readability, since we can easily see at a glance that the logic for
writing these three types of files is exactly the same, aside from the
obviously differing cases of "*final_name" being NULL, and
"make_read_only_if_same" being different.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/index-pack.c | 48 +++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6cc4890217..3e3736cd95 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1477,6 +1477,22 @@ static void write_special_file(const char *suffix, const char *msg,
 	strbuf_release(&name_buf);
 }
 
+static void rename_tmp_packfile(const char **final_name,
+				const char *curr_name,
+				struct strbuf *name, unsigned char *hash,
+				const char *ext, int make_read_only_if_same)
+{
+	if (*final_name != curr_name) {
+		if (!*final_name)
+			*final_name = odb_pack_name(name, hash, ext);
+		if (finalize_object_file(curr_name, *final_name))
+			die(_("unable to rename temporary '*.%s' file to '%s"),
+			    ext, *final_name);
+	} else if (make_read_only_if_same) {
+		chmod(*final_name, 0444);
+	}
+}
+
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
 		  const char *final_rev_index_name, const char *curr_rev_index_name,
@@ -1505,31 +1521,13 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		write_special_file("promisor", promisor_msg, final_pack_name,
 				   hash, NULL);
 
-	if (final_pack_name != curr_pack_name) {
-		if (!final_pack_name)
-			final_pack_name = odb_pack_name(&pack_name, hash, "pack");
-		if (finalize_object_file(curr_pack_name, final_pack_name))
-			die(_("cannot store pack file"));
-	} else if (from_stdin)
-		chmod(final_pack_name, 0444);
-
-	if (final_index_name != curr_index_name) {
-		if (!final_index_name)
-			final_index_name = odb_pack_name(&index_name, hash, "idx");
-		if (finalize_object_file(curr_index_name, final_index_name))
-			die(_("cannot store index file"));
-	} else
-		chmod(final_index_name, 0444);
-
-	if (curr_rev_index_name) {
-		if (final_rev_index_name != curr_rev_index_name) {
-			if (!final_rev_index_name)
-				final_rev_index_name = odb_pack_name(&rev_index_name, hash, "rev");
-			if (finalize_object_file(curr_rev_index_name, final_rev_index_name))
-				die(_("cannot store reverse index file"));
-		} else
-			chmod(final_rev_index_name, 0444);
-	}
+	rename_tmp_packfile(&final_pack_name, curr_pack_name, &pack_name,
+			    hash, "pack", from_stdin);
+	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
+			    hash, "idx", 1);
+	if (curr_rev_index_name)
+		rename_tmp_packfile(&final_rev_index_name, curr_rev_index_name,
+				    &rev_index_name, hash, "rev", 1);
 
 	if (do_fsck_object) {
 		struct packed_git *p;
-- 
2.33.0.96.g73915697e6

