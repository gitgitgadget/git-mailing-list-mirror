From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule-config: keep shallow recommendation around
Date: Thu, 26 May 2016 14:59:42 -0700
Message-ID: <20160526215943.29526-2-sbeller@google.com>
References: <20160526215943.29526-1-sbeller@google.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 00:00:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b63KG-0007pT-6Z
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 00:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbcEZV76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 17:59:58 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35611 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbcEZV7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 17:59:54 -0400
Received: by mail-pf0-f177.google.com with SMTP id g64so34921016pfb.2
        for <git@vger.kernel.org>; Thu, 26 May 2016 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j+lzv2VLS1Hk7BsSoz6hDhJ8K7DbOpbBNxI9r5hxsxA=;
        b=Ov8czd8YNUQrAaI7Zk26VLYO8puAkzA9VbPRBAqKMu//S/4hGMkyHtsmmQBYWnKtFc
         q3anGxsTeYCDcrPUHeXMP0k8sQY3795dDL1SJoWh671YO2AAGPeUNaq4jYWPdHsCHgqX
         4DZUG1YuFwf0QFQeAZrWn9pYUPHUvdtVPbVWhvtcOMrzq/ytPfPBVwGhwsLGXobeepJZ
         S96KdH69Y6+wbPHJ6nFOfjEbKhyiv3zbs/olgThdNwfdqxTcWVrtTo/+ncc5KPNzTF1u
         a35OsqYgK5BtN4If8H7rJhZh05WoL69n3wRP7g1RI7QImT0tEIUYk7wk/Q4Z2S4fiWya
         R5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j+lzv2VLS1Hk7BsSoz6hDhJ8K7DbOpbBNxI9r5hxsxA=;
        b=c2lJV8sdt1LV9IN87P/qN4SbC//AndFpDVytDqac/s0/Q2+8y0Rff/FL7NPxvHy68f
         pyC5B+XnVdF2TmcARwhUxGqNnGBqlgqoi/J8MpyAjiK30V6xUZxJjz/ggsXPFq29V3mV
         T8+A8AeuxJqEzL/e0B8kcj6E7v35V1nzPtFKYesMz95dUR/shxPMWC97MNpKXZl4LTUO
         kplD1Mg6+ev8NZaJdKrl4kxxeat/b5c+wgwCMPnh9i/eBLxTTvYDKZjpuQfdFavQoaxO
         RP16gomb3o7gSp3eTFB2BgHwziyZVJ7TSltvmHwXyRvmyks6tGP9xORZhEexFpLkqu3+
         vR5A==
X-Gm-Message-State: ALyK8tJCy+AHgtj9V9B/PPZpIvoz1wN9m/T42OVnSVFVvL+DJCpeXIuj8LFbrRillHnfLoev
X-Received: by 10.98.90.130 with SMTP id o124mr17199757pfb.115.1464299993491;
        Thu, 26 May 2016 14:59:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f5f9:aea3:ef22:58b3])
        by smtp.gmail.com with ESMTPSA id l67sm8359079pfi.10.2016.05.26.14.59.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 26 May 2016 14:59:52 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.2.g145fc64
In-Reply-To: <20160526215943.29526-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295696>

The shallow field will be used in a later patch by `submodule update`.
To differentiate between the actual depth (which may be different),
we name it `recommend_shallow` as the field in the .gitmodules file
is only a recommendation by the project.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 9 +++++++++
 submodule-config.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index debab29..db1847f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -199,6 +199,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->update_strategy.command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
+	submodule->recommend_shallow = -1;
 
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
@@ -353,6 +354,14 @@ static int parse_config(const char *var, const char *value, void *data)
 		else if (parse_submodule_update_strategy(value,
 			 &submodule->update_strategy) < 0)
 				die(_("invalid value for %s"), var);
+	} else if (!strcmp(item.buf, "shallow")) {
+		if (!me->overwrite && submodule->recommend_shallow != -1)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "shallow");
+		else {
+			submodule->recommend_shallow =
+				git_config_bool(var, value);
+		}
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index e4857f5..b1fdcc0 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -18,6 +18,7 @@ struct submodule {
 	struct submodule_update_strategy update_strategy;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
+	int recommend_shallow;
 };
 
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-- 
2.9.0.rc0.2.g145fc64
