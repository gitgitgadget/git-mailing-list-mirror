From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] submodule-config: keep submodule groups around
Date: Tue, 24 Nov 2015 17:32:15 -0800
Message-ID: <1448415139-23675-2-git-send-email-sbeller@google.com>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:32:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Owg-0005gz-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbbKYBc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:32:26 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36530 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbbKYBcX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:32:23 -0500
Received: by pacdm15 with SMTP id dm15so39563872pac.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R+Kt8qLVBUGzUPEHca9JT+kK/2GjeWw6FB8TtSHiEJo=;
        b=FqgOaBPqnDZ6MVPm5xlFcKnoRnT6yqY3tS/7dGm0bsTU+9HFRHJW8in4022dfMWABf
         fmuzrTDbaTgt5UoB701vlajNFQtAYbDK8+BUgmgvGadsPsEU5epE2IKZn8E5stQ1Y3L2
         Pw6oTnRoIjApfKFQoFDgF9rWfTWI5ysMd5QblA2c4XtwjEiU87KTa3E0xRQN41ipXgJp
         3rHftFGrxYOmw78FqfqzplwYs5bxfyG0+CvxSGTf19GJDtFSVtVqmxINB+PpGhyntmfE
         cwGQfad1MjhTQp33pp+JDT1VZbN67EA+nQHur0zLpZvKPnvY4ebnwjWZ12sudcYyKxyQ
         eD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R+Kt8qLVBUGzUPEHca9JT+kK/2GjeWw6FB8TtSHiEJo=;
        b=PtenAs4cFxGf9Q2htX2/kY2vLsdCsIaaF7FIV2fBcsvoCr1Dxt688c+/Sz+iqbFEmE
         YYV6OLzmh64VC6tKgwtm5/uheR744TeZZ46VFCHwjmjqOTYzAMgbgmgigl1/fmPVuU5A
         scOOJb4pLltd7faegmB2KxL+j73bFMKDNymJ5NbhV1znsB8xteTRN6dG2WExlcARqmqI
         TXVjHGTbB49/3J7/ZGqZitHQnA3ZqYgSlz49/cNoSM7aWiCRmAA/Y2oRnEWVkyB92UyK
         8NqivLVMrIiEl6rJawEXrwO4u3WMA3gjTmdnWjd5Ao8yjj4iDPZ2Vqn8a0q8p6JIGpbh
         iVqw==
X-Gm-Message-State: ALoCoQmYMPJRDpxBc3rtQa7dROVRaassLcahUtcUEzrNk+5S6TErKCai7Cu7MDEWgjC8Yg7tK1xI
X-Received: by 10.98.71.157 with SMTP id p29mr27576802pfi.152.1448415142808;
        Tue, 24 Nov 2015 17:32:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:38f7:d727:e789:685b])
        by smtp.gmail.com with ESMTPSA id l84sm16832879pfb.15.2015.11.24.17.32.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:32:22 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448415139-23675-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281669>

We need to query the groups in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 14 ++++++++++++++
 submodule-config.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index a32259e..f44ce20 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -60,6 +60,7 @@ static void free_one_config(struct submodule_entry *entry)
 {
 	free((void *) entry->config->path);
 	free((void *) entry->config->name);
+	free((void *) entry->config->groups);
 	free(entry->config);
 }
 
@@ -182,6 +183,8 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->path = NULL;
 	submodule->url = NULL;
 	submodule->update = NULL;
+	submodule->groups = xmalloc(sizeof(*submodule->groups));
+	string_list_init(submodule->groups, 1);
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -324,6 +327,17 @@ static int parse_specific_submodule_config(const char *subsection, int subsectio
 			free((void *) submodule->update);
 			submodule->update = xstrdup(value);
 		}
+	} else if (!strcmp(key, "groups")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite && submodule->groups)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "groups");
+		else {
+			string_list_clear(submodule->groups, 0);
+			string_list_split(submodule->groups, value, ',', -1);
+			string_list_sort(submodule->groups);
+		}
 	}
 
 	return ret;
diff --git a/submodule-config.h b/submodule-config.h
index d9bbf9a..7fc21e1 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -3,6 +3,7 @@
 
 #include "hashmap.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 /*
  * Submodule entry containing the information about a certain submodule
@@ -17,6 +18,7 @@ struct submodule {
 	const char *update;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
+	struct string_list *groups;
 };
 
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-- 
2.6.1.261.g0d9c4c1
