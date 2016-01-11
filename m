From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 4/8] submodule-config: introduce parse_generic_submodule_config
Date: Mon, 11 Jan 2016 11:41:57 -0800
Message-ID: <1452541321-27810-5-git-send-email-sbeller@google.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 11 20:42:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiMK-00057R-P3
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbcAKTmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:42:25 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33966 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934626AbcAKTmT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:42:19 -0500
Received: by mail-pa0-f45.google.com with SMTP id uo6so309180604pac.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 11:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5a2ltRTTKP0hS8A/LAYoyo+8wNoI8wg8O/AplXn/TPA=;
        b=QV8kTPjhWz/DO1ooCMTMoWQQw/sHk92JavL/XoK7Wmone1R8c5Aehoi2ixTKhH49uM
         Uony004uZBvp2BH3WsSYTp/zBtNvfqldNcLH2GhfWIHsspTUT9sQxnd1aVRfUjJ3YzTG
         dXlRiUk64oEu6f/K4inNMebWQmfYAlE3viBKUYos8xE0a4tiDrHfd4vZK2aPX+ksYGu3
         YTGyF7xN03UziRnI0N5fDxEvkZALeNStDZudZdKcxWQWFCfG0UMrW6l24MvLSc3capFD
         bOKR/HI+swbIa3pg537HuZ9BolQ7mJnZmN2r61oSwlEvyfP51F44W0hRsArOCNGgFV7s
         pCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5a2ltRTTKP0hS8A/LAYoyo+8wNoI8wg8O/AplXn/TPA=;
        b=broBBZrhTxqS4i8VhDXV4RK3KuhfemXhokfyxeDnVqrkDlRnu9TPnyO6zs+Dn0CHpC
         AC85cqdpyXC9dOcX8OWxP7tz/PDJCPIIlkkPUN237fUxPcxwyhbDLtnW3sEOq6KkSFyP
         koqipQDlBu+VKMrKD+14+GPGkR8c2BmvrS9S7aVSE2jvdiOcE9DThzjTd3dtSCKmYlxN
         2iGmNUgSL6oIlCS6MmNj9DdB13zXc2IuX5tQQXMyProukh7ClfbVwVbh1FqyPVWoGWJ0
         ckhJXf7Nl4iDSw3eM6uKh/6VxqnGw3fSw09YdhiOr7eo6NJsR8Zp4LmA+ewDL6zTFZza
         8Nqg==
X-Gm-Message-State: ALoCoQlFTcU+N2ddIPv7ZRnz3pSMPJmnFnuGDE0SfzqGwzxV/Y12daZqUHuUGbkttNRR0wQM+9bptV2Ib8gARRL6qYwloRmKNw==
X-Received: by 10.67.14.74 with SMTP id fe10mr185727836pad.151.1452541338361;
        Mon, 11 Jan 2016 11:42:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8d8c:9316:e7e7:6f4f])
        by smtp.gmail.com with ESMTPSA id ry1sm187696735pab.30.2016.01.11.11.42.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Jan 2016 11:42:17 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.7.gf4541cb.dirty
In-Reply-To: <1452541321-27810-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283708>

This rewrites parse_config to distinguish between configs specific to
one submodule and configs which apply generically to all submodules.
We do not have generic submodule configs yet, but the next patch will
introduce "submodule.fetchJobs".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index b826841..29e21b2 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -234,17 +234,22 @@ struct parse_config_parameter {
 	int overwrite;
 };
 
-static int parse_config(const char *var, const char *value, void *data)
+static int parse_generic_submodule_config(const char *key,
+					  const char *var,
+					  const char *value,
+					  struct parse_config_parameter *me)
 {
-	struct parse_config_parameter *me = data;
-	struct submodule *submodule;
-	int subsection_len, ret = 0;
-	const char *subsection, *key;
-
-	if (parse_config_key(var, "submodule", &subsection,
-			     &subsection_len, &key) < 0 || !subsection_len)
-		return 0;
+	return 0;
+}
 
+static int parse_specific_submodule_config(const char *subsection, int subsection_len,
+					   const char *key,
+					   const char *var,
+					   const char *value,
+					   struct parse_config_parameter *me)
+{
+	int ret = 0;
+	struct submodule *submodule;
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
 					     subsection, subsection_len);
@@ -314,6 +319,24 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
+static int parse_config(const char *var, const char *value, void *data)
+{
+	struct parse_config_parameter *me = data;
+	int subsection_len;
+	const char *subsection, *key;
+
+	if (parse_config_key(var, "submodule", &subsection,
+			     &subsection_len, &key) < 0)
+		return 0;
+
+	if (!subsection_len)
+		return parse_generic_submodule_config(key, var, value, me);
+	else
+		return parse_specific_submodule_config(subsection,
+						       subsection_len, key,
+						       var, value, me);
+}
+
 static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1)
 {
-- 
2.7.0.rc1.7.gf4541cb.dirty
