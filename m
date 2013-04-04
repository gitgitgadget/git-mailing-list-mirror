From: John Koleszar <jkoleszar@google.com>
Subject: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu,  4 Apr 2013 09:01:33 -0700
Message-ID: <1365091293-23758-1-git-send-email-jkoleszar@google.com>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>,
	John Koleszar <jkoleszar@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 18:02:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmcD-0003zF-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 18:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762716Ab3DDQBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 12:01:49 -0400
Received: from mail-ia0-f201.google.com ([209.85.210.201]:33763 "EHLO
	mail-ia0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762698Ab3DDQBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 12:01:47 -0400
Received: by mail-ia0-f201.google.com with SMTP id t4so672380iag.4
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=oMyxT26UcrentiUXRuZL/3iL2ke3KnEbe6oEJ062yhg=;
        b=CRGm0I9bCOo1vBdN0FDPT2lUwh/wgxhlnTS/IZzGzaOrv+D9FlGs9UUDZUaTU/Mcbw
         tMldG9iSkfOJmY4biAhx86VRcX0SzSBSKgdTjrcjgUYsW7LKfDxgeOiV+UYocP20NdFt
         5eVNoI+uH69s1+Rt4uZBevBfBfulDpWdl+xfLYqs08udBSjyfWgWVWLxdq9nN8t5wE7H
         4kNhSV8jZRtYFNC9jHbvDg4NYTCJJ7TdOvx7sNjlBSwgBE4hYI1h2/cIa2g6Pf2Mo5Ht
         4mlbT0c9s9riVLmnEvvMt6vFwVqu4gO+07jkdU/xRAuC7FNqp8zy445lcrpZCJCiwng9
         oXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=oMyxT26UcrentiUXRuZL/3iL2ke3KnEbe6oEJ062yhg=;
        b=gys5wGcAK37FybTHwTeXYol62F1/aZTsRqtE+LSt5HSNRXAGiYVYZyGvcTXlOf8YtP
         ih2V8d90fth/JIAMfVtPIfx0yDCbr9OPp0+lFnBCUTtpeSJKzQOzy5C8/0HLiYpuqTeN
         7AU2f2Fhk2kE1W6gU+mfyGEhIcnIoLFDNaRS9z6/hmctV6mS7cN7GWhaI/w0uBQkkWG/
         uLD9eUOOUNneU3SKUad+13xzBLJAs6mROKShGEvTalhq/AzxJfCaWdi7A0OrvUDJLIqr
         WV+zbJBDWOVE1mr7qdA4xqsO/n//FeccBMHPnm6mSbU3Epxny7i+gL2q6gQFzqnubzsu
         u/HA==
X-Received: by 10.43.45.130 with SMTP id uk2mr5043684icb.28.1365091307210;
        Thu, 04 Apr 2013 09:01:47 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j7si1466617igc.3.2013.04.04.09.01.46
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Apr 2013 09:01:47 -0700 (PDT)
Received: from sigill.mtv.corp.google.com (sigill.mtv.corp.google.com [172.22.77.100])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 60D625A4005;
	Thu,  4 Apr 2013 09:01:46 -0700 (PDT)
Received: by sigill.mtv.corp.google.com (Postfix, from userid 105890)
	id DDFC2A0BB4; Thu,  4 Apr 2013 09:01:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3
In-Reply-To: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
X-Gm-Message-State: ALoCoQn+9fgmT8ZHqLwdF5Ugfvz3KafhJb2EvCE6r4G95sAN3ji7pZIuZbgB6OwTaLQwlS9VKpYNZn6r//kitRsut4PW3A9V+i4fjVxDSH8AlIghpWLQnYqf6eVJYt3Oi5D4WVhrATmYNnuWz7DBaH23EGLL17Gp+xBNPMOkGsUojKw/aKHTzQRkNSg6azwZ52md3y2DV1VJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220025>

Filter the list of refs returned via the dumb HTTP protocol according
to the active namespace, consistent with other clients of the
upload-pack service.

Signed-off-by: John Koleszar <jkoleszar@google.com>
---

Incorporate peff's suggested test, and Junio's comments. With regard to
whether it's sufficient to test for the presence of /ns/ without
testing the contents further, I think it is. The test uses ls-remote
as the gold standard, and the test verifies that what it gets back from
the http-backend matches what ls-remote sees on the local filesystem
without the http-backend, so I think we're covered under whatever tests
exist for ls-remote and upload-pack, in addition to the new tests peff
suggested. If you want more though, let me know.
 
http-backend.c                   |  9 ++++++---
 t/lib-httpd/apache.conf          |  5 +++++
 t/t5551-http-fetch.sh            | 22 ++++++++++++++++++++++
 t/t5560-http-backend-noserver.sh |  7 +++++++
 t/t5561-http-backend.sh          | 11 +++++++++++
 t/t556x_common                   | 28 ++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f50e77f..d32128f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -361,17 +361,19 @@ static void run_service(const char **argv)
 static int show_text_ref(const char *name, const unsigned char *sha1,
 	int flag, void *cb_data)
 {
+	const char *name_nons = strip_namespace(name);
 	struct strbuf *buf = cb_data;
 	struct object *o = parse_object(sha1);
 	if (!o)
 		return 0;
 
-	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name);
+	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name_nons);
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, name, 0);
 		if (!o)
 			return 0;
