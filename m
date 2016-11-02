Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412E720193
	for <e@80x24.org>; Wed,  2 Nov 2016 23:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757011AbcKBXRc (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 19:17:32 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36822 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756229AbcKBXRa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 19:17:30 -0400
Received: by mail-pf0-f179.google.com with SMTP id 189so19608332pfz.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c+Xqsn2zcpBBoMUsMaSahwJ5IUUaplH2FDb7WFXZ4rY=;
        b=KywVW9VwBFXlbSWwX6wt/OATK5EC2PmGIKuIsWWFkfqiIVcAUEbnZ10QBM4S6YiOX3
         pgFJ0W38YjIC7WpOXwBGhi1JbwzS8xCdzB+gGnpiVlyQmih3T73uZGzozXbao+fwQIv6
         KWWNBt9CbIO7ysAbw9RJixdgw3k8DheFFjZ3bULkP+1gT9h4nyxHGCrYmphkiH7VLvNf
         Axaoi8tpjc99IIfx1Cef2sZc6iZhlo11R9OXycftuFcPk0LPZZkFnU71gs8qHeG8JLnZ
         CEN67W/ffEtPYh0KqwwhyTwf+/KalT5TCqu5YsiXvXHifQudvlzkS1qDX8+q1e8W+uEK
         waXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c+Xqsn2zcpBBoMUsMaSahwJ5IUUaplH2FDb7WFXZ4rY=;
        b=Bz8KWw5tSnRACShpC4nDvWsrEZ+5hU3rruiCTIVM7MGTnBsd0haa4L1qOykh+4hj84
         3T2WSv5BcSXq3ZhwMTB1w/qWZ2INW0vLSnFGnKVkDIEt0liADFlNhbiyLBQYdN3l0t/i
         LAOy+J1vaZm3v//do+MMwI4RoJN+IzpRqduCCo8ldYaWBf3bwV0TYwVpLzojrH5loLTW
         v9lJGwpVqvq6CShrBwGOYDQEb9lH6vDJQAE6RA5QBDOryibv8tkt+uOhL2Qjb1vy1+M5
         OdEd3txYeklNo9D+9Kyp9HkPmzOCV4vWGW2pDRpS3l/VpxD9nTgl24+nzFl9A37g8OlK
         l9vQ==
X-Gm-Message-State: ABUngveZbPCOehOCqF8IOVwlWKZj2LmDBWytd42PVO0Fnd87ZDHKrne90KZrEV0C7RBLSeWi
X-Received: by 10.98.9.147 with SMTP id 19mr11404693pfj.68.1478128649925;
        Wed, 02 Nov 2016 16:17:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b836:b884:f13a:bcf4])
        by smtp.gmail.com with ESMTPSA id c15sm7226246pfd.53.2016.11.02.16.17.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 16:17:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule config: inline config_from_{name, path}
Date:   Wed,  2 Nov 2016 16:17:20 -0700
Message-Id: <20161102231722.15787-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.621.g399b625.dirty
In-Reply-To: <20161102231722.15787-1-sbeller@google.com>
References: <20161102231722.15787-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no other user of config_from_{name, path}, such that there is no
reason for the existence of these one liner functions. Just inline these
to increase readability.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 098085be69..15ffab6af4 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -471,18 +471,6 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	return submodule;
 }
 
-static const struct submodule *config_from_path(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *path)
-{
-	return config_from(cache, commit_sha1, path, lookup_path);
-}
-
-static const struct submodule *config_from_name(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *name)
-{
-	return config_from(cache, commit_sha1, name, lookup_name);
-}
-
 static void ensure_cache_init(void)
 {
 	if (is_cache_init)
@@ -508,14 +496,14 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name)
 {
 	ensure_cache_init();
-	return config_from_name(&the_submodule_cache, commit_sha1, name);
+	return config_from(&the_submodule_cache, commit_sha1, name, lookup_name);
 }
 
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path)
 {
 	ensure_cache_init();
-	return config_from_path(&the_submodule_cache, commit_sha1, path);
+	return config_from(&the_submodule_cache, commit_sha1, path, lookup_path);
 }
 
 void submodule_free(void)
-- 
2.10.2.621.g399b625.dirty

