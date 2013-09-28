From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 38/44] ruby: bind diff_tree_sha1()
Date: Sat, 28 Sep 2013 17:04:03 -0500
Message-ID: <1380405849-13000-39-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2k3-00047C-L9
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab3I1WLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:55 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:41392 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab3I1WLw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:52 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so3047275oag.3
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KGW5K3JzuZWqwYN98u7mOgKpj0Z67kI4nw/JadUXnBQ=;
        b=Re/vtq4Yr80rkMs+orBiVjdt5c0WVxucK21Wf1xfsZvnbSfxXQj77mtiZIKMib+E2I
         Cq67t+zm8v+cyvZXtIb75dfgr7ofqukxXkLvrbtJUX7WpY2WpXjPPkBJ2hl6F/cS2BL6
         7Z/t2eFBgomIvr5tsok1CIYKuhpIhgVCdxGxpShkbroi2LRTG3XMlROh+x6/vyyxiwHE
         OZhrWfKB6h1u0P+00wPU6LFMe8bMiK28rVmXOWnMeSqnGGp4sayQeRZwYsZ/9NbS01s1
         5wnDq5y0Se3ugVmxjfO0IITiaM5RaxBGV4AnRHZFXtU8QaeY7iTYCAtXGIpfQ07kV947
         ur9A==
X-Received: by 10.60.43.131 with SMTP id w3mr12427392oel.10.1380406312251;
        Sat, 28 Sep 2013 15:11:52 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm19476825obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235558>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 ruby.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ruby.c b/ruby.c
index d59aafd..b491754 100644
--- a/ruby.c
+++ b/ruby.c
@@ -360,6 +360,17 @@ static VALUE git_rb_shortlog(VALUE self, VALUE commits)
 	return Qnil;
 }
 
+static VALUE git_rb_diff_tree_sha1(VALUE self, VALUE old, VALUE new, VALUE base, VALUE opt)
+{
+	struct diff_options *g_opt;
+	int r;
+
+	Data_Get_Struct(opt, struct diff_options, g_opt);
+
+	r = diff_tree_sha1(str_to_sha1(old), str_to_sha1(new), str_to_cstr(base), g_opt);
+	return INT2FIX(r);
+}
+
 static VALUE git_rb_diff_opt_new(VALUE class)
 {
 	struct diff_options *opt;
@@ -477,6 +488,7 @@ static void git_ruby_init(void)
 	rb_define_global_function("find_unique_abbrev", git_rb_find_unique_abbrev, 2);
 	rb_define_global_function("read_sha1_file", git_rb_read_sha1_file, 1);
 	rb_define_global_function("shortlog", git_rb_shortlog, 1);
+	rb_define_global_function("diff_tree_sha1", git_rb_diff_tree_sha1, 4);
 
 	git_rb_object = rb_define_class_under(mod, "Object", rb_cData);
 	rb_define_singleton_method(git_rb_object, "get", git_rb_object_get, 1);
-- 
1.8.4-fc