-		strbuf_addf(buf, "%s\t%s^{}\n", sha1_to_hex(o->sha1), name);
+		strbuf_addf(buf, "%s\t%s^{}\n", sha1_to_hex(o->sha1),
+		            name_nons);
 	}
 	return 0;
 }
@@ -402,7 +404,8 @@ static void get_info_refs(char *arg)
 
 	} else {
 		select_getanyfile();
-		for_each_ref(show_text_ref, &buf);
+		head_ref_namespaced(show_text_ref, &buf);
+		for_each_namespaced_ref(show_text_ref, &buf);
 		send_strbuf("text/plain", &buf);
 	}
 	strbuf_release(&buf);
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 938b4cf..ad85537 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -61,6 +61,11 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_COMMITTER_NAME "Custom User"
 	SetEnv GIT_COMMITTER_EMAIL custom@example.com
 </LocationMatch>
+<LocationMatch /smart_namespace/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	SetEnv GIT_NAMESPACE ns
+</LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 <Directory ${GIT_EXEC_PATH}>
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 47eb769..b5032bd 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -162,6 +162,28 @@ test_expect_success 'invalid Content-Type rejected' '
 	grep "not valid:" actual
 '
 
+test_expect_success 'create namespaced refs' '
+	test_commit namespaced &&
+	git push public HEAD:refs/namespaces/ns/refs/heads/master
+'
+
+test_expect_success 'smart clone respects namespace' '
+	git clone --bare "$HTTPD_URL/smart_namespace/repo.git" ns-smart.git &&
+	echo namespaced >expect &&
+	git --git-dir=ns-smart.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'dumb clone via http-backend respects namespace' '
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+		config http.getanyfile true &&
+	GIT_SMART_HTTP=0 git clone --bare \
+		"$HTTPD_URL/smart_namespace/repo.git" ns-dumb.git &&
+	echo namespaced >expect &&
+	git --git-dir=ns-dumb.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index ef98d95..85a5625 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -26,6 +26,13 @@ GET() {
 	test_cmp exp act
 }
 
+GET_BODY() {
+	REQUEST_METHOD="GET" && export REQUEST_METHOD &&
+	run_backend "/repo.git/$1" &&
+	sane_unset REQUEST_METHOD &&
+	tr '\015' Q <act.out | sed '1,/^Q$/d'
+}
+
 POST() {
 	REQUEST_METHOD="POST" && export REQUEST_METHOD &&
 	CONTENT_TYPE="application/x-$1-request" && export CONTENT_TYPE &&
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index b5d7fbc..97f97a1 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -23,6 +23,10 @@ GET() {
 	test_cmp exp act
 }
 
+GET_BODY() {
+	curl "$HTTPD_URL/$SMART/repo.git/$1"
+}
+
 POST() {
 	curl --include --data "$2" \
 	--header "Content-Type: application/x-$1-request" \
@@ -134,6 +138,13 @@ POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
 ###
 GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
 POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
+
+###  namespace test
+###
+GET  /smart/repo.git/info/refs HTTP/1.1 200
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+GET  /smart_namespace/repo.git/info/refs HTTP/1.1 200
+GET  /smart_namespace/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'server request log matches test results' '
 	sed -e "
diff --git a/t/t556x_common b/t/t556x_common
index 82926cf..1ce2429 100755
--- a/t/t556x_common
+++ b/t/t556x_common
@@ -120,3 +120,31 @@ test_expect_success 'http.receivepack false' '
 	GET info/refs?service=git-receive-pack "403 Forbidden" &&
 	POST git-receive-pack 0000 "403 Forbidden"
 '
+
+test_expect_success 'backend respects namespaces' '(
+	log_div "namespace test"
+	config http.uploadpack true &&
+	config http.getanyfile true &&
+
+	NS=ns &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		git update-ref refs/namespaces/$NS/refs/heads/master HEAD
+	) &&
+
+	SMART=smart
+	git ls-remote public >expect &&  
+	grep /$NS/ expect &&
+	GET_BODY "info/refs" >actual &&
+	test_cmp expect actual &&
+	GET_BODY "info/refs?service=git-upload-pack" >actual &&
+	grep /$NS/ actual &&
+
+	SMART=smart_namespace &&
+	GIT_NAMESPACE=$NS && export GIT_NAMESPACE &&
+	git ls-remote public >expect &&  
+	! grep /$NS/ expect &&
+	GET_BODY "info/refs" >actual &&
+	test_cmp expect actual &&
+	GET_BODY "info/refs?service=git-upload-pack" >actual &&
+	! grep /$NS/ actual
+)'
-- 
1.8.1.3
