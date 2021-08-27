Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D9EC4320E
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C780160EBA
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhH0Xub (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 19:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhH0Xua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 19:50:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D058C061796
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y195so1974861wmc.2
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vnlYrcMPlZV7jn+Lh11sIHW9c4SJp4J6AKtj4Z4AN0M=;
        b=hPSy3PTiyJIQx+RD7TYCyRwCXCvwYExuJ1YG/9d22YlnJelBUd51kwJh4f/HXkqlYn
         j2ZUchkCr01Q4JEXh6pdjmCjXrCyCAfp9Ucne0oTdjwyCw2OcJG/bXNLdJ+iWPBCpprh
         eXQd/meoPeMOEk2LJ5Ey/P7g38HFAMSEfel/MSzCbkBbdJw2Oo3B0HclcuGVzAKsr+3f
         trovRZAKv+BqMm7A7xCfLL7uDi4aic/YeZxEBDW8GIdX8J2JBb+yJlUCOtx20uJ8/RmE
         swaK7mvJsb8cGXVSWepJOEyl9MBjqK9W3c4bhAx5zY13QpYM6RFhC/jTl5Nmvho/9W1P
         GP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vnlYrcMPlZV7jn+Lh11sIHW9c4SJp4J6AKtj4Z4AN0M=;
        b=l6r3SK/i7I+M0akyBnQJ7ZO++hCVAXb6Wi7bCh5g22743VpcEOE8OHVlgRQzKHnuAo
         HkoSFbIrqJeu+UGJOeDLIkJfhrWy/x2eiM7UePvPLg9j6FVF28FwI6dJGptW7JHkwE0L
         l2D5wmykX/++FgsF0VPx8OrFjVVYk1H0SNCw8okrW6RzklkCCO66pTBUmSNWGi12GYxl
         GyGBf79VNoOn0A0ynWX4XFxWgMTOvcjxg0AJf5A5hFPnv2bG95B8F77+QNtkajDk7X+d
         0s07if4PR/vIfyBYHK6XmZtgBPihQpNs5EUqKsQoszMxJp2xpRWmbGlLximIrlR06vhR
         MRGA==
X-Gm-Message-State: AOAM530yf8Kx4FGMKEzkYFo4cHJHzq2tWJxifAjrIfxiD635Ov/jfycf
        oFzBw5YmQ3fEgbvJTfWNcz8bDxeGsZc=
X-Google-Smtp-Source: ABdhPJxzwRd3M0pfxtvirRAbKYxBKhQLnYp1E1On/QKhg4/NCIFVsop10LVOOaO1ZE/3fkBMRbV9tQ==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr11130015wmq.76.1630108178952;
        Fri, 27 Aug 2021 16:49:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm8022099wrz.61.2021.08.27.16.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:49:38 -0700 (PDT)
Message-Id: <fc3d5a7b63524647c4a0de53e41772a7eede4f2d.1630108177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
        <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Aug 2021 23:49:32 +0000
Subject: [PATCH v2 1/6] object-file: use futimens rather than utime
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

Make close_loose_object do all of the steps for syncing and correctly
naming a new loose object so that it can be reimplemented in the
upcoming bulk-fsync mode.

Use futimens, which is available in POSIX.1-2008 to update the file
timestamps. This should be slightly faster than utime, since we have
a file descriptor already available. This change allows us to update
the time before closing, renaming, and potentially fsyincing the file
being refreshed. This code is currently only invoked by git-pack-objects
via force_object_loose.

Implement a futimens shim for the Windows port of Git.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 compat/mingw.c | 53 ++++++++++++++++++++++++++++++++++----------------
 compat/mingw.h |  2 ++
 object-file.c  | 17 ++++++++--------
 3 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9e0cd1e097f..ce14b21c182 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -734,11 +734,14 @@ int mingw_chmod(const char *filename, int mode)
  * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
  * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
  */
+
+#define UNIX_EPOCH_FILETIME 116444736000000000LL
+
 static inline long long filetime_to_hnsec(const FILETIME *ft)
 {
 	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
 	/* Windows to Unix Epoch conversion */
-	return winTime - 116444736000000000LL;
+	return winTime - UNIX_EPOCH_FILETIME;
 }
 
 static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
@@ -748,6 +751,13 @@ static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
 	ts->tv_nsec = (hnsec % 10000000) * 100;
 }
 
+static inline void timespec_to_filetime(const struct timespec *t, FILETIME *ft)
+{
+	long long winTime = t->tv_sec * 10000000LL + t->tv_nsec / 100 + UNIX_EPOCH_FILETIME;
+	ft->dwLowDateTime = winTime;
+	ft->dwHighDateTime = winTime >> 32;
+}
+
 /**
  * Verifies that safe_create_leading_directories() would succeed.
  */
@@ -949,19 +959,33 @@ int mingw_fstat(int fd, struct stat *buf)
 	}
 }
 
-static inline void time_t_to_filetime(time_t t, FILETIME *ft)
+int mingw_futimens(int fd, const struct timespec times[2])
 {
-	long long winTime = t * 10000000LL + 116444736000000000LL;
-	ft->dwLowDateTime = winTime;
-	ft->dwHighDateTime = winTime >> 32;
+	FILETIME mft, aft;
+
+	if (times) {
+		timespec_to_filetime(&times[0], &aft);
+		timespec_to_filetime(&times[1], &mft);
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
 }
 
-int mingw_utime (const char *file_name, const struct utimbuf *times)
+int mingw_utime(const char *file_name, const struct utimbuf *times)
 {
-	FILETIME mft, aft;
 	int fh, rc;
 	DWORD attrs;
 	wchar_t wfilename[MAX_PATH];
+	struct timespec ts[2];
+
 	if (xutftowcs_path(wfilename, file_name) < 0)
 		return -1;
 
@@ -979,17 +1003,12 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 	}
 
 	if (times) {
-		time_t_to_filetime(times->modtime, &mft);
-		time_t_to_filetime(times->actime, &aft);
-	} else {
-		GetSystemTimeAsFileTime(&mft);
-		aft = mft;
+		memset(ts, 0, sizeof(ts));
+		ts[0].tv_sec = times->actime;
+		ts[1].tv_sec = times->modtime;
 	}
-	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
-		errno = EINVAL;
-		rc = -1;
-	} else
-		rc = 0;
+
+	rc = mingw_futimens(fh, times ? ts : NULL);
 	close(fh);
 
 revert_attrs:
diff --git a/compat/mingw.h b/compat/mingw.h
index c9a52ad64a6..87944dfec72 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -398,6 +398,8 @@ int mingw_fstat(int fd, struct stat *buf);
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
+int mingw_futimens(int fd, const struct timespec times[2]);
+#define futimens mingw_futimens
 size_t mingw_strftime(char *s, size_t max,
 		   const char *format, const struct tm *tm);
 #define strftime mingw_strftime
diff --git a/object-file.c b/object-file.c
index a8be8994814..5421811273e 100644
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
+		struct timespec ts[2] = {0};
+		ts[0].tv_sec = mtime;
+		ts[1].tv_sec = mtime;
+		if (futimens(fd, ts) < 0)
+			warning_errno(_("failed futimes() on %s"), tmp_file.buf);
 	}
 
-	return finalize_object_file(tmp_file.buf, filename.buf);
+	return close_loose_object(fd, tmp_file.buf, filename.buf);
 }
 
 static int freshen_loose_object(const struct object_id *oid)
-- 
gitgitgadget

