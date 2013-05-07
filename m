From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/11] sha1_name: don't waste cycles in the @-parsing loop
Date: Tue,  7 May 2013 16:55:09 -0500
Message-ID: <1367963711-8722-10-git-send-email-felipe.contreras@gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpst-0008Tb-OG
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab3EGV5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:57:11 -0400
Received: from mail-gh0-f175.google.com ([209.85.160.175]:50199 "EHLO
	mail-gh0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab3EGV5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:57:09 -0400
Received: by mail-gh0-f175.google.com with SMTP id z19so215401ghb.20
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5MGMpWZKy47rlWytkTtMUwtLdZWxurvewqhRRCDE160=;
        b=u+LlnPgVWat1kC5HTQ7tZwhxVZZ5sntJIz+wKemzGBg0EJ+iExv7nDUI/EB4+aKM+I
         Y6Fl/+i/CNiPkGB8gWuLE+awXyfR/lrLQnEaHPcyPIePSPx0Hahq0gnwsmm8Jol01g47
         iKEKPascoR1dRHVqXWjK4ZCyT6xW/FE7UD87lfGE38EULmobjFi9NF6Cn8k1ziYuGZ7y
         txm/Asgmkx2CWLwPvcAjQGhHHhDQjIqzDQ3UqGtwZ4hmRaDQ5bJchLMEEvTFvmWkZolI
         7BlZ5b8bSUuWxdJplqCfQV8fY0H2lBfMrs4vgeu7nsDyyAqzliBm2Ti1AA894KXDy3Gv
         woAw==
X-Received: by 10.236.120.52 with SMTP id o40mr3902195yhh.58.1367963828732;
        Tue, 07 May 2013 14:57:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id y24sm53795561yhn.20.2013.05.07.14.57.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:57:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223614>

From: Ramkumar Ramachandra <artagnon@gmail.com>

The @-parsing loop unnecessarily checks for the sequence "@{" from len -
2 unnecessarily. We can safely check from len - 4.

[fc: remove cruft]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 93c4e8c..0acc6e0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -445,7 +445,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len = at = 0;
 	if (len && str[len-1] == '}') {
-		for (at = len-2; at >= 0; at--) {
+		for (at = len-4; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
 				if (!upstream_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
-- 
1.8.3.rc0.401.g45bba44
