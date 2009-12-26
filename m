From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH 1/2] Smart-http: Add tests and documentation for export-ok
Date: Sat, 26 Dec 2009 18:29:12 -0500
Message-ID: <1261870153-57572-1-git-send-email-tarmigan+git@gmail.com>
References: <7vk4w963np.fsf@alter.siamese.dyndns.org>
Cc: spearce@spearce.org, git@vger.kernel.org, rctay89@gmail.com,
	drizzd@aon.at, warthog9@kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 00:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOg5I-0004C1-8E
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 00:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbZLZX3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 18:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbZLZX3q
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 18:29:46 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:33163 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbZLZX3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 18:29:45 -0500
Received: by qyk30 with SMTP id 30so4402376qyk.33
        for <git@vger.kernel.org>; Sat, 26 Dec 2009 15:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=uRbzXhMqKyxT1J0O0EuPFVku4ql6KUqiiQvz/ip0yH8=;
        b=OtppWBKNvpc6RFilqIYAkG0W5zUZ2b4BGRt2u8wJN3MJUaK90WkNZ5KXGAQXSISoUd
         KKWv07yBDYzbuC0iXK39bnggwl2TBZe4TncIulTo8dJnZ8OY9FcMcBmATm/S214etdvD
         6ib7671YSpS4B0Tpj2LVR7RUi/aKBGDML6aS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=XUqQROA5NqRPIvYSo8LGlhdPVbPXN0tpHmUCiyUH76F9m7wKBSjI/wDz0aYCLUeFkx
         ty/H2BJX3IPFXHtNvSB8wMs+tToD+S/3L2Ep2MhTiXJglGVlAEpSWHM/2pttFGNpP9x7
         iefeKnhO52LRiyW7NKlwcNdAhvadmN+rpAvtw=
Received: by 10.229.93.41 with SMTP id t41mr5937689qcm.81.1261870184466;
        Sat, 26 Dec 2009 15:29:44 -0800 (PST)
Received: from localhost.localdomain (c-69-141-159-197.hsd1.nj.comcast.net [69.141.159.197])
        by mx.google.com with ESMTPS id 22sm9238679qyk.2.2009.12.26.15.29.42
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Dec 2009 15:29:43 -0800 (PST)
X-Mailer: git-send-email 1.6.6.2.g5daf2
In-Reply-To: <7vk4w963np.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135696>

Add some tests for having smart-http check whether a repository is ok
to export.  Add tests for the GIT_HTTP_EXPORT_ALL environmental
variable and checking the git-daemon-export-ok file, while leaving
existing tests still functional.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 Documentation/git-http-backend.txt |   10 +++++++++
 t/lib-httpd/apache.conf            |    5 ++++
 t/t5560-http-backend.sh            |   39 ++++++++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 67aec06..c8fe08a 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -18,6 +18,11 @@ The program supports clients fetching using both the smart HTTP protcol
 and the backwards-compatible dumb HTTP protocol, as well as clients
 pushing using the smart HTTP protocol.
 
+It verifies that the directory has the magic file
+"git-daemon-export-ok", and it will refuse to export any git directory
+that hasn't explicitly been marked for export this way (unless the
+GIT_HTTP_EXPORT_ALL environmental variable is set).
+
 By default, only the `upload-pack` service is enabled, which serves
 'git-fetch-pack' and 'git-ls-remote' clients, which are invoked from
 'git-fetch', 'git-pull', and 'git-clone'.  If the client is authenticated,
@@ -70,6 +75,7 @@ Apache 2.x::
 +
 ----------------------------------------------------------------
 SetEnv GIT_PROJECT_ROOT /var/www/git
+SetEnv GIT_HTTP_EXPORT_ALL
 ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
 ----------------------------------------------------------------
 +
@@ -157,6 +163,10 @@ by the invoking web server, including:
 * QUERY_STRING
 * REQUEST_METHOD
 
+The GIT_HTTP_EXPORT_ALL environmental variable may be passed to
+'git-http-backend' to bypass the check for the "git-daemon-export-ok"
+file in each repository before allowing export of that repository.
+
 The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
 GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
 ensuring that any reflogs created by 'git-receive-pack' contain some
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0fe3fd0..4961505 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -22,8 +22,13 @@ Alias /dumb/ www/
 
 <Location /smart/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</Location>
+<Location /smart_noexport/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 </Location>
 ScriptAlias /smart/ ${GIT_EXEC_PATH}/git-http-backend/
+ScriptAlias /smart_noexport/ ${GIT_EXEC_PATH}/git-http-backend/
 <Directory ${GIT_EXEC_PATH}>
 	Options None
 </Directory>
diff --git a/t/t5560-http-backend.sh b/t/t5560-http-backend.sh
index ed034bc..f763880 100755
--- a/t/t5560-http-backend.sh
+++ b/t/t5560-http-backend.sh
@@ -23,7 +23,7 @@ config() {
 }
 
 GET() {
-	curl --include "$HTTPD_URL/smart/repo.git/$1" >out 2>/dev/null &&
+	curl --include "$HTTPD_URL/$SMART/repo.git/$1" >out 2>/dev/null &&
 	tr '\015' Q <out |
 	sed '
 		s/Q$//
@@ -91,6 +91,20 @@ get_static_files() {
 	GET $IDX_URL "$1"
 }
 
+SMART=smart_noexport
+test_expect_success 'no export by default' '
+	log_div "no git-daemon-export-ok"
+	get_static_files "404 Not Found"
+'
+test_expect_success 'export if git-daemon-export-ok' '
+	log_div "git-daemon-export-ok"
+        (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 touch git-daemon-export-ok
+	) &&
+        get_static_files "200 OK"
+'
+
+SMART=smart
 test_expect_success 'direct refs/heads/master not found' '
 	log_div "refs/heads/master"
 	GET refs/heads/master "404 Not Found"
@@ -145,7 +159,6 @@ test_expect_success 'http.receivepack false' '
 	GET info/refs?service=git-receive-pack "403 Forbidden" &&
 	POST git-receive-pack 0000 "403 Forbidden"
 '
-
 run_backend() {
 	REQUEST_METHOD=GET \
 	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
@@ -179,6 +192,28 @@ test_expect_success 'http-backend blocks bad PATH_INFO' '
 
 cat >exp <<EOF
 
+###  no git-daemon-export-ok
+###
+GET  /smart_noexport/repo.git/HEAD HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/info/refs HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 404 -
+
+###  git-daemon-export-ok
+###
+GET  /smart_noexport/repo.git/HEAD HTTP/1.1 200
+GET  /smart_noexport/repo.git/info/refs HTTP/1.1 200
+GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 200
+GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 200 -
+GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 200 -
+GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 200
+GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 200
+GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 200
+
 ###  refs/heads/master
 ###
 GET  /smart/repo.git/refs/heads/master HTTP/1.1 404 -
-- 
1.6.6.2.g5daf2
