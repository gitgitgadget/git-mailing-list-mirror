Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69647C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345773AbiDRR2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347083AbiDRR1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9333E00
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x18so11451317wrc.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lARK1u60ShkCoOmiWb5+2NXO48lrNaKT0syXnWjdaBk=;
        b=h6QP+wzcfSvbrb1f3wCjndzS93+o6GoCZEeO5xUMXWstPBNOY7e0FjCj+yvPE8Inbe
         fvMtSA3yXy+SbYo56Dwf0F6UOwfIMHRT296oyiB16Bka9XiBerCb3n1ewiS6dL3Qv23S
         m2WGsVatiN1qYNz2dmYCK00BKV7qXZz1ySxir1PpmjCSvfwgRCcEzi6f931AJ5aUdpg8
         nqrva+d+1HFZ4BMyhpsw9MkNIjoKR60wCtjHdnDuUou4s8MF4tKm+fDzHFDariKpbzvj
         /mJ9k1wtv+oFgp++6LdCV9dbZvpjFKAazP52Veyir5fCjeQZbQCDcaKokS0wvo4rvS62
         2YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lARK1u60ShkCoOmiWb5+2NXO48lrNaKT0syXnWjdaBk=;
        b=ImJKVIizqwDqTyDd9URe7XAGdpbqnwpQwr336xWvJ6ZaxxdTiLOCjHGrD6B7GqWIQs
         2uefGFo7vMEpCo2WW4AItbqdDyj4tuZoR9i6C+Cr7INcHTw7wl8vWUuZ4OZdteU3AFi4
         cLs8TchHWFveRPvLA4AMvAuROoWCjsyXJN+zOz8Zg08jytbph/0u0uYcFIB5Pby102gU
         20xwZdhF88Kr7iJ7eMwOx+XnGCeef+z24wXnByJvxajQqCiyDKtl5VToZ8J8Dy/n/hds
         lOym+5m6FXYjz+Ztd+MIpHsZic3duLCfyPUp0Hzi/uIi+S4jH2hiupr0kubiRsTMCX+m
         cWrA==
X-Gm-Message-State: AOAM5332SjKGQtx5Jqn8fXTq3T5vKM91sD+1LO/7/q34hPV+Pcc8F5aB
        iQY8lmHekaJenOtdoq+VAVIpQNOsn8RITw==
X-Google-Smtp-Source: ABdhPJwvb4p9jd4dMZFxPkPL4SnXLfklGbInzvqtVndbgozG9aAyHJapMIyTscT5nwkmDy9GpOSJEA==
X-Received: by 2002:adf:f781:0:b0:207:9c12:5bee with SMTP id q1-20020adff781000000b002079c125beemr8786260wrp.122.1650302666006;
        Mon, 18 Apr 2022 10:24:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 25/36] bundle: only fetch bundles if timestamp is new
Date:   Mon, 18 Apr 2022 19:23:42 +0200
Message-Id: <RFC-patch-v2-25.36-ab349b1cbea-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

If a bundle server is providing a table of contents with timestamps for
the bundles, then we can store the most-recent timestamp and use that as
a test if the bundle server has any new information. Teach 'git bundle
fetch' to store the timestamp in the config file as
'fetch.bundleTimestamp' and compare the existing value to the
most-recent timestamp in the bundle server's table of contents. If the
new timestamp is at most the stored timestamp, then exit early (with
success). If the new timestamp is greater than the stored timestamp,
then continue with the normal fetch logic of downloading the most-recent
bundle until all missing objects are satisfied. Store that new timestamp
in the config for next time.

RFC-TODO: Update documentation of 'git bundle fetch' to match his new
behavior.

RFC-TODO: Add 'fetch.bundleTimestamp' to Documentation/config/

RFC-TODO @ Ævar: I replaced the git_config_get_timestamp() with
parse_expiry_date(), but as noted perhaps we want *nix epochs here
only, in that case we could add an "isdigit" loop here.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/bundle.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index c55d5215181..4c51b014f0b 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -413,6 +413,10 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 	struct remote_bundle_info *stack = NULL;
 	struct hashmap toc = { 0 };
 	const char *filter = NULL;
+	const char *timestamp_key = "fetch.bundletimestamp";
+	timestamp_t stored_time = 0;
+	timestamp_t max_time = 0;
+	const char *value;
 
 	struct option options[] = {
 		OPT_BOOL(0, "progress", &progress,
@@ -428,6 +432,17 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 	if (!startup_info->have_repository)
 		die(_("'fetch' requires a repository"));
 
+	/*
+	 * TODO: Is it important re
+	 * https://lore.kernel.org/git/220311.86pmmshahy.gmgdl@evledraar.gmail.com/
+	 * that we don't accept "2.days.ago" etc., and only *nix
+	 * epochs?
+	 */
+	if (!git_config_get_string_tmp(timestamp_key, &value) &&
+	    parse_expiry_date(value, &stored_time))
+		return error(_("'%s' for '%s' is not a valid timestamp"),
+			     value, timestamp_key);
+
 	/*
 	 * Step 1: determine protocol for uri, and download contents to
 	 * a temporary location.
@@ -449,7 +464,6 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 	} else {
 		struct hashmap_iter iter;
 		struct remote_bundle_info *info;
-		timestamp_t max_time = 0;
 
 		/* populate a hashtable with all relevant bundles. */
 		used_hashmap = 1;
@@ -480,6 +494,13 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 				max_time = info->timestamp;
 			}
 		}
+
+		trace2_data_intmax("bundle", the_repository, "max_time", max_time);
+		trace2_data_intmax("bundle", the_repository, "stored_time", stored_time);
+
+		/* Skip fetching bundles if data isn't new enough. */
+		if (max_time <= stored_time)
+			goto cleanup;
 	}
 
 	/*
@@ -567,6 +588,14 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 		stack = stack->stack_next;
 	}
 
+	if (max_time) {
+		struct strbuf tstr = STRBUF_INIT;
+		strbuf_addf(&tstr, "%"PRIuMAX"", max_time);
+		git_config_set_gently(timestamp_key, tstr.buf);
+		strbuf_release(&tstr);
+	}
+
+cleanup:
 	if (used_hashmap) {
 		struct hashmap_iter iter;
 		struct remote_bundle_info *info;
-- 
2.36.0.rc2.902.g60576bbc845

