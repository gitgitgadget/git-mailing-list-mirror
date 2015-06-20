From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 18/19] fsck: git receive-pack: support excluding
 objects from fsck'ing
Date: Sat, 20 Jun 2015 14:45:51 +0200
Organization: gmx
Message-ID: <9b7c42e6ec81fd70015b8fe9ff2bd137@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <e843f9f1defca543d3f2eb3143cf9fee8c72f695.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqwpyz5t66.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 14:46:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6IA2-0007Wz-7E
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 14:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbbFTMqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 08:46:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:50148 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455AbbFTMqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 08:46:07 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MKYLf-1Z5TTZ00fP-0021oF; Sat, 20 Jun 2015 14:45:54
 +0200
In-Reply-To: <xmqqwpyz5t66.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:8sdnbLcz+Q2j7PxqHXbj17K8uZa+b2xNQUluqq1EFPqRZ4XiLAw
 hPAKnbUtTNN3CTMVg50+qohO5taOC7jsMQnKvFS2Z5wtLaI88Mk9YVY5DixYpYW/Jhz96nc
 ChhSxd9zTZFb5d81JrvCkhaY9WEpHBZYm+LYVQurF7gUmY76mKO+dZLEfx2NNzECFGxORTp
 DYGdNg9ZVGVolxPOqjm8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B+OJqxVPh2Y=:2UzU3SZUO7wu1iDfPx8OaD
 vZqNNobI/F6ad9qScsoApz5/O4++WJMn1lOKrh7p3f5TPdEZe/yH5WG7Z+F845a4syo7U/bDy
 d2IDWVYFomuEuC2KUuNYM6jBOh92B2yrdODia59xl3R1AAiO10AZ5QjTjWnbJkcxfx4jeJFda
 liQiOUdpa65Us5t+M1dRJ4JFw9HtQsAJPsfLrp8A5y4vXQ7hywd4+N2U+h/K6ejBOzeVJtJgG
 XOukaR5hjbzoojb4K+M/LFsVWIZZeTMXIq/wbJwPAMARX4E7rjoNWxsdYUwBnahMLEc8TMMUi
 1RFK3SiZ8XRovmPsv8yoJqIV6TaV0DE1oRKCfQXKaoKNVSUkEVDYsBm2SxaSMzbU7o6NCavCi
 xpl/mVCIL9f/lGCG8ElaNp9QeGqwagbYR6abaB1+6avdzzQ9zeLqiDPibIOkHNaI1ft9BXxEY
 V4YAMACQ4+3zh+oj5MFuNg8bW6+u1DywY2NCfu7LGSWV/alHp42+Dw+gSYhzz95rG0U1J0ElP
 ncMJUAGUae192lEUEpvWqjv90m5chFLbLL7kMZsL6uvKaAmGFEIolh7LKNzRmMxGiMzvnElVZ
 0CTJn+f/KgckRWu4LLG2Wke/uXU1SRcMWxy239Jsdz7HT8gE+23kpN7k5RmmqGDzlLrkjVE9V
 k4c+fFTGA3tEphb5fFTVnITlZ+5Tl9RvBCw0YZdx/EIIvsQ114044UmuE2bqRWckD3ww=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272227>

Hi Junio,

On 2015-06-19 22:39, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> +	if (strcmp(var, "receive.fsck.skiplist") == 0) {
>> +		const char *path = is_absolute_path(value) ?
>> +			value : git_path("%s", value);
> 
> This "either absolute or inside $GIT_DIR" looks somewhat strange to
> me.  Shouldn't we mimick what "git config --path" does instead?

Okay. That would also support user paths.

There is a problem, though: `git_config_pathname()` accepts a `const char **` parameter to set the path, yet I need to `free()` that pointer afterwards because it has been obtained through `expand_user_path()` which detaches that buffer from a `strbuf`.

In regular use cases, that does not matter much because the path obtained via `git_config_pathname()` is typically stored in a global variable, but in my case, I append it to a global variable.

Of course I could cast the value to a `char *` and `free()` it, but that would assume too much about the implementation detail of `git_config_pathname()` for my taste.

The easiest cop out would be to recapitulate the code in `git_config_pathname()`, but I think the correct solution would be to change the signature of `git_config_pathname()` to accept a `char **` instead. Do you agree? However, the diff looks really ugly:

-- snipsnap --
diff --git a/builtin/commit.c b/builtin/commit.c
index 254477f..946b31b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1494,7 +1494,7 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	int status;
 
 	if (!strcmp(k, "commit.template"))
-		return git_config_pathname(&template_file, k, v);
+		return git_config_pathname((char **)&template_file, k, v);
 	if (!strcmp(k, "commit.status")) {
 		include_status = git_config_bool(k, v);
 		return 0;
diff --git a/builtin/config.c b/builtin/config.c
index 7188405..a249faa 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -130,7 +130,7 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 		else
 			sprintf(value, "%d", v);
 	} else if (types == TYPE_PATH) {
-		if (git_config_pathname(&vptr, key_, value_) < 0)
+		if (git_config_pathname((char **)&vptr, key_, value_) < 0)
 			return -1;
 		must_free_vptr = 1;
 	} else if (value_) {
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 4335738..0572cae 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -177,7 +177,8 @@ free_return:
 static int git_init_db_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "init.templatedir"))
