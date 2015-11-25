From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 2/9] submodule-config: keep update strategy around
Date: Tue, 24 Nov 2015 17:14:49 -0800
Message-ID: <1448414096-22021-3-git-send-email-sbeller@google.com>
References: <1448414096-22021-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:15:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Ofy-0000xG-54
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbbKYBPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:15:11 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34534 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbbKYBPF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:15:05 -0500
Received: by padhx2 with SMTP id hx2so39241140pad.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k1R3PGq7IjC9FUenSMBXZD4otvDFex84iQuH3954jfY=;
        b=COdJm8v6EE7K5ZXGWsCo+ZjT9KHjPQ0Pk7k1J7DjXmuTnpzsV1LDzwR5wD9PoQK2OU
         DqW3iDdg6vv+miLQivU5Xeq3lKijU/p9yl/w7ku8DLc8tgUtw0a/i+vJXhkExxQXqJ1K
         lNRpLSCK6eX+dNCJoLOtZRP2qheIY/s/mpjO8JF83/LV0J0qyv+AwUqg5imZjO8bqmJ9
         zX0ZsBr0BUuD+eAvzoPV2P+snr+wIO+U4YQV5ZUHVHZ+QxuxELOaL5yx2vcBpWpzt42F
         HESrB7rBFG40WH5BIV91XA5OtjvV56QpgGrDQbJmf/bkjo6A8Hk2qhviuxPjBQafvpDb
         2sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k1R3PGq7IjC9FUenSMBXZD4otvDFex84iQuH3954jfY=;
        b=mk0AfDagfC8gZTARnokF4vocbXKfoolXOVAxMBXgI8UV8pJZaJYtjIfIVTI8RXSsgQ
         VUqbe25etv9IvOaGanabgtqMpgXES4KvzQ85uVeQGYvbHKFPG8JukUQ0XQYxEI9c6kO6
         zQ+QYW37HU/zTyD8NPjQcXuMZjioDQdEOLJJ+x5eNOfBLzX/o7fZjKUHoX/s1WffNjUE
         rzbauCNzBKhEmjR04FZ5z1rGUZ5uH0rSYBs+SFxatb8OZyp1+tB93CLwW67le4eTuq4R
         3r4XODqKwBgb8lDyqkMBGD8sw+ZZNTFFpuu3MUQ6KjCRBW3aWySXFapdW8jhqYoYN0OJ
         pxNA==
X-Gm-Message-State: ALoCoQm+kcPQ7Yyue/L5YjeXPhIPBWmpL0Mq0VhqSZnCRalkSBeqGlqexvp2UFRjAWL+nY7YWer2
X-Received: by 10.66.153.139 with SMTP id vg11mr47570610pab.118.1448414104757;
        Tue, 24 Nov 2015 17:15:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5407:71cc:c14:4343])
        by smtp.gmail.com with ESMTPSA id q62sm16777990pfq.6.2015.11.24.17.15.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:15:04 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448414096-22021-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281662>

We need the submodule update strategies in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 11 +++++++++++
 submodule-config.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index afe0ea8..4239b0e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -194,6 +194,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -311,6 +312,16 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
+	} else if (!strcmp(item.buf, "update")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite && submodule->update != NULL)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "update");
+		else {
+			free((void *) submodule->update);
+			submodule->update = xstrdup(value);
+		}
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index 9061e4e..f9e2a29 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -14,6 +14,7 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
+	const char *update;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
 };
-- 
2.6.1.261.g0d9c4c1
