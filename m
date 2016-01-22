From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/2] Port `git submodule init` from shell to C
Date: Fri, 22 Jan 2016 15:32:14 -0800
Message-ID: <1453505536-14895-1-git-send-email-sbeller@google.com>
References: <xmqqoacdtfh3.fsf@gitster.mtv.corp.google.com>
Cc: Stefan Beller <sbeller@google.com>, j6t@kdbg.org,
	sunshine@sunshineco.com, Jens.Lehmann@web.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 23 00:32:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMlCB-00051y-FI
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 00:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618AbcAVXcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 18:32:31 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34720 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562AbcAVXc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 18:32:26 -0500
Received: by mail-pa0-f49.google.com with SMTP id uo6so49852016pac.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 15:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3JGUB/Db+nS/VBgKJj/UzYBHaOvYPRl8d6d65qCJKs0=;
        b=fSjlmVxfkcTiMosApIIls+JxtnRuWvwoMtieumgylu5RKLefEHiJvI6rTnB+D9g10u
         0FDmsxRQfZHklxeDwaqBPKw+yZq8ZeuWvKf2murS4m3dQpDuIJ7biD+6ndvU0TqDC7oV
         zPH4w6xi0EODrjv4rN/bLDHjuJ052wYkvdoJeCQhoHnirl7PkkSuDRmlHuY7JtENZUZn
         18ysfB15c/bwhtD2EYuWUCZIJNlX+YXZqdmiU0reYCCDGHRAPvBcv3kdAly0X3J4b57j
         m7pgvGkXv/x+OJizmbCu+56/1FVJ0hTAkDjXW2nJKCuWNJFMrJrJKxSiFCi3dR3cwfed
         hGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3JGUB/Db+nS/VBgKJj/UzYBHaOvYPRl8d6d65qCJKs0=;
        b=Xr93tBD+ja1cZXs/tRvcmH6sDShqSeL9TIVBUYGxP6LknIB5jPMKw8+RONKgOSRvCg
         d6fElIiogqVQdqAvuWLYPm1qQZwRucMNgOjLBq6oCjAQzKtPSCZXR1NdXU8a18fzTnhs
         /wB5V2noqcXHR+mvZ5rks9VkETp4LCWcMND5wCoRK0J68bOWnvA/G/yP1qo0ERyIGeTF
         fyBZtR+agmcdO01YrCoTss6elOHd+uIeMMtTh3djwd5reqfTICFPHaENyMik4XPbFtVG
         XFyT1zoZR3zldzLLfWmsMzLEbVDkNi+IEyE0t1F8MW3FrtIXgDASGJ9k/ON+vrg3PG4F
         KB0g==
X-Gm-Message-State: AG10YOQiO2AtMO5ssWxsgu8kHbik2wZ65TqQvuU8ycfqG9p5k58Ysco/xRrphpO31ONA8fyk
X-Received: by 10.66.120.77 with SMTP id la13mr8350144pab.74.1453505545780;
        Fri, 22 Jan 2016 15:32:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:add1:48d1:6b77:ed16])
        by smtp.gmail.com with ESMTPSA id x10sm12032001pas.37.2016.01.22.15.32.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jan 2016 15:32:24 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.45.g0dba895.dirty
In-Reply-To: <xmqqoacdtfh3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284609>

This applies on top of sb/submodule-parallel-update, replacing
sb/submodule-init.

Fixes:

 * a more faithful conversion by staying on stdout (We switch to stderr later
   in another series)
 * use the existing find_last_dir_sep instead of reinventing the wheel.

Stefan Beller (2):
  submodule: port resolve_relative_url from shell to C
  submodule: port init from shell to C

 builtin/submodule--helper.c | 321 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            | 118 +---------------
 t/t0060-path-utils.sh       |  42 ++++++
 3 files changed, 361 insertions(+), 120 deletions(-)

Interdiff to  origin/sb/submodule-init (committed 2016-01-20 12:55:30)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4684f16..c9b0c05 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -51,21 +51,12 @@ static int starts_with_dot_dot_slash(const char *str)
        return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
 }
 
-static char *last_dir_separator(char *str)
-{
-       char *p = str + strlen(str);
-       while (p-- > str)
-               if (is_dir_sep(*p))
-                       return p;
-       return NULL;
-}
-
 /*
  * Returns 1 if it was the last chop before ':'.
  */
 static int chop_last_dir(char **remoteurl, int is_relative)
 {
-       char *rfind = last_dir_separator(*remoteurl);
+       char *rfind = find_last_dir_sep(*remoteurl);
        if (rfind) {
                *rfind = '\0';
                return 0;
@@ -232,7 +223,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
        struct strbuf sb = STRBUF_INIT;
        char *url = NULL;
        const char *upd = NULL;
-       const char *displaypath = relative_path(xgetcwd(), prefix, &sb);;
+       const char *displaypath = relative_path(xgetcwd(), prefix, &sb);
 
        /* Only loads from .gitmodules, no overlay with .git/config */
        gitmodules_config();
@@ -276,7 +267,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
                        die(_("Failed to register url for submodule path '%s'"),
                            displaypath);
                if (!quiet)
-                       fprintf(stderr, _("Submodule '%s' (%s) registered for path '%s'\n"),
+                       printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
                                sub->name, url, displaypath);
                free(url);
        }

-- 
2.7.0.rc0.45.g0dba895.dirty
