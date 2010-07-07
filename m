From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/13] Add debug editor from Subversion trunk
Date: Wed,  7 Jul 2010 02:14:43 +0200
Message-ID: <1278461693-3828-4-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 02:13:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWIGm-0004kM-F4
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 02:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab0GGAN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 20:13:28 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39519 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab0GGAN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 20:13:27 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1968051ewy.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 17:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=t2QTA4MDIrWEN4zEbqqzQmZy3aaFktzHP9338YkZxIo=;
        b=SYuCVc+zDlsZRGN97DhNuOxbg8YlGZY0sQq8RZQAwp/n9VnZY5UwDDuDjBnB8qiVEj
         X/sEd08aAkExkqjuaankmevASL6wcViDLwkdLjeI96M+iYXJMFL1Ib2E4GLEI7D/ld1t
         GpC5VA29xm5UtrAXrrtLDR8S7KBlku9iSMo4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BZ+hK2O8fNpifrk9dIUVHUIvA7Hp3JaU0qhC0ftqSkeq/mCn4pTsS4qIwmJ3nuSfwX
         hBtFQeFRCs5brn59aPneSA4AACtd6jDqygg4nou2DYS6gIm/T299h3OS1p2HlQ0iBm80
         v66CEVg1oDZxBkRNWb/C19KsTsq86ms6bEE9w=
Received: by 10.213.14.15 with SMTP id e15mr4801453eba.62.1278461606137;
        Tue, 06 Jul 2010 17:13:26 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm55853426eei.18.2010.07.06.17.13.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150423>

Add the debug editor from subversion/libsvn_delta/debug_editor.c along
with a header to expose the svn_delta__get_debug_editor function.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile       |    4 +-
 debug_editor.c |  402 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 debug_editor.h |   10 ++
 3 files changed, 414 insertions(+), 2 deletions(-)
 create mode 100644 debug_editor.c
 create mode 100644 debug_editor.h

diff --git a/Makefile b/Makefile
index a6022f7..e4d106e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 svndumpr: *.c *.h
-	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svndumpr.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
+	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svndumpr.c debug_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
 
 svndumpr_bench: *.c *.h
-	$(CC) -O2 -o $@ svndumpr.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
+	$(CC) -O2 -o $@ svndumpr.c debug_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
 
 clean:
 	$(RM) svndumpr svndumpr_bench
