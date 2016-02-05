From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v6 3/3] ident: cleanup wrt ident's source
Date: Fri,  5 Feb 2016 09:42:28 +0200
Message-ID: <1454658148-3031-4-git-send-email-alonid@gmail.com>
References: <1454658148-3031-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 08:43:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRb2n-0006az-Dz
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 08:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbcBEHnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 02:43:00 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37395 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbcBEHm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 02:42:57 -0500
Received: by mail-wm0-f44.google.com with SMTP id g62so14913852wme.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 23:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RTBwo5Xxbl361Etz2IX1ewj6c6IbJWBihsPOnvXeDy0=;
        b=GxN/kXYMLiplAxP1hlxI1U/FVJtkWez2FVne+MEZob5gslNM1jAA7REC7DmQCWYPh2
         RmffDyO7YS8WQ/eCMzcNwA/0St0VK9FZR6B2CVvOLsQivcmR5Liumv9C4+Z5H1KxOhxP
         mciJRTiC377nvzvI8ytm8xg1VjBy3JLO6MlexgWABnV6dB+KwD++3NyxbLzPzmnYbY+1
         KEe+PGfi8vw+pUwnbeEIcTtWakYIltQW8gQo9DwIUuMfWGmWh8f4yIBngAjJiXK//nET
         PwgYUs8PWgzgJMcbJG9c1LurssnxZJojVDZHsrMMTn/qe7GHE6y+H/3fljhnP3NuDnVK
         5ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RTBwo5Xxbl361Etz2IX1ewj6c6IbJWBihsPOnvXeDy0=;
        b=hmjy+uKQGE3gVJimrrVbjC+D2EpjhPN9MuKkpmcEppx02mIf99xG/NPBSGaS0TC8E+
         dOEQkSgZS6o08FBVPUcNzAF+GGgb2VZpfBmhCwxhIspAZC9CrtHhjSdRi0q2FAfGlgf3
         46vt/0tgCrpc6n6YCqm+1jR+YDOCwMa78/A/rITY0nqgSr5EPsffg3N0WImK+CnBrUMs
         Ba1qxTS5pjKeehuCrGNmnXuCsuLNxqcHvxr1GdLnHzfMTpkMLg99Xv7Jd2nrTr5+D7EV
         IGk87ZjdLjaz0GI/wAl2c3jJWqWR346NvWn1XmoycC6IQG1cYlmaDyg3rCxnI0KbtfQa
         3S0g==
X-Gm-Message-State: AG10YOR1obYCW3xeISQwJXE685lDf94H1gu50+T7l2YE7dfq69Xt3gQfgL4U7K80zyKFdQ==
X-Received: by 10.194.201.134 with SMTP id ka6mr12447070wjc.116.1454658176421;
        Thu, 04 Feb 2016 23:42:56 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id w66sm16062302wmd.2.2016.02.04.23.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 23:42:56 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454658148-3031-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285551>

This change condenses the variables that tells where we got the user's
ident into single enum, instead of a collection of booleans.

In addtion, also have {committer,author}_ident_sufficiently_given
directly probe the environment and the afformentioned enum instead of
relying on git_{committer,author}_info to do so.

Signed-off-by: Dan Aloni <alonid@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 ident.c | 126 ++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 80 insertions(+), 46 deletions(-)

diff --git a/ident.c b/ident.c
index 9bd6ac69bfe8..9bb05912b59a 100644
--- a/ident.c
+++ b/ident.c
@@ -10,17 +10,19 @@
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
 static struct strbuf git_default_date = STRBUF_INIT;
-static int default_email_is_bogus;
-static int default_name_is_bogus;
+
+enum ident_source {
+	IDENT_SOURCE_UNKNOWN = 0,
+	IDENT_SOURCE_CONFIG,
+	IDENT_SOURCE_ENVIRONMENT,
+	IDENT_SOURCE_GUESSED,
+	IDENT_SOURCE_GUESSED_BOGUS
+};
 
 static int ident_use_config_only;
 
