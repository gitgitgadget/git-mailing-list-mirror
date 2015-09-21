From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 09/13] submodule config: keep update strategy around
Date: Mon, 21 Sep 2015 15:39:15 -0700
Message-ID: <1442875159-13027-10-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:40:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kf-0006vj-B3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933115AbbIUWj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:39:56 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35469 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933017AbbIUWjg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:36 -0400
Received: by pacfv12 with SMTP id fv12so131216000pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qDQfYD+M9/ei+8FMknWZJ7yyD/HmPAXoYirMsn8pmrg=;
        b=L8KPDnl9MI8VtMRMF1RewPMmSeX9VldHlLhghvDg8cMD89S5vb7qRlRHHbvZquqJQ3
         KNTQDyOuRtnFnIW4cddHjT24Cruhzee/5BoXv/9Qvddo9Vgno4rDUxXiESWibDvd84g2
         ve0ysiqntKIaC1Rn/ZPBFj3DFujLANARvtj88IojL017REdJR7G8Wl35n9KVeZE3yMSm
         WWfttr3A8lRsZA5bI0zWGNY+MBhOwXbouqvw9zulRoGB1xrz3k/c+m9BRnA8OmmglUFQ
         alQY0Z0Pgb0FB3SwbpciChuU2mhrMy43mr8nP79cjymn7PfpEdpIfAafPx+WhFKSKdAe
         W7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qDQfYD+M9/ei+8FMknWZJ7yyD/HmPAXoYirMsn8pmrg=;
        b=ZiwpLfTUTOq1Eqw57FBgcdL6G/hzN6jhmi0N3CUf6pSAkDbH+JU2c8jl3MzWcqYWR7
         lBgVkVTEk0n0Kwb7b9YkpYBg/wj+ywFTkcW//dW8XU311lEcPIFZvm8CKIqMS49lulqW
         fNqBK32Bi46oT3uNtZ3+tC7zWL0JoHUAmtV0AWZEsgeDXuoSk6O0Xbot5Qr5zReUXY7f
         jFAbxKTqNlxpK6KUcGz//bjli/ZCDq3YGComPFEFgk/H6taMIHf2tCe6OE4EC83wW1vS
         h/y6fW1AkdpjPRsXFJnr/+3eJU+IiduAo5fDK5QSAdfDavbsQTnRJ4xcgA4Gc4jtrKIl
         oFiw==
X-Gm-Message-State: ALoCoQn7O1JtFtr4XNyG/fAqRMgG1eAIWpUwCV1wDJp/9HxClOnihKQ9xMm5oj0Yw3lgybxDOZF2
X-Received: by 10.66.236.10 with SMTP id uq10mr4978604pac.55.1442875175781;
        Mon, 21 Sep 2015 15:39:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id of1sm26500515pbc.11.2015.09.21.15.39.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278343>

We need the submodule update strategies in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 16 ++++++++++++++++
 submodule-config.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index 393de53..0298a60 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -194,6 +194,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -326,6 +327,21 @@ static int parse_config(const char *var, const char *value, void *data)
 		free((void *) submodule->url);
 		strbuf_addstr(&url, value);
 		submodule->url = strbuf_detach(&url, NULL);
+	} else if (!strcmp(item.buf, "update")) {
+		struct strbuf update = STRBUF_INIT;
+		if (!value) {
+			ret = config_error_nonbool(var);
+			goto release_return;
+		}
+		if (!me->overwrite && submodule->update != NULL) {
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					"update");
+			goto release_return;
+		}
+
+		free((void *) submodule->update);
+		strbuf_addstr(&update, value);
+		submodule->update = strbuf_detach(&update, NULL);
 	}
 
 release_return:
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
2.5.0.275.ge015d2a