diff --git a/debug_editor.c b/debug_editor.c
new file mode 100644
index 0000000..8164477
--- /dev/null
+++ b/debug_editor.c
@@ -0,0 +1,402 @@
+/* Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+
+#include "debug_editor.h"
+
+struct edit_baton
+{
+	const svn_delta_editor_t *wrapped_editor;
+	void *wrapped_edit_baton;
+
+	int indent_level;
+
+	svn_stream_t *out;
+};
+
+struct dir_baton
+{
+	void *edit_baton;
+	void *wrapped_dir_baton;
+};
+
+struct file_baton
+{
+	void *edit_baton;
+	void *wrapped_file_baton;
+};
+
+static svn_error_t *write_indent(struct edit_baton *eb, apr_pool_t *pool)
+{
+	int i;
+
+	for (i = 0; i < eb->indent_level; ++i)
+		SVN_ERR(svn_stream_printf(eb->out, pool, " "));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *set_target_revision(void *edit_baton,
+					svn_revnum_t target_revision,
+					apr_pool_t *pool)
+{
+	struct edit_baton *eb = edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "set_target_revision : %ld\n",
+				  target_revision));
+
+	return eb->wrapped_editor->set_target_revision(eb->wrapped_edit_baton,
+						       target_revision,
+						       pool);
+}
+
+static svn_error_t *open_root(void *edit_baton,
+			      svn_revnum_t base_revision,
+			      apr_pool_t *pool,
+			      void **root_baton)
+{
+	struct edit_baton *eb = edit_baton;
+	struct dir_baton *dir_baton = apr_palloc(pool, sizeof(*dir_baton));
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "open_root : %ld\n",
+				  base_revision));
+	eb->indent_level++;
+
+	SVN_ERR(eb->wrapped_editor->open_root(eb->wrapped_edit_baton,
+					      base_revision,
+					      pool,
+					      &dir_baton->wrapped_dir_baton));
+
+	dir_baton->edit_baton = edit_baton;
+
+	*root_baton = dir_baton;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *delete_entry(const char *path,
+				 svn_revnum_t base_revision,
+				 void *parent_baton,
+				 apr_pool_t *pool)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "delete_entry : %s:%ld\n",
+				  path, base_revision));
+
+	return eb->wrapped_editor->delete_entry(path,
+						base_revision,
+						pb->wrapped_dir_baton,
+						pool);
+}
+
+static svn_error_t *add_directory(const char *path,
+				  void *parent_baton,
+				  const char *copyfrom_path,
+				  svn_revnum_t copyfrom_revision,
+				  apr_pool_t *pool,
+				  void **child_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	struct dir_baton *b = apr_palloc(pool, sizeof(*b));
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool,
+				  "add_directory : '%s' [from '%s':%ld]\n",
+				  path, copyfrom_path, copyfrom_revision));
+	eb->indent_level++;
+
+	SVN_ERR(eb->wrapped_editor->add_directory(path,
+						  pb->wrapped_dir_baton,
+						  copyfrom_path,
+						  copyfrom_revision,
+						  pool,
+						  &b->wrapped_dir_baton));
+
+	b->edit_baton = eb;
+	*child_baton = b;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *open_directory(const char *path,
+				   void *parent_baton,
+				   svn_revnum_t base_revision,
+				   apr_pool_t *pool,
+				   void **child_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	struct dir_baton *db = apr_palloc(pool, sizeof(*db));
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "open_directory : '%s':%ld\n",
+				  path, base_revision));
+	eb->indent_level++;
+
+	SVN_ERR(eb->wrapped_editor->open_directory(path,
+						   pb->wrapped_dir_baton,
+						   base_revision,
+						   pool,
+						   &db->wrapped_dir_baton));
+
+	db->edit_baton = eb;
+	*child_baton = db;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *add_file(const char *path,
+			     void *parent_baton,
+			     const char *copyfrom_path,
+			     svn_revnum_t copyfrom_revision,
+			     apr_pool_t *pool,
+			     void **file_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	struct file_baton *fb = apr_palloc(pool, sizeof(*fb));
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool,
+				  "add_file : '%s' [from '%s':%ld]\n",
+				  path, copyfrom_path, copyfrom_revision));
+
+	eb->indent_level++;
+
+	SVN_ERR(eb->wrapped_editor->add_file(path,
+					     pb->wrapped_dir_baton,
+					     copyfrom_path,
+					     copyfrom_revision,
+					     pool,
+					     &fb->wrapped_file_baton));
+
+	fb->edit_baton = eb;
+	*file_baton = fb;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *open_file(const char *path,
+			      void *parent_baton,
+			      svn_revnum_t base_revision,
+			      apr_pool_t *pool,
+			      void **file_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	struct file_baton *fb = apr_palloc(pool, sizeof(*fb));
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "open_file : '%s':%ld\n",
+				  path, base_revision));
+
+	eb->indent_level++;
+
+	SVN_ERR(eb->wrapped_editor->open_file(path,
+					      pb->wrapped_dir_baton,
+					      base_revision,
+					      pool,
+					      &fb->wrapped_file_baton));
+
+	fb->edit_baton = eb;
+	*file_baton = fb;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *apply_textdelta(void *file_baton,
+				    const char *base_checksum,
+				    apr_pool_t *pool,
+				    svn_txdelta_window_handler_t *handler,
+				    void **handler_baton)
+{
+	struct file_baton *fb = file_baton;
+	struct edit_baton *eb = fb->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "apply_textdelta : %s\n",
+				  base_checksum));
+
+	SVN_ERR(eb->wrapped_editor->apply_textdelta(fb->wrapped_file_baton,
+						    base_checksum,
+						    pool,
+						    handler,
+						    handler_baton));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *close_file(void *file_baton,
+			       const char *text_checksum,
+			       apr_pool_t *pool)
+{
+	struct file_baton *fb = file_baton;
+	struct edit_baton *eb = fb->edit_baton;
+
+	eb->indent_level--;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "close_file : %s\n",
+				  text_checksum));
+
+	SVN_ERR(eb->wrapped_editor->close_file(fb->wrapped_file_baton,
+					       text_checksum, pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *absent_file(const char *path,
+				void *file_baton,
+				apr_pool_t *pool)
+{
+	struct file_baton *fb = file_baton;
+	struct edit_baton *eb = fb->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "absent_file : %s\n", path));
+
+	SVN_ERR(eb->wrapped_editor->absent_file(path, fb->wrapped_file_baton,
+						pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *close_directory(void *dir_baton,
+				    apr_pool_t *pool)
+{
+	struct dir_baton *db = dir_baton;
+	struct edit_baton *eb = db->edit_baton;
+
+	eb->indent_level--;
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "close_directory\n"));
+
+	SVN_ERR(eb->wrapped_editor->close_directory(db->wrapped_dir_baton,
+						    pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *absent_directory(const char *path,
+				     void *dir_baton,
+				     apr_pool_t *pool)
+{
+	struct dir_baton *db = dir_baton;
+	struct edit_baton *eb = db->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "absent_directory : %s\n",
+				  path));
+
+	SVN_ERR(eb->wrapped_editor->absent_directory(path, db->wrapped_dir_baton,
+						     pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *change_file_prop(void *file_baton,
+				     const char *name,
+				     const svn_string_t *value,
+				     apr_pool_t *pool)
+{
+	struct file_baton *fb = file_baton;
+	struct edit_baton *eb = fb->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "change_file_prop : %s\n",
+				  name));
+
+	SVN_ERR(eb->wrapped_editor->change_file_prop(fb->wrapped_file_baton,
+						     name,
+						     value,
+						     pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *change_dir_prop(void *dir_baton,
+				    const char *name,
+				    const svn_string_t *value,
+				    apr_pool_t *pool)
+{
+	struct dir_baton *db = dir_baton;
+	struct edit_baton *eb = db->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "change_dir_prop : %s\n", name));
+
+	SVN_ERR(eb->wrapped_editor->change_dir_prop(db->wrapped_dir_baton,
+						    name,
+						    value,
+						    pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *close_edit(void *edit_baton,
+			       apr_pool_t *pool)
+{
+	struct edit_baton *eb = edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "close_edit\n"));
+
+	SVN_ERR(eb->wrapped_editor->close_edit(eb->wrapped_edit_baton, pool));
+
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *svn_delta__get_debug_editor(const svn_delta_editor_t **editor,
+					 void **edit_baton,
+					 const svn_delta_editor_t *wrapped_editor,
+					 void *wrapped_edit_baton,
+					 apr_pool_t *pool)
+{
+	svn_delta_editor_t *tree_editor = svn_delta_default_editor(pool);
+	struct edit_baton *eb = apr_palloc(pool, sizeof(*eb));
+	apr_file_t *errfp;
+	svn_stream_t *out;
+
+	apr_status_t apr_err = apr_file_open_stderr(&errfp, pool);
+	if (apr_err)
+		return svn_error_wrap_apr(apr_err, "Problem opening stderr");
+
+	out = svn_stream_from_aprfile2(errfp, TRUE, pool);
+
+	tree_editor->set_target_revision = set_target_revision;
+	tree_editor->open_root = open_root;
+	tree_editor->delete_entry = delete_entry;
+	tree_editor->add_directory = add_directory;
+	tree_editor->open_directory = open_directory;
+	tree_editor->change_dir_prop = change_dir_prop;
+	tree_editor->close_directory = close_directory;
+	tree_editor->absent_directory = absent_directory;
+	tree_editor->add_file = add_file;
+	tree_editor->open_file = open_file;
+	tree_editor->apply_textdelta = apply_textdelta;
+	tree_editor->change_file_prop = change_file_prop;
+	tree_editor->close_file = close_file;
+	tree_editor->absent_file = absent_file;
+	tree_editor->close_edit = close_edit;
+
+	eb->wrapped_editor = wrapped_editor;
+	eb->wrapped_edit_baton = wrapped_edit_baton;
+	eb->out = out;
+	eb->indent_level = 0;
+
+	*editor = tree_editor;
+	*edit_baton = eb;
+
+	return SVN_NO_ERROR;
+}
diff --git a/debug_editor.h b/debug_editor.h
new file mode 100644
index 0000000..a0d412a
--- /dev/null
+++ b/debug_editor.h
@@ -0,0 +1,10 @@
+#ifndef DEBUG_EDITOR_H_
+#define DEBUG_EDITOR_H_
+
+svn_error_t *svn_delta__get_debug_editor(const svn_delta_editor_t **editor,
+					 void **edit_baton,
+					 const svn_delta_editor_t *wrapped_editor,
+					 void *wrapped_edit_baton,
+					 apr_pool_t *pool);
+
+#endif
-- 
1.7.1
