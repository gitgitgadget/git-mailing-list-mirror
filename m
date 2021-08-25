Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965CC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652E261247
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhHYBwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 21:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhHYBwU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 21:52:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97CAC061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 18:51:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso3482751wmi.5
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 18:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tsx8F8QBGoLP8zCje8bBYOUiRP6z8OQLjZfOeWYXN7I=;
        b=Rz416YxVSCsqO3IyvSGYIWMqDLs5US5rCjcK+2hJ1Jsisg8iJulnCxfuxZHBeCo7TE
         kZcI7bqERIlCiPUMzA/Tujf5sWZFkjRXS2Q3V4uEy9/pW0PBG2EVRUCTkk8D6Rq7QvLi
         O38U7yBboHLQK/q87R/wGph/5QjgIpmhuXvnoIOvdJrS6oeTpgLP5sB+ETe0kROK3oe0
         IuZQOMGnGymOi6nrtqzhGw9FYNj6wWejOXpO4fM9dc1EE9TyyL3CKR+TCGkWFieLkRvY
         ydK5MWw4tHBtgS3r2e52kWZFzPIxY9jQa68svYlrqaTKZ6jf4dOuEQHQJuR1nRpfUMqa
         ep0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tsx8F8QBGoLP8zCje8bBYOUiRP6z8OQLjZfOeWYXN7I=;
        b=opM9yzXI81qjQkZS8Do3OFk3cbkYMn3XB2Jze3D/FOM6Ju1dvmrrqJP3NJk2tmMr4W
         SG/Xvmazou2/e1VgjhjB9+vaItsQlunMLaHXAG2c6sgKqd/BLF4hFzcgkJniyW1V/T+y
         KVJ+FImwundcDyPuDBrJef2710DAVsRUI3496Mwag+QXdXhn6y5u2asPE6dlQMkJoWi1
         LlUt6p5++g090OfoxuvpDOtXqEVSV7W8yjD00rfnimU3SDR+4mWIeCYnMN8NmHfUikR1
         ZkfcWhTtLho6stS8OX8vFpNEaYB8+Qdq+MPiOJIit1Olw8qB+f5qLLuT6Q5jInK3XbLC
         mXsw==
X-Gm-Message-State: AOAM533oXCqrVGR96AQ88e+zzJ7HCuZ2W+6H4fKElqyozFSNcQ9l4qx1
        pfy4jrPdSr1pMv3EP0ILUY3l4BsF33M=
X-Google-Smtp-Source: ABdhPJy28dppHWUOSdgFlXQ56ZF3ps5ks6b/Txqq7MsKJS0kezx9ZTBJn5Lwke7Yxrtmxz/pTDMIYQ==
X-Received: by 2002:a7b:c927:: with SMTP id h7mr5786984wml.154.1629856294556;
        Tue, 24 Aug 2021 18:51:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm21273943wru.1.2021.08.24.18.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 18:51:34 -0700 (PDT)
Message-Id: <2c1ddef6057157d85da74a7274e03eacf0374e45.1629856293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 01:51:31 +0000
Subject: [PATCH 1/2] object-file: use futimes rather than utime
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Refactor the loose object file creation code and use the futimes(2) API
rather than utime. This should be slightly faster given that we already
have an FD to work with.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 compat/mingw.c | 42 +++++++++++++++++++++++++++++-------------
 compat/mingw.h |  2 ++
 object-file.c  | 17 ++++++++---------
 3 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9e0cd1e097f..948f4c3428b 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -949,19 +949,40 @@ int mingw_fstat(int fd, struct stat *buf)
 	}
 }
 
-static inline void time_t_to_filetime(time_t t, FILETIME *ft)
+static inline void timeval_to_filetime(const struct timeval *t, FILETIME *ft)
 {
-	long long winTime = t * 10000000LL + 116444736000000000LL;
+	long long winTime = t->tv_sec * 10000000LL + t->tv_usec * 10 + 116444736000000000LL;
 	ft->dwLowDateTime = winTime;
 	ft->dwHighDateTime = winTime >> 32;
 }
 
-int mingw_utime (const char *file_name, const struct utimbuf *times)
+int mingw_futimes(int fd, const struct timeval times[2])
 {
 	FILETIME mft, aft;
+
+	if (times) {
+		timeval_to_filetime(&times[0], &aft);
+		timeval_to_filetime(&times[1], &mft);
+	} else {
+		GetSystemTimeAsFileTime(&mft);
+		aft = mft;
+	}
+
+	if (!SetFileTime((HANDLE)_get_osfhandle(fd), NULL, &aft, &mft)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	return 0;
+}
+
+int mingw_utime (const char *file_name, const struct utimbuf *times)
+{
 	int fh, rc;
 	DWORD attrs;
 	wchar_t wfilename[MAX_PATH];
+	struct timeval tvs[2];
+
 	if (xutftowcs_path(wfilename, file_name) < 0)
 		return -1;
 
@@ -979,17 +1000,12 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 	}
 
 	if (times) {
-		time_t_to_filetime(times->modtime, &mft);
-		time_t_to_filetime(times->actime, &aft);
-	} else {
-		GetSystemTimeAsFileTime(&mft);
-		aft = mft;
+		memset(tvs, 0, sizeof(tvs));
+		tvs[0].tv_sec = times->actime;
+		tvs[1].tv_sec = times->modtime;
 	}
-	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
-		errno = EINVAL;
-		rc = -1;
-	} else
-		rc = 0;
+
+	rc = mingw_futimes(fh, times ? tvs : NULL);
 	close(fh);
 
 revert_attrs:
diff --git a/compat/mingw.h b/compat/mingw.h
index c9a52ad64a6..1eb14edb2ed 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -398,6 +398,8 @@ int mingw_fstat(int fd, struct stat *buf);
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
+int mingw_futimes(int fd, const struct timeval times[2]);
+#define futimes mingw_futimes
 size_t mingw_strftime(char *s, size_t max,
 		   const char *format, const struct tm *tm);
 #define strftime mingw_strftime
diff --git a/object-file.c b/object-file.c
index a8be8994814..607e9e2f80b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1860,12 +1860,13 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_loose_object(int fd)
+static int close_loose_object(int fd, const char *tmpfile, const char *filename)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "loose object file");
 	if (close(fd) != 0)
 		die_errno(_("error when closing loose object file"));
+	return finalize_object_file(tmpfile, filename);
 }
 
 /* Size of directory component, including the ending '/' */
@@ -1973,17 +1974,15 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd);
-
 	if (mtime) {
-		struct utimbuf utb;
-		utb.actime = mtime;
-		utb.modtime = mtime;
-		if (utime(tmp_file.buf, &utb) < 0)
-			warning_errno(_("failed utime() on %s"), tmp_file.buf);
+		struct timeval tvs[2] = {0};
+		tvs[0].tv_sec = mtime;
+		tvs[1].tv_sec = mtime;
+		if (futimes(fd, tvs) < 0)
+			warning_errno(_("failed futimes() on %s"), tmp_file.buf);
 	}
 
-	return finalize_object_file(tmp_file.buf, filename.buf);
+	return close_loose_object(fd, tmp_file.buf, filename.buf);
 }
 
 static int freshen_loose_object(const struct object_id *oid)
-- 
gitgitgadget

