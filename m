From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 39/44] ruby: bind log_tree_diff_flush()
Date: Sat, 28 Sep 2013 17:04:04 -0500
Message-ID: <1380405849-13000-40-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:12:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2k9-0004Ck-WC
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab3I1WMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:12:01 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:38749 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab3I1WL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:58 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp4so4152483obc.28
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ylVr9K8Qw8BpOuQjas2zn7shgvmzNEb2FJv/xRyoeDw=;
        b=VZVRRVwTcz8InaE60KdyqPV7ZPdJUovb0gpBK6zLKp21kqyWbu1ueXYvkIsuh2bk3i
         zOGJjEwcEzOmU7uxRXahnX/8biUT9FZQUoJeFsxcarTMX6fgC9m3eHN2R3RnImSDDq3R
         VhSwBfz9MQKctwbxtjsZqnuwnZewCuwjTMt9nQ/KkCpwIxO0F/9UR3DlmV2zM2z8nYQ9
         AuAGcNwtmis1hJ0gW6ai9B/cyWW0pYix9bmWaLcQVcxfCwQT7r1qnh1cG8KHDHnR6vxI
         XwQLUvvQmHsVYYO40wRO92a9u98bsadgdZJANV0K98RB82XpiYVCpPb9fV0vTaWuvvVM
         luNg==
X-Received: by 10.60.115.164 with SMTP id jp4mr12231615oeb.19.1380406317636;
        Sat, 28 Sep 2013 15:11:57 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm25489311oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235559>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 ruby.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ruby.c b/ruby.c
index b491754..71d5cb6 100644
--- a/ruby.c
+++ b/ruby.c
@@ -8,6 +8,7 @@
 #include "revision.h"
 #include "diff.h"
 #include "shortlog.h"
+#include "log-tree.h"
 
 #undef NORETURN
 #undef PATH_SEP
@@ -371,6 +372,16 @@ static VALUE git_rb_diff_tree_sha1(VALUE self, VALUE old, VALUE new, VALUE base,
 	return INT2FIX(r);
 }
 
+static VALUE git_rb_log_tree_diff_flush(VALUE self, VALUE revs)
+{
+	struct rev_info *g_revs;
+	int r;
+
+	Data_Get_Struct(revs, struct rev_info, g_revs);
+	r = log_tree_diff_flush(g_revs);
+	return INT2FIX(r);
+}
+
 static VALUE git_rb_diff_opt_new(VALUE class)
 {
 	struct diff_options *opt;
@@ -489,6 +500,7 @@ static void git_ruby_init(void)
 	rb_define_global_function("read_sha1_file", git_rb_read_sha1_file, 1);
 	rb_define_global_function("shortlog", git_rb_shortlog, 1);
 	rb_define_global_function("diff_tree_sha1", git_rb_diff_tree_sha1, 4);
+	rb_define_global_function("log_tree_diff_flush", git_rb_log_tree_diff_flush, 1);
 
 	git_rb_object = rb_define_class_under(mod, "Object", rb_cData);
 	rb_define_singleton_method(git_rb_object, "get", git_rb_object_get, 1);
-- 
1.8.4-fc
