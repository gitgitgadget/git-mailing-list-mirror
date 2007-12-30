From: =?ISO-8859-1?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>
Subject: git over webdav: what can I do for improving http-push ?
Date: Sun, 30 Dec 2007 23:59:15 +0100
Message-ID: <477822C3.9060002@gbarbier.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060905070808090803090307"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 00:20:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J97Rv-00087q-HI
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 00:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbXL3XTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 18:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753816AbXL3XTl
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 18:19:41 -0500
Received: from slow1-v.mail.gandi.net ([217.70.178.88]:50928 "EHLO
	slow1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbXL3XTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 18:19:40 -0500
X-Greylist: delayed 1216 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Dec 2007 18:19:39 EST
Received: from relay1-v.mail.gandi.net (relay1-v.mail.gandi.net [217.70.178.75])
	by slow1-v.mail.gandi.net (Postfix) with ESMTP id 12F6E688A89
	for <git@vger.kernel.org>; Sun, 30 Dec 2007 23:59:54 +0100 (CET)
Received: from localhost (mfilter4-v.gandi.net [217.70.178.38])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 27722362AF;
	Sun, 30 Dec 2007 23:59:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter4-v.mgt.gandi.net
Received: from relay1-v.mail.gandi.net ([217.70.178.75])
	by localhost (mfilter4-v.mgt.gandi.net [217.70.178.38]) (amavisd-new, port 10024)
	with ESMTP id oxR8cAW358td; Sun, 30 Dec 2007 23:30:34 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 87492362AA;
	Sun, 30 Dec 2007 23:59:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69382>

This is a multi-part message in MIME format.
--------------060905070808090803090307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi everybody.

I've just subscribed to the list, therefore I think it should be rude 
not to introduce myself. My name is Grégoire Barbier (non 
french-speaking people should call me Greg and don't bother with 
non-ascii characters), I'm working mainly as a consultant (using 
Powerpoint and wearing a tie) but have some personal and professional 
interest in programming, especially about middlewares. BTW I apologize 
for my poor english.

I'm using Git for a rather short time but enough to fall in love with 
it. For a few days I'm trying to use it over webdav, that is over 
http/https with write (push) access. As for me, the main rationale to 
use http(s) rather than git or ssh is to get through corporate 
firewalls, otherwise I would probably not bother with webdav.

With 1.5.3.6 and 1.5.4-rc2, I encounter severe issues that make me think 
that http-push is not totally ready for production. That's why I would 
like to have a discussion with some of you that use and maintain it, to 
see what I can do to improve it or to help you improve it.

Here are some issues I encountered:
- http-push does not release locks when failing due to syntax error 
(e.g. if one types "git push" instead of "git push origin master")
- http-push freezes with no message with urls not terminated by a slash
- http-push does not create directory for the object (objects/xx/) and 
if the directory exists, it does not actually push objects without 
having USE_CURL_MULTI defined (which is not the compilation default)

I've starting to look at the source code and make some little 
improvements, but I feel that I should rather discuss with you to 
understand why there are two rather independant modes in http-push 
(USE_CURL_MULTI or not) and what is the real target (I don't want to 
work twice, neither to mess up the work of someone else that would be 
currently reorginzing this part of the code).

I attached some patches I did against 1.5.4-rc2, but I'm not sure they 
are doing it the good way, so I wouldn't be suprised if you were not 
okay to apply them as is.

-- 
Grégoire Barbier - gb à gbarbier.org - +33 6 21 35 73 49

--------------060905070808090803090307
Content-Type: text/plain;
 name="0001-Removed-double-free-int-http-push.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Removed-double-free-int-http-push.c.patch"

>From 216f27db1f768fd80519a4e57dd835a1f497d902 Mon Sep 17 00:00:00 2001
From: Gregoire Barbier, gb at gbarbier dot org <gb@panoramix.(none)>
Date: Sun, 30 Dec 2007 17:45:54 +0100
Subject: [PATCH] Removed double-free() int http-push.c.

---
 http-push.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 64be904..55d0c94 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1979,7 +1979,6 @@ static int remote_exists(const char *path)
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		free(url);
 		if (results.http_code == 404)
 			ret = 0;
 		else if (results.curl_result == CURLE_OK)
@@ -1987,7 +1986,6 @@ static int remote_exists(const char *path)
 		else
 			fprintf(stderr, "HEAD HTTP error %ld\n", results.http_code);
 	} else {
-		free(url);
 		fprintf(stderr, "Unable to start HEAD request\n");
 	}
 
-- 
1.5.4.rc2.4.gcef60-dirty


--------------060905070808090803090307
Content-Type: text/plain;
 name="0002-Making-HTTP-push-more-robust-and-more-user-friendly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-Making-HTTP-push-more-robust-and-more-user-friendly.pat";
 filename*1="ch"

