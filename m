From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 16/17] editor: implement git_sequence_editor() and launch_sequence_editor()
Date: Sat, 12 Mar 2016 18:46:36 +0800
Message-ID: <1457779597-6918-17-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh5R-0006JB-Q9
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbcCLKru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:50 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34376 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbcCLKrq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:46 -0500
Received: by mail-pa0-f53.google.com with SMTP id fe3so103228682pab.1
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=psHZx5fbWfJ617vjrElDLLfQ8pbEQ1n57ZhOaGmGPb0=;
        b=AV8BB+AR7dPZyOVQqxQzsZXgyj8cFWsJSeGmT5SVzvUi4+hd23HeQwhAbDGEe+ZAeg
         di6CSbY6TQrX+1aeK6jhyoJyBHBvj2wn8uZCfy3NUgtuc/oydEPvUdM67CnPQauPYsex
         1i9tHdxBG/6Ef836wx0SShYda3vzFKGAVmaNP0073ggvREQBpHTncYQxirW+K9hwaoS6
         2bTB7K6kzoKfN/9mwxa19RBU3cOvuLWVD5f71V/rIaMheGuRY1rVYH4scmAo0K9vA/zi
         CLMr4cUXdIjNJ4vU50zOPqSu39syHX9A0GqVEMX4PJ9VFEJIX4jWJ1O7zzZbq9C599W0
         IyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=psHZx5fbWfJ617vjrElDLLfQ8pbEQ1n57ZhOaGmGPb0=;
        b=bxRUk6+eg4Cde5d1aEm4Op8kt0lzHE9efJqOQNws1OO1B1D9t2Cgg28qFG6iDuu11w
         Y1sfnZ0hhzotXYeX8a9CqdTy6vnqQyflkVUh56aiuLNx9AUR8df1CA0jHHTBzBHclA6i
         YtNCVFp8EGGuKMwilJ2V4BSPndSm9Jh1R/9iJO0xugVw0IJklDnm8fCV8urecFroV1Pu
         UV0SsLFoC+LkKSAE4PXdpkv0lqTtC9aMyWzH3wiLlu82btmt64OZXHBslGtpcvAXsXxx
         j75d3J+fEQW/QTNrXzKrQm/gh402tpuz2pkvdFCX/DEllRTSVUUOouggiJV3It9Uqyjf
         h9ew==
X-Gm-Message-State: AD7BkJJB/N0hoBlVu56T/slDb1A7nh/jVhctBFvGSPSyopvgQy1IhEourWWTOzPuZ+WWDg==
X-Received: by 10.66.144.134 with SMTP id sm6mr22821779pab.158.1457779664794;
        Sat, 12 Mar 2016 02:47:44 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:43 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288744>

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 cache.h  |  1 +
 editor.c | 27 +++++++++++++++++++++++++--
 strbuf.h |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index aa5e97c..d7a6fc6 100644
--- a/cache.h
+++ b/cache.h
@@ -1222,6 +1222,7 @@ extern const char *fmt_name(const char *name, const char *email);
 extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
+extern const char *git_sequence_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 extern int git_ident_config(const char *, const char *, void *);
 
diff --git a/editor.c b/editor.c
index 01c644c..4c5874b 100644
--- a/editor.c
+++ b/editor.c
@@ -29,10 +29,22 @@ const char *git_editor(void)
 	return editor;
 }
 
-int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+const char *git_sequence_editor(void)
 {
-	const char *editor = git_editor();
+	const char *sequence_editor = getenv("GIT_SEQUENCE_EDITOR");
+
+	if (sequence_editor && *sequence_editor)
+		return sequence_editor;
 
+	git_config_get_string_const("sequence.editor", &sequence_editor);
+	if (sequence_editor && *sequence_editor)
+		return sequence_editor;
+
+	return git_editor();
+}
+
+static int launch_specific_editor(const char *editor, const char *path, struct strbuf *buffer, const char *const *env)
+{
 	if (!editor)
 		return error("Terminal is dumb, but EDITOR unset");
 
@@ -65,5 +77,16 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 	if (strbuf_read_file(buffer, path, 0) < 0)
 		return error("could not read file '%s': %s",
 				path, strerror(errno));
+
 	return 0;
 }
+
+int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+{
+	return launch_specific_editor(git_editor(), path, buffer, env);
+}
+
+int launch_sequence_editor(const char *path, struct strbuf *buffer, const char *const *env)
+{
+	return launch_specific_editor(git_sequence_editor(), path, buffer, env);
+}
diff --git a/strbuf.h b/strbuf.h
index f72fd14..aebdcd7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -524,6 +524,7 @@ extern void strbuf_add_unique_abbrev(struct strbuf *sb,
  * file's contents are not read into the buffer upon completion.
  */
 extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
+extern int launch_sequence_editor(const char *path, struct strbuf *buffer, const char *const *env);
 
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
-- 
2.7.0
