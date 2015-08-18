From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/7] submodule: Allow errornous values for the fetchrecursesubmodules option
Date: Mon, 17 Aug 2015 17:22:00 -0700
Message-ID: <1439857323-21048-5-git-send-email-sbeller@google.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 02:22:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRUfh-0007we-Bp
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 02:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbbHRAWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 20:22:21 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34923 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbbHRAWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 20:22:17 -0400
Received: by pacgr6 with SMTP id gr6so118962723pac.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 17:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FP1kCRMHi0bzOcW5voWEIhPa/iETJ3duImuhUW8/+6k=;
        b=BFl3dq0jxknlF5SPRnjBcBZceI+iBgl58Ezw7ELRK7JFQfresgz0Ophuql2m2r0p0V
         AcKSKUhZFimbLnihUa1Hyi81SX3WsBSEY3NeVoWe+9E6rhrsBNDF/om0ircwKsZ6k9ah
         X6a2Gk112Elcu4R4vRMvaa1RwAFNtiItOzgd+h25YDhaaqgSCFpOyT/qbZBqs1bojeRp
         a2N32QGAS1Y/IuzQU5NRTmFVR6IkidAYMaIO9XjPZ4iQbnt4IhVNJQhHc6As+S9bv1fX
         3wtvOlrIahHA2+KOgYt0TUfT7mKtg8aofqH14h5hCY2j11SNEi7AUyw5Ccj4tj7RZIZ5
         K2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FP1kCRMHi0bzOcW5voWEIhPa/iETJ3duImuhUW8/+6k=;
        b=HSOVFeHj7WWjO5n48G7C2l525xpuiNlknreyoD3O+2VqHW365iFT5K3geTg8TYDdf4
         Bf6NAVSEVQDaosbpG8wO9ZYhncPZWrRLDLkmq09ktJvaDKzyx3jZGV9ZteFSjbF1WtBE
         yXU0kwo4V07JLPr+VljNuV+mcELcHbg7ZzhKoGH4TNeMyqBHjWejo1tFzz2SmTKOvUTF
         DzyRQWhYDqriKLdaptLBLdwFZRtv79JuleZJuPTm1R6zAhKw7a1d8LwY36JHXCWckRee
         FJAJkoKeRgYbVeTtlQRfbCODDzZ/rlUIT3jGdH0So5GNZzORA5yzzKTu3mjlAXGt3jZS
         Vt3A==
X-Gm-Message-State: ALoCoQnC2jw4XaOqfaBQt4L+VKXBmR9qmrjRTClp2H3d5QE+8S313wQAwWkS9348+e59FJNeIiYI
X-Received: by 10.66.253.229 with SMTP id ad5mr7499760pad.101.1439857336611;
        Mon, 17 Aug 2015 17:22:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bca6:6b6f:4dbb:30a3])
        by smtp.gmail.com with ESMTPSA id p1sm15951075pdb.3.2015.08.17.17.22.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 17:22:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.330.g130be8e.dirty
In-Reply-To: <1439857323-21048-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276114>

From: Heiko Voigt <hvoigt@hvoigt.net>

We should not die when reading the submodule config cache since the user
might not be able to get out of that situation when the configuration is
part of the history.

We should handle this condition later when the value is about to be
used.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             |  1 +
 submodule-config.c          | 29 ++++++++++++++++++++++++++++-
 submodule-config.h          |  1 +
 submodule.c                 | 15 ---------------
 submodule.h                 |  2 +-
 t/t7411-submodule-config.sh | 35 +++++++++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index df16d0a..ee1f1a9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "sigchain.h"
+#include "submodule-config.h"
 #include "submodule.h"
 #include "connected.h"
 #include "argv-array.h"
diff --git a/submodule-config.c b/submodule-config.c
index c64faf3..393de53 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -204,6 +204,30 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	return submodule;
 }
 
