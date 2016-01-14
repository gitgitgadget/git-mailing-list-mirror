From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 16/20] refs: check submodules ref storage config
Date: Thu, 14 Jan 2016 11:26:13 -0500
Message-ID: <1452788777-24954-17-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkjs-0002SK-KM
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784AbcANQ0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:54 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33417 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbcANQ0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:49 -0500
Received: by mail-qg0-f50.google.com with SMTP id b35so356512418qge.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Agd2SjSir1uVo7PqxqvO7IZ5klLcMTKg3N5APRPxfg=;
        b=IiwV5DfWXKkjr8OptoqTBW0wCziOm+w3id+GSGq5SjeYzXgG4UEbIBQrilsdMqJx+v
         422BbYq/Dt0idCF7t+T+91X3SP25rjJR8zljFw+d8enlnlszzt/LUBKfhP7IYmShgRJn
         uWovPRmv3HbGxYWo/D/BVvu9qDll0QjZUy1h+RL3cEQH9oNe8CE3Ue3gT43zaA5XRw6u
         1KBrMRtxsWTAbB90clAhc0sxWNx9HBSIyh6WeRUiykfjXeyTVG6S3K91fqE3rfNKN9i8
         9/nQqKlRudXUjx4/OWkh/2igSxoHRh82FwcRhsi2y3RkpguZKF5bPIeZYGZ1t0MruHHj
         JJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Agd2SjSir1uVo7PqxqvO7IZ5klLcMTKg3N5APRPxfg=;
        b=eEWCDAjGebxzMD72FQ+EAO9uIsc0Rzt0vDfZ8Ci9PuDWg/OSes+zK1Qg07829KKwUy
         FZCqXjOfTo013/cNRAFKu12i1uFzHnFYm+Lyqj6SCrOVZQDMmZnZH04CBupsYaacSRN2
         /CeEIiwYF+v0SIraoJGpJNCDake99eBnHu+I1ilQQyz5ySWE0LIHSmvgiqYCLOAxZuXz
         Cl56VaV/hhu/zehWw+9wJHstpPvE9WUPGy5P6Q8oA6iduEQQtm/A7LEqr2OJ+VnetcTN
         oZ0Rbn9kLt4rmY+K4t3U9F2m+9/7lok8O9pM88MFTUoKwuNprQTZQBOH8ptw0bOIe0+l
         TFhw==
X-Gm-Message-State: ALoCoQneAUzGg+MdQ6Lu6qo8HffKPIOtzYhuPKc5HDEectAq5jjVV2xrdjGkhWpGuXRZRFf6xXsEC8YO1zAQdlehy2JycAsmLA==
X-Received: by 10.140.42.20 with SMTP id b20mr6738015qga.16.1452788809182;
        Thu, 14 Jan 2016 08:26:49 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:48 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284041>

All submodules must have the same ref storage (for now).  Confirm that
this is so before attempting to do anything with submodule refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/refs.c b/refs.c
index 9f946d0..3d4c0a6 100644
--- a/refs.c
+++ b/refs.c
@@ -297,8 +297,44 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
+static int submodule_backend(const char *key, const char *value, void *data)
+{
+	char **path = data;
+	if (!strcmp(key, "extensions.refstorage"))
+		*path = xstrdup(value);
+	return 0;
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
 
@@ -309,6 +345,7 @@ int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
 }
 
@@ -319,6 +356,7 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
 
@@ -1366,6 +1404,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int resolve_gitlink_ref(const char *path, const char *refname,
 			unsigned char *sha1)
 {
+	check_submodule_backend(path);
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
 
@@ -1376,6 +1415,7 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return the_refs_backend->head_ref_submodule(submodule, fn, cb_data);
 }
 
@@ -1386,6 +1426,7 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return the_refs_backend->for_each_ref_submodule(submodule, fn, cb_data);
 }
 
@@ -1404,6 +1445,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 			      each_ref_fn fn, void *cb_data)
 {
+	check_submodule_backend(submodule);
 	return the_refs_backend->for_each_ref_in_submodule(submodule, prefix,
 							   fn, cb_data);
 }
-- 
2.4.2.749.g730654d-twtrsrc
