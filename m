Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F7EC433FE
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbhLUSF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbhLUSFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B39EC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b73so9652907wmd.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NL9gpskVh13Do2E5ujoRMKXPeq0YO/+28ekdWUSdz6c=;
        b=iwlk5V6CpUuUYIHnqU2h76Zh1YLhVwOAvk7dnZOEUmebWwQpP96MM1fZfMy/e7e7+/
         8ErRPCHZdhps+0VZ11crriI/4UIHmuUogkfK6YI4D5Hcz+2KvAFqKM2Gyl10eerlLO5k
         y5qRiGSNMTdpQrlFGNSKXIUhM8/f1JhqaNdXMQwUcxunfanu1AX7o0VJ0biGTI7SsKad
         c7g9pxPFhWsG/liWDKl7GNv9DzXhSIn0rtwoigdYtPng1U3y9UGq2Q8zBbcRMd1QUotD
         c4a/3L3xoA2C1TLmyyN9gbSFPdBLBLJZkV7ZtQhYFk59Bze7Fu4iGQbh0vn2ZEpPk/pu
         qh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NL9gpskVh13Do2E5ujoRMKXPeq0YO/+28ekdWUSdz6c=;
        b=d4H45r7JhLO+IVbYZgBXQ/KQIPEQS6G/EaPq3b7naeGH0TMtSlYPL805GaSjUvLTcz
         ykeO+DlNb93+wV71gjh8TqU3Rgpy6CCV1RkPuR3CSbP5BRdAWUK0twPpAfOw9Rn09Ejv
         BBSCJuyI7I5Vh5yJLwdf5nvhctdcFz6Ied9TYk5xYHJe1qrC/SLPKp9sqtzevKezmm4s
         ZTOFsG3r10CdQ3V6GSgxvSG3e60TQXzF68pz/uuonZD32a7s9NUgZlXDVcUR+QSnEAzf
         zwrtabIL6xwbMZCW5pXQlHQqAxJbVZ/xAqUTksddLHQBRclPBDxzMGhP3B1MBvJYFirQ
         Hzhw==
X-Gm-Message-State: AOAM531/S+5tQdLBN1xJCpJIHFsEQ01b437gC5BSLAsZTZDaOuyljVug
        gciVwp5Zp0dXmaJlIoX6Ehlm0Vbqaok=
X-Google-Smtp-Source: ABdhPJwporh0AC9Ozfb2O6mtFLLl9sddMxybK2RokzY1lIdFXhWXjF0ye7Wb9HijX7+2TV8s4acixA==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr3871971wmg.102.1640109953713;
        Tue, 21 Dec 2021 10:05:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm2933913wmc.40.2021.12.21.10.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:05:53 -0800 (PST)
Message-Id: <dd5461d45de99ef50a82297142332c25a54aff82.1640109948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 18:05:44 +0000
Subject: [PATCH 5/9] merge-ort: make path_messages available to external
 callers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-ort is designed to be more flexible so that it could be called as
more of a library function.  Part of that design is not writing to the
working tree or index unless and until requested.  Part of it is
returning tree objects (rather than creating commits and making them
part of HEAD), and allowing callers to do their own special thing with
that merged tree.  Along the same lines, we want to enable callers to do
something special with output messages (conflicts and other warnings)
besides just automatically displaying on stdout/stderr.  Do so by making
the output path messages accessible via a new member of struct
merge_result named path_messages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c |  1 +
 merge-ort.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index fe27870e73e..c4d6c5c81cc 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4547,6 +4547,7 @@ redo:
 	trace2_region_leave("merge", "process_entries", opt->repo);
 
 	/* Set return values */
+	result->path_messages = &opt->priv->output;
 	result->tree = parse_tree_indirect(&working_tree_oid);
 	/* existence of conflicted entries implies unclean */
 	result->clean &= strmap_empty(&opt->priv->conflicted);
diff --git a/merge-ort.h b/merge-ort.h
index c011864ffeb..fe599b87868 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -5,6 +5,7 @@
 
 struct commit;
 struct tree;
+struct strmap;
 
 struct merge_result {
 	/*
@@ -23,6 +24,15 @@ struct merge_result {
 	 */
 	struct tree *tree;
 
+	/*
+	 * Special messages and conflict notices for various paths
+	 *
+	 * This is a map of pathnames to strbufs.  It contains various
+	 * warning/conflict/notice messages (possibly multiple per path)
+	 * that callers may want to use.
+	 */
+	struct strmap *path_messages;
+
 	/*
 	 * Additional metadata used by merge_switch_to_result() or future calls
 	 * to merge_incore_*().  Includes data needed to update the index (if
-- 
gitgitgadget

