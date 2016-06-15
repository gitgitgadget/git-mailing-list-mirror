From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 06/11] http*: move common variables and macros to http.[ch]
Date: Sat, 16 May 2009 11:51:47 +0800
Message-ID: <20090516115147.22eba93b.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 05:56:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5B0T-0005js-VX
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756331AbZEPDzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 23:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756751AbZEPDzf
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:55:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:16840 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbZEPDzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 23:55:31 -0400
Received: by wa-out-1112.google.com with SMTP id j5so808043wah.21
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=bUjwAY7PAnsjsywvyr0jXIByqEpg2PaBlXi5KOA986Y=;
        b=V1kOjVZu2HZuxSR/M/2pfrn6FnjJdULVNiRTMFvPjq/4enKGcaRgUtMgpv/301+lNx
         AG3NTKFkej9uqRo9EYsU+Q14JOeOEGAsIv+l1jNCvsNqswoPdglAS4UpuQZBi5GsoIYN
         mLn6vPOwftKv89XyR2pThpaMJjmeKpLT+8m6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=bqRXmiuThLtH7j3uB5TlfDdGMSOSN5nkT+4+Ezwl769+NypIj9AAG6nQqob9FtAU0y
         O/bibWbEN41TRsDqo3P/GqJZSlxcCHDLBi3NkjyhUo8OxtNwTBSjFgXO3Jq+Na3khdQv
         jYYYi+ToXZdg67iue7QtuIYKLJDM2jLEZbxik=
