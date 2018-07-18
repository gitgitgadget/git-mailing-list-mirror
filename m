Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703371F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbeGRULs (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:48 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:52014 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbeGRULr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:47 -0400
Received: by mail-qk0-f202.google.com with SMTP id h67-v6so4452560qke.18
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=UB5bsxNAtE9LOfWRZ35VsahyWnHQK1EcvLSMudLLw24=;
        b=nC54YfaVQutkw3fEkjedUVME5x+X7dg3T7G6WlLflbcYxUiVWUpBy63l//kgPd6AVy
         OpWylbuVZxqzQ0fyrxmdE8XbcIac8qfln67HX97Fjo74JsTur/bj9hfoGvBb2d4yt7xT
         70fE4IRELQPq89hcfR0X+iS1JqunLH/fkHtLFL+WvnfdPADM3YTkQqQiNSo8sAbLou0n
         PSODhGMXn6srEFLManhl1z0I21Nc/J5UAfVBL7adizTvR1ReYF7BjvpqQaRaFdWtblF/
         cgN+GeQ6b0ZPmyaPzr+J4C+bFOzl6qs+GFGxDVZmpG0uBdEQTalV2EWQKFITPsLmbY6V
         iYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=UB5bsxNAtE9LOfWRZ35VsahyWnHQK1EcvLSMudLLw24=;
        b=lvCOIIeZMeKut0WtRXokxNEVovT5K0GgL4n2kvMSLzwrAgH4Drk6yooaPg5EU8C0Y2
         F+MMmbJcd0AHzcq02BEC1t4uF/T3+Ks+kt8HFslY6vjNQYpxhxy3dQQ2eqRDB1NXWvyO
         W/aZUHp1N+5jWaKivJcsKGqadiL6wwxyZfS2VF5vH14o2HptjXqn/QWhHxPsbGHHeLtJ
         hh7ddSbfEq66XXDRR1jTOXX+o9uqMyf1IhGf4AWZFjjAx57a5YDF1mRGqvlLpuiTPwaS
         FeHFxMpoASUCDKkD4ifh5CsrNBoAblOr9a/3SLJvApSrgiqFVGB9kUNeIyszM09NV6d4
         zIxQ==
X-Gm-Message-State: AOUpUlEJDKp+Q0MZppdQUE8rH81qjVNMq37ubkH9CpqXVYrevC8Wuec2
        PQ5urmOnXhePBAhc2hg1KkFTZzm9UgHKRtZ3MZaCCgufSU0XeIf+z6DK/3pCNuZCRZryZbnQYui
        hkRA7RWd5XmbXhWejtK+/ScdKHoLAjP2LrUrY8qWk/Vr7D76Bv7/iSuJtcpRH
X-Google-Smtp-Source: AAOMgpco5mYiEPkFZC+IAUhZeuMYTAvP6SRbJht+uHPAgyQPa5HSjGQ2lJa1M8ZYNwN51PYAePh+pjSrSMao
MIME-Version: 1.0
X-Received: by 2002:a37:a647:: with SMTP id p68-v6mr3758584qke.7.1531942346945;
 Wed, 18 Jul 2018 12:32:26 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:56 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com>
Message-Id: <20180718193156.47365-11-sbeller@google.com>
References: <20180718193156.47365-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 10/10] diff.c: offer config option to control ws handling in
 move detection
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt       | 5 +++++
 Documentation/diff-options.txt | 7 +++++--
 diff.c                         | 9 +++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb37..6ca7118b018 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1122,6 +1122,11 @@ diff.colorMoved::
 	true the default color mode will be used. When set to false,
 	moved lines are not colored.
 
+diff.colorMovedWS::
+	When moved lines are colored using e.g. the `diff.colorMoved` setting,
+	this option controls the `<mode>` how spaces are treated
+	for details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
+
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 143acd9417e..8da7fed4e22 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -294,8 +294,11 @@ dimmed_zebra::
 
 --color-moved-ws=<modes>::
 	This configures how white spaces are ignored when performing the
-	move detection for `--color-moved`. These modes can be given
-	as a comma separated list:
+	move detection for `--color-moved`.
+ifdef::git-diff[]
+	It can be set by the `diff.colorMovedWS` configuration setting.
+endif::git-diff[]
+	These modes can be given as a comma separated list:
 +
 --
 ignore-space-at-eol::
diff --git a/diff.c b/diff.c
index 7810a4733f8..5089c6eb3a4 100644
--- a/diff.c
+++ b/diff.c
@@ -35,6 +35,7 @@ static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
 static int diff_color_moved_default;
+static int diff_color_moved_ws_default;
 static int diff_context_default = 3;
 static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
@@ -332,6 +333,13 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_color_moved_default = cm;
 		return 0;
 	}
+	if (!strcmp(var, "diff.colormovedws")) {
+		int cm = parse_color_moved_ws(value);
+		if (cm < 0)
+			return -1;
+		diff_color_moved_ws_default = cm;
+		return 0;
+	}
 	if (!strcmp(var, "diff.context")) {
 		diff_context_default = git_config_int(var, value);
 		if (diff_context_default < 0)
@@ -4327,6 +4335,7 @@ void diff_setup(struct diff_options *options)
 	}
 
 	options->color_moved = diff_color_moved_default;
+	options->color_moved_ws_handling = diff_color_moved_ws_default;
 }
 
 void diff_setup_done(struct diff_options *options)
-- 
2.18.0.233.g985f88cf7e-goog

