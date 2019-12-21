Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEF3C2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F25B206D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI53V4xF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfLUWFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:05:06 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:38263 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUWFF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:05:05 -0500
Received: by mail-ed1-f50.google.com with SMTP id i16so12015637edr.5
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mHrbhgU5L11xO3SSikFSQyObRqkQS+Hm2Ch2OKfzKGI=;
        b=QI53V4xFz2ANGG37igQq+BOsYhuwt9qT0ZQsXdeczKXyb7PwpBj94kDjCgCgMBLYwe
         3ya3KBt3NrrawX3GzynpRTwyjuQ1bHv003MhpySHR/z5Kp4hF/v0WqCC4lkgX4xPBvEq
         2Afs73x9+H/+g5LeGGT2Bw5M42MXbtprEGAJ86gf49MKPynFHoBlWLuAxVPrx1+lY9rX
         YEX1TM/rtjp0DpjEbrzATxKiErUFfTbYPZMaRwaSAXQMSb2Po8WsnCS3yHF7VllrDryn
         5KYPv5EjLyrbO9oC8zAuuXclH37AucFA7BPNXF1GS/fvnvXKfIJtHPOAaYY7Fs+Jo0/4
         mpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mHrbhgU5L11xO3SSikFSQyObRqkQS+Hm2Ch2OKfzKGI=;
        b=Ce3KJ9gPDp6S1Kl+C7okDXjlujIwZ0sovYeulPzbM+u2yksd0dHkyUoeLxA8DhpuBV
         5QYUc3p+jokfdTN4za+AeblH3f2Muf3hf/C1bb6qgeMo14+BXi9R50tu6REhO4ZrEQHi
         K2+r8kCVtPlg3SINcl33OwOLFY0jhFy2m1ayCmbAz/9BJtrIeANDWnbN9E2enBXXf4wI
         gB4AaTe0NVGSBWn0LyCaQoMsrAVLnyJwY4HgbSk3aW6x56YtuPBtQ0A4+jzR0aKl9ecE
         S/bYdD336t87LOW0fsvCHX2mwuvf/igiIOkt8KbRqMWqFG3cZ2Y6nsqkqpNpXm+ZKtiE
         NLdw==
X-Gm-Message-State: APjAAAXYgWxTJIE3P8aq48J+rKDhOqsjytNQDv1X9+g9+dPh0jXzSzr1
        kaknHTZcw5jEzHMCKN63E2NLRZms
X-Google-Smtp-Source: APXvYqyKVd368JAMaAXFXAj7VyYCzmJ/wcxeYjMkeC5b2nDVHwVvvE6IghNktR7vO+YQ08Yg53qcgQ==
X-Received: by 2002:a17:906:198b:: with SMTP id g11mr24102355ejd.271.1576965903669;
        Sat, 21 Dec 2019 14:05:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24sm1565037edr.83.2019.12.21.14.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:05:03 -0800 (PST)
Message-Id: <171871addc00acb12a77796c97d7f7b4f605ebc9.1576965901.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.496.git.1576965901.gitgitgadget@gmail.com>
References: <pull.496.git.1576965901.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:05:01 +0000
Subject: [PATCH 2/2] mingw: refuse paths containing reserved names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There are a couple of reserved names that cannot be file names on
Windows, such as `AUX`, `NUL`, etc. For an almost complete list, see
https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file

If one would try to create a directory named `NUL`, it would actually
"succeed", i.e. the call would return success, but nothing would be
created.

Worse, even adding a file extension to the reserved name does not make
it a valid file name. To understand the rationale behind that behavior,
see https://devblogs.microsoft.com/oldnewthing/20031022-00/?p=42073

Let's just disallow them all.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c        | 104 ++++++++++++++++++++++++++++++++++++------
 compat/mingw.h        |  11 ++++-
 t/t0060-path-utils.sh |  13 +++++-
 3 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 03c4538ec8..f482ecd6da 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -393,7 +393,7 @@ int mingw_mkdir(const char *path, int mode)
 	int ret;
 	wchar_t wpath[MAX_PATH];
 
