From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 30/44] ruby: bind read_sha1_file()
Date: Sat, 28 Sep 2013 17:03:55 -0500
Message-ID: <1380405849-13000-31-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2je-0003o7-RF
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341Ab3I1WLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:30 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:42976 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab3I1WL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:28 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so2936796oag.24
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vfNor1o4PJ+ATD767b6rARGa8UYW+6Qe/Gdp0QipwBk=;
        b=a9PLarq6tO/GV/FxY58RNGB69mBSewGGSBPRRjY5fCTfCU1KZFJ7FIAAr5ZRHcaR1U
         DP93yaxguJbgxHVRj/KDOcgA7m1zXCapX37P6BmcMOTt8Lr6MNLOh1SSK+p3LGrVDIDB
         GjW0H+Kpxpl2Oy3H1klUQqUZyyLHgGrGYOH6ywN77rc+bff5jI9sqS2YBI2q2RKiMhId
         B2trhkzNgrELIUhtomF1YkaQhehEej/TSx/4fk5mN8KLJj+BdGQEUwSZ4yuKdFLvsuNQ
         tArCj1FgQ2tluKwWUdkV4uouAsZpOM6Ee4YaMUT/obJ6421WhNxgquelmjivK23CZqeX
         WPcg==
X-Received: by 10.60.17.136 with SMTP id o8mr12308109oed.7.1380406287531;
        Sat, 28 Sep 2013 15:11:27 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm25440305oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235548>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 ruby.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ruby.c b/ruby.c
index 7496c18..360515f 100644
--- a/ruby.c
+++ b/ruby.c
@@ -265,6 +265,18 @@ static VALUE git_rb_find_unique_abbrev(VALUE self, VALUE sha1, VALUE len)
 	return rb_str_new2(abbrev);
 }
 
+static VALUE git_rb_read_sha1_file(VALUE self, VALUE sha1, VALUE type)
+{
+	enum object_type g_type;
+	void *buffer;
+	unsigned long size;
+
+	buffer = read_sha1_file(str_to_sha1(sha1), &g_type, &size);
+	if (!buffer)
+		return Qnil;
+	return rb_ary_new3(2, rb_str_new(buffer, size), INT2FIX(g_type));
+}
+
 static void git_ruby_init(void)
 {
 	VALUE mod;
@@ -295,6 +307,7 @@ static void git_ruby_init(void)
 	rb_define_global_function("remote_get", git_rb_remote_get, 1);
 	rb_define_global_function("transport_get", git_rb_transport_get, 2);
 	rb_define_global_function("find_unique_abbrev", git_rb_find_unique_abbrev, 2);
+	rb_define_global_function("read_sha1_file", git_rb_read_sha1_file, 1);
 
 	git_rb_object = rb_define_class_under(mod, "Object", rb_cData);
 	rb_define_singleton_method(git_rb_object, "get", git_rb_object_get, 1);
-- 
1.8.4-fc
