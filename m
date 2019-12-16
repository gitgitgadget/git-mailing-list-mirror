Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E268C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447DF206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2XrEiCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfLPPs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:29 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37304 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfLPPsR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:17 -0500
Received: by mail-wm1-f49.google.com with SMTP id f129so7246634wmf.2
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2pdu4w9L5gn7kiCH/6G8ZLbD2+biJruLwAPyx7b5tiA=;
        b=c2XrEiCjW+2+z/lbavxRsMhiflpN2DrJCwWMkLQCdRrhyJznp27y3w8gkIXctGLP6B
         L8gEtH3y7I/7duRp6b6yBMzZqf6mhS+VHsBOPUSHCtU1vc/UACPncTSGTWBvf1ZHY9GG
         WpZBCI5CrlA/YgYMMJLc3bdxwKP+SCaj3xxOvZSlAODEfqlKs+ZQo14sAnhPq3Vz8aAA
         Vp2KO8WMgSP1nIkNN8OAiAAzryEUItKph8ohFd+n6RYXx6Ebtm8A2//akXppM9Mu9Ik8
         7y6I+KnWE0wvEFcwZZFu7Vvvfpj8Hv86jc6vlgwZliQRtytFUkkq6bxS63NnWpSe9EY+
         SfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2pdu4w9L5gn7kiCH/6G8ZLbD2+biJruLwAPyx7b5tiA=;
        b=ORcC5V+b4j9MxhT8r4ioMa4kRjjW9VpxXpEGfhuCU64Wm9GFMRvLufSaGQ+Mg5uTjs
         lrxOvVtpa3p9bmQBJAxzZ4OURYfrY1WeP5eUSTYqY44El58eZy+559VI8TxSlgpEE04p
         F4qhpfeQ1U5c7uYWTC0CcvYoPzaOTHtbPAlSi0NFnT/5ehQfbZuQuuZVeUaP7Fv8a46J
         iAoKq4kzcBQvOipobCgbuRn5qw3lbUNj9qu+gi/Bc0jAgARyptr4AF8O7QBfe3EkaR5J
         RV55pPdvjmxSWzpSPGwIH86GmlnnU1qVMXx6KOBs894DeLQbdbVK3zpX8L6Q/upfAIry
         qKMQ==
X-Gm-Message-State: APjAAAUt9bW7R8YJfLe6yTYewwzYFqXLdNBQlV5LFDpzeMVQ4TN5Bg45
        6MMFZq8aE8ikQBdoA96DKXf1T3Ty
X-Google-Smtp-Source: APXvYqz9UxGMYFWU5s9tVp2D1axSnXYrMs1A6oBCkV7t/fbgdf3EM4afgYJclFtuD7sy0WOcCixJbQ==
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr17645753wmg.83.1576511295470;
        Mon, 16 Dec 2019 07:48:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g21sm23337933wrb.48.2019.12.16.07.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:15 -0800 (PST)
Message-Id: <2c23bd602d3bcc88a9671aab1659b327fc056854.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:59 +0000
Subject: [PATCH v2 11/18] parse_branchname_arg(): extract part as new function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This is done for the next commit to avoid crazy 7x tab code padding.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3634a3dac1..e1b9df1543 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1113,6 +1113,22 @@ static void setup_new_branch_info_and_source_tree(
 	}
 }
 
+static const char *parse_remote_branch(const char *arg,
+				       struct object_id *rev,
+				       int could_be_checkout_paths,
+				       int *dwim_remotes_matched)
+{
+	const char *remote = unique_tracking_name(arg, rev, dwim_remotes_matched);
+	
+	if (remote && could_be_checkout_paths) {
+		die(_("'%s' could be both a local file and a tracking branch.\n"
+			"Please use -- (and optionally --no-guess) to disambiguate"),
+		    arg);
+	}
+
+	return remote;
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
@@ -1223,13 +1239,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 			recover_with_dwim = 0;
 
 		if (recover_with_dwim) {
-			const char *remote = unique_tracking_name(arg, rev,
-								  dwim_remotes_matched);
+			const char *remote = parse_remote_branch(arg, rev,
+								 could_be_checkout_paths,
+								 dwim_remotes_matched);
 			if (remote) {
-				if (could_be_checkout_paths)
-					die(_("'%s' could be both a local file and a tracking branch.\n"
-					      "Please use -- (and optionally --no-guess) to disambiguate"),
-					    arg);
 				*new_branch = arg;
 				arg = remote;
 				/* DWIMmed to create local branch, case (3).(b) */
-- 
gitgitgadget

