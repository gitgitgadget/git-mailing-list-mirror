Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB5C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64164206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmAT2mjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLUWFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:05:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37902 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLUWFF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:05:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id i16so12015619edr.5
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qrft+PiEo7aTblQ7Sc/9tnxL90PAiDzn81zSQ6uRI0U=;
        b=LmAT2mjrM3vt4Wl1DosGvyVjQgkWToper36VoynPXVYy0niCgQJCd2SlS41Ke9uftO
         VL0q6ntwzK4jX8rwq4JVI3KMwEqAI5btKSaQlGWi4A2NWOBTfw576LpX9YFwCDygXS8p
         sAaVCGmRbaot1iVaXY+T0YBaL6ruYMaHBfCnLh64l6LzPlx/bUQAHndnaeDLBcxG7i3M
         An6hJ8UdiwavvdtqimpkozLghAVwIUf9W1txsqa9O68mNCAjFC9k+nxdJB9gbZHOGYDa
         WnvaK7D+Gp3KdzQonOUI1pPNfUcwDonB0L7Np3kK3Ju9UoTwBK8muk7V3NlOx/9K85B0
         JmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qrft+PiEo7aTblQ7Sc/9tnxL90PAiDzn81zSQ6uRI0U=;
        b=Y6zQsO18TFV+aZTyIa8XDzjKQENcEI1KpdOF6fn7tOV0Sv6pedyfNRCQcrtc2oIubb
         7/3XjUDNDe4nwkrUJvVYi6QY6N8GfiOvyjdUDhghLLvK7/guZiQ/C/RsN7FL2GuyG9p3
         Zc1G94iTbNRseolnX06Q5UBDq1Uxgp6dnonHoA5+U4Uix5ikMAefSGCMAnS8OqbFfqjz
         V3mjxaf7uHcVPwSejUvnDa8ep4yJq4fKbJUlaTjYo9ViaBbhRuyVSA/RRLUXar7o8gro
         QGha2iilmfthnP45vayTXh+K3rIes/+O17qSxgwDKbOWFi3TmlYQ8oefYspUInl9lL7r
         uMzw==
X-Gm-Message-State: APjAAAWvZwL8Ug9Vqh4rgqpHWxj5VWeUC6rGASw3uuGa9/SuCwWOYF3t
        0AoVpvglI6859PERK97xh79xgWW4
X-Google-Smtp-Source: APXvYqyaFZAs8giA4MpUZmGW84+kXG6VqICpPXUR0yhQ9tWc7XfQ9XwkwNmt8LEkIVPSKvI9iDPMnA==
X-Received: by 2002:a05:6402:2036:: with SMTP id ay22mr24392938edb.303.1576965902959;
        Sat, 21 Dec 2019 14:05:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm1541479edt.60.2019.12.21.14.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:05:02 -0800 (PST)
Message-Id: <f4dbaa66cc313d458f1a15c0c258016abfc698a0.1576965901.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.496.git.1576965901.gitgitgadget@gmail.com>
References: <pull.496.git.1576965901.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:05:00 +0000
Subject: [PATCH 1/2] mingw: short-circuit the conversion of `/dev/null` to
 UTF-16
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

In the next commit, we want to disallow accessing any path that contains
any segment that is equivalent to `NUL`. In particular, we want to
disallow accessing `NUL` (e.g. to prevent any repository from being
checked out that contains a file called `NUL`, as that is not a valid
file name on Windows).

However, there are legitimate use cases within Git itself to write to
the Null device. As Git is really a Linux project, it does not abstract
that idea, though, but instead uses `/dev/null` to describe this
intention.

So let's side-step the validation _specifically_ in the case that we
want to write to (or read from) `/dev/null`, via a dedicated short-cut
in the code that skips the call to `validate_win32_path()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index bd24d913f9..03c4538ec8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -484,16 +484,16 @@ int mingw_open (const char *filename, int oflags, ...)
 		return -1;
 	}
 
-	if (filename && !strcmp(filename, "/dev/null"))
-		filename = "nul";
-
 	if ((oflags & O_APPEND) && !is_local_named_pipe_path(filename))
 		open_fn = mingw_open_append;
 	else
 		open_fn = _wopen;
 
-	if (xutftowcs_path(wfilename, filename) < 0)
+	if (filename && !strcmp(filename, "/dev/null"))
+		wcscpy(wfilename, L"nul");
+	else if (xutftowcs_path(wfilename, filename) < 0)
 		return -1;
+
 	fd = open_fn(wfilename, oflags, mode);
 
 	if (fd < 0 && (oflags & O_ACCMODE) != O_RDONLY && errno == EACCES) {
@@ -556,10 +556,13 @@ FILE *mingw_fopen (const char *filename, const char *otype)
 		return NULL;
 	}
 	if (filename && !strcmp(filename, "/dev/null"))
-		filename = "nul";
-	if (xutftowcs_path(wfilename, filename) < 0 ||
-		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
+		wcscpy(wfilename, L"nul");
+	else if (xutftowcs_path(wfilename, filename) < 0)
 		return NULL;
+
+	if (xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
+		return NULL;
+
 	if (hide && !access(filename, F_OK) && set_hidden_flag(wfilename, 0)) {
 		error("could not unhide %s", filename);
 		return NULL;
@@ -583,10 +586,13 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
 		return NULL;
 	}
 	if (filename && !strcmp(filename, "/dev/null"))
-		filename = "nul";
-	if (xutftowcs_path(wfilename, filename) < 0 ||
-		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
+		wcscpy(wfilename, L"nul");
+	else if (xutftowcs_path(wfilename, filename) < 0)
 		return NULL;
+
+	if (xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
+		return NULL;
+
 	if (hide && !access(filename, F_OK) && set_hidden_flag(wfilename, 0)) {
 		error("could not unhide %s", filename);
 		return NULL;
-- 
gitgitgadget

