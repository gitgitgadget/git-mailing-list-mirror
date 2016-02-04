From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 1/9] submodule-config: keep update strategy around
Date: Thu,  4 Feb 2016 14:09:28 -0800
Message-ID: <1454623776-3347-2-git-send-email-sbeller@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 04 23:09:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRS63-00077i-PG
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbcBDWJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:09:48 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34643 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934313AbcBDWJp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:09:45 -0500
Received: by mail-pf0-f170.google.com with SMTP id o185so56659756pfb.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8kxXLJ5p8+VyXtf5y2htvR/XfRWlxluK42OQtRRHOI=;
        b=U0VWCwUjPFenKi388UHF/TKoBEYRi6H7lH07MRoo876lvIkHE7U2afUIkcPJbq3QCZ
         iaxGwFP8R8/K2eLbow0tpr302bjM/kcstrFzk63M1HE0gtJCcJT9DyJJJ9pxmr+HdUms
         Lc5m7T3BwYzv/JEjcuOo2xEN8JhP6itfUax/f+9r876t5gAXb4RMt+yjlNIss2zSRgvk
         5Y4MOUDqccQK35KYH5FzrhI/9KAtIAR+Y+WDdiNMHV0+K6jH4uDhwhWtmqjPmNPW+ERk
         PBMNs6GxuTDIjuoPvCGnaHNAJ3DoTNcex0WwIHo32DpiDKceh0QoDqfD0annbYI8zlok
         YpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8kxXLJ5p8+VyXtf5y2htvR/XfRWlxluK42OQtRRHOI=;
        b=glAjKdYPQi417rWu97TeBELUKDb1CpxZHX4/7DrZujU+aYaSewGAiZacEZZj8PI8OW
         2bGvKEIR3a05IkbQX8ReFRlebZ0Wbi+LovPbl07hzZ5e/UTr+VL9Dahb1Yz93NMG2PSY
         Us4ODVaNCk/jTSvu7O0EBTMCCl46jlSjSF5xKmrzGoTueRItyIYUWZPVKeIYkdtkuQBT
         LT/HQ4lNuMAfsmFG6RvomA6En4Gub/EAEP1UVGm3NvZHmQKOTduEgQwkYYfxWBgDs+2c
         JVUbIr+n2ye1dRBCON2vO0p8Muez+MfaL2RdPMz+4ifIakgdnTkoMcKUxPY1XWYHIcns
         KtbQ==
X-Gm-Message-State: AG10YORMlrxn6gYHnYFqtDmn4RFoXIe8Z3ry0XyERpZDNrEkZZVxqN6GDvhMEeAixwJ8uMw6
X-Received: by 10.98.67.135 with SMTP id l7mr14777502pfi.148.1454623785394;
        Thu, 04 Feb 2016 14:09:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5194:ebf5:4051:c1fd])
        by smtp.gmail.com with ESMTPSA id i13sm19313236pfi.95.2016.02.04.14.09.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 14:09:44 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.gd102984.dirty
In-Reply-To: <1454623776-3347-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285500>

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
2.7.0.rc0.41.gd102984.dirty
