Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4617C32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 02:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878332075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 02:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/25pRDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgAGCE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:04:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40905 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgAGCE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 21:04:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id s21so19816457plr.7
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 18:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uBIyOw+YAVFOAe7B8tkfnaSfMjAdgJ/j5c+34+wHWc=;
        b=u/25pRDjjQS8MCVf1Xr1C4dTSJPNQUpDX2oXkRBdws47gPTg/spwYt/J2zAQ+C59ND
         y+b/0F3ptt0aULifV5Jauke0ODzAvR5AhZrs+lc3RIJDS8hIprrX4W+UdhwcEE6ocUQF
         chnKn52gqXKmOxNHRB1yoXLTHyHkhdTAd5VAUvksriXDleoPHyowAmkM3c6nRZDCul9T
         o0gQmbqmqjvFuqzs779Qv4Rx/hnMaI6i7Xs5FkGHqIkcHzzMTF2cTTPS22zhH9DE9KX9
         rGDeWdjvHnssjBrglYL8OsG0OaFLW13qa4+VABRKXZDagHlRL3+6nxoVsOJZ8yzEZgWJ
         3WOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uBIyOw+YAVFOAe7B8tkfnaSfMjAdgJ/j5c+34+wHWc=;
        b=fYQOEh2Y6e7BfNdptQ4/vIQs4wy/bmyA6czlJegdItFY+lPDJn/hJs23Yom13HQ5eR
         JQh2/f9IVO+eDY9U8nxQeM7Cz8Y6KTbT0kmiLf1KAA9hMLZecDrf9oys0nXgeyitSi8h
         AgpqmrIgjro798nfMmZ5MDss9hPYXTEweG5q38SHh5nx/25nYvsFkrboslzrwOLMrAEl
         n+tlw3nLL/hnXhaWPCacDb2MO8cN3PETwVnxrZfpvS9BAn9a8HH+k7XD6OhNYVD9nzbr
         WM/AwrArkpfGruIMZFGHX0SW4h20N6GDaDpSsKPV1gWP6UGe7jBCekVFNJi10clM/yog
         9efA==
X-Gm-Message-State: APjAAAUfZYP2L5PaJTKTDkDDNT7yrgRnjSTDG+H5S4Z4UBgRVF1L4HGX
        xSyu+6HyaClsWW9iBCShhic=
X-Google-Smtp-Source: APXvYqwKsqWHVIxA1eueTYqCNYEUIDj/3Fm72tF9CmUd6ZlGj7ID8Nj1as2YkwWy3rg0ixoFzUHmlA==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr46987085pjp.114.1578362667933;
        Mon, 06 Jan 2020 18:04:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id n1sm80025101pfd.47.2020.01.06.18.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 18:04:27 -0800 (PST)
Date:   Mon, 6 Jan 2020 18:04:25 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Miriam R." <mirucam@gmail.com>
Subject: Re: [PATCH] run-command: avoid undefined behavior in exists_in_PATH
Message-ID: <20200107020425.GG92456@google.com>
References: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> In this function, we free the pointer we get from locate_in_PATH and
> then check whether it's NULL.  However, this is undefined behavior if
> the pointer is non-NULL, since the C standard no longer permits us to
> use a valid pointer after freeing it.
[...]
> Noticed-by: Miriam R. <mirucam@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  run-command.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

This API that forces the caller to deal with the allocated result when
they never asked for it seems a bit inconvenient.  Should we clean it up
a little?  Something like this (on top):

-- >8 --
Subject: run-command: let caller pass in buffer to locate_in_PATH

Instead of returning a buffer that the caller is responsible for
freeing, use a strbuf output parameter to record the path to the
searched-for program.

This makes ownership a little easier to reason about, since the owning
code declares the buffer.  It's a good habit to follow because it
allows buffer reuse when calling such a function in a loop.

It also allows the caller exists_in_PATH that does not care about the
path to the command to be slightly simplified, by allowing a NULL
output parameter that means that locate_in_PATH should take care of
allocating and freeing its temporary buffer.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 run-command.c | 51 +++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git i/run-command.c w/run-command.c
index f5e1149f9b..a6dc38396a 100644
--- i/run-command.c
+++ w/run-command.c
@@ -170,52 +170,57 @@ int is_executable(const char *name)
  * The caller should ensure that file contains no directory
  * separators.
  *
- * Returns the path to the command, as found in $PATH or NULL if the
- * command could not be found.  The caller inherits ownership of the memory
- * used to store the resultant path.
+ * Returns a boolean indicating whether the command was found in $PATH.
+ * The path to the command is recorded in the strbuf 'out', if supplied.
  *
  * This should not be used on Windows, where the $PATH search rules
  * are more complicated (e.g., a search for "foo" should find
  * "foo.exe").
  */
-static char *locate_in_PATH(const char *file)
+static int locate_in_PATH(const char *file, struct strbuf *out)
 {
 	const char *p = getenv("PATH");
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!p || !*p)
-		return NULL;
+	if (!out)
+		out = &buf;
+
+	if (!p || !*p) {
+		strbuf_reset(out);
+		strbuf_release(&buf);
+		return 0;
+	}
 
 	while (1) {
 		const char *end = strchrnul(p, ':');
 
-		strbuf_reset(&buf);
+		strbuf_reset(out);
 
 		/* POSIX specifies an empty entry as the current directory. */
 		if (end != p) {
-			strbuf_add(&buf, p, end - p);
-			strbuf_addch(&buf, '/');
+			strbuf_add(out, p, end - p);
+			strbuf_addch(out, '/');
 		}
-		strbuf_addstr(&buf, file);
+		strbuf_addstr(out, file);
 
-		if (is_executable(buf.buf))
-			return strbuf_detach(&buf, NULL);
+		if (is_executable(out->buf)) {
+			strbuf_release(&buf);
+			return 1;
+		}
 
 		if (!*end)
 			break;
 		p = end + 1;
 	}
 
+	strbuf_reset(out);
 	strbuf_release(&buf);
-	return NULL;
+	return 0;
 }
 
 static int exists_in_PATH(const char *file)
 {
-	char *r = locate_in_PATH(file);
-	int found = r != NULL;
-	free(r);
-	return found;
+	return locate_in_PATH(file, NULL);
 }
 
 int sane_execvp(const char *file, char * const argv[])
@@ -427,15 +432,17 @@ static int prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 	 * directly.
 	 */
 	if (!strchr(out->argv[1], '/')) {
-		char *program = locate_in_PATH(out->argv[1]);
-		if (program) {
-			free((char *)out->argv[1]);
-			out->argv[1] = program;
-		} else {
+		struct strbuf program = STRBUF_INIT;
+
+		if (!locate_in_PATH(out->argv[1], &program)) {
 			argv_array_clear(out);
+			strbuf_release(&program);
 			errno = ENOENT;
 			return -1;
 		}
+
+		free((char *)out->argv[1]);
+		out->argv[1] = strbuf_detach(&program, NULL);
 	}
 
 	return 0;
