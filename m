Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E0120357
	for <e@80x24.org>; Thu, 13 Jul 2017 06:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdGMGvH (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 02:51:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32784 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdGMGvF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 02:51:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id j85so3067163wmj.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c1DB6OrAdmAhdRqkrNsiMSbu+PRo64zNXPtAIjuPHdU=;
        b=OJuA18ntN3Y4DC+8h6SDLdjrEdCzx/v1CFE90h4t3q94ranvr5B0QZQzP+kpZTDf4K
         IXPQP8gXqWb7HgE1Z2oNXtk8BVGGvBIHfZCb/qApD0YF8GxvT9iP4mXLD1ACzOiWLW5n
         TXYcxNqC1ds/uPBtL8tDKvmrjd2wVxnPR10rVFEYV3V/h+LxzrOGyvSMZS3h+9y/HEF3
         cMtiTXS0ZsibosMdjZHzE+Vpp2wpdvCNAjeDPq9ZcsrsArUG+91cTc0ir/pKz+XyNGkp
         U6Sn/yjRRtyFLAHw8vygI4if/CIwIt0Jei1D20DzCoAGAbCFKGOO5wvT+cklpQBqFgWf
         IWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c1DB6OrAdmAhdRqkrNsiMSbu+PRo64zNXPtAIjuPHdU=;
        b=Vrcq2yLcenYVNBDKxH1YGOycYuRYuSlHEDBVABu3+DBd+mYP8MThUa6+7bCQOSJdzC
         dO6zBkvBViWbg7fZxb5WKBV+NaUPu1pIHq9Z8hZNS2MBQRFa7I8dgsZIYmxaupxp+uk+
         6ueUYON7W1ehS54StCaOUop4WZlR/EWq6pubJg1XZ3BMiVsdtb5bsnG/leQjSZvPXd+i
         MwbUFD2q54GtbPUxNAOIfmVY1oC9YQGKWo98a/I0MGKGZz03hHJXpnihf/mCZgN2GIod
         8IqdjO4/SbxiUsNTavRXNj6yQpiGpuwCgK0RQkACZJ5Bx9vGffBS5IgoXAKooEBH70jC
         1fWA==
X-Gm-Message-State: AIVw112++x0AyWjJirWXuBAVpawx0CYemsHUpYNx0+YeeKU770+5I2qO
        I0Tnh8AfFFmYEn+e
X-Received: by 10.28.66.208 with SMTP id k77mr699571wmi.89.1499928664142;
        Wed, 12 Jul 2017 23:51:04 -0700 (PDT)
Received: from localhost.localdomain (43.40.120.78.rev.sfr.net. [78.120.40.43])
        by smtp.gmail.com with ESMTPSA id l20sm3332564wre.25.2017.07.12.23.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 23:51:03 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 2/4] perf/run: add get_var_from_env_or_config()
Date:   Thu, 13 Jul 2017 08:50:48 +0200
Message-Id: <20170713065050.19215-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.2.647.g8b2efe2a0f
In-Reply-To: <20170713065050.19215-1-chriscool@tuxfamily.org>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add get_var_from_env_or_config() to easily set variables
from a config file if they are defined there and not already set.

This can also set them to a default value if one is provided.

As an example, use this function to set GIT_PERF_REPEAT_COUNT
from the perf.repeatCount config option or from the default
value.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/perf-lib.sh |  3 ---
 t/perf/run         | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index b50211b259..2f88fc12a9 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -59,9 +59,6 @@ perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
 mkdir -p "$perf_results_dir"
 rm -f "$perf_results_dir"/$(basename "$0" .sh).subtests
 
-if test -z "$GIT_PERF_REPEAT_COUNT"; then
-	GIT_PERF_REPEAT_COUNT=3
-fi
 die_if_build_dir_not_repo () {
 	if ! ( cd "$TEST_DIRECTORY/.." &&
 		    git rev-parse --build-dir >/dev/null 2>&1 ); then
diff --git a/t/perf/run b/t/perf/run
index 1e7c2a59e4..41580ac6df 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -34,6 +34,7 @@ unpack_git_rev () {
 	(cd "$(git rev-parse --show-cdup)" && git archive --format=tar $rev) |
 	(cd build/$rev && tar x)
 }
+
 build_git_rev () {
 	rev=$1
 	for config in config.mak config.mak.autogen config.status
@@ -92,6 +93,26 @@ run_dirs () {
 	done
 }
 
+get_var_from_env_or_config () {
+	env_var="$1"
+	conf_var="$2"
+	# $3 can be set to a default value
+
+	# Do nothing if the env variable is already set
+	eval "test -z \"\${$env_var+x}\"" || return
+
+	# Check if the variable is in the config file
+	test -n "$GIT_PERF_CONFIG_FILE" &&
+	conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$conf_var") &&
+	eval "$env_var=\"$conf_value\"" || {
+		test -n "${3+x}" &&
+		eval "$env_var=\"$3\""
+	}
+}
+
+get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf.repeatCount" 3
+export GIT_PERF_REPEAT_COUNT
+
 GIT_PERF_AGGREGATING_LATER=t
 export GIT_PERF_AGGREGATING_LATER
 
-- 
2.13.2.647.g8b2efe2a0f

