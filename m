From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 28/47] remote-hg: add check_bookmark() test helper
Date: Mon, 13 May 2013 23:36:51 -0500
Message-ID: <1368506230-19614-29-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72F-0004WY-LV
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832Ab3ENEkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:15 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39825 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab3ENEkL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:11 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so102264oag.19
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=OmnCL5aT//YUJEHq/HTNsizL6+tCJkrQXHEG+ejF9F4=;
        b=s9YMj9QwM1Is1+gd5Cqt9PJIC7mCRLCI4S9iU/kLUVI2vt1G69+Mct2V20rq17Gn7F
         eKXA2HHYFPvKucPybpurVjMg6/MdJGtLPvkE+A1cRV3RAuPqpnw9OdO2SgNZ5tEYhqXU
         dLcdl6yK9pPWsjsKFiXNEVIQhenMOXifz7/jaTDPVV9E33ftcAZZy7RtqbhXVC5zfoBz
         uchyQlSDmf8F7F1dnCNMM3jYmXq+tczYfwemIH0Tkdcxo+bu7F5sLu66BSLJVwWH7t1R
         N3Zy+D7P2ISlkty6Ac23ARBsMOTYBZLCmGR5QtsEq6mPhKFw+07FDvPaHNRgymh5oEoi
         7olg==
X-Received: by 10.60.55.74 with SMTP id q10mr9533193oep.80.1368506411264;
        Mon, 13 May 2013 21:40:11 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm20504278oez.4.2013.05.13.21.40.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224257>

And check in a more proper way.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 8d1f6e0..dc71c37 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -26,6 +26,12 @@ check () {
 	test_cmp expected actual
 }
 
+check_bookmark () {
+	echo $3 > expected &&
+	hg -R $1 log -r "bookmark('$2')" --template '{desc}\n' > actual &&
+	test_cmp expected actual
+}
+
 setup () {
 	(
 	echo "[ui]"
@@ -98,7 +104,7 @@ test_expect_success 'update bookmark' '
 	git push --quiet
 	) &&
 
-	hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
+	check_bookmark hgrepo devel devel
 '
 
 # cleanup previous stuff
-- 
1.8.3.rc1.579.g184e698