-#define IDENT_NAME_GIVEN 01
-#define IDENT_MAIL_GIVEN 02
-#define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
-static int committer_ident_explicitly_given;
-static int author_ident_explicitly_given;
-static int ident_config_given;
+static enum ident_source source_of_default_email = IDENT_SOURCE_UNKNOWN;
+static enum ident_source source_of_default_name = IDENT_SOURCE_UNKNOWN;
 
 #ifdef NO_GECOS_IN_PWENT
 #define get_gecos(ignored) "&"
@@ -28,7 +30,7 @@ static int ident_config_given;
 #define get_gecos(struct_passwd) ((struct_passwd)->pw_gecos)
 #endif
 
-static struct passwd *xgetpwuid_self(int *is_bogus)
+static struct passwd *xgetpwuid_self(enum ident_source *source)
 {
 	struct passwd *pw;
 
@@ -41,9 +43,13 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 		fallback.pw_gecos = "Unknown";
 #endif
 		pw = &fallback;
-		if (is_bogus)
-			*is_bogus = 1;
+		if (source)
+			*source = IDENT_SOURCE_GUESSED_BOGUS;
+	} else {
+		if (source)
+			*source = IDENT_SOURCE_GUESSED;
 	}
+
 	return pw;
 }
 
@@ -120,26 +126,26 @@ static int canonical_name(const char *host, struct strbuf *out)
 	return status;
 }
 
-static void add_domainname(struct strbuf *out, int *is_bogus)
+static void add_domainname(struct strbuf *out, enum ident_source *source)
 {
 	char buf[1024];
 
 	if (gethostname(buf, sizeof(buf))) {
 		warning("cannot get host name: %s", strerror(errno));
 		strbuf_addstr(out, "(none)");
-		*is_bogus = 1;
+		*source = IDENT_SOURCE_GUESSED_BOGUS;
 		return;
 	}
 	if (strchr(buf, '.'))
 		strbuf_addstr(out, buf);
 	else if (canonical_name(buf, out) < 0) {
 		strbuf_addf(out, "%s.(none)", buf);
-		*is_bogus = 1;
+		*source = IDENT_SOURCE_GUESSED_BOGUS;
 	}
 }
 
 static void copy_email(const struct passwd *pw, struct strbuf *email,
-		       int *is_bogus)
+		       enum ident_source *source)
 {
 	/*
 	 * Make up a fake email address
@@ -150,13 +156,13 @@ static void copy_email(const struct passwd *pw, struct strbuf *email,
 
 	if (!add_mailname_host(email))
 		return;	/* read from "/etc/mailname" (Debian) */
-	add_domainname(email, is_bogus);
+	add_domainname(email, source);
 }
 
 const char *ident_default_name(void)
 {
 	if (!git_default_name.len) {
-		copy_gecos(xgetpwuid_self(&default_name_is_bogus), &git_default_name);
+		copy_gecos(xgetpwuid_self(&source_of_default_name), &git_default_name);
 		strbuf_trim(&git_default_name);
 	}
 	return git_default_name.buf;
@@ -169,11 +175,12 @@ const char *ident_default_email(void)
 
 		if (email && email[0]) {
 			strbuf_addstr(&git_default_email, email);
-			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		} else
-			copy_email(xgetpwuid_self(&default_email_is_bogus),
-				   &git_default_email, &default_email_is_bogus);
+			source_of_default_email = IDENT_SOURCE_ENVIRONMENT;
+		} else {
+			copy_email(xgetpwuid_self(&source_of_default_email),
+				   &git_default_email, &source_of_default_email);
+		}
+
 		strbuf_trim(&git_default_email);
 	}
 	return git_default_email.buf;
