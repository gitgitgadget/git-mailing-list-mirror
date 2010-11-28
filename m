From: "ZHANG, Le" <r0bertz@gentoo.org>
Subject: [PATCH v4 2/4] i18n.patchencoding: introduce a new config variable
Date: Mon, 29 Nov 2010 03:10:15 +0800
Message-ID: <1290971417-4474-3-git-send-email-r0bertz@gentoo.org>
References: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
Cc: "ZHANG, Le" <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 20:11:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMmeK-0001A8-Rf
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab0K1TKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:10:52 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55102 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab0K1TKv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 14:10:51 -0500
Received: by gyb11 with SMTP id 11so1661632gyb.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 11:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0HrgtdRW5Ugg4XlGR6Bwmr7S2GHO4uQJNhGAZSMd33o=;
        b=gO+CTvlcWlWD4sRYHqnKTgcAfF4N7QqqPGdXNBv+LgYaLgxK6VCRp7lNs18um3nZQ0
         8fOxqeSCSig/qkE271vo7SEdAtny9PjVjYvErj7j1PO2tWGt0YsCbMX4QaubTkfXG44Q
         fKCn2hQZ4TpNlpMJvDUKCb7HYe6spUEt4E51o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=tOYnHwQaFWEHfSJ7mVGhRlTyOitxbgP/qSarsvrK7rWU5pCnPd6v0lHIQHBdAjSj2m
         4MqTW/Y2b1XrlES8l5SwJbwupnMZ/CUXwlSq3SCPK2URV8yfCFZLaLWLk2SI/aaKNyOo
         KQaIHUkTM9yy8X5Aww19zLeTl8HBk7csr0IdI=
Received: by 10.150.185.1 with SMTP id i1mr7220123ybf.370.1290971450555;
        Sun, 28 Nov 2010 11:10:50 -0800 (PST)
Received: from localhost ([183.37.0.219])
        by mx.google.com with ESMTPS id e24sm4791729ana.2.2010.11.28.11.10.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 11:10:49 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.344.gb3680.dirty
In-Reply-To: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162347>

This varible will be used by git mailinfo's --recode-patch parameter only.

Signed-off-by: ZHANG, Le <r0bertz@gentoo.org>
---
 cache.h       |    1 +
 config.c      |    3 +++
 environment.c |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..d04aeff 100644
--- a/cache.h
+++ b/cache.h
@@ -1015,6 +1015,7 @@ extern int user_ident_explicitly_given;
 extern int user_ident_sufficiently_given(void);
 
 extern const char *git_commit_encoding;
+extern const char *git_patch_encoding;
 extern const char *git_log_output_encoding;
 extern const char *git_mailmap_file;
 
diff --git a/config.c b/config.c
index c63d683..14b0f92 100644
--- a/config.c
+++ b/config.c
@@ -674,6 +674,9 @@ static int git_default_i18n_config(const char *var, const char *value)
 	if (!strcmp(var, "i18n.commitencoding"))
 		return git_config_string(&git_commit_encoding, var, value);
 
+	if (!strcmp(var, "i18n.patchencoding"))
+		return git_config_string(&git_patch_encoding, var, value);
+
 	if (!strcmp(var, "i18n.logoutputencoding"))
 		return git_config_string(&git_log_output_encoding, var, value);
 
diff --git a/environment.c b/environment.c
index de5581f..b2870f4 100644
--- a/environment.c
+++ b/environment.c
@@ -23,6 +23,7 @@ int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 const char *git_commit_encoding;
+const char *git_patch_encoding;
 const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
-- 
1.7.3.2.344.gb3680.dirty
