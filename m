From: John Szakmeister <john@szakmeister.net>
Subject: [PATCH v3] contrib/git-credential-gnome-keyring.c: small stylistic cleanups
Date: Sat, 14 Dec 2013 06:21:26 -0500
Message-ID: <1387020086-92690-1-git-send-email-john@szakmeister.net>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	John Szakmeister <john@szakmeister.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 14 12:22:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrnIT-0002aG-E8
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 12:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab3LNLWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 06:22:08 -0500
Received: from mail-qe0-f41.google.com ([209.85.128.41]:39212 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab3LNLWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 06:22:07 -0500
Received: by mail-qe0-f41.google.com with SMTP id gh4so2497857qeb.14
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 03:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=XxVgQCAQn2D7FJPt2tSsab7WSIdYBxuYcCf3GpwzqFU=;
        b=djpU8DQxi3RNf5HzVhgSIewL7x3E80Lhs4ABu929pEZS1ccqmQdW7q30+2OECn4XQL
         19JZpHYcTyWYO+xgkdhxsjirDsBdd/aQnLQE5Fe5xp8pZXROxE7pPkndNrkm1/iQjNU/
         u461saOAf0KkrLz/RmGEjIFojns2Dge73Ju/ys33sbDtzWLqoYkndDydAq2TU5Nf9Cek
         6b1i1FkOLRakl3hl6+e9QqitvazVuFrQToG/d3BXX38mDkzHWBrQYM85GN3T9DtM8nFZ
         y5YVhaNPF8Ph6H3s6zRDItT9aKH4cSQi6ZdFSRzjesfvj2w7oY22v1SO3QT+IEgLDq93
         4lkw==
X-Received: by 10.224.148.9 with SMTP id n9mr13866758qav.32.1387020126499;
        Sat, 14 Dec 2013 03:22:06 -0800 (PST)
Received: from localhost.localdomain (pool-173-59-254-58.bltmmd.fios.verizon.net. [173.59.254.58])
        by mx.google.com with ESMTPSA id f10sm16615640qej.1.2013.12.14.03.22.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 03:22:05 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239304>

Signed-off-by: John Szakmeister <john@szakmeister.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Thanks for the extra patch Junio.  I incorporated it and fixed a
few other minor violations I found afterwards.  This version
builds on the first version of the patch--without dropping the
gpointer casts.

-John

 .../gnome-keyring/git-credential-gnome-keyring.c   | 85 ++++++++++------------
 1 file changed, 39 insertions(+), 46 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 635c96b..2a317fc 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -60,7 +60,7 @@
 #define gnome_keyring_memory_free gnome_keyring_free_password
 #define gnome_keyring_memory_strdup g_strdup
 
-static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
+static const char *gnome_keyring_result_to_message(GnomeKeyringResult result)
 {
 	switch (result) {
 	case GNOME_KEYRING_RESULT_OK:
@@ -95,9 +95,9 @@ static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
 
 static void gnome_keyring_done_cb(GnomeKeyringResult result, gpointer user_data)
 {
-	gpointer *data = (gpointer*) user_data;
-	int *done = (int*) data[0];
-	GnomeKeyringResult *r = (GnomeKeyringResult*) data[1];
+	gpointer *data = (gpointer *)user_data;
+	int *done = (int *)data[0];
+	GnomeKeyringResult *r = (GnomeKeyringResult *)data[1];
 
 	*r = result;
 	*done = 1;
@@ -130,34 +130,30 @@ static GnomeKeyringResult gnome_keyring_item_delete_sync(const char *keyring, gu
 /*
  * This credential struct and API is simplified from git's credential.{h,c}
  */
-struct credential
-{
-	char          *protocol;
-	char          *host;
+struct credential {
+	char *protocol;
+	char *host;
 	unsigned short port;
-	char          *path;
-	char          *username;
-	char          *password;
+	char *path;
+	char *username;
+	char *password;
 };
 
-#define CREDENTIAL_INIT \
-  { NULL,NULL,0,NULL,NULL,NULL }
+#define CREDENTIAL_INIT { NULL, NULL, 0, NULL, NULL, NULL }
 
-typedef int (*credential_op_cb)(struct credential*);
+typedef int (*credential_op_cb)(struct credential *);
 
-struct credential_operation
-{
-	char             *name;
+struct credential_operation {
+	char *name;
 	credential_op_cb op;
 };
 
-#define CREDENTIAL_OP_END \
-  { NULL,NULL }
+#define CREDENTIAL_OP_END { NULL, NULL }
 
 /* ----------------- GNOME Keyring functions ----------------- */
 
 /* create a special keyring option string, if path is given */
-static char* keyring_object(struct credential *c)
+static char *keyring_object(struct credential *c)
 {
 	if (!c->path)
 		return NULL;
@@ -170,7 +166,7 @@ static char* keyring_object(struct credential *c)
 
 static int keyring_get(struct credential *c)
 {
-	char* object = NULL;
+	char *object = NULL;
 	GList *entries;
 	GnomeKeyringNetworkPasswordData *password_data;
 	GnomeKeyringResult result;
@@ -204,7 +200,7 @@ static int keyring_get(struct credential *c)
 	}
 
 	/* pick the first one from the list */
-	password_data = (GnomeKeyringNetworkPasswordData *) entries->data;
+	password_data = (GnomeKeyringNetworkPasswordData *)entries->data;
 
 	gnome_keyring_memory_free(c->password);
 	c->password = gnome_keyring_memory_strdup(password_data->password);
@@ -221,7 +217,7 @@ static int keyring_get(struct credential *c)
 static int keyring_store(struct credential *c)
 {
 	guint32 item_id;
-	char  *object = NULL;
+	char *object = NULL;
 	GnomeKeyringResult result;
 
 	/*
@@ -262,7 +258,7 @@ static int keyring_store(struct credential *c)
 
 static int keyring_erase(struct credential *c)
 {
-	char  *object = NULL;
+	char *object = NULL;
 	GList *entries;
 	GnomeKeyringNetworkPasswordData *password_data;
 	GnomeKeyringResult result;
@@ -298,22 +294,20 @@ static int keyring_erase(struct credential *c)
 	if (result == GNOME_KEYRING_RESULT_CANCELLED)
 		return EXIT_SUCCESS;
 
-	if (result != GNOME_KEYRING_RESULT_OK)
-	{
+	if (result != GNOME_KEYRING_RESULT_OK) {
 		g_critical("%s", gnome_keyring_result_to_message(result));
 		return EXIT_FAILURE;
 	}
 
 	/* pick the first one from the list (delete all matches?) */
-	password_data = (GnomeKeyringNetworkPasswordData *) entries->data;
+	password_data = (GnomeKeyringNetworkPasswordData *)entries->data;
 
 	result = gnome_keyring_item_delete_sync(
 		password_data->keyring, password_data->item_id);
 
 	gnome_keyring_network_password_list_free(entries);
 
-	if (result != GNOME_KEYRING_RESULT_OK)
-	{
+	if (result != GNOME_KEYRING_RESULT_OK) {
 		g_critical("%s", gnome_keyring_result_to_message(result));
 		return EXIT_FAILURE;
 	}
@@ -325,9 +319,8 @@ static int keyring_erase(struct credential *c)
  * Table with helper operation callbacks, used by generic
  * credential helper main function.
  */
-static struct credential_operation const credential_helper_ops[] =
-{
-	{ "get",   keyring_get   },
+static struct credential_operation const credential_helper_ops[] = {
+	{ "get",   keyring_get },
 	{ "store", keyring_store },
 	{ "erase", keyring_erase },
 	CREDENTIAL_OP_END
@@ -353,24 +346,23 @@ static void credential_clear(struct credential *c)
 
 static int credential_read(struct credential *c)
 {
-	char    *buf;
+	char *buf;
 	size_t line_len;
-	char   *key;
-	char   *value;
+	char *key;
+	char *value;
 
 	key = buf = gnome_keyring_memory_alloc(1024);
 
-	while (fgets(buf, 1024, stdin))
-	{
+	while (fgets(buf, 1024, stdin)) {
 		line_len = strlen(buf);
 
 		if (line_len && buf[line_len-1] == '\n')
-			buf[--line_len]='\0';
+			buf[--line_len] = '\0';
 
 		if (!line_len)
 			break;
 
-		value = strchr(buf,'=');
+		value = strchr(buf, '=');
 		if (!value) {
 			g_warning("invalid credential line: %s", key);
 			gnome_keyring_memory_free(buf);
@@ -384,7 +376,7 @@ static int credential_read(struct credential *c)
 		} else if (!strcmp(key, "host")) {
 			g_free(c->host);
 			c->host = g_strdup(value);
-			value = strrchr(c->host,':');
+			value = strrchr(c->host, ':');
 			if (value) {
 				*value++ = '\0';
 				c->port = atoi(value);
@@ -398,7 +390,8 @@ static int credential_read(struct credential *c)
 		} else if (!strcmp(key, "password")) {
 			gnome_keyring_memory_free(c->password);
 			c->password = gnome_keyring_memory_strdup(value);
-			while (*value) *value++ = '\0';
+			while (*value)
+				*value++ = '\0';
 		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
@@ -429,16 +422,16 @@ static void credential_write(const struct credential *c)
 static void usage(const char *name)
 {
 	struct credential_operation const *try_op = credential_helper_ops;
-	const char *basename = strrchr(name,'/');
+	const char *basename = strrchr(name, '/');
 
 	basename = (basename) ? basename + 1 : name;
 	fprintf(stderr, "usage: %s <", basename);
 	while (try_op->name) {
-		fprintf(stderr,"%s",(try_op++)->name);
+		fprintf(stderr, "%s", (try_op++)->name);
 		if (try_op->name)
-			fprintf(stderr,"%s","|");
+			fprintf(stderr, "%s", "|");
 	}
-	fprintf(stderr,"%s",">\n");
+	fprintf(stderr, "%s", ">\n");
 }
 
 int main(int argc, char *argv[])
@@ -446,7 +439,7 @@ int main(int argc, char *argv[])
 	int ret = EXIT_SUCCESS;
 
 	struct credential_operation const *try_op = credential_helper_ops;
-	struct credential                  cred   = CREDENTIAL_INIT;
+	struct credential cred = CREDENTIAL_INIT;
 
 	if (!argv[1]) {
 		usage(argv[0]);
-- 
1.8.3.1
