From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t/t5560: use `X=Y && export X' not `export X=Y'
Date: Thu,  7 Oct 2010 07:47:14 +0000
Message-ID: <1286437634-12593-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 09:47:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3lCb-0006b6-EL
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 09:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760136Ab0JGHre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 03:47:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48633 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760127Ab0JGHrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 03:47:32 -0400
Received: by wyb28 with SMTP id 28so395421wyb.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=bOYmye/dx4Dx7qcExymeou0I6QTNXobL8u/HR/fCwTc=;
        b=MCHDkw4YN/nVtwHq0YpzKH0eP2GIfhRlWIc2jQhXlSV/am0xYFs4m3lq9HCqKeG/7J
         es522Yap86k+LZs4ULDRVrC9gfPjxUX8awwbPlWqlmC5DsoWC10ZC/lFLol+A11sm0A6
         zbomLIlEFx/fLc9QAkNvQrEJ/i7Nqeq24Bstw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=IoVJRE027YzU9mtZWsP+jJ0sLqvjJGyGfPfE4dDq048L0ElXDA0tUZBSYWbLQmf1u1
         rrwZl0fJfBkgg4b3CyEElXUuTr8+T5alQC45XNsUxraYFGOV4GxIbyzAijxVIkJn2aOk
         jbvv1vhl79WjP2qGXaYK0J8bW/bAec3L04aFA=
Received: by 10.216.70.10 with SMTP id o10mr340382wed.83.1286437649092;
        Thu, 07 Oct 2010 00:47:29 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p42sm1197894weq.36.2010.10.07.00.47.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 00:47:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.50.g1e633
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158380>

Change t/t5560-http-backend-noserver.sh to use the `X=3DY && export X'
style instead of `export X=3DY'. The latter doesn't work on all POSIX
shells.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t5560-http-backend-noserver.sh |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-no=
server.sh
index 406432e..effe797 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -5,7 +5,11 @@ test_description=3D'test git-http-backend-noserver'
=20
 HTTPD_DOCUMENT_ROOT_PATH=3D"$TRASH_DIRECTORY"
=20
-test_have_prereq MINGW && export GREP_OPTIONS=3D-U
+if test_have_prereq MINGW
+then
+	GREP_OPTIONS=3D-U
+	export GREP_OPTIONS
+fi
=20
 run_backend() {
 	echo "$2" |
@@ -15,7 +19,8 @@ run_backend() {
 }
=20
 GET() {
-	export REQUEST_METHOD=3D"GET" &&
+	REQUEST_METHOD=3D"GET" &&
+	export REQUEST_METHOD &&
 	run_backend "/repo.git/$1" &&
 	unset REQUEST_METHOD &&
 	if ! grep "Status" act.out >act
@@ -27,8 +32,9 @@ GET() {
 }
=20
 POST() {
-	export REQUEST_METHOD=3D"POST" &&
-	export CONTENT_TYPE=3D"application/x-$1-request" &&
+	REQUEST_METHOD=3D"POST" &&
+	CONTENT_TYPE=3D"application/x-$1-request" &&
+	export REQUEST_METHOD CONTENT_TYPE &&
 	run_backend "/repo.git/$1" "$2" &&
 	unset REQUEST_METHOD &&
 	unset CONTENT_TYPE &&
@@ -47,7 +53,8 @@ log_div() {
 . "$TEST_DIRECTORY"/t556x_common
=20
 expect_aliased() {
-	export REQUEST_METHOD=3D"GET" &&
+	REQUEST_METHOD=3D"GET" &&
+	export REQUEST_METHOD &&
 	if test $1 =3D 0; then
 		run_backend "$2"
 	else
--=20
1.7.3.1.50.g1e633
