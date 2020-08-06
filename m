Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D006FC433E1
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F312311B
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRoqwkrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgHFRKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbgHFRKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DDBC008685
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:27:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so39319286wrs.8
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=aysV2puYgcNkpte47TMyhBDETIO5BUY6qwNU0+U1u2E=;
        b=pRoqwkrswvuChSnBe44unRdQulb1cuUqIfgvo+OXF4VeYTHXyT2jL0OJyRgerVqLWT
         StUAjXVQj2YU33YyjzYhrQibKcOY2INq5pArr7M0nwrdwJohUlpQQDJVoSrtnetmYa7B
         KbiPoa20HGvx3gp8FM7IPJuJxjLxJMP2VMxhxx8+Gk8VK0PXzI8tgjB04/PXlLCl9cTt
         safnaj3Gj/f2KEkGiDTZTJfQALIF77oDLqSL8bNZcySUD+WdV/NJAo7oO/Fkp2W0v0e9
         7LzE4Ui0nn3eQYjjqKxqLF/viAEObE4XA5Na4qL91ECMRDMqvDhmx8m4KT3Jcf8xwVSe
         02Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=aysV2puYgcNkpte47TMyhBDETIO5BUY6qwNU0+U1u2E=;
        b=evesyacuCfLpzt3Mk7hGDSIjs8sqjXNKZ99e2/pbdUwsYxFd7Xhp8OWa0uIC1G1amt
         QuYgIq6xrUY8cUuZDQ/b3AA6QNisQN4FVozULK9UCVBUiAWkNzNmigfvVMe5MQ1J+0Y6
         yzi4FDh8/sVJOj82+QFEYgkhDZQCRYW3iUqgBcmjb9tZRZBIYseR6wS2PG4BEMbdBoD+
         4ZBU5EsyxbcqQHGMgm/Zu1h2Bsd/nW58w77UXQGvhVCVgMRSQFAa+1CtlX8ieO89BbxI
         PVLXDkTeG1HcG5yb0x9VPLdVONzvq/VE2o9KQ08KN770XKQpdo7cH3KNdNtvwzA8C92M
         Q3GA==
X-Gm-Message-State: AOAM533SCpb80d3kuKYNvJjHoJNxMP6TaEDO/0oxeSJBod+LwRiAbrEP
        VBtFSj81daqfp5ptMy4WqMF7SSWE
X-Google-Smtp-Source: ABdhPJyjfhmHbGddxYIjkYzCbVrEDRMR1g/yfzQG5rEw+gnXVWfNixK4MuvQDlAa9vejPS2lSh1VIA==
X-Received: by 2002:adf:d84f:: with SMTP id k15mr7621333wrl.176.1596727675564;
        Thu, 06 Aug 2020 08:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 69sm7237024wmb.8.2020.08.06.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:27:55 -0700 (PDT)
Message-Id: <26b25b0d652e3a5b834eb004151f4a322c450403.1596727673.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.693.v2.git.1596727673.gitgitgadget@gmail.com>
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
        <pull.693.v2.git.1596727673.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:27:52 +0000
Subject: [PATCH v2 1/2] mergetool-lib: use $XDG_CURRENT_DESKTOP to check GNOME
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Marco Trevisan <mail@3v1n0.net>,
        =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>

To list merge tool candidates we used to use a private GNOME env
variable (GNOME_DESKTOP_SESSION_ID) that has been deprecated for long time ago
and removed as part of GNOME 3.30.0 release [1].

So, git should instead primarily check the XDG_CURRENT_DESKTOP env variable,
that is now supported by all the desktop environments.

Since the variable is actually a colon-separated list of names that the current
desktop is known as, we need to check if the value is set if we're using GNOME.

[1] https://gitlab.gnome.org/GNOME/gnome-session/-/commit/00e0e6226371d53f65

Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
---
 git-mergetool--lib.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 204a5acd66..f9d8f309c8 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -266,6 +266,17 @@ run_merge_cmd () {
 	fi
 }
 
+is_desktop () {
+	case ":$XDG_CURRENT_DESKTOP:" in
+	*:$1:*)
+		return 0
+		;;
+	*)
+		return 1
+		;;
+	esac
+}
+
 list_merge_tool_candidates () {
 	if merge_mode
 	then
@@ -275,7 +286,7 @@ list_merge_tool_candidates () {
 	fi
 	if test -n "$DISPLAY"
 	then
-		if test -n "$GNOME_DESKTOP_SESSION_ID"
+		if is_desktop "GNOME" || test -n "$GNOME_DESKTOP_SESSION_ID"
 		then
 			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
 		else
-- 
gitgitgadget

