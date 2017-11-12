Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F837201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 15:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdKLPAn (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 10:00:43 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:57986
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751150AbdKLPAm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 10:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1510498840;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=AKW2u/FztgUuqMaQba8ViZz2ale5Hcd4uJOiP5IntWY=;
        b=jyvzxwQ7XjTgb/ZJ6pMJt9vJdDaI3Q6v9XJwgdrI0VJoZnEM27qZC+uYNLTysdBi
        Z0mg6ydJy5vkxwKoGiDZyFOsFXspeqQ4NUi6lVVt7YyV1uGIkYI1G9a6Q6UCOdpMeW0
        XpifKaqAL3ipUBnvh1iD7oolKTxwmOB7XZ0g2Qh0=
From:   Soukaina NAIT HMID <nhsoukaina@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015fb0bf3002-3462777a-2363-40cf-af37-80e26c0db65b-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
Subject: [add-default-config 2/5] adding default to color
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Nov 2017 15:00:40 +0000
X-SES-Outgoing: 2017.11.12-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Soukaina NAIT HMID <snaithmid@bloomberg.net>

Signed-off-by: Soukaina NAIT HMID <snaithmid@bloomberg.net>
---
 builtin/config.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 124a682d50fa8..9df2d9c43bcad 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -30,6 +30,7 @@ static int end_null;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
+static const char *default_value;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -47,6 +48,7 @@ static int show_origin;
 #define ACTION_GET_COLOR (1<<13)
 #define ACTION_GET_COLORBOOL (1<<14)
 #define ACTION_GET_URLMATCH (1<<15)
+#define ACTION_GET_COLORORDEFAULT (1<<16)
 
 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
@@ -80,12 +82,13 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
 	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
 	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
-	OPT_BIT(0, "color", &actions, N_("find the color configured"), ACTION_GET_COLOR),
+	OPT_BIT(0, "color", &actions, N_("find the color configured"), ACTION_GET_COLORORDEFAULT),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_STRING(0, "default", &default_value, N_("default-value"), N_("sets default for bool/int/path/color when no value is returned from config")),
 	OPT_END(),
 };
 
@@ -331,6 +334,11 @@ static void get_color(const char *var, const char *def_color)
 	fputs(parsed_color, stdout);
 }
 
+static void get_color_default(const char *var)
+{
+	get_color(var, default_value);
+}
+
 static int get_colorbool_found;
 static int get_diff_color_found;
 static int get_color_ui_found;
@@ -726,6 +734,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		get_color(argv[0], argv[1]);
 	}
+	else if (actions == ACTION_GET_COLORORDEFAULT) {
+		check_argc(argc, 1, 1);
+		get_color_default(argv[0]);
+	}
 	else if (actions == ACTION_GET_COLORBOOL) {
 		check_argc(argc, 1, 2);
 		if (argc == 2)

--
https://github.com/git/git/pull/431
