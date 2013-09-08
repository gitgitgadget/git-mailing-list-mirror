From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/14] index-pack: add more comments on some big functions
Date: Sun,  8 Sep 2013 14:22:29 +0700
Message-ID: <1378624960-8919-4-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:19:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZHp-0003hh-Lh
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785Ab3IHHTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:19:54 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:63761 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHTx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:19:53 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so4896441pbb.28
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2DZi+Sizz/cDoUcocWIi9/kXcHiPGN5I2W5hE3GKc8=;
        b=yvXvvy0eSw5TK3gCV4e7qFA0z8KrvQ1Ga+xuWIeCEfS48TbxaAjeDh0eTjAPGIzgCK
         LRxUSSKa3LCV/4LVrFalZZc6uGjCsYNBpBR5T4dUqQCNxnEmhqhlGR0FQwfZ0xUDShiN
         uBJWktJ6maBwD5/8dgGFjeB8iduRE3POBXFj/587H9zAxKFEG7wMS3UTHkP3iYqe9dXA
         xvsZMc/9ZAe57QvVSinv2juva3MwHoYZjWXIwujeTpD+DVjO8k3Fd/XRSEazRjLshSsv
         311xEypa9kx6e96HarNzKXVXjYLx33YQzS3oaq6r2p4HcgbAGsRyKLyiN2waVNt6yF4T
         VhaQ==
X-Received: by 10.66.118.71 with SMTP id kk7mr13507309pab.14.1378624792943;
        Sun, 08 Sep 2013 00:19:52 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id fa4sm9295333pab.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:19:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:01 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234200>

---
 builtin/index-pack.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9c1cfac..1dbabe0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -19,8 +19,8 @@ struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;
 	unsigned int hdr_size;
-	enum object_type type;
-	enum object_type real_type;
+	enum object_type type;	/* type as written in pack */
+	enum object_type real_type; /* type after delta resolving */
 	unsigned delta_depth;
 	int base_object_no;
 };
@@ -187,8 +187,10 @@ static int mark_link(struct object *obj, int type, void *data)
 	return 0;
 }
 
-/* The content of each linked object must have been checked
-   or it must be already present in the object database */
+/*
+ * The content of each linked object must have been checked or it must
+ * be already present in the object database
+ */
 static unsigned check_object(struct object *obj)
 {
 	if (!obj)
@@ -407,6 +409,11 @@ static int is_delta_type(enum object_type type)
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
 }
 
+/*
+ * Unpack an entry data in the streamed pack, calculate the object
+ * SHA-1 if it's not a large blob. Otherwise just try to inflate the
+ * object to /dev/null to determine the end of the entry in the pack.
+ */
 static void *unpack_entry_data(unsigned long offset, unsigned long size,
 			       enum object_type type, unsigned char *sha1)
 {
@@ -522,6 +529,11 @@ static void *unpack_raw_entry(struct object_entry *obj,
 	return data;
 }
 
+/*
+ * Unpack entry data in the second pass when the pack is already
+ * stored on disk. consume call back is used for large-blob case. Must
+ * be thread safe.
+ */
 static void *unpack_data(struct object_entry *obj,
 			 int (*consume)(const unsigned char *, unsigned long, void *),
 			 void *cb_data)
@@ -875,6 +887,11 @@ static void resolve_delta(struct object_entry *delta_obj,
 	counter_unlock();
 }
 
+/*
+ * Given a base object, search for all objects depending on the base,
+ * try to unpack one of those object. The function will be called
+ * repeatedly until all objects are unpacked.
+ */
 static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 						  struct base_data *prev_base)
 {
@@ -958,6 +975,10 @@ static int compare_delta_entry(const void *a, const void *b)
 				   objects[delta_b->obj_no].type);
 }
 
+/*
+ * Unpack all objects depending directly or indirectly on the given
+ * object
+ */
 static void resolve_base(struct object_entry *obj)
 {
 	struct base_data *base_obj = alloc_base_data();
@@ -967,6 +988,7 @@ static void resolve_base(struct object_entry *obj)
 }
 
 #ifndef NO_PTHREADS
+/* Call resolve_base() in multiple threads */
 static void *threaded_second_pass(void *data)
 {
 	set_thread_data(data);
-- 
1.8.2.83.gc99314b
