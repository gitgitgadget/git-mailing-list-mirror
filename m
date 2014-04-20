From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 1/8] t5516 (fetch-push): fix test restoration
Date: Sun, 20 Apr 2014 14:44:59 -0500
Message-ID: <1398023106-25958-2-git-send-email-felipe.contreras@gmail.com>
References: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:55:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbxqH-0006IQ-OG
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbaDTTzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:55:36 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:41873 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbaDTTza (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:55:30 -0400
Received: by mail-yk0-f177.google.com with SMTP id q200so2847522ykb.36
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xh2omw5Z4AqQArn5nbCoQDLIwmCwKOn2wcntOCinY50=;
        b=MtxJhQwwFTHpv2S8e/eFarV5HzbAdH7RcBFdNRcqbjSTPRumEnFSnZoSAcIqORLjjC
         xkkr5XdLEylhEf6D1Rnqi/qpSSkIn367d1ndUJj7jdrcLHLbCA9KZd/386OQA6NWbh48
         Xdr5CAwW+spoTV3xWLuDpicy/qmOdoEStuAEEFaZyZOnIcfKUdM57MYlG3ITXJQiV6V5
         Y+ieGYstxNLbqYD2oTP5UlehQoTCweJAZzx3qM4hQ0FM5tuVhP6ZEuMSskzJLHgO+xEp
         XcrAIIN698RSC4ZXDmII4vt8ga/gLHLrzQKxd1K1TILBL3Cl160v4jxfeNS42pf7yZVw
         hDQA==
X-Received: by 10.236.20.68 with SMTP id o44mr11753942yho.76.1398023729998;
        Sun, 20 Apr 2014 12:55:29 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id v60sm57984137yhc.40.2014.04.20.12.55.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:55:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246569>

We shouldn't modify the commits; it screws the following tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5516-fetch-push.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 67e0ab3..f4cf0db 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1261,6 +1261,8 @@ test_expect_success 'push --follow-tag only pushes relevant tags' '
 '
 
 test_expect_success 'push --no-thin must produce non-thin pack' '
+	test_when_finished "git reset --hard v1.0" &&
+
 	cat >>path1 <<\EOF &&
 keep base version of path1 big enough, compared to the new changes
 later, in order to pass size heuristics in
-- 
1.9.1+fc3.9.gc73078e
