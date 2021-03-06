Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB98C001C7
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A10965029
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhCFLFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhCFLFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A790CC06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:09 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l11so1833212wrp.7
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7xlsqyuPYQZ64lHqwsCMknPWl8WoR+/0IrTGdVxtSs=;
        b=lLf9VTKCKkqtdmAPi2+Wa4yQffSBfjYSz8F+L6xT7zZAg2j6IPe/sGltOteLyDA/F9
         jyPcsFURMpnX+VUp+PmqAwN72FZSKdp6q2bniWvxCNFZ4oziwzB+RQnIP6YvysKiyDZJ
         Voc84nSSMZI1xEGb0j0xxRfF1SuBzsRHh+f6dDtNMBgMNG0uSJpzwBJq3QatRzV9/wHV
         eY+06G4edfj5PkPo/Ave31W7ttITewpvyPBzZaK0ha8XJOG5oy6I4hwmpBwZzSmOWmdE
         lSSbi2D8npOPvUwmVO5iYsNYydSNyMX5YvkrGZnTUN9hL8kbeb35dkUktvxrjxtBdUNA
         bb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7xlsqyuPYQZ64lHqwsCMknPWl8WoR+/0IrTGdVxtSs=;
        b=kCuy1dCT/JUT+lZmwZoXrN8aGWdKqKKy/8EzdQa219g5kIJBijayxifft/lGZfNgMy
         0JADQ7tOr6KLcTlBQsz3G0bzf+d8eNqNUe63Lkjmz7PAI1VcH4G7apMNkcPZIEzD802H
         B73KAzJqMYmjhvAW364ttClFRamkUrkpgotEo8swIno4AQk5gQ1VKRcdbuEE0o0lEU9X
         SCg/dLMvYmsNNAIQKYh/27mO/H8tf5NLYjr4dMbgafEqsfBdUuWrbE+BDMG2xUtV4aiF
         rH6o/3ZToaDMqiHUAGvzrQXN2kYNHheGYsU9VDUd82nBNcPxKI8a74vYAmilsPUIrgYq
         FFkA==
X-Gm-Message-State: AOAM532ZyJnHK/GVi9MzaNhgZBwQzD/vtoMi9s8ufCVtSR+/wFZlnk1X
        PEpvAQW11A/kX9x1lDA7GhIHKsj8F88F0w==
X-Google-Smtp-Source: ABdhPJytgwwDt5YXR2exuLGP3oQeTAttc9FXjDtNDhTTlknEHCLhd4/l9kLHiWWoQTzyebBtr9yCKw==
X-Received: by 2002:a05:6000:18ac:: with SMTP id b12mr13766539wri.77.1615028708177;
        Sat, 06 Mar 2021 03:05:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 20/22] fetch-pack: don't needlessly copy fsck_options
Date:   Sat,  6 Mar 2021 12:04:37 +0100
Message-Id: <20210306110439.27694-21-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of the .gitmodules validation added in
5476e1efde (fetch-pack: print and use dangling .gitmodules,
2021-02-22) so we're using one "fsck_options".

I found that code confusing to read. One might think that not setting
up the error_func earlier means that we're relying on the "error_func"
not being set in some code in between the two hunks being modified
here.

But we're not, all we're doing in the rest of "cmd_index_pack()" is
further setup by calling fsck_set_msg_types(), and assigning to
do_fsck_object.

So there was no reason in 5476e1efde to make a shallow copy of the
fsck_options struct before setting error_func. Let's just do this
setup at the top of the function, along with the "walk" assignment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2b2266a4b7d..5ad80b85b47 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1761,6 +1761,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 	fsck_options.walk = mark_link;
+	fsck_options.error_func = print_dangling_gitmodules;
 
 	reset_pack_idx_option(&opts);
 	git_config(git_index_pack_config, &opts);
@@ -1951,13 +1952,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	else
 		close(input_fd);
 
-	if (do_fsck_object) {
-		struct fsck_options fo = fsck_options;
-
-		fo.error_func = print_dangling_gitmodules;
-		if (fsck_finish(&fo))
-			die(_("fsck error in pack objects"));
-	}
+	if (do_fsck_object && fsck_finish(&fsck_options))
+		die(_("fsck error in pack objects"));
 
 	free(objects);
 	strbuf_release(&index_name_buf);
-- 
2.31.0.rc0.126.g04f22c5b82

