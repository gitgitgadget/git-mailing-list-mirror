Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683B6C2D0D1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C08324679
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEBntyGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfLSV2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:28:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40394 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfLSV2g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 16:28:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id b8so6294390edx.7
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 13:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MmYpkLT1ZacSJKjEx9Dyv7Qs23ty5Ec5tk1JIoopM4Y=;
        b=XEBntyGXIsZ+QQBh6zLo9+SZfDn2Uc8mx3muVxVkfZtljLEa9DZJ/gPywxtPCOPa08
         zuic50+iuSL/OACRK+kw2AeSE4qaa0tfcQIv1+yvjpAHJX+E+qZBlANJTquC+UXCsWh6
         dzWOXcakZzohXLtYncKav8sAoflax7RgIAVrBmbbG8sCgoQ5pZ4ZEENN7lGFeY3xnZxO
         IhzW4ya4LYyq0Sa2tKnPcOj+WgSHB1mi9E9YwxZOrPQtRMpxsVGGtnHNrPT/6Wy9Pdhz
         IjKibURUejzqf60p/AiezLrHiSBU9dJSapTDrq5MFBkPAZSLrtOYBs/mpU2XER2DFM30
         yZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MmYpkLT1ZacSJKjEx9Dyv7Qs23ty5Ec5tk1JIoopM4Y=;
        b=DOvpqLXA/j1SEB/wJJm9+WhdKysb03S4HQR27l4SRiNqjRL7sE69Xdz13pYTT4LRCC
         03I0xwSgqWUuYAljYVPpWV3xfRSipkrmxlu8773vEyZsADMoHjIRuSY+NPAl+ix19ttD
         dyVY/1lS+TRzGqO9cARzaSx8F1aqLwHAEeES3/howL6Ww93ztubseBVvk0CqArkbkg8h
         nbqdyOL+Y3Hgii+SkL0mQdj5ceC5KMKEdE1peuBYe8aa7P+xHvDa2cW8bCSzQzrLCzGa
         Wgaq0CDhe8DJZjJk1xpyX7aej0w77grkC8OxH5YTks4FZ/B65meUiIVIC9o2mOkWTx73
         kZsA==
X-Gm-Message-State: APjAAAVDuuoq9jeWzDgWx7NnSw3UVDF45kbzQzEIcsEO7LfhBvEjkM4a
        gjzvfHFmWxwoPgoY3aHthUJPXSsr
X-Google-Smtp-Source: APXvYqyGyUYGV961TCmYp38vjQ4fPhhJSfbGAZL/MUHjcKN/Z5TR2pV+pT+mqRqg94FgooFpN1DwBg==
X-Received: by 2002:aa7:ce13:: with SMTP id d19mr11556291edv.296.1576790914635;
        Thu, 19 Dec 2019 13:28:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21sm674388edu.70.2019.12.19.13.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 13:28:34 -0800 (PST)
Message-Id: <e4768931d0e9bca4fd8fcb7f3048287f4fa6d0a5.1576790906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
References: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
        <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 21:28:26 +0000
Subject: [PATCH v5 8/8] dir: consolidate similar code in treat_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Both the DIR_SKIP_NESTED_GIT and DIR_NO_GITLINKS cases were checking for
whether a path was actually a nonbare repository.  That code could be
shared, with just the result of how to act differing between the two
cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index 357f9593c4..e1b74f6478 100644
--- a/dir.c
+++ b/dir.c
@@ -1461,6 +1461,8 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	const char *dirname, int len, int baselen, int exclude,
 	const struct pathspec *pathspec)
 {
+	int nested_repo = 0;
+
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(istate, dirname, len-1)) {
 	case index_directory:
@@ -1470,15 +1472,16 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_none;
 
 	case index_nonexistent:
-		if (dir->flags & DIR_SKIP_NESTED_GIT) {
-			int nested_repo;
+		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
+		    !(dir->flags & DIR_NO_GITLINKS)) {
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addstr(&sb, dirname);
 			nested_repo = is_nonbare_repository_dir(&sb);
 			strbuf_release(&sb);
-			if (nested_repo)
-				return path_none;
 		}
+		if (nested_repo)
+			return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
+				(exclude ? path_excluded : path_untracked));
 
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
@@ -1506,13 +1509,6 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 			return path_none;
 		}
-		if (!(dir->flags & DIR_NO_GITLINKS)) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addstr(&sb, dirname);
-			if (is_nonbare_repository_dir(&sb))
-				return exclude ? path_excluded : path_untracked;
-			strbuf_release(&sb);
-		}
 		return path_recurse;
 	}
 
-- 
gitgitgadget
