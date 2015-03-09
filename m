From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] connect.c: Fix memory leak
Date: Mon,  9 Mar 2015 09:58:22 -0700
Message-ID: <1425920304-22360-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 09 17:58:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV10l-00024O-AC
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 17:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbbCIQ6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 12:58:30 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37408 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbbCIQ63 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 12:58:29 -0400
Received: by iebtr6 with SMTP id tr6so31753991ieb.4
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EqnpJJwVzu+G6HdPtOjhmgyP5ZsMdp3yuO5Wod+KmZk=;
        b=nXXTCAWBrUSc2R2xxULIQfMd8ULpxQArjNdeZJCLucxo1C5dVcF0HKEwRyyvh2SX4Z
         SKCYEYld9Qm9JjQF2cwHQPEt/W2qAdNjqXrhDZi/kU0SW8cQsSQ5S8ZuhphTZkWDDRQm
         F+pKVC+38knRdJZprcqs1X/yCUfMt+dqeX3eLXPFvDJf3zvAQPJfWD9MyMJwKSIWhayp
         75EmEqtUTwgtxOMMJzmW1EnL34xmdRE1A3pwrpht0GoPsAI+KixAhb7febyJMQ6YyB+n
         SlPqKlRv33Ia9QDv2l9VxAo0B+n66Q6t/jOCGKu1G4UjQJGqe49Zx2pD33qArevQx431
         gC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EqnpJJwVzu+G6HdPtOjhmgyP5ZsMdp3yuO5Wod+KmZk=;
        b=F6/932NqM6ZXB8oyJBwror/SnL/LJCq/CBJBa8eikb9+vYocy1Vd39vDY8mYSJvxho
         ZmxEb6KbiFgIu8wjcmGDFrhnkl87D2MQkOkneaut8SZa4XwdXQr3ZlBn7LWk2ezfPwoq
         xDSiR2XWM2vYQ8z/ZufUMabJVGuqez8Lp7trx1Ds8uWN0kC3KYdnUH5YXRi5mPbCNhNC
         kmoFab3tkKnS3YSX55UQjPCw4LnSbO/yEl/ywqiBR+kHvjycKJazMbHJMKE1MTNohAbq
         fJO3j4sfSlDalMRW/ltfeXrwsBygfkhxWAdCOHoQY3BDcng0r1ybFZy+1QVsShTfyfWB
         aDWg==
X-Gm-Message-State: ALoCoQnzcev8+8ZwDqpTGz4jrTa7UGiZiObfFewYiAMUKnUKTL33VIFqrC79Blhh/nlEvZBqTAkr
X-Received: by 10.107.163.65 with SMTP id m62mr13657467ioe.40.1425920308148;
        Mon, 09 Mar 2015 09:58:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:556f:5b0e:5ec6:a1a9])
        by mx.google.com with ESMTPSA id d6sm12429151ioe.44.2015.03.09.09.58.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Mar 2015 09:58:27 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265179>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/connect.c b/connect.c
index ce0e121..6090211 100644
--- a/connect.c
+++ b/connect.c
@@ -739,6 +739,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 				free(hostandport);
 				free(path);
+				free(conn);
 				return NULL;
 			} else {
 				ssh = getenv("GIT_SSH_COMMAND");
-- 
2.3.0.81.gc37f363
