From: John Koleszar <jkoleszar@google.com>
Subject: [PATCH v4] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Tue,  9 Apr 2013 17:55:08 -0700
Message-ID: <1365555308-611-1-git-send-email-jkoleszar@google.com>
References: <CAAvHm8NV4OD+QqVp-7oOzsSdAwten6gTpfUFfi85jv_VQ3soFA@mail.gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	John Koleszar <jkoleszar@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 02:55:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPjK1-0000Cy-97
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 02:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935170Ab3DJAz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 20:55:28 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:52214 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765432Ab3DJAz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 20:55:26 -0400
Received: by mail-ie0-f201.google.com with SMTP id a11so1921853iee.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 17:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1MiPtDkoqFE9+D3b4E0acpyJs7bVW7IlpvrkI+JBu0o=;
        b=WA4VbKkBdyjiv66fdy0T0+9h4FweisIDzApODLHOv3CkrPglrb19YVaYZbR6RhC8Sx
         N30BC0GldReHJNeexxLwCNJtk4K7RfaTDZ2Ta3gM56r5Cdq2TrqAzN6263za1YhNs0HD
         ISFMPpgazEEJSbMhtHGpMweN3sqb2YgVbCgD9wkeovl5XOL+ddMIutKuBuV2iJoGeiDc
         8q6iCUkqHL5ElW3ozLK4HSeKfSxwkXAuy+EfVtIljiYpXl0Ij2qaqwQPIiKNeGLyh3VT
         QaV5MsM+FVz9Py62ZiG7xnlNlfrzNcS+jyWR7pQIo8w3uxBIKuVFP1RtjJ9mNQ3SxHkT
         BoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=1MiPtDkoqFE9+D3b4E0acpyJs7bVW7IlpvrkI+JBu0o=;
        b=bq46mmAb6CWtu81HRCTVTGXSuJhxoTO1AAnc3+d8R6Xrp7qKSl+DRuZuzLfoo8/jmO
         80FyOr9KwAngWJjbzwj+0WInjYC62inw8z3It1uR71ktkZ8muTb5/mI9qTlq0hXj3h9a
         4BxgKvzs6Z5sY7Tjw7LECQfXk4K0yHwjCl9ozsD6gSRZb9gZTTs0vp+RmDfl8qurOMEZ
         ivua3lcayNLNPDN/uARWWpmAXuYnYuHXjV95u+Al7fogAjYN3AnNpzwLOXFmJA219WEU
         mufleM9omY7Swwq2EYrMqu1UOWeK0lX6iY6yskEVJ50ueLLPTH9hnijwdLCw4iQucILK
         gNNg==
X-Received: by 10.42.233.13 with SMTP id jw13mr2425354icb.14.1365555326179;
        Tue, 09 Apr 2013 17:55:26 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id iw8si2392359igc.1.2013.04.09.17.55.25
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Tue, 09 Apr 2013 17:55:26 -0700 (PDT)
Received: from sigill.mtv.corp.google.com (sigill.mtv.corp.google.com [172.22.77.100])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 681A631C0A5;
	Tue,  9 Apr 2013 17:55:25 -0700 (PDT)
Received: by sigill.mtv.corp.google.com (Postfix, from userid 105890)
	id E8359A08F5; Tue,  9 Apr 2013 17:55:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3
In-Reply-To: <CAAvHm8NV4OD+QqVp-7oOzsSdAwten6gTpfUFfi85jv_VQ3soFA@mail.gmail.com>
X-Gm-Message-State: ALoCoQmBlP/YCzz6zaq4A9lfZ4quCECewv1k5ycCEO/IGVq32vfVoM5w8VgJ9UfDXwdULXJyBT1xrfhHb4SQhNVBThBQdPbROfuV412Rmof4JbFajky8ZpLBZz4pxjAxazQYJrsuVx8T0V2gxH0MKNJQIjXKc5LqvkR+/LERjyaZRO3f3bwT7G+87ZCUwffG23mFCAySS8Zh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220653>

Filter the list of refs returned via the dumb HTTP protocol according
to the active namespace, consistent with other clients of the
upload-pack service.

Signed-off-by: John Koleszar <jkoleszar@google.com>
---
Updates to generate HEAD. Drops my original tests, since they were under the
flawed assumption that both the dumb and smart protocols produced the same
ref advertisement at /info/refs.

 http-backend.c          |   38 ++++++++++++++++++++++++++++++++++----
 t/lib-httpd/apache.conf |    5 +++++
 t/t5551-http-fetch.sh   |   24 ++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f50e77f..4f35a31 100644
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
@@ -402,12 +404,40 @@ static void get_info_refs(char *arg)
 
 	} else {
 		select_getanyfile();
-		for_each_ref(show_text_ref, &buf);
+		for_each_namespaced_ref(show_text_ref, &buf);
 		send_strbuf("text/plain", &buf);
 	}
 	strbuf_release(&buf);
 }
 
+static int show_head_ref(const char *name, const unsigned char *sha1,
+	int flag, void *cb_data)
+{
+	struct strbuf *buf = cb_data;
+
+	if (flag & REF_ISSYMREF) {
+		unsigned char sha1[20];
+		const char *target = resolve_ref_unsafe(name, sha1, 1, NULL);
+		const char *target_nons = strip_namespace(target);
+
+		strbuf_addf(buf, "ref: %s\n", target_nons);
+	} else {
+		strbuf_addf(buf, "%s\n", sha1_to_hex(sha1));
+	}
+
+	return 0;
+}
+
+static void get_head(char *arg)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	select_getanyfile();
+	head_ref_namespaced(show_head_ref, &buf);
+	send_strbuf("text/plain", &buf);
+	strbuf_release(&buf);
+}
+
 static void get_info_packs(char *arg)
 {
 	size_t objdirlen = strlen(get_object_directory());
@@ -520,7 +550,7 @@ static struct service_cmd {
 	const char *pattern;
 	void (*imp)(char *);
 } services[] = {
-	{"GET", "/HEAD$", get_text_file},
+	{"GET", "/HEAD$", get_head},
 	{"GET", "/info/refs$", get_info_refs},
 	{"GET", "/objects/info/alternates$", get_text_file},
 	{"GET", "/objects/info/http-alternates$", get_text_file},
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
index 47eb769..b31019f 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -162,6 +162,30 @@ test_expect_success 'invalid Content-Type rejected' '
 	grep "not valid:" actual
 '
 
+test_expect_success 'create namespaced refs' '
+	test_commit namespaced &&
+	git push public HEAD:refs/namespaces/ns/refs/heads/master &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+		symbolic-ref refs/namespaces/ns/HEAD refs/namespaces/ns/refs/heads/master
+'
+
+test_expect_success 'smart clone respects namespace' '
+	git clone "$HTTPD_URL/smart_namespace/repo.git" ns-smart &&
+	echo namespaced >expect &&
+	git --git-dir=ns-smart/.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'dumb clone via http-backend respects namespace' '
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+		config http.getanyfile true &&
+	GIT_SMART_HTTP=0 git clone \
+		"$HTTPD_URL/smart_namespace/repo.git" ns-dumb &&
+	echo namespaced >expect &&
+	git --git-dir=ns-dumb/.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
-- 
1.7.9.6 (Apple Git-31.1)
