From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 1/2] remove unnecessary parameter from get_patch_ids()
Date: Fri, 27 Jul 2012 10:21:38 -0700
Message-ID: <1343409699-27199-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 19:22:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuoEk-0006zR-TM
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 19:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab2G0RVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 13:21:47 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:53100 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab2G0RVq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 13:21:46 -0400
Received: by yhl10 with SMTP id 10so355017yhl.1
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=uzcolexPpI/7an6mpgfeuoJMV2FdiuM3xk4P3ars26s=;
        b=S8Q+CGxJTUdh82heviyTwY3ydYDNlp3aQDclhlN8E6gw9Lowzhtwd2mD3iT41///eo
         DpdKRbF19F+Odm6Urldz4uvjL7oGG4Lu8Ues+kWF1oAr46XGtl6u0R/bNz1nsxMzhZ9g
         zXMefZsB/LuAdS5AiuCkZtlufqlgkScc+LUxbijvjiiqQZpknMmmLi6j187Jr5Tkcwbn
         QxNo5w3Fcx3TND/R+k4TC5sm4txwU6aTgRv5hq8eupFudWDyqW/DgHH+nQo/Y7BPR2qZ
         NGPg5K74xr8J7haRwQ+U5J3iB963hLpvspHTA3vusb8l8kzVMNSTMDcWPUwNw2dVbHeY
         MCVA==
Received: by 10.236.153.69 with SMTP id e45mr1528208yhk.35.1343409705707;
        Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: by 10.236.153.69 with SMTP id e45mr1528203yhk.35.1343409705669;
        Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id l23si719417yhk.6.2012.07.27.10.21.45
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 8ED15100047;
	Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 2B418C0CED; Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQnVvt+haMUERXr7JY4XU7gP38MLbRPd26a196gAOq3uCkm+uf8ouWA8nRO8ckSv7jiIWrKoon0EL7BphyQUYIPkz0wRtq5OZgy3af8DrIb7QAcVxUiv5Dqd86l4LyobDw/eolZlvenE0Hod+92VIsP5FilBw195q3YBfxefjsHYWkra7DHdowyTkbzQqgDaRdz6/415
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202363>

get_patch_ids() takes an already initialized rev_info and a
prefix. The prefix is used when initalizing a second rev_info. Since
the initialized rev_info already has a prefix and it seems the prefix
doesn't change, we can used the prefix from the initialized rev_info
to initialize the second rev_info.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 builtin/log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ecc2793..7a92e3f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -696,7 +696,7 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 	return 0;
 }
 
-static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const char *prefix)
+static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 {
 	struct rev_info check_rev;
 	struct commit *commit;
@@ -717,7 +717,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
 	init_patch_ids(ids);
 
 	/* given a range a..b get all patch ids for b..a */
-	init_revisions(&check_rev, prefix);
+	init_revisions(&check_rev, rev->prefix);
 	o1->flags ^= UNINTERESTING;
 	o2->flags ^= UNINTERESTING;
 	add_pending_object(&check_rev, o1, "o1");
@@ -1306,7 +1306,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			if (hashcmp(o[0].item->sha1, o[1].item->sha1) == 0)
 				return 0;
 		}
-		get_patch_ids(&rev, &ids, prefix);
+		get_patch_ids(&rev, &ids);
 	}
 
 	if (!use_stdout)
@@ -1525,7 +1525,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			return 0;
 	}
 
-	get_patch_ids(&revs, &ids, prefix);
+	get_patch_ids(&revs, &ids);
 
 	if (limit && add_pending_commit(limit, &revs, UNINTERESTING))
 		die(_("Unknown commit %s"), limit);
-- 
1.7.11.1.104.ge7b44f1
