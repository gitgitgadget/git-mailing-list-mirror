From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 18/44] ruby: bind read_ref()/peel_ref()
Date: Sat, 28 Sep 2013 17:03:43 -0500
Message-ID: <1380405849-13000-19-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2j7-0003Og-NJ
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab3I1WK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:57 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:50114 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab3I1WKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:53 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so3055178oag.14
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zT5st8sJOOZ1KbVduKZqL+OQAtVaxWixChCQuISArBs=;
        b=TvILEDmahp9oB0IlQG3k578MwXL7qjNmpCfrcfmqrvjZXz2CK8zNDbzp6RGrpYOyat
         2BdSQV2C3ul1ijiE7a0JK3qhQpigPkJVf3bVPYEMN0qbc2uyXjXsJwR0o3sLafinHkYs
         kaL8COdFycogk5v79xYDHdZBK22SWDMO7d9IZpM70ma4uKXDdkc/3QjEy9IWnXQRY1fq
         wxIjQPgFStFiu/wuFPwFCqoXwf8ZumhHDXDu2KiLk5MGQzOoev2wA0vYoCPSQSDkA6BL
         d2C+CdVUZDvS4uApoP9MqVe6IAqP4b3iTCOg2elG/pF9wNW63M7+7BqQLOael7+4LWOm
         UWVw==
X-Received: by 10.182.129.201 with SMTP id ny9mr12516609obb.0.1380406252885;
        Sat, 28 Sep 2013 15:10:52 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm25483546oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235538>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 ruby.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/ruby.c b/ruby.c
index 36de943..92c636c 100644
--- a/ruby.c
+++ b/ruby.c
@@ -65,12 +65,30 @@ static VALUE git_rb_git_config(VALUE self)
 	return INT2FIX(r);
 }
 
+static VALUE git_rb_read_ref(VALUE self, VALUE refname)
+{
+	unsigned char sha1[20];
+	if (read_ref(RSTRING_PTR(refname), sha1))
+		return Qnil;
+	return sha1_to_str(sha1);
+}
+
+static VALUE git_rb_peel_ref(VALUE self, VALUE refname)
+{
+	unsigned char sha1[20];
+	if (peel_ref(RSTRING_PTR(refname), sha1))
+		return Qnil;
+	return sha1_to_str(sha1);
+}
+
 static void git_ruby_init(void)
 {
 	rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
 	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
 	rb_define_global_function("dwim_ref", git_rb_dwim_ref, 1);
 	rb_define_global_function("git_config", git_rb_git_config, 0);
+	rb_define_global_function("read_ref", git_rb_read_ref, 1);
+	rb_define_global_function("peel_ref", git_rb_peel_ref, 1);
 }
 
 static int run_ruby_command(const char *cmd, int argc, const char **argv)
-- 
1.8.4-fc