>From 70226905d8f1dd6ed7d953285a6ee693f1e87b65 Mon Sep 17 00:00:00 2001
From: Gregoire Barbier, gb at gbarbier dot org <gb@panoramix.(none)>
Date: Sun, 30 Dec 2007 17:48:07 +0100
Subject: [PATCH] Making HTTP push more robust and more user-friendly: - fail when info/refs exists and is already locked (avoiding some repository corruption) - warn if the URL does not end with '/' (since 302 is not yet handled) - more explicit error message when the URL or password is not set correctly (instead of "no DAV locking support") - DAV locking time of 1 minute instead of 10 minutes (avoid waiting 10 minutes for a orphan lock to expire)

---
 http-push.c |   17 ++++++++++++++++-
 http.c      |   25 +++++++++++++++++++++++++
 http.h      |    1 +
 3 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 55d0c94..c005903 100644
--- a/http-push.c
+++ b/http-push.c
@@ -57,7 +57,7 @@ enum XML_Status {
 #define PROPFIND_ALL_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:propfind xmlns:D=\"DAV:\">\n<D:allprop/>\n</D:propfind>"
 #define LOCK_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:lockinfo xmlns:D=\"DAV:\">\n<D:lockscope><D:exclusive/></D:lockscope>\n<D:locktype><D:write/></D:locktype>\n<D:owner>\n<D:href>mailto:%s</D:href>\n</D:owner>\n</D:lockinfo>"
 
-#define LOCK_TIME 600
+#define LOCK_TIME 60
 #define LOCK_REFRESH 30
 
 /* bits #0-15 in revision.h */
@@ -2224,6 +2224,16 @@ int main(int argc, char **argv)
 
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
+	/* Verify connexion string (agains bad URLs or password errors) */
+	if (remote->url && remote->url[strlen(remote->url)-1] != '/') {
+		fprintf(stderr, "Warning: remote URL does not end with a '/' which often leads to problems\n");
+	}
+	if (!http_test_connection(remote->url)) {
+		fprintf(stderr, "Error: cannot access to remote URL (maybe malformed URL, network error or bad credentials)\n");
+		rc = 1;
+		goto cleanup;
+	}
+
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
 		fprintf(stderr, "Error: no DAV locking support on remote repo %s\n", remote->url);
@@ -2239,6 +2249,11 @@ int main(int argc, char **argv)
 		info_ref_lock = lock_remote("info/refs", LOCK_TIME);
 		if (info_ref_lock)
 			remote->can_update_info_refs = 1;
+		else {
+			fprintf(stderr, "Error: cannot lock existing info/refs\n");
+			rc = 1;
+			goto cleanup;
+		}
 	}
 	if (remote->has_info_packs)
 		fetch_indices();
diff --git a/http.c b/http.c
index d2c11ae..8b04ae9 100644
--- a/http.c
+++ b/http.c
@@ -634,3 +634,28 @@ int http_fetch_ref(const char *base, const char *ref, unsigned char *sha1)
 	free(url);
 	return ret;
 }
+
+int http_test_connection(const char *url)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	struct active_request_slot *slot;
+	struct slot_results results;
+	int ret = 0;
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result == CURLE_OK)
+			ret = -1;
+		else
+			error("Cannot access to URL %s, return code %d", url, results.curl_result);
+	} else
+		error("Unable to start request");
+	strbuf_release(&buffer);
+	return ret;
+}
diff --git a/http.h b/http.h
index aeba930..b353007 100644
--- a/http.h
+++ b/http.h
@@ -77,6 +77,7 @@ extern void step_active_slots(void);
 
 extern void http_init(void);
 extern void http_cleanup(void);
+extern int http_test_connection(const char *url);
 
 extern int data_received;
 extern int active_requests;
-- 
1.5.4.rc2.4.gcef60-dirty


--------------060905070808090803090307
Content-Type: text/plain;
 name="0003-Releasing-webdav-lock-even-if-push-fails-because-of.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003-Releasing-webdav-lock-even-if-push-fails-because-of.pat";
 filename*1="ch"

>From e00ae0f4b9ed0e61088fa729a7cabbfcbd006b98 Mon Sep 17 00:00:00 2001
From: Gregoire Barbier, gb at gbarbier dot org <gb@panoramix.(none)>
Date: Sun, 30 Dec 2007 19:35:31 +0100
Subject: [PATCH] Releasing webdav lock even if push fails because of bad (or no) reference on command line.

---
 http-push.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/http-push.c b/http-push.c
index c005903..cbbf432 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2275,11 +2275,14 @@ int main(int argc, char **argv)
 	if (!remote_tail)
 		remote_tail = &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, (const char **) refspec, push_all))
-		return -1;
+		       nr_refspec, (const char **) refspec, push_all)) {
+		rc = -1;
+		goto cleanup;
+	}
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n");
-		return 0;
+		rc = 0;
+		goto cleanup;
 	}
 
 	new_refs = 0;
@@ -2410,10 +2413,10 @@ int main(int argc, char **argv)
 			fprintf(stderr, "Unable to update server info\n");
 		}
 	}
-	if (info_ref_lock)
-		unlock_remote(info_ref_lock);
 
  cleanup:
