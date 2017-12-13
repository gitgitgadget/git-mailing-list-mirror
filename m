Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946B21F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbdLMPOX (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:14:23 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46373 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbdLMPOA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:14:00 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so5698144wme.5
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4OBB5z6EvOlEJ3x9XBn60AqHUrO7oUjM8gtHIh/2nJY=;
        b=UtTRU4c+q1LpJr9U9gnnplYFLbmEWrFOSPHHmjHK88z5WTCo0hh8SHGfQz0+7ibb4v
         etl9iBw4QvyskzVFc8h3PSwCfsARq9OXvLlOXEBM6DYzsBUSGef5ATK8bcJh9URKFA0i
         BNKoEkelB43BkUrXoQv9yrJeVGicmFFCztpelZ/RUDBYzIF+aG4+fl56tIwg4kLey3AA
         +L5PKx0716fzaOdyqPvbfSkQcCc3kzAiKEZGnGytb3J4G9hvSI7rXvOxD18o6D87EMPk
         igE8q0sEjudCWCii6BZqT6IWcH/H9r84RnoASemOlw5ZbPzg8W0KxwSOUqb4lYg80iAA
         XC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4OBB5z6EvOlEJ3x9XBn60AqHUrO7oUjM8gtHIh/2nJY=;
        b=fyI4cOLzqdws1vZerMReZ3URrLCGl3HqQGLKIwI0K+5YkWZk8liLISmlIHTH75JpWM
         bFw+aF7rzi1ogDvphnIyX2U5fL6EGmfMBA+grUXSYFuWM5XO9R2v+AlpHyAd6n1mhBn3
         nuXUda33Quxl8ad5+EAFKAdZhcJNKzLCho476bixkA/ZTSo7NzWgFajt74valcovAa4E
         AAA0NzD8t9rx68RXVfgd5BChGzZviD/hXJxqwCmMICRBgTU9lF2NAinDVj1xpuLIJF//
         KMyOrdwmFPBwWNFa19z/XecTJKxi6NB3nhZvzLdqgvQXhMI8tJX62GCqTF2ggn8ZeJeZ
         0gfQ==
X-Gm-Message-State: AKGB3mIVE4oWE2MG2LCOl+DLJdgmVd7ql3L0MGu9lSO+cliB2ax3LjRd
        chovUKQUcCFGLTc1odV8p+7ol/A5
X-Google-Smtp-Source: ACJfBosj7a9mqVUsachRpeLDnHDRxenLbO9V/WAWiJxjVW9rGerWg1fIprTmPeh4uRpS6/uE5WtiGg==
X-Received: by 10.80.158.194 with SMTP id a60mr7896603edf.228.1513178039432;
        Wed, 13 Dec 2017 07:13:59 -0800 (PST)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id z56sm1552690edb.72.2017.12.13.07.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 07:13:58 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/8] perf/run: add conf_opts argument to get_var_from_env_or_config()
Date:   Wed, 13 Dec 2017 16:13:41 +0100
Message-Id: <20171213151344.2138-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171213151344.2138-1-chriscool@tuxfamily.org>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/perf/run b/t/perf/run
index bbd703dc4f..04ea5090f9 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -106,6 +106,7 @@ get_var_from_env_or_config () {
 	conf_sec="$2"
 	conf_var="$3"
 	default_value="$4" # optional
+	conf_opts="$5" # optional
 
 	# Do nothing if the env variable is already set
 	eval "test -z \"\${$env_var+x}\"" || return
@@ -116,11 +117,11 @@ get_var_from_env_or_config () {
 	if test -n "$GIT_PERF_SUBSECTION"
 	then
 		var="$conf_sec.$GIT_PERF_SUBSECTION.$conf_var"
-		conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$var") &&
+		conf_value=$(git config $conf_opts -f "$GIT_PERF_CONFIG_FILE" "$var") &&
 		eval "$env_var=\"$conf_value\"" && return
 	fi
 	var="$conf_sec.$conf_var"
-	conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$var") &&
+	conf_value=$(git config $conf_opts -f "$GIT_PERF_CONFIG_FILE" "$var") &&
 	eval "$env_var=\"$conf_value\"" && return
 
 	test -n "${default_value+x}" && eval "$env_var=\"$default_value\""
-- 
2.15.1.361.g8b07d831d0

