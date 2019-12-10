Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B8AC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E470420836
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX3Q/3ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLJUAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36713 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfLJUAf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:00:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so21550327wru.3
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+CgvyKrM09apU1qkOsJft1P4o4wqjmDRS+ywvTmG7xU=;
        b=QX3Q/3ikcZVVB3OiemY1ggPzZ1sIEnyUMW+gm9MGMn6b2epSo2Sf/crBZN7znIehhy
         pfRXSA5V9tqc0DPaoWf2QXuVVm2UzBOjF6AqcU+840kgj+kYUBBpPmnTAOC8g9YkwD9h
         uwLRcMv9rlpexjRL37mSySsIwNtJOLYTvHW5W6iRFiBQ3jONI9eWBNJTAgzE3xkA/LPj
         g3UyVy1AOiw2XXlLYuykvdlbT4sWPPxElZ6fc9849LVZ1zoDRlWESkzTir1VMDLDnP8Z
         R5T3e59hLNDHoto9RhcijTZl3R33SdoXhUA4C+2G7QzsfRzGrqcPG066U76BD8Ya4WI9
         9fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+CgvyKrM09apU1qkOsJft1P4o4wqjmDRS+ywvTmG7xU=;
        b=mcAgc5OYjlW9axlU+sLLaGknP8HoJeB5A/QzTaD8TW4IYKSwjRAk/9zewUk3g/ffvI
         HKZpD8faD4b4I6FfaZ0wvbMEztB3eXlygbafKEkqHf7944OZ9QbmZjwn2CMHvEp/lSeH
         J7PyBC8RdEl+oTeGClAjMWJUqFBh0zQhJELWsKTBJtL+GxkhJ5am9DpB9tfR2IqqrbIC
         auzkYPIKzSLvMXG1/e/mCc/PsNcURikI3/VuAx/q3F67WmXWmL/SaflGaIdmWVSDzmm9
         xHEAZvfc2yBmsmuhj6gpnzLqcwJZW/samtyClIbCvPLRPgWvhTyHkUNq+dKl/xz0g2/1
         gRIw==
X-Gm-Message-State: APjAAAX+jpxNG6xIkkz25r3O+muT+cFcSH1eYbCmQVPCO3DQr+px0AVu
        A2fVxdpEXt+mAoje4de+rcEH9KXF
X-Google-Smtp-Source: APXvYqzb/fOTEoyxzqOF+5uAeoMivyYMl+SN5B0bYF9MxmRYlcnsI7E9WpMbo5865xb52v4ayUFarg==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr5496353wrf.385.1576008033399;
        Tue, 10 Dec 2019 12:00:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z189sm4559344wmc.2.2019.12.10.12.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:00:33 -0800 (PST)
Message-Id: <d2f5623bd71352f3adbf12f211dbae5820b33666.1576008027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 20:00:24 +0000
Subject: [PATCH v2 5/8] dir: break part of read_directory_recursive() out for
 reuse
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

Create an add_path_to_appropriate_result_list() function from the code
at the end of read_directory_recursive() so we can use it elsewhere.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 60 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/dir.c b/dir.c
index 517a569e10..645b44ea64 100644
--- a/dir.c
+++ b/dir.c
@@ -1932,6 +1932,40 @@ static void close_cached_dir(struct cached_dir *cdir)
 	}
 }
 
+static void add_path_to_appropriate_result_list(struct dir_struct *dir,
+	struct untracked_cache_dir *untracked,
+	struct cached_dir *cdir,
+	struct index_state *istate,
+	struct strbuf *path,
+	int baselen,
+	const struct pathspec *pathspec,
+	enum path_treatment state)
+{
+	/* add the path to the appropriate result list */
+	switch (state) {
+	case path_excluded:
+		if (dir->flags & DIR_SHOW_IGNORED)
+			dir_add_name(dir, istate, path->buf, path->len);
+		else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
+			((dir->flags & DIR_COLLECT_IGNORED) &&
+			exclude_matches_pathspec(path->buf, path->len,
+						 pathspec)))
+			dir_add_ignored(dir, istate, path->buf, path->len);
+		break;
+
+	case path_untracked:
+		if (dir->flags & DIR_SHOW_IGNORED)
+			break;
+		dir_add_name(dir, istate, path->buf, path->len);
+		if (cdir->fdir)
+			add_untracked(untracked, path->buf + baselen);
+		break;
+
+	default:
+		break;
+	}
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -2035,29 +2069,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			continue;
 		}
 
-		/* add the path to the appropriate result list */
-		switch (state) {
-		case path_excluded:
-			if (dir->flags & DIR_SHOW_IGNORED)
-				dir_add_name(dir, istate, path.buf, path.len);
-			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
-				((dir->flags & DIR_COLLECT_IGNORED) &&
-				exclude_matches_pathspec(path.buf, path.len,
-							 pathspec)))
-				dir_add_ignored(dir, istate, path.buf, path.len);
-			break;
-
-		case path_untracked:
-			if (dir->flags & DIR_SHOW_IGNORED)
-				break;
-			dir_add_name(dir, istate, path.buf, path.len);
-			if (cdir.fdir)
-				add_untracked(untracked, path.buf + baselen);
-			break;
-
-		default:
-			break;
-		}
+		add_path_to_appropriate_result_list(dir, untracked, &cdir,
+						    istate, &path, baselen,
+						    pathspec, state);
 	}
 	close_cached_dir(&cdir);
  out:
-- 
gitgitgadget

