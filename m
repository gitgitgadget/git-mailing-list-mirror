From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v3 2/2] merge-recursive: more consistent interface
Date: Tue, 16 Feb 2016 23:11:35 -0200
Message-ID: <1455671495-10908-3-git-send-email-felipegassis@gmail.com>
References: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 02:13:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVqgG-0004cF-La
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 02:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275AbcBQBNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 20:13:21 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33907 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964874AbcBQBNT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 20:13:19 -0500
Received: by mail-qg0-f51.google.com with SMTP id b67so1384987qgb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 17:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R6Ou3Nz/Z78aBVpFu30UAUCFmMJ69YUSbVZhYRT+JS8=;
        b=ajIo4inmIH0J8TRkpNr2Nx5eeWqwnNOy3BhX1I4nfI3fOneCPfoZOdhOiC3tjQVvQN
         CgFOyFvF/53RgZzyvoq4ka9S8aWFpV3MpyUxNUIS9D0rkJXFKed1DLC1SIv6qs5g2XrQ
         YQb5ThFHYUc/hMdic55nzsKVsXaZeMSP1UujL1iSZFRLUoARpMyL8z9eZ4S7pdbrw63x
         7sEktsTJeyU9hKDxYxg3KJYQIF5MyHKMkKNrjV01bKSo78n9Zb7hz6Gc8PDqtmhuJFet
         G7TGN1jD+MTv8pVM3loaXgljUh+3dehz9gOcWIlfsKH5w2vRtnPooWTb+JneiUw4RPPd
         v7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R6Ou3Nz/Z78aBVpFu30UAUCFmMJ69YUSbVZhYRT+JS8=;
        b=VT7K7bwIv5fYD2tUQ5oxkXoLDJDJeXEOZV6gxDb/8vXuSFXrx7IM9wQVLDKE6aOmLb
         c9fnZlqNYrGKSAb7dtSjfGiUjMZ5NtSyBsnEgCrFNxYhe7J4L4783CayYxAevkF5G97A
         upPeiShjeX/GlHMOIKg6dIIVU9hEHFfXpADa8XBvzUNMNOiPUvH8U/ZUo1zoHQv7qq5J
         VAYrzXAMr7PtNTI4fZElZxJpCl3H83iBF+mYPdrUScXlTXEv/mGftaNWP1FVzH0wVJvb
         YsVjuKMbeJW5jb+h6ke2RCjN18JyWfXf/oHBSgFkXOe7CX3baPvq4+TYV09ylZN6YzI2
         6flQ==
X-Gm-Message-State: AG10YOSBvze0gUE1ezNeA7/ibdtpJuDaL+cy3us1zznr9v0z6I8hHWW0JOHbk5bajR0fGg==
X-Received: by 10.140.132.149 with SMTP id 143mr31675837qhe.7.1455671599046;
        Tue, 16 Feb 2016 17:13:19 -0800 (PST)
Received: from traveller.moon ([187.34.45.132])
        by smtp.gmail.com with ESMTPSA id a88sm14361238qkj.32.2016.02.16.17.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 17:13:18 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.288.gfad33a8
In-Reply-To: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286471>

Add strategy option find-renames, following git-diff interface. This
makes the option rename-threshold redundant.
---

A minor note
git diff --check complains about an indent with spaces here, but I think I did
the right thing: indented with tabs and aligned with spaces. If desired, I can
align with tabs to avoid this.

 Documentation/merge-strategies.txt | 8 ++++++--
 merge-recursive.c                  | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 1a5e197..f8618c9 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -85,11 +85,15 @@ no-renames;;
 	Turn off rename detection.
 	See also linkgit:git-diff[1] `--no-renames`.
 
-rename-threshold=<n>;;
+find-renames[=<n>];;
 	Controls the similarity threshold used for rename detection.
 	Re-enables rename detection if disabled by a preceding
 	`no-renames`.
-	See also linkgit:git-diff[1] `-M`.
+	See also linkgit:git-diff[1] `--find-renames`.
+
+rename-threshold=<n>;;
+	Synonym for `find-renames=<n>`. Present for historical reasons.
+	New scripts should prefer the `find-renames=<n>` syntax.
 
 subtree[=<path>];;
 	This option is a more advanced form of 'subtree' strategy, where
diff --git a/merge-recursive.c b/merge-recursive.c
index 6dd0a11..700febd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2094,7 +2094,10 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->renormalize = 0;
 	else if (!strcmp(s, "no-renames"))
 		o->detect_rename = 0;
-	else if (skip_prefix(s, "rename-threshold=", &arg)) {
+	else if (!strcmp(s, "find-renames"))
+		o->detect_rename = 1;
+	else if (skip_prefix(s, "find-renames=", &arg) ||
+	         skip_prefix(s, "rename-threshold=", &arg)) {
 		if ((o->rename_score = parse_rename_score(&arg)) == -1 || *arg != 0)
 			return -1;
 		o->detect_rename = 1;
-- 
2.7.1.288.gfad33a8
