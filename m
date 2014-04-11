From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/8] t5516 (fetch-push): fix test restoration
Date: Fri, 11 Apr 2014 12:59:04 -0500
Message-ID: <1397239151-2391-2-git-send-email-felipe.contreras@gmail.com>
References: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 20:09:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYftJ-0006v1-GR
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 20:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbaDKSJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 14:09:18 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:49521 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbaDKSJP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 14:09:15 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so6600042oag.3
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eNOuyl7ZjpnUiJrSZuVogPbVS9MKHeieCWG1XWq0NwA=;
        b=LxvNonqFMKWt28XRq8m7vHHW4Mx4vGwAwhrgOG1yiJhjzgO1hKdEHPzya+1VvJSXnS
         wcKINl0edhNNwJsarMeeMBBDJVUAv5tKdnoXPlCHwClE2aIDwIRrlIRY+BJEMVSnfbPO
         5UnTIMvfpziKlisMsVsbYp1UBUZ5OvERiA2W3jaKEeeY/94uiANaQVDmsu4Z/2njDBPF
         QQno6FIVWt9NqeVMU+f29II17gA7rtbb4zy1SWvYkGrPcyThoZYl9s2kOY7zBwRpi121
         fMbHYL+Iy7A9eDL1Efrvp3eQNm5x/dTbDb0gDkYwwKpkNifipBTRERr74F5rNefCAs0f
         +kKg==
X-Received: by 10.60.141.70 with SMTP id rm6mr20725121oeb.27.1397239754952;
        Fri, 11 Apr 2014 11:09:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id np9sm12841009obc.12.2014.04.11.11.09.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 11:09:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246117>

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
1.9.1+fc1
