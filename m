From: John Koleszar <jkoleszar@google.com>
Subject: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Wed, 27 Mar 2013 21:58:41 -0700
Message-ID: <1364446721-13351-1-git-send-email-jkoleszar@google.com>
Cc: Shawn Pearce <spearce@spearce.org>,
	John Koleszar <jkoleszar@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 28 06:00:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL4wI-0005dl-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 05:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab3C1E7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 00:59:12 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:46586 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab3C1E7L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 00:59:11 -0400
Received: by mail-qc0-f202.google.com with SMTP id k26so621915qcs.3
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 21:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=+L9WEO5FSuJvnURakgdQ1WqjP8HUhn0mAJIK+C+D1kI=;
        b=DttomPr6XZMZnfsJbsa2CfBaTcrpoZqGWae7I7N9d8kWRqcniugwihWHJNF3fgpmKL
         EBoY+yBSZvKau2RwsQgvR8vrkQ8gIZbHoCpUIBoY0MeAEZ8PicXkxZkjDU87ipZwDah+
         ncVz6fT7unNw4UC1G9tyqbse/TT0G9rPM7p/knL12jJt6DZJDiFK4U6VJcsOd2SOxEx7
         e/O5qA/Z9TUn9kcxUh+XES/R5rGfjYp4K/ldc6DJCdxyVwqoa6sD6JvQL/ulEE9Z3YMt
         9BCSmDP5MUmpl3zr27egkBkY3UThtYugHMzxhUFAcx8AU6+xxN4PTUKlPWCnT34Nxd4/
         3L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=+L9WEO5FSuJvnURakgdQ1WqjP8HUhn0mAJIK+C+D1kI=;
        b=cY7g3xPipeLfnpTSRhDXR4+xjqcYXx9ZiYvAkKTDlNrQviNUxrYpyQ7u6fZrrjUKlM
         oKZ0Pihp65BytZwAkO/IUZw46tjtM86fCE0j8bOETl7S/qjJAvdtHXjXaG0kVIMHWGQr
         lJ09ssMdl95HW/byzCyxCzIA7s1pwnQgVe4aZZubNbtYUQNHort1k7qwqU7PU/NiDaOD
         m1g//xUvPw6v3sm+ps77VTJ0lEyUWrqSHmvr1TQMcfTvyKY3f1AtHXq29KzbIggJIUT+
         +USFJW8/6mQlbbqLoCDR4ShnqHGgPYUXc7JC3N4661nFVG9FIJZiVhs8cj7PVG5t+bqy
         60KA==
X-Received: by 10.224.72.199 with SMTP id n7mr13265029qaj.5.1364446750087;
        Wed, 27 Mar 2013 21:59:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y8si4126229qcx.0.2013.03.27.21.59.10
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Wed, 27 Mar 2013 21:59:10 -0700 (PDT)
Received: from sigill.mtv.corp.google.com (sigill.mtv.corp.google.com [172.22.77.100])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CDD7D31C016;
	Wed, 27 Mar 2013 21:59:09 -0700 (PDT)
Received: by sigill.mtv.corp.google.com (Postfix, from userid 105890)
	id 794E5A0698; Wed, 27 Mar 2013 21:59:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3
X-Gm-Message-State: ALoCoQms/ScOa7OdpMuX9kqZW6pEwKnvVRsI1BfasO3FALsOjqsJQMmbVoBWYPqPRTpXinFr0yXJ1GNT1EOEE0sanR5sXvhSjgysl/tffpXP/ixWPD8OZZxAoxSssj6agm8FdlKe/dB42csZuYTST2PA/ktMVb+LHs3Q3D7as9FgBU8dSOpslbxkQ1HIspXpO70dxMoTq0Pg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219364>

Filter the list of refs returned via the dumb HTTP protocol according
to the active namespace, consistent with other clients of the
upload-pack service.

Signed-off-by: John Koleszar <jkoleszar@google.com>
---
 http-backend.c          |  8 +++++---
 t/lib-httpd/apache.conf |  5 +++++
 t/t5561-http-backend.sh |  4 ++++
 t/t556x_common          | 16 ++++++++++++++++
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f50e77f..b9896b0 100644
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
@@ -402,7 +404,7 @@ static void get_info_refs(char *arg)
 
 	} else {
 		select_getanyfile();
-		for_each_ref(show_text_ref, &buf);
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
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index b5d7fbc..5a19d61 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -134,6 +134,10 @@ POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
 ###
 GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
 POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
+
+###  namespace test
+###
+GET  /smart_namespace/repo.git/info/refs HTTP/1.1 200
 EOF
 test_expect_success 'server request log matches test results' '
 	sed -e "
diff --git a/t/t556x_common b/t/t556x_common
index 82926cf..cb9eb9d 100755
--- a/t/t556x_common
+++ b/t/t556x_common
@@ -120,3 +120,19 @@ test_expect_success 'http.receivepack false' '
 	GET info/refs?service=git-receive-pack "403 Forbidden" &&
 	POST git-receive-pack 0000 "403 Forbidden"
 '
+test_expect_success 'backend respects namespaces' '
+	log_div "namespace test"
+	config http.uploadpack true &&
+	config http.getanyfile true &&
+
+	GIT_NAMESPACE=ns && export GIT_NAMESPACE &&
+	git push public master:master &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		git for-each-ref | grep /$GIT_NAMESPACE/ >/dev/null
+	) &&
+
+	git ls-remote public >exp &&  
+	curl "$HTTPD_URL/smart_namespace/repo.git/info/refs" >act &&
+	test_cmp exp act &&
+	(grep /ns/ exp && false || true)
+'
-- 
1.8.1.3
