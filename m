From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 19/20] t/test-lib-functions.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:56:02 -0700
Message-ID: <1402066563-28519-20-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZN-0001vC-Qk
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbaFFO4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:32 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:56344 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaFFO40 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:26 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so2579812pbc.9
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhTl8a4N0cB5UdvNrlCQwqgQHbee5JAbBUDCN5CqMqE=;
        b=Ua4Q/TASkcro85KjHbbICUfWPbwxMH2S7TPRbNdX/beixMF8LF5/48gO786c17ePO/
         4rLrTVWbl4UGspwviazx/5pHVRPBvRM+kj3c7fkoEzwlRqJ9W01y2tR+aWZpKBP7Nsca
         kgGjKoH+qluTLMdOEi8ioWtkSwZNSadvkpXtBoPEKUTkBhQ3Uo4d2XF6ECun+Q3I8yDF
         ZiR9MOcGyr+8iR3eDXfl2c3ZKV5JLJpBPkXCTWmV7fQOQ6gVtNHRHPBVfuI8IKuo3drx
         DfvSKWp172dPmW4xOhOe7ENTiQhlV6W/NqJka92aDd2dd5m013lrUK+90kivmssr0G9F
         WDbA==
X-Received: by 10.68.253.73 with SMTP id zy9mr1591471pbc.114.1402066585672;
        Fri, 06 Jun 2014 07:56:25 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250929>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/test-lib-functions.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 158e10a..0681003 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -542,7 +542,7 @@ test_must_fail () {
 	if test $exit_code = 0; then
 		echo >&2 "test_must_fail: command succeeded: $*"
 		return 1
-	elif test $exit_code -gt 129 -a $exit_code -le 192; then
+	elif test $exit_code -gt 129 && test $exit_code -le 192; then
 		echo >&2 "test_must_fail: died by signal: $*"
 		return 1
 	elif test $exit_code = 127; then
@@ -569,7 +569,7 @@ test_must_fail () {
 test_might_fail () {
 	"$@"
 	exit_code=$?
-	if test $exit_code -gt 129 -a $exit_code -le 192; then
+	if test $exit_code -gt 129 && test $exit_code -le 192; then
 		echo >&2 "test_might_fail: died by signal: $*"
 		return 1
 	elif test $exit_code = 127; then
-- 
1.7.10.4
