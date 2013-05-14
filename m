From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 33/47] remote-hg: add test for new bookmark special
Date: Mon, 13 May 2013 23:36:56 -0500
Message-ID: <1368506230-19614-34-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72j-0004oJ-FF
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab3ENEkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:36 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:59871 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3ENEk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:28 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so105938oag.9
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XU/DPd1kxyO+gvaKYDBvUVO8dhH7VIUqn5fbUaHqU0Q=;
        b=EgTv7S1UEkIN4LiGhEovdKRVP8qMFPicknbz1Ubf3Ohkg7rez2NihJ3yARTTvP50ZW
         9TyQy+BwOrtKiukKOI2ljm5G6T68wMVq+eAQPKrEUsbLmkaD56ywTzmi+evv9SGqy67P
         S/XOrkfyK/m18sD3zkK/TYFtISp9MH9PYab0IIcxINI07JhlKjpotwxzIOytexR230ak
         W3L0gvgVtxxS+4qBXQzvEhAXKaWZHP0KRdScS1Rf9VUQ3TkXDlRL95vBl7HJ6c3AoH5C
         RMa+EFGBycXz/VlTdfb8k1aWwHZ85AyMjnYAUcdj8J9+DxhlCg+nrCOh6JfXTq4NmzOD
         v+vw==
X-Received: by 10.60.80.33 with SMTP id o1mr15828752oex.116.1368506427865;
        Mon, 13 May 2013 21:40:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ku7sm20009239obc.6.2013.05.13.21.40.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224265>

>From the point of view of Mercurial, this creates a new branch head, and
requires a forced push.

Ideally, whoever, we would want it to work just like in git; new
branches can be pushed without problems.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index f4e3807..c3fa04d 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -310,4 +310,19 @@ test_expect_failure 'remote update bookmark diverge' '
 	check_bookmark hgrepo diverge "bump bookmark"
 '
 
+test_expect_failure 'remote new bookmark multiple branch head' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet -b feature-c HEAD^ &&
+	echo feature-c > content &&
+	git commit -a -m feature-c &&
+	git push --quiet origin feature-c
+	) &&
+
+	check_bookmark hgrepo feature-c feature-c
+'
+
 test_done
-- 
1.8.3.rc1.579.g184e698
