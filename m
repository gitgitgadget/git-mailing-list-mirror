From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 16/21] refs: check submodules ref storage config
Date: Mon, 11 Jan 2016 20:22:15 -0500
Message-ID: <1452561740-8668-17-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:22:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aInfk-0003L8-TH
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761904AbcALBWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:52 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35547 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761817AbcALBWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:51 -0500
Received: by mail-qg0-f53.google.com with SMTP id o11so417844453qge.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ct62rYp4wUxL0eiAHoLTnCuNuDM74LojSES4Ur5kHuc=;
        b=dQhaqKQg/KKh0sUtmETbZyTqZvgWvIPmve39Zs8QExeLWHiTaltK0/qJ1r3MPNKUuU
         JAQ1Da+yJ4suJW98sAkM81ElPtRP8xQky2q4dUU+zksW5ByDKVPX6+Up3BjQKic1fsWi
         Sr8cA31G/vTJ5aGss3hnDQlKVFc2hoPZ+CpSGn6iHhWg5YbVHRjP2xwzWd2xEolB3JfA
         pX7yDgD9UFdMhuFwr9SvcdDMhwEGX6OQ0fm3VhrbYqToY8zGbl5YkICTmU1HjZzIW1Al
         tvu/UTUmEjqDWc0OssmmiTkbUEitEy84aGwMkbB1e+PmamzEZrjbnDK+Tb3rwHiAM/0n
         tgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ct62rYp4wUxL0eiAHoLTnCuNuDM74LojSES4Ur5kHuc=;
        b=gTiu2ybkaUuV3K6l62lvVakvvpxsxuiY3z7qY3aqyBygFrqKBKPqJLqiCY1ESaXMMq
         oAcDn9l9fQPslt6WOwfvQIv0RpfUKdNDRxKUcfixCoxD04JwkRYNIwz5BK+tB0p2O8RN
         FmknPqqavoxwvI+5947b0wbjGJQ8zXWppFxDBLX9s9MWVr7fAIf5pQG64y5+Kd9ML/T2
         WqrRktaXy+1ettlhdbk2qzw/ejsRmTxvcBYwe6XsvEbAPjCazrVe0bpLyp5JHNRJJLCQ
         XzgwiIZgWuhrjPEDEi+UOkoOJt4JHCQsjTe3+NWozQp9KU+fffow5NGPlaH14W1zr3ux
         7c6g==
X-Gm-Message-State: ALoCoQnY6d0bz3OoywYwlGQ5dJFZOaSlq577r/ouoNSJ5zuu3iL2ILeTmiQX+syVecm+9KxbiQcMtiZdVEUorpl3xviog9+EtQ==
X-Received: by 10.141.6.131 with SMTP id i125mr46646558qhd.68.1452561770068;
        Mon, 11 Jan 2016 17:22:50 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:49 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283745>

All submodules must have the same ref storage (for now).  Confirm that
this is so before attempting to do anything with submodule refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/refs.c b/refs.c
index 07f1dab..1ccc7f6 100644
--- a/refs.c
+++ b/refs.c
@@ -297,8 +297,43 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
+static int submodule_backend(const char *key, const char *value, void *data)
+{
+	char **path = data;
+	if (!strcmp(key, "extensions.refstorage"))
+		*path = xstrdup(value);
+}
+
+static void check_submodule_backend(const char *submodule)
+{
+	struct strbuf sb = STRBUF_INIT;
+	char *submodule_storage_backend = xstrdup("files");
+
+	if (!submodule)
+		goto done;
+
+	strbuf_git_path_submodule(&sb, submodule, "%s", "");
+
+	if (!is_git_directory(sb.buf))
+		goto done;
+
+	strbuf_reset(&sb);
+	strbuf_git_path_submodule(&sb, submodule, "config");
+
+	git_config_from_file(submodule_backend, sb.buf,
+			     &submodule_storage_backend);
+	if (strcmp(submodule_storage_backend, ref_storage_backend))
+		die("Ref storage '%s' for submodule '%s' does not match our storage, '%s'",
+		    submodule_storage_backend, submodule, ref_storage_backend);
+
+done:
+	free(submodule_storage_backend);
+	strbuf_release(&sb);
+}
+
 int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
 }
 
@@ -309,6 +344,7 @@ int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
 }
 
@@ -319,6 +355,7 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
 
@@ -1369,6 +1406,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int resolve_gitlink_ref(const char *path, const char *refname,
 			unsigned char *sha1)
 {
+	check_submodule_backend(path);
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
 
@@ -1379,6 +1417,7 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return the_refs_backend->head_ref_submodule(submodule, fn, cb_data);
 }
 
@@ -1389,6 +1428,7 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return the_refs_backend->for_each_ref_submodule(submodule, fn, cb_data);
 }
 
@@ -1407,6 +1447,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 			      each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return the_refs_backend->for_each_ref_in_submodule(submodule, prefix,
 							   fn, cb_data);
 }
-- 
2.4.2.749.g730654d-twtrsrc
