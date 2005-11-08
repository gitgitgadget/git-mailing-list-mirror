From: Peter Hagervall <hager@cs.umu.se>
Subject: [PATCH] sparse fixes for http-{fetch,push}.c
Date: Tue, 8 Nov 2005 23:18:31 +0100
Message-ID: <20051108221830.GA14318@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 23:20:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZbnb-0007NC-0A
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 23:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVKHWSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 17:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbVKHWSg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 17:18:36 -0500
Received: from mail.cs.umu.se ([130.239.40.25]:29421 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1030331AbVKHWSf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 17:18:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 5EFC92D91;
	Tue,  8 Nov 2005 23:18:34 +0100 (MET)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 27157-01-10; Tue,  8 Nov 2005 23:18:31 +0100 (MET)
Received: from peppar.cs.umu.se (peppar.cs.umu.se [130.239.40.13])
	by mail.cs.umu.se (Postfix) with ESMTP id 2B5E42D89;
	Tue,  8 Nov 2005 23:18:31 +0100 (MET)
Received: by peppar.cs.umu.se (Postfix, from userid 12006)
	id 153A12EDA; Tue,  8 Nov 2005 23:18:31 +0100 (MET)
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11362>

Make a bunch of needlessly global functions static, and replace two
K&R-style declarations.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>
---

diff --git a/http-fetch.c b/http-fetch.c
index ea8af1b..88b74b4 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -569,7 +569,7 @@ static void release_request(struct trans
 }
 
 #ifdef USE_CURL_MULTI
-void process_curl_messages(void)
+static void process_curl_messages(void)
 {
 	int num_messages;
 	struct active_request_slot *slot;
@@ -625,7 +625,7 @@ void process_curl_messages(void)
 	}
 }
 
-void process_request_queue(void)
+static void process_request_queue(void)
 {
 	struct transfer_request *request = request_queue_head;
 	struct active_request_slot *slot = active_queue_head;
diff --git a/http-push.c b/http-push.c
index 0b90fb9..8866189 100644
--- a/http-push.c
+++ b/http-push.c
@@ -595,7 +595,7 @@ static void start_move(struct transfer_r
 	}
 }
 
-int refresh_lock(struct active_lock *lock)
+static int refresh_lock(struct active_lock *lock)
 {
 	struct active_request_slot *slot;
 	char *if_header;
@@ -726,7 +726,7 @@ static void release_request(struct trans
 }
 
 #ifdef USE_CURL_MULTI
-void process_curl_messages(void)
+static void process_curl_messages(void)
 {
 	int num_messages;
 	struct active_request_slot *slot;
@@ -766,7 +766,7 @@ void process_curl_messages(void)
 	}
 }
 
-void process_request_queue(void)
+static void process_request_queue(void)
 {
 	struct transfer_request *request = request_queue_head;
 	struct active_request_slot *slot = active_queue_head;
@@ -799,7 +799,7 @@ void process_request_queue(void)
 }
 #endif
 
-void process_waiting_requests(void)
+static void process_waiting_requests(void)
 {
 	struct active_request_slot *slot = active_queue_head;
 
@@ -812,7 +812,7 @@ void process_waiting_requests(void)
 		}
 }
 
-void add_request(unsigned char *sha1, struct active_lock *lock)
+static void add_request(unsigned char *sha1, struct active_lock *lock)
 {
 	struct transfer_request *request = request_queue_head;
 	struct packed_git *target;
@@ -939,7 +939,7 @@ static int setup_index(unsigned char *sh
 	return 0;
 }
 
-static int fetch_indices()
+static int fetch_indices(void)
 {
 	unsigned char sha1[20];
 	char *url;
@@ -1189,7 +1189,7 @@ end_lockprop_element(void *userData, con
 	}
 }
 
-struct active_lock *lock_remote(char *file, long timeout)
+static struct active_lock *lock_remote(char *file, long timeout)
 {
 	struct active_request_slot *slot;
 	struct buffer out_buffer;
@@ -1318,7 +1318,7 @@ struct active_lock *lock_remote(char *fi
 	return new_lock;
 }
 
-int unlock_remote(struct active_lock *lock)
+static int unlock_remote(struct active_lock *lock)
 {
 	struct active_request_slot *slot;
 	char *lock_token_header;
@@ -1359,7 +1359,7 @@ int unlock_remote(struct active_lock *lo
 	return rc;
 }
 
-int check_locking()
+static int check_locking(void)
 {
 	struct active_request_slot *slot;
 	struct buffer in_buffer;
@@ -1425,7 +1425,7 @@ int check_locking()
 		return 1;
 }
 
-int is_ancestor(unsigned char *sha1, struct commit *commit)
+static int is_ancestor(unsigned char *sha1, struct commit *commit)
 {
 	struct commit_list *parents;
 
@@ -1446,8 +1446,8 @@ int is_ancestor(unsigned char *sha1, str
 	return 0;
 }
 
-void get_delta(unsigned char *sha1, struct object *obj,
-	       struct active_lock *lock)
+static void get_delta(unsigned char *sha1, struct object *obj,
+		      struct active_lock *lock)
 {
 	struct commit *commit;
 	struct commit_list *parents;
@@ -1503,7 +1503,7 @@ void get_delta(unsigned char *sha1, stru
 	}
 }
 
-int update_remote(unsigned char *sha1, struct active_lock *lock)
+static int update_remote(unsigned char *sha1, struct active_lock *lock)
 {
 	struct active_request_slot *slot;
 	char *out_data;
