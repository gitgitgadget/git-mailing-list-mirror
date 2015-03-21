From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/15] http-push: Remove unneeded cleanup
Date: Fri, 20 Mar 2015 17:28:05 -0700
Message-ID: <1426897692-18322-9-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7HE-0001gw-7o
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbbCUA22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:28 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38780 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbbCUA21 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:27 -0400
Received: by igbqf9 with SMTP id qf9so1466064igb.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i2n+N2OrNc4oDu5B69CLcubYClQX61SfUFxc5eYFdOY=;
        b=GTQXBI2ysz0ROiLbmQ2g1AncCOPRUjOv0h8CunocVEPHrzTa+cdtOBxAhudfxZ0FhJ
         TUaOdFOqA9m1cEIfH4iLk+PLghuE0Ap8oiBAHhMo9MEjR1hG2xAXYEhADZxpdPvzbbxc
         PTYW4WXM9/yqX3DdBh4ysPA+R22CKEQdc1SRnJPZHA2MM0KlpJQXcrsiEtq65EsT0Lff
         oLwtsvpI0TBHbHgs4NakHXk1j3J4qdphLHgbiHtodh6GEXOXZqHwxsK+0xaVrH1eUKxo
         rorM+m7sroeuI74C7goNX0vw1H+adO07wxF/1yJEPxrmLhBPBKbBVSv6S3qIlW+HmsKy
         3yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i2n+N2OrNc4oDu5B69CLcubYClQX61SfUFxc5eYFdOY=;
        b=hMBkJc2k2ELT3tclA2OZgwGOZORnywWad/Usn+82OQLcqhgIp0qqriB8taCtbAyRwi
         tw7iqwN046EbhPS7T9rZgVeU/8OpIoXdooZgxf9hOTsD76U/X054q1qj0l1u2R/oeeNv
         FHZXnzYuNJouCo/vzaWQL3iZAPbecGHRnCPsJlRfc9QLdgJjGqLuSHnq4DXDt1Wy6zLQ
         RJMVdgbQTcqP234KGDBPD/pmAUReL7X/83jvkrzlDurA3MiNO29wpNHu9eEQHm9RE0hb
         C9C8wUpbLDmM8FR18UIEUpWBUl51Qkrcv5vx7UoBWMLqz9a8t6b3WadBl6EaBluEcJQV
         qGWw==
X-Gm-Message-State: ALoCoQndWlkmxEaFfSRABcHs2ihkkT8lgr/g0ACsnX8fjgmJi88nxbJz3BSklinh7UZtePpcuaGB
X-Received: by 10.107.33.136 with SMTP id h130mr34824460ioh.54.1426897706355;
        Fri, 20 Mar 2015 17:28:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id 94sm4235510iod.23.2015.03.20.17.28.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:26 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265983>

preq is NULL as the condition the line before dictates. And the cleanup
function release_http_pack_request is not null pointer safe.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 http-push.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index bfb1c96..c98dad2 100644
--- a/http-push.c
+++ b/http-push.c
@@ -316,7 +316,6 @@ static void start_fetch_packed(struct transfer_request *request)
 
 	preq = new_http_pack_request(target, repo->url);
 	if (preq == NULL) {
-		release_http_pack_request(preq);
 		repo->can_update_info_refs = 0;
 		return;
 	}
-- 
2.3.0.81.gc37f363
