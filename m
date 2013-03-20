From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t: don't redefine test_config() in various places
Date: Wed, 20 Mar 2013 13:51:43 +0530
Message-ID: <1363767703-12936-1-git-send-email-artagnon@gmail.com>
References: <7vk3p3jrrw.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 09:21:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIEGk-0000kA-Uw
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 09:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934012Ab3CTIUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 04:20:39 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:62357 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933959Ab3CTIUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 04:20:35 -0400
X-Greylist: delayed 155123 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2013 04:20:35 EDT
Received: by mail-pd0-f177.google.com with SMTP id y14so505286pdi.22
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=vzUXKorQfJbqAcfkwb66T0kwdM40v+w0wGGX5yDH25g=;
        b=wgezAYUvrn2GB53ZfKCCvdWccO7gJFKz2LJIBHVF3jULY97fz5xZESUKlXaLFCFboG
         WyRaupAC7EmrtO9TnfGl1M5QzxrqFYUXvYuoizgzIFQ+/L5eeEWC6BR+erChhs1JXfVL
         IpOt+rcHk/qRxysOtkCo5hFBAgDQFfBJtN0n99t1lPFRcZV8ly7OPH3i0cqX3oc/ZAL4
         k25PwPzDsSXiXGXcoManak0mDlYmx3rJrySn+QWhh5F2QUFJZPYYll6Pb4CSzASwofGX
         4g/FtWU4KsHLGTIa1LxgQl7TN3GWG7RPHpDtjnW3vgGSLG7dFJRo3KwQBiAM6Ag+Pd5G
         bUbg==
X-Received: by 10.67.3.39 with SMTP id bt7mr7663461pad.161.1363767635147;
        Wed, 20 Mar 2013 01:20:35 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id is1sm1277420pbc.15.2013.03.20.01.20.32
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 01:20:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <7vk3p3jrrw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218577>

test_config() is already a well-defined function in
test-lib-functions.sh.  Don't duplicate it unnecessarily in:

  t4018-diff-funcname.sh
  t7810-grep.sh
  t7811-grep-open.sh

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Thanks, Junio.

 t/t4018-diff-funcname.sh | 5 -----
 t/t7810-grep.sh          | 5 -----
 t/t7811-grep-open.sh     | 5 -----
 3 files changed, 15 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 082d3e8..38a092a 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -93,11 +93,6 @@ sed -e '
 	s/song;/song();/
 ' <Beer.perl >Beer-correct.perl
 
-test_config () {
-	git config "$1" "$2" &&
-	test_when_finished "git config --unset $1"
-}
-
 test_expect_funcname () {
 	lang=${2-java}
 	test_expect_code 1 git diff --no-index -U1 \
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f698001..500eb50 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1084,11 +1084,6 @@ test_expect_success 'grep -E pattern with grep.patternType=fixed' '
 	test_cmp expected actual
 '
 
-test_config() {
-	git config "$1" "$2" &&
-	test_when_finished "git config --unset $1"
-}
-
 cat >expected <<EOF
 hello.c<RED>:<RESET>int main(int argc, const char **argv)
 hello.c<RED>-<RESET>{
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index a895778..e1951a5 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -125,11 +125,6 @@ test_expect_success 'modified file' '
 	test_cmp empty out
 '
 
-test_config() {
-	git config "$1" "$2" &&
-	test_when_finished "git config --unset $1"
-}
-
 test_expect_success 'copes with color settings' '
 	rm -f actual &&
 	echo grep.h >expect &&
-- 
1.8.2
