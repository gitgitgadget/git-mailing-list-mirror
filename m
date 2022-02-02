Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3194DC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiBBHfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiBBHev (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:34:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47761C06173B
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h21so36591240wrb.8
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k2ZlxCTFDYzSmpOeGJxUNf6f5dpCk/vHuvJ4srC3B9s=;
        b=NNrycH5fde6IEuPga/Rd70bfXihZ26z66fx/lUUjNxZcV9Wf82IPcEnZlVWJphZQXG
         g+tiK9Fv/fN/64CruaqL/BviNKNQONOHrQE0sSrVjh1sT59u3hXzM4ZQL+R8V+i4850f
         Nq4GJ7cRAHaSwAtO/sLJZQWP8MJv9W1ElhP+emWYCEQ/jjXaxr2YI5ypDckvZAMma6Ra
         LKVVtMGylbGqkWg3NcK4WHhlCUT40Mfb5bnsCzo7DQ2C3tWEROOCrw2gTvWmzVBcr5E9
         U+CYPj0Y41l0UUByaOIdIBPKYx+1hsNwv7RiQGl0reQpj03M726VuIjiXGOX3fgqBRXS
         ALrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k2ZlxCTFDYzSmpOeGJxUNf6f5dpCk/vHuvJ4srC3B9s=;
        b=ymFKInT86/l22xfJDU9AwcMViVcESguse/fkcy+gHL+/RiyXot4WMoyMBBcemqVt2j
         byNv/Zr9tJdSkp88y8UiLXYgfx42VWOLZBzNhjMFbS1FiAofSNMANNaaByEHPtxAslHJ
         dRMO9UJv6nJ1sv4ygfyQ7KYlL1bfYqFAF4t8ABIWIKfeL3JBr82om7seZI7YZqvjTxep
         1S13ng1HCQzHmq5zc0wHxxqv6W3CoLXaQ8wslY5AR+QzS8sGwcMIHcpgHdgmEqO1cawH
         dbUIZnyssw2D8z6t+8S4X4fLSSohYlF2VpHJGcBxRXvsdNx0sQ+lUyhL/b3nbPKrufWj
         pyaA==
X-Gm-Message-State: AOAM533RlhL8T2kvluQGS2Rirem101QCHEn5timjCGcY7qHTyIwJ49fO
        OQfflf7/bIVstvaqmkYcbmhYNqAFrf4=
X-Google-Smtp-Source: ABdhPJxXuna/4CBitkgsodVIJVH4fdPa7urkrNCnIVAlQI9yXxwe9Qs+L6FsEBiBKLP4ZUzwS8ux4g==
X-Received: by 2002:adf:f703:: with SMTP id r3mr24785747wrp.354.1643787289790;
        Tue, 01 Feb 2022 23:34:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm4664604wmq.34.2022.02.01.23.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:49 -0800 (PST)
Message-Id: <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:34 +0000
Subject: [PATCH v3 08/15] merge-ort: allow update messages to be written to
 different file stream
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This modifies the new display_update_messages() function to allow
printing to somewhere other than stdout.  It also consolidates the
location of the diff_warn_rename_limit() message with the rest of the
CONFLICT and other update messages to all go to the same stream.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 9 +++++----
 merge-ort.h | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 82d2faf5bf9..d28d1721d14 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4236,7 +4236,8 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 }
 
 void merge_display_update_messages(struct merge_options *opt,
-				   struct merge_result *result)
+				   struct merge_result *result,
+				   FILE *stream)
 {
 	struct merge_options_internal *opti = result->priv;
 	struct hashmap_iter iter;
@@ -4263,13 +4264,13 @@ void merge_display_update_messages(struct merge_options *opt,
 	for (i = 0; i < olist.nr; ++i) {
 		struct strbuf *sb = olist.items[i].util;
 
-		printf("%s", sb->buf);
+		strbuf_write(sb, stream);
 	}
 	string_list_clear(&olist, 0);
 
 	/* Also include needed rename limit adjustment now */
 	diff_warn_rename_limit("merge.renamelimit",
-			       opti->renames.needed_limit, 0, stderr);
+			       opti->renames.needed_limit, 0, stream);
 
 	trace2_region_leave("merge", "display messages", opt->repo);
 }
@@ -4313,7 +4314,7 @@ void merge_switch_to_result(struct merge_options *opt,
 	}
 
 	if (display_update_msgs)
-		merge_display_update_messages(opt, result);
+		merge_display_update_messages(opt, result, stdout);
 
 	merge_finalize(opt, result);
 }
diff --git a/merge-ort.h b/merge-ort.h
index e5aec45b18f..d643b47cb7c 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -86,7 +86,8 @@ void merge_switch_to_result(struct merge_options *opt,
  * so only call this when bypassing merge_switch_to_result().
  */
 void merge_display_update_messages(struct merge_options *opt,
-				   struct merge_result *result);
+				   struct merge_result *result,
+				   FILE *stream);
 
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
-- 
gitgitgadget