-	if (!is_valid_win32_path(path)) {
+	if (!is_valid_win32_path(path, 0)) {
 		errno = EINVAL;
 		return -1;
 	}
@@ -479,7 +479,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	mode = va_arg(args, int);
 	va_end(args);
 
-	if (!is_valid_win32_path(filename)) {
+	if (!is_valid_win32_path(filename, !create)) {
 		errno = create ? EINVAL : ENOENT;
 		return -1;
 	}
@@ -550,14 +550,13 @@ FILE *mingw_fopen (const char *filename, const char *otype)
 	int hide = needs_hiding(filename);
 	FILE *file;
 	wchar_t wfilename[MAX_PATH], wotype[4];
-	if (!is_valid_win32_path(filename)) {
+	if (filename && !strcmp(filename, "/dev/null"))
+		wcscpy(wfilename, L"nul");
+	else if (!is_valid_win32_path(filename, 1)) {
 		int create = otype && strchr(otype, 'w');
 		errno = create ? EINVAL : ENOENT;
 		return NULL;
-	}
-	if (filename && !strcmp(filename, "/dev/null"))
-		wcscpy(wfilename, L"nul");
-	else if (xutftowcs_path(wfilename, filename) < 0)
+	} else if (xutftowcs_path(wfilename, filename) < 0)
 		return NULL;
 
 	if (xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
@@ -580,14 +579,13 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
 	int hide = needs_hiding(filename);
 	FILE *file;
 	wchar_t wfilename[MAX_PATH], wotype[4];
-	if (!is_valid_win32_path(filename)) {
+	if (filename && !strcmp(filename, "/dev/null"))
+		wcscpy(wfilename, L"nul");
+	else if (!is_valid_win32_path(filename, 1)) {
 		int create = otype && strchr(otype, 'w');
 		errno = create ? EINVAL : ENOENT;
 		return NULL;
-	}
-	if (filename && !strcmp(filename, "/dev/null"))
-		wcscpy(wfilename, L"nul");
-	else if (xutftowcs_path(wfilename, filename) < 0)
+	} else if (xutftowcs_path(wfilename, filename) < 0)
 		return NULL;
 
 	if (xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
@@ -2412,14 +2410,16 @@ static void setup_windows_environment(void)
 	}
 }
 
-int is_valid_win32_path(const char *path)
+int is_valid_win32_path(const char *path, int allow_literal_nul)
 {
+	const char *p = path;
 	int preceding_space_or_period = 0, i = 0, periods = 0;
 
 	if (!protect_ntfs)
 		return 1;
 
 	skip_dos_drive_prefix((char **)&path);
+	goto segment_start;
 
 	for (;;) {
 		char c = *(path++);
@@ -2434,7 +2434,83 @@ int is_valid_win32_path(const char *path)
 				return 1;
 
 			i = periods = preceding_space_or_period = 0;
-			continue;
+
+segment_start:
+			switch (*path) {
+			case 'a': case 'A': /* AUX */
+				if (((c = path[++i]) != 'u' && c != 'U') ||
+				    ((c = path[++i]) != 'x' && c != 'X')) {
+not_a_reserved_name:
+					path += i;
+					continue;
+				}
+				break;
+			case 'c': case 'C': /* COM<N>, CON, CONIN$, CONOUT$ */
+				if ((c = path[++i]) != 'o' && c != 'O')
+					goto not_a_reserved_name;
+				c = path[++i];
+				if (c == 'm' || c == 'M') { /* COM<N> */
+					if (!isdigit(path[++i]))
+						goto not_a_reserved_name;
+				} else if (c == 'n' || c == 'N') { /* CON */
+					c = path[i + 1];
+					if ((c == 'i' || c == 'I') &&
+					    ((c = path[i + 2]) == 'n' ||
+					     c == 'N') &&
+					    path[i + 3] == '$')
+						i += 3; /* CONIN$ */
+					else if ((c == 'o' || c == 'O') &&
+						 ((c = path[i + 2]) == 'u' ||
+						  c == 'U') &&
+						 ((c = path[i + 3]) == 't' ||
+						  c == 'T') &&
+						 path[i + 4] == '$')
+						i += 4; /* CONOUT$ */
+				} else
+					goto not_a_reserved_name;
+				break;
+			case 'l': case 'L': /* LPT<N> */
+				if (((c = path[++i]) != 'p' && c != 'P') ||
+				    ((c = path[++i]) != 't' && c != 'T') ||
+				    !isdigit(path[++i]))
+					goto not_a_reserved_name;
+				break;
+			case 'n': case 'N': /* NUL */
+				if (((c = path[++i]) != 'u' && c != 'U') ||
+				    ((c = path[++i]) != 'l' && c != 'L') ||
+				    (allow_literal_nul &&
+				     !path[i + 1] && p == path))
+					goto not_a_reserved_name;
+				break;
+			case 'p': case 'P': /* PRN */
+				if (((c = path[++i]) != 'r' && c != 'R') ||
+				    ((c = path[++i]) != 'n' && c != 'N'))
+					goto not_a_reserved_name;
+				break;
+			default:
+				continue;
+			}
+
+			/*
+			 * So far, this looks like a reserved name. Let's see
+			 * whether it actually is one: trailing spaces, a file
+			 * extension, or an NTFS Alternate Data Stream do not
+			 * matter, the name is still reserved if any of those
+			 * follow immediately after the actual name.
+			 */
+			i++;
+			if (path[i] == ' ') {
+				preceding_space_or_period = 1;
+				while (path[++i] == ' ')
+					; /* skip all spaces */
+			}
+
+			c = path[i];
+			if (c && c != '.' && c != ':' && c != '/' && c != '\\')
+				goto not_a_reserved_name;
+
+			/* contains reserved name */
+			return 0;
 		case '.':
 			periods++;
 			/* fallthru */
diff --git a/compat/mingw.h b/compat/mingw.h
index 04ca731a6b..ebc1e6a773 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -461,10 +461,17 @@ char *mingw_query_user_email(void);
  *
  * - contain any of the reserved characters, e.g. `:`, `;`, `*`, etc
  *
+ * - correspond to reserved names (such as `AUX`, `PRN`, etc)
+ *
+ * The `allow_literal_nul` parameter controls whether the path `NUL` should
+ * be considered valid (this makes sense e.g. before opening files, as it is
+ * perfectly legitimate to open `NUL` on Windows, just as it is to open
+ * `/dev/null` on Unix/Linux).
+ *
  * Returns 1 upon success, otherwise 0.
  */
-int is_valid_win32_path(const char *path);
-#define is_valid_path(path) is_valid_win32_path(path)
+int is_valid_win32_path(const char *path, int allow_literal_nul);
+#define is_valid_path(path) is_valid_win32_path(path, 0)
 
 /**
  * Converts UTF-8 encoded string to UTF-16LE.
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index b193ed4205..eaf3be94e3 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -465,11 +465,14 @@ test_expect_success 'match .gitmodules' '
 '
 
 test_expect_success MINGW 'is_valid_path() on Windows' '
-       test-tool path-utils is_valid_path \
+	test-tool path-utils is_valid_path \
 		win32 \
 		"win32 x" \
 		../hello.txt \
 		C:\\git \
+		comm \
+		conout.c \
+		lptN \
 		\
 		--not \
 		"win32 "  \
@@ -477,7 +480,13 @@ test_expect_success MINGW 'is_valid_path() on Windows' '
 		"win32."  \
 		"win32 . ." \
 		.../hello.txt \
-		colon:test
+		colon:test \
+		"AUX.c" \
+		"abc/conOut\$  .xyz/test" \
+		lpt8 \
+		"lpt*" \
+		Nul \
+		"PRN./abc"
 '
 
 test_done
-- 
gitgitgadget