+static int parse_fetch_recurse(const char *opt, const char *arg,
+			       int die_on_error)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		return RECURSE_SUBMODULES_ON;
+	case 0:
+		return RECURSE_SUBMODULES_OFF;
+	default:
+		if (!strcmp(arg, "on-demand"))
+			return RECURSE_SUBMODULES_ON_DEMAND;
+
+		if (die_on_error)
+			die("bad %s argument: %s", opt, arg);
+		else
+			return RECURSE_SUBMODULES_ERROR;
+	}
+}
+
+int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
+{
+	return parse_fetch_recurse(opt, arg, 1);
+}
+
 static void warn_multiple_config(const unsigned char *commit_sha1,
 				 const char *name, const char *option)
 {
@@ -255,6 +279,8 @@ static int parse_config(const char *var, const char *value, void *data)
 		submodule->path = strbuf_detach(&path, NULL);
 		cache_put_path(me->cache, submodule);
 	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
+		/* when parsing worktree configurations we can die early */
+		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
 		    submodule->fetch_recurse != RECURSE_SUBMODULES_NONE) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
@@ -262,7 +288,8 @@ static int parse_config(const char *var, const char *value, void *data)
 			goto release_return;
 		}
 
-		submodule->fetch_recurse = parse_fetch_recurse_submodules_arg(var, value);
+		submodule->fetch_recurse = parse_fetch_recurse(var, value,
+								die_on_error);
 	} else if (!strcmp(item.buf, "ignore")) {
 		struct strbuf ignore = STRBUF_INIT;
 		if (!me->overwrite && submodule->ignore != NULL) {
diff --git a/submodule-config.h b/submodule-config.h
index 5fe44ce..9061e4e 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -18,6 +18,7 @@ struct submodule {
 	unsigned char gitmodules_sha1[20];
 };
 
+int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_submodule_config_option(const char *var, const char *value);
 const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name);
diff --git a/submodule.c b/submodule.c
index a382677..9fcc86f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -288,21 +288,6 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
-int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
-{
-	switch (git_config_maybe_bool(opt, arg)) {
-	case 1:
-		return RECURSE_SUBMODULES_ON;
-	case 0:
-		return RECURSE_SUBMODULES_OFF;
-	default:
-		if (!strcmp(arg, "on-demand"))
-			return RECURSE_SUBMODULES_ON_DEMAND;
-		/* TODO: remove the die for history parsing here */
-		die("bad %s argument: %s", opt, arg);
-	}
-}
-
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
diff --git a/submodule.h b/submodule.h
index 547219d..5507c3d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -5,6 +5,7 @@ struct diff_options;
 struct argv_array;
 
 enum {
+	RECURSE_SUBMODULES_ERROR = -3,
 	RECURSE_SUBMODULES_NONE = -2,
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
 	RECURSE_SUBMODULES_OFF = 0,
@@ -21,7 +22,6 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
-int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 7229978..fc97c33 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -115,4 +115,39 @@ test_expect_success 'reading of local configuration' '
 	)
 '
 
+cat >super/expect_fetchrecurse_die.err <<EOF
+fatal: bad submodule.submodule.fetchrecursesubmodules argument: blabla
+EOF
+
+test_expect_success 'local error in fetchrecursesubmodule dies early' '
+	(cd super &&
+		git config submodule.submodule.fetchrecursesubmodules blabla &&
+		test_must_fail test-submodule-config \
+			"" b \
+			"" submodule \
+				>actual.out 2>actual.err &&
+		touch expect_fetchrecurse_die.out &&
+		test_cmp expect_fetchrecurse_die.out actual.out  &&
+		test_cmp expect_fetchrecurse_die.err actual.err  &&
+		git config --unset submodule.submodule.fetchrecursesubmodules
+	)
+'
+
+test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
+	(cd super &&
+		git config -f .gitmodules \
+			submodule.submodule.fetchrecursesubmodules blabla &&
+		git add .gitmodules &&
+		git config --unset -f .gitmodules \
+			submodule.submodule.fetchrecursesubmodules &&
+		git commit -m "add error in fetchrecursesubmodules" &&
+		test-submodule-config \
+			HEAD b \
+			HEAD submodule \
+				>actual &&
+		test_cmp expect_error actual  &&
+		git reset --hard HEAD^
+	)
+'
+
 test_done
-- 
2.5.0.330.g130be8e.dirty
