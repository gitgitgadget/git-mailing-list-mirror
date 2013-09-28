From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 28/44] ruby: bind find_unique_abbrev()
Date: Sat, 28 Sep 2013 17:03:53 -0500
Message-ID: <1380405849-13000-29-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jj-0003sA-84
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349Ab3I1WLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:34 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:36949 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab3I1WLW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:22 -0400
Received: by mail-oa0-f48.google.com with SMTP id m6so3024820oag.35
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QTGp1biiBMzvVIQdXlrEfUS8wAjzh10ZCNyXezbNRCA=;
        b=aw3pN/D1dZnFosm1z1ADF49bZpu4ZLLZd4X0ly2u1ZkUqoBxRX8Te3d6uWJr22Zc2y
         X0r4EcX419bChNUs70/kJ/kzgNPHJChJDg9PZyKst2jNx5k2n1c2TV5aW/gMirmzuhFN
         YVCRfoF/UKRm7Wag9XREU1vKO5TzfMnP0thYZrxpUK9QTb2P1PV0h2i5LCZEUyyYlSMD
         v8NGc4urgWY2KbH/Qm+Sx+v4F3RAcSRhIVushZcBtPfuCx4AZRO2Kw8MoWiOjxApDmt7
         jQIzvNmJiGHWd+NzvhhGBvSDiCAyBy3GLMmKlAlzFiEHRdakP/0ZZe/SF/fip1dqiOLq
         17kA==
X-Received: by 10.182.88.129 with SMTP id bg1mr57519obb.36.1380406281534;
        Sat, 28 Sep 2013 15:11:21 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm19496515obc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235550>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 ruby.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/ruby.c b/ruby.c
index ee548dc..7496c18 100644
--- a/ruby.c
+++ b/ruby.c
@@ -258,6 +258,13 @@ static VALUE git_rb_ref_old_sha1(VALUE self)
 	return sha1_to_str(ref->old_sha1);
 }
 
+static VALUE git_rb_find_unique_abbrev(VALUE self, VALUE sha1, VALUE len)
+{
+	const char *abbrev;
+	abbrev = find_unique_abbrev(str_to_sha1(sha1), NUM2INT(len));
+	return rb_str_new2(abbrev);
+}
+
 static void git_ruby_init(void)
 {
 	VALUE mod;
@@ -275,6 +282,8 @@ static void git_ruby_init(void)
 	rb_define_global_const("OBJ_ANY", INT2FIX(OBJ_ANY));
 	rb_define_global_const("OBJ_MAX", INT2FIX(OBJ_MAX));
 
+	rb_define_global_const("DEFAULT_ABBREV", INT2FIX(DEFAULT_ABBREV));
+
 	rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
 	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
 	rb_define_global_function("dwim_ref", git_rb_dwim_ref, 1);
@@ -285,6 +294,7 @@ static void git_ruby_init(void)
 	rb_define_global_function("get_merge_bases", git_rb_get_merge_bases, 2);
 	rb_define_global_function("remote_get", git_rb_remote_get, 1);
 	rb_define_global_function("transport_get", git_rb_transport_get, 2);
+	rb_define_global_function("find_unique_abbrev", git_rb_find_unique_abbrev, 2);
 
 	git_rb_object = rb_define_class_under(mod, "Object", rb_cData);
 	rb_define_singleton_method(git_rb_object, "get", git_rb_object_get, 1);
-- 
1.8.4-fc
