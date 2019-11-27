Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13986C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 09:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A7120678
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 09:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFqBQps1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfK0JtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:49:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36191 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfK0JtB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 04:49:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so771451wma.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2pdu4w9L5gn7kiCH/6G8ZLbD2+biJruLwAPyx7b5tiA=;
        b=VFqBQps1Y5YLDOWDQa9rrxLweRhM9QJt9dR0tCUPayMWTXaosYJh5Ooc4d1uufBrNu
         hQr8YhFfPu8QxdqMxUmYoRQjyLSwBXnhTlizi53GrOHN+tXWiSb5tYoSuVT4amUH2T8G
         a7v7eYjvy0UyLRTqbkJxJm9P5ue2O4Z2E+6aKAhaVeVXvs7FkUgE3yaMEova4jU/kvHa
         nPDf3+W3HYuIM+Xqq8z4AKNrrJY7hNVZElEZPuW6OGx20kLr1AMyPz73TlYGtZgcjc8+
         04Xs1qPRh2UVlmDTVFLsgrnTtL71X0lSvT4etP81oa1HYG6duvE48oW2zXGauuStqMGR
         UGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2pdu4w9L5gn7kiCH/6G8ZLbD2+biJruLwAPyx7b5tiA=;
        b=eA7YbVDuvsFuND4jVJD60XmQ6K0/TIf1B8/pVshLLoG/2WL85/o/tYiyva09Bqn9T1
         D9NT+OjUeVWg2WBJAxSThd4xkWwzyUdPyszwhtvwgnQzwiumyFzi7sC55BaRW+MPe8cN
         cw9BW/8pWUvuQIUEJF2wRIL1zr+vwHQ4bOdCowO1li+PxDxPxF8z3q9JejguLASv1KWi
         kmcl9yPQGhSS85GcM0rIUluMIApm5M2CXHT03Eq74MrSLNZySlJakSHhtw/LFu+7DAW5
         A+BOw6eBY0vq8j5aNv33LrXFeJJeDCHRuSKN9HlB15lk7QrbeIe609leS1MCOx3lCAY6
         FCcw==
X-Gm-Message-State: APjAAAUHRQCXfObjseEZwjdXIVemXNHLtIItmUtwSp/w3t4SFaetifvI
        1zUuDtKpjfmvyGn0+h5ksIbRwGHf
X-Google-Smtp-Source: APXvYqwSHnZX848fkNMiRZ245/AZjuVVlojd3XgTpQfaP719NfAgLh+uI6s9FTyUmnGXINIgpoRQLQ==
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr3343042wml.106.1574848139533;
        Wed, 27 Nov 2019 01:48:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17sm6086588wmg.19.2019.11.27.01.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 01:48:59 -0800 (PST)
Message-Id: <c5b92ce3ed629ccd5efddb9d5c7a754ed2e8ddbe.1574848137.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.477.git.1574848137.gitgitgadget@gmail.com>
References: <pull.477.git.1574848137.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Nov 2019 09:48:56 +0000
Subject: [PATCH 1/2] parse_branchname_arg(): extract part as new function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
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