Received: by 10.115.91.2 with SMTP id t2mr6211737wal.224.1242446133009;
        Fri, 15 May 2009 20:55:33 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id k21sm2176090waf.6.2009.05.15.20.55.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 20:55:32 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119328>

 *RANGE_HEADER_SIZE has been moved to http.h.

 *the curl header list, no_pragma_header, containing the header
  "Pragma:", has been created in http.[ch]. It is allocated in
  http_init, and freed in http_cleanup. It replaces the similarly-named
  variable in http-push.c, and the no_pragma_header member in
  walker_data in http-walker.c.

 *the variable http_is_verbose is created. It is intended for use by
  methods in http.c, and is modified at the entry points of http.c's
  users, namely http-push.c (when parsing options) and http-walker.c
  (in get_http_walker).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |    8 +-------
 http-walker.c |   18 +++++-------------
 http.c        |    9 +++++++++
 http.h        |    5 +++++
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/http-push.c b/http-push.c
index 875b2c6..7cbc8cf 100644
--- a/http-push.c
+++ b/http-push.c
@@ -27,7 +27,6 @@ enum XML_Status {
 #endif
 
 #define PREV_BUF_SIZE 4096
-#define RANGE_HEADER_SIZE 30
 
 /* DAV methods */
 #define DAV_LOCK "LOCK"
@@ -76,8 +75,6 @@ static int pushing;
 static int aborted;
 static signed char remote_dir_exists[256];
 
-static struct curl_slist *no_pragma_header;
-
 static int push_verbosely;
 static int push_all = MATCH_REFS_NONE;
 static int force_all;
@@ -2226,6 +2223,7 @@ int main(int argc, char **argv)
 			}
 			if (!strcmp(arg, "--verbose")) {
 				push_verbosely = 1;
+				http_is_verbose = 1;
 				continue;
 			}
 			if (!strcmp(arg, "-d")) {
@@ -2275,8 +2273,6 @@ int main(int argc, char **argv)
 	remote->url[remote->url_nr++] = repo->url;
 	http_init(remote);
 
-	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
-
 	if (repo->url && repo->url[strlen(repo->url)-1] != '/') {
 		rewritten_url = xmalloc(strlen(repo->url)+2);
 		strcpy(rewritten_url, repo->url);
@@ -2482,8 +2478,6 @@ int main(int argc, char **argv)
 		unlock_remote(info_ref_lock);
 	free(repo);
 
-	curl_slist_free_all(no_pragma_header);
-
 	http_cleanup();
 
 	request = request_queue_head;
diff --git a/http-walker.c b/http-walker.c
index 8bf83d0..024ed58 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -5,7 +5,6 @@
 #include "http.h"
 
 #define PREV_BUF_SIZE 4096
-#define RANGE_HEADER_SIZE 30
 
 struct alt_base
 {
@@ -57,7 +56,6 @@ struct walker_data {
 	const char *url;
 	int got_alternates;
 	struct alt_base *alt;
-	struct curl_slist *no_pragma_header;
 };
 
 static struct object_request *object_queue_head;
@@ -108,7 +106,6 @@ static void start_object_request(struct walker *walker,
 	char range[RANGE_HEADER_SIZE];
 	struct curl_slist *range_header = NULL;
 	struct active_request_slot *slot;
-	struct walker_data *data = walker->data;
 
 	snprintf(prevfile, sizeof(prevfile), "%s.prev", obj_req->filename);
 	unlink(prevfile);
@@ -205,7 +202,7 @@ static void start_object_request(struct walker *walker,
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, obj_req->errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 
 	/*
 	 * If we have successfully processed data from a previous fetch
@@ -354,6 +351,8 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 	newreq->slot = NULL;
 	newreq->next = NULL;
 
+	http_is_verbose = walker->get_verbosely;
+
 	if (object_queue_head == NULL) {
 		object_queue_head = newreq;
 	} else {
@@ -379,7 +378,6 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
 	struct curl_slist *range_header = NULL;
-	struct walker_data *data = walker->data;
 
 	FILE *indexfile;
 	struct active_request_slot *slot;
@@ -430,7 +428,7 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, indexfile);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 	slot->local = indexfile;
 
 	/*
@@ -767,7 +765,6 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
 	struct curl_slist *range_header = NULL;
-	struct walker_data *data = walker->data;
 
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -801,7 +798,7 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, packfile);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 	slot->local = packfile;
 
 	/*
@@ -944,10 +941,7 @@ static int fetch_ref(struct walker *walker, struct ref *ref)
 
 static void cleanup(struct walker *walker)
 {
-	struct walker_data *data = walker->data;
 	http_cleanup();
-
-	curl_slist_free_all(data->no_pragma_header);
 }
 
 struct walker *get_http_walker(const char *url, struct remote *remote)
@@ -958,8 +952,6 @@ struct walker *get_http_walker(const char *url, struct remote *remote)
 
 	http_init(remote);
 
-	data->no_pragma_header = curl_slist_append(NULL, "Pragma:");
-
 	data->alt = xmalloc(sizeof(*data->alt));
 	data->alt->base = xmalloc(strlen(url) + 1);
 	strcpy(data->alt->base, url);
diff --git a/http.c b/http.c
index 2e3d649..3ca60bb 100644
--- a/http.c
+++ b/http.c
@@ -2,6 +2,7 @@
 
 int data_received;
 int active_requests;
+int http_is_verbose;
 
 #ifdef USE_CURL_MULTI
 static int max_requests = -1;
@@ -29,6 +30,8 @@ static char *user_name, *user_pass;
 
 static struct curl_slist *pragma_header;
 
+struct curl_slist *no_pragma_header;
+
 static struct active_request_slot *active_queue_head;
 
 size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb, void *buffer_)
@@ -276,6 +279,8 @@ void http_init(struct remote *remote)
 	char *low_speed_limit;
 	char *low_speed_time;
 
+	http_is_verbose = 0;
+
 	git_config(http_options, NULL);
 
 	curl_global_init(CURL_GLOBAL_ALL);
@@ -284,6 +289,7 @@ void http_init(struct remote *remote)
 		curl_http_proxy = xstrdup(remote->http_proxy);
 
 	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
+	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
 #ifdef USE_CURL_MULTI
 	{
@@ -366,6 +372,9 @@ void http_cleanup(void)
 	curl_slist_free_all(pragma_header);
 	pragma_header = NULL;
 
+	curl_slist_free_all(no_pragma_header);
+	no_pragma_header = NULL;
+
 	if (curl_http_proxy) {
 		free((void *)curl_http_proxy);
 		curl_http_proxy = NULL;
diff --git a/http.h b/http.h
index 26abebe..1ef7dc1 100644
--- a/http.h
+++ b/http.h
@@ -88,11 +88,16 @@ extern void add_fill_function(void *data, int (*fill)(void *));
 extern void step_active_slots(void);
 #endif
 
+extern struct curl_slist *no_pragma_header;
+
+#define RANGE_HEADER_SIZE 30
+
 extern void http_init(struct remote *remote);
 extern void http_cleanup(void);
 
 extern int data_received;
 extern int active_requests;
+extern int http_is_verbose;
 
 extern char curl_errorstr[CURL_ERROR_SIZE];
 
-- 
1.6.3.rc0