+	if (info_ref_lock)
+		unlock_remote(info_ref_lock);
 	free(remote);
 
 	curl_slist_free_all(no_pragma_header);
-- 
1.5.4.rc2.4.gcef60-dirty


--------------060905070808090803090307
Content-Type: text/plain;
 name="0004-Adding-define-DEFAULT_MAX_REQUESTS-for-USE_CURL_MUL.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0004-Adding-define-DEFAULT_MAX_REQUESTS-for-USE_CURL_MUL.pat";
 filename*1="ch"

>From cef60c7940008487547894855eeed34d2edeb48e Mon Sep 17 00:00:00 2001
From: Gregoire Barbier, gb at gbarbier dot org <gb@panoramix.(none)>
Date: Sun, 30 Dec 2007 21:30:25 +0100
Subject: [PATCH] Adding #define DEFAULT_MAX_REQUESTS for USE_CURL_MULTI mode

---
 http.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 8b04ae9..7b1bcb8 100644
--- a/http.c
+++ b/http.c
@@ -4,6 +4,7 @@ int data_received;
 int active_requests = 0;
 
 #ifdef USE_CURL_MULTI
+#define DEFAULT_MAX_REQUESTS 4
 static int max_requests = -1;
 static CURLM *curlm;
 #endif
-- 
1.5.4.rc2.4.gcef60-dirty


--------------060905070808090803090307
Content-Type: text/plain;
 name="0005-Moving-ifdef-endif-for-making-USE_CURL_MULTI-code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0005-Moving-ifdef-endif-for-making-USE_CURL_MULTI-code.patch"

>From b34d81c1fff43a806cb91615effd00e424bd0e6b Mon Sep 17 00:00:00 2001
From: Gregoire Barbier, gb at gbarbier dot org <gb@panoramix.(none)>
Date: Sun, 30 Dec 2007 23:40:18 +0100
Subject: [PATCH] Moving #ifdef/#endif for making USE_CURL_MULTI code more visible.

---
 http-push.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 http-push.c

diff --git a/http-push.c b/http-push.c
old mode 100644
new mode 100755
index cbbf432..6dd3c45
--- a/http-push.c
+++ b/http-push.c
@@ -116,10 +116,12 @@ struct transfer_request
 	struct remote_lock *lock;
 	struct curl_slist *headers;
 	struct buffer buffer;
+#ifdef USE_CURL_MULTI
 	char filename[PATH_MAX];
 	char tmpfile[PATH_MAX];
 	int local_fileno;
 	FILE *local_stream;
+#endif
 	enum transfer_state state;
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
@@ -175,6 +177,7 @@ struct remote_ls_ctx
 	struct remote_ls_ctx *parent;
 };
 
+#ifdef USE_CURL_MULTI
 static void finish_request(struct transfer_request *request);
 static void release_request(struct transfer_request *request);
 
@@ -186,7 +189,6 @@ static void process_response(void *callback_data)
 	finish_request(request);
 }
 
-#ifdef USE_CURL_MULTI
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
 {
@@ -383,7 +385,6 @@ static void start_mkcol(struct transfer_request *request)
 		request->url = NULL;
 	}
 }
-#endif
 
 static void start_fetch_packed(struct transfer_request *request)
 {
@@ -581,6 +582,7 @@ static void start_move(struct transfer_request *request)
 		request->url = NULL;
 	}
 }
+#endif
 
 static int refresh_lock(struct remote_lock *lock)
 {
@@ -660,15 +662,18 @@ static void release_request(struct transfer_request *request)
 			entry->next = entry->next->next;
 	}
 
+#ifdef USE_CURL_MULTI
 	if (request->local_fileno != -1)
 		close(request->local_fileno);
 	if (request->local_stream)
 		fclose(request->local_stream);
+#endif
 	if (request->url != NULL)
 		free(request->url);
 	free(request);
 }
 
+#ifdef USE_CURL_MULTI
 static void finish_request(struct transfer_request *request)
 {
 	struct stat st;
@@ -793,7 +798,6 @@ static void finish_request(struct transfer_request *request)
 	}
 }
 
-#ifdef USE_CURL_MULTI
 static int fill_active_slot(void *unused)
 {
 	struct transfer_request *request = request_queue_head;
@@ -841,8 +845,10 @@ static void add_fetch_request(struct object *obj)
 	request->url = NULL;
 	request->lock = NULL;
 	request->headers = NULL;
+#ifdef USE_CURL_MULTI
 	request->local_fileno = -1;
 	request->local_stream = NULL;
+#endif
 	request->state = NEED_FETCH;
 	request->next = request_queue_head;
 	request_queue_head = request;
@@ -881,12 +887,13 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	request->url = NULL;
 	request->lock = lock;
 	request->headers = NULL;
+#ifdef USE_CURL_MULTI
 	request->local_fileno = -1;
 	request->local_stream = NULL;
+#endif
 	request->state = NEED_PUSH;
 	request->next = request_queue_head;
 	request_queue_head = request;
-
 #ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
-- 
1.5.4.rc2.4.gcef60-dirty


--------------060905070808090803090307--