@@ -353,12 +360,13 @@ const char *fmt_ident(const char *name, const char *email,
 		if (!name) {
 			name = ident_default_name();
 			using_default = 1;
-			if (strict && default_name_is_bogus) {
+			if (strict &&
+			    source_of_default_name == IDENT_SOURCE_GUESSED_BOGUS) {
 				fputs(env_hint, stderr);
 				die("unable to auto-detect name (got '%s')", name);
 			}
 			if (strict && ident_use_config_only &&
-			    !(ident_config_given & IDENT_NAME_GIVEN))
+			    source_of_default_name != IDENT_SOURCE_CONFIG)
 				die("user.useConfigOnly set but no name given");
 		}
 		if (!*name) {
@@ -375,12 +383,12 @@ const char *fmt_ident(const char *name, const char *email,
 
 	if (!email) {
 		email = ident_default_email();
-		if (strict && default_email_is_bogus) {
+		if (strict && source_of_default_email == IDENT_SOURCE_GUESSED_BOGUS) {
 			fputs(env_hint, stderr);
 			die("unable to auto-detect email address (got '%s')", email);
 		}
-		if (strict && ident_use_config_only
-		    && !(ident_config_given & IDENT_MAIL_GIVEN))
+		if (strict && ident_use_config_only &&
+		    source_of_default_email != IDENT_SOURCE_CONFIG)
 			die("user.useConfigOnly set but no mail given");
 	}
 
@@ -412,10 +420,6 @@ const char *fmt_name(const char *name, const char *email)
 
 const char *git_author_info(int flag)
 {
-	if (getenv("GIT_AUTHOR_NAME"))
-		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
-	if (getenv("GIT_AUTHOR_EMAIL"))
-		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
 			 getenv("GIT_AUTHOR_DATE"),
@@ -424,33 +428,67 @@ const char *git_author_info(int flag)
 
 const char *git_committer_info(int flag)
 {
-	if (getenv("GIT_COMMITTER_NAME"))
-		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
-	if (getenv("GIT_COMMITTER_EMAIL"))
-		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
 			 flag);
 }
 
-static int ident_is_sufficient(int user_ident_explicitly_given)
+enum ident_person {
+	IDENT_PERSON_COMMITTER,
+	IDENT_PERSON_AUTHOR
+};
+
+static int ident_source_is_sufficient(enum ident_source source)
+{
+	switch (source) {
+	case IDENT_SOURCE_CONFIG:
+	case IDENT_SOURCE_ENVIRONMENT:
+		return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int ident_is_sufficient(enum ident_person person)
 {
+	const char *str_name, *str_email;
+	int name, email;
+
+	switch (person) {
+	case IDENT_PERSON_COMMITTER:
+		str_name = getenv("GIT_COMMITTER_NAME");
+		str_email = getenv("GIT_COMMITTER_EMAIL");
+		break;
+	case IDENT_PERSON_AUTHOR:
+		str_name = getenv("GIT_AUTHOR_NAME");
+		str_email = getenv("GIT_AUTHOR_EMAIL");
+		break;
+	default:
+		die("invalid parameter to ident_is_sufficient()");
+	}
+
+	name = !!str_name || ident_source_is_sufficient(source_of_default_name);
+	email = !!str_email || ident_source_is_sufficient(source_of_default_email);
+
 #ifndef WINDOWS
-	return (user_ident_explicitly_given & IDENT_MAIL_GIVEN);
+	(void)name;
+	return email;
 #else
-	return (user_ident_explicitly_given == IDENT_ALL_GIVEN);
+	return name && email;
 #endif
 }
 
 int committer_ident_sufficiently_given(void)
 {
-	return ident_is_sufficient(committer_ident_explicitly_given);
+	return ident_is_sufficient(IDENT_PERSON_COMMITTER);
 }
 
 int author_ident_sufficiently_given(void)
 {
-	return ident_is_sufficient(author_ident_explicitly_given);
+	return ident_is_sufficient(IDENT_PERSON_AUTHOR);
 }
 
 int git_ident_config(const char *var, const char *value, void *data)
@@ -465,9 +503,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 			return config_error_nonbool(var);
 		strbuf_reset(&git_default_name);
 		strbuf_addstr(&git_default_name, value);
-		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
-		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
-		ident_config_given |= IDENT_NAME_GIVEN;
+		source_of_default_name = IDENT_SOURCE_CONFIG;
 		return 0;
 	}
 
@@ -476,9 +512,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 			return config_error_nonbool(var);
 		strbuf_reset(&git_default_email);
 		strbuf_addstr(&git_default_email, value);
-		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		ident_config_given |= IDENT_MAIL_GIVEN;
+		source_of_default_email = IDENT_SOURCE_CONFIG;
 		return 0;
 	}
 
-- 
2.5.0
