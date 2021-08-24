Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F53C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B1161265
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhHXPou (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbhHXPor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 11:44:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28645C061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:44:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso2181222wmg.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ujN0FQRr+FWLAy19xPfFIpJYT0D+RlRUwgm3kFpZHBA=;
        b=K4aaUgNK8RmpkZRl9Rhm7+MOqH4mS0VZTWm8Z+DAwCJ93YOIRtyyJvouS44c5lMmgX
         dQ1lyljzrX+jP2pQhqimR+37oKTKsCOYJsJ74f76Jfza+bs3ZZSngBZ3NxEm49NSjIwx
         PIJ2qE69Op62m6C/GVvwB3sYSWWMIwoMi5B/t8RjXqU/20vWkehvOVaMRw18Kdfohsek
         wG5WtTSZe+fdJPgNITsiWwXs3jV/fQZ2etSLWuTUveckbGo4jYREkmhL6K6cNZDFOUDz
         A4J1vFX2Ng5UgNYOxJhIjD3S0YqPn8ZAsUS85g5BSa9cq4g/84eyJsBSX6w1bkVfZrl1
         xuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ujN0FQRr+FWLAy19xPfFIpJYT0D+RlRUwgm3kFpZHBA=;
        b=Qr9c+Eqhsfzljz9jCTAwRdPsffwSJAJDepe0i8gIt/0Cvt9k28iCq8+FAIjG0jqshv
         iE0REqX7wF0AhNAz7K0rpM0/8+jWTmJwAlB0/ng+5akWaSi6Ek2sl4ZSEPAe0wEBQnxQ
         97GrooBl/GlVjZCubk4JhuNOGiBkcGz75tqAtdRX2PvRkWCyYv6G+9AYaaivvoShiuzq
         eGm9sTEjbuYjvydhxnVgAKSbeE54D0vASFJ1PchVEC3KoWjDR1Kx9b/sWPGUbdvRPsNx
         2H8daPcRnSJM228GHvq+/ir/oaB3xIW4bEj3vFiqDqTlwQkOm5+yAoLhvri4s6NjjKNZ
         ElqQ==
X-Gm-Message-State: AOAM532q2558CFJaDgRH349Z+K0gZLWCpx4MYjrFemqU0qUk4kV8lAcB
        7YwOJIyDbH6ddXxUNZ7vahC/CLb/CLI=
X-Google-Smtp-Source: ABdhPJxZQko7FGgyqSzXbsYDkHw49QeTqpvnZteCfm0dVROi8tunlzaf0/FvXNUBtEM1F5uqaqXdxw==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr4688431wml.143.1629819841845;
        Tue, 24 Aug 2021 08:44:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm19368302wrd.75.2021.08.24.08.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:44:01 -0700 (PDT)
Message-Id: <62ad2255e6eb0a6aa0995a96a80e40d3342eb394.1629819840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1024.git.1629819840.gitgitgadget@gmail.com>
References: <pull.1024.git.1629819840.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 15:43:59 +0000
Subject: [PATCH 1/2] maintenance: create `launchctl` configuration using a
 lock file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When two `git maintenance` processes try to write the `.plist` file, we
need to help them with serializing their efforts.

The 150ms time-out value was determined from thin air.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/gc.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ef7226d7bca..4a78b497d0e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1617,16 +1617,14 @@ static int launchctl_remove_plists(const char *cmd)
 
 static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule, const char *cmd)
 {
-	FILE *plist;
-	int i;
+	int i, fd;
 	const char *preamble, *repeat;
 	const char *frequency = get_frequency(schedule);
 	char *name = launchctl_service_name(frequency);
 	char *filename = launchctl_service_filename(name);
-
-	if (safe_create_leading_directories(filename))
-		die(_("failed to create directories for '%s'"), filename);
-	plist = xfopen(filename, "w");
+	struct lock_file lk = LOCK_INIT;
+	static unsigned long lock_file_timeout_ms = ULONG_MAX;
+	struct strbuf plist = STRBUF_INIT;
 
 	preamble = "<?xml version=\"1.0\"?>\n"
 		   "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
@@ -1645,7 +1643,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 		   "</array>\n"
 		   "<key>StartCalendarInterval</key>\n"
 		   "<array>\n";
-	fprintf(plist, preamble, name, exec_path, exec_path, frequency);
+	strbuf_addf(&plist, preamble, name, exec_path, exec_path, frequency);
 
 	switch (schedule) {
 	case SCHEDULE_HOURLY:
@@ -1654,7 +1652,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 			 "<key>Minute</key><integer>0</integer>\n"
 			 "</dict>\n";
 		for (i = 1; i <= 23; i++)
-			fprintf(plist, repeat, i);
+			strbuf_addf(&plist, repeat, i);
 		break;
 
 	case SCHEDULE_DAILY:
@@ -1664,24 +1662,38 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 			 "<key>Minute</key><integer>0</integer>\n"
 			 "</dict>\n";
 		for (i = 1; i <= 6; i++)
-			fprintf(plist, repeat, i);
+			strbuf_addf(&plist, repeat, i);
 		break;
 
 	case SCHEDULE_WEEKLY:
-		fprintf(plist,
-			"<dict>\n"
-			"<key>Day</key><integer>0</integer>\n"
-			"<key>Hour</key><integer>0</integer>\n"
-			"<key>Minute</key><integer>0</integer>\n"
-			"</dict>\n");
+		strbuf_addstr(&plist,
+			      "<dict>\n"
+			      "<key>Day</key><integer>0</integer>\n"
+			      "<key>Hour</key><integer>0</integer>\n"
+			      "<key>Minute</key><integer>0</integer>\n"
+			      "</dict>\n");
 		break;
 
 	default:
 		/* unreachable */
 		break;
 	}
-	fprintf(plist, "</array>\n</dict>\n</plist>\n");
-	fclose(plist);
+	strbuf_addstr(&plist, "</array>\n</dict>\n</plist>\n");
+
+	if (safe_create_leading_directories(filename))
+		die(_("failed to create directories for '%s'"), filename);
+
+	if ((long)lock_file_timeout_ms < 0 &&
+	    git_config_get_ulong("gc.launchctlplistlocktimeoutms",
+				 &lock_file_timeout_ms))
+		lock_file_timeout_ms = 150;
+
+	fd = hold_lock_file_for_update_timeout(&lk, filename, LOCK_DIE_ON_ERROR,
+					       lock_file_timeout_ms);
+
+	if (write_in_full(fd, plist.buf, plist.len) < 0 ||
+	    commit_lock_file(&lk))
+		die_errno(_("could not write '%s'"), filename);
 
 	/* bootout might fail if not already running, so ignore */
 	launchctl_boot_plist(0, filename, cmd);
@@ -1690,6 +1702,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 
 	free(filename);
 	free(name);
+	strbuf_release(&plist);
 	return 0;
 }
 
-- 
gitgitgadget