-		return git_config_pathname(&init_db_template_dir, k, v);
+		return git_config_pathname((char **)&init_db_template_dir,
+				k, v);
 
 	return 0;
 }
diff --git a/builtin/log.c b/builtin/log.c
index 8781049..8751173 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -743,7 +743,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "format.signature"))
 		return git_config_string(&signature, var, value);
 	if (!strcmp(var, "format.signaturefile"))
-		return git_config_pathname(&signature_file, var, value);
+		return git_config_pathname((char **)&signature_file,
+				var, value);
 	if (!strcmp(var, "format.coverletter")) {
 		if (value && !strcasecmp(value, "auto")) {
 			config_cover_letter = COVER_AUTO;
diff --git a/cache.h b/cache.h
index 4f55466..19af52e 100644
--- a/cache.h
+++ b/cache.h
@@ -1442,7 +1442,7 @@ extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
-extern int git_config_pathname(const char **, const char *, const char *);
+extern int git_config_pathname(char **, const char *, const char *);
 extern int git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
diff --git a/config.c b/config.c
index 29fa012..51781b8 100644
--- a/config.c
+++ b/config.c
@@ -670,7 +670,7 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
-int git_config_pathname(const char **dest, const char *var, const char *value)
+int git_config_pathname(char **dest, const char *var, const char *value)
 {
 	if (!value)
 		return config_error_nonbool(var);
@@ -714,7 +714,8 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.attributesfile"))
-		return git_config_pathname(&git_attributes_file, var, value);
+		return git_config_pathname((char **)&git_attributes_file,
+				var, value);
 
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
@@ -862,7 +863,7 @@ static int git_default_core_config(const char *var, const char *value)
 		return git_config_string(&askpass_program, var, value);
 
 	if (!strcmp(var, "core.excludesfile"))
-		return git_config_pathname(&excludes_file, var, value);
+		return git_config_pathname((char **)&excludes_file, var, value);
 
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
@@ -989,7 +990,8 @@ static int git_default_push_config(const char *var, const char *value)
 static int git_default_mailmap_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "mailmap.file"))
-		return git_config_pathname(&git_mailmap_file, var, value);
+		return git_config_pathname((char **)&git_mailmap_file,
+				var, value);
 	if (!strcmp(var, "mailmap.blob"))
 		return git_config_string(&git_mailmap_blob, var, value);
 
@@ -1506,7 +1508,7 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 {
 	const char *value;
 	if (!git_configset_get_value(cs, key, &value))
-		return git_config_pathname(dest, key, value);
+		return git_config_pathname((char **)dest, key, value);
 	else
 		return 1;
 }
diff --git a/diff.c b/diff.c
index 87b16d5..e029b75 100644
--- a/diff.c
+++ b/diff.c
@@ -204,7 +204,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.wordregex"))
 		return git_config_string(&diff_word_regex_cfg, var, value);
 	if (!strcmp(var, "diff.orderfile"))
-		return git_config_pathname(&diff_order_file_cfg, var, value);
+		return git_config_pathname((char **)&diff_order_file_cfg,
+				var, value);
 
 	if (!strcmp(var, "diff.ignoresubmodules"))
 		handle_ignore_submodules_arg(&default_diff_options, value);
