Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA8C1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbdGaU4t (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:56:49 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38110 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdGaU4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:56:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id e3so9895328pfc.5
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=A42KBGlq40wHo3Hr14Wltbdii3i1mqAPc6ftyRAd9KwR2k832MMOR91YQLzDH9pYLX
         xv2m+xIKH7xGYWzls84JBgFSJINU9457Kzd0hQLEplCWewIAMPuPpM7qen4khFBYe794
         Y7qdJY3pPvALEuzcw4mHJujHeQP27cE9Djl+aCXeM7iqOp1k8YciBo3Lt1Ml48RQsE1E
         N578C0zCWbymZR/FENsswyviswnTS9WFAP7RM1gZY/AHnG3JZp30wtQQg99RyFzX56uZ
         vjv5IF7J3hOz33pwEtvIfiLy0bM9W032foypwFKqi/h4swua+DA047AXcEPK7kRBI3Mu
         sCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=EDSJ0qAkkr//B8mbIa32u30QU2TjHE1FpNjM3/uefWr+xnf3fPKsFMpKdyAwjfieWO
         dgKGNAhENi7hn47IalL+LNdZr5Nq4gRRTs/oHA8f+k1eqCd5dbG6XOOHMIpqXsIHvXoe
         J8KSCgGnDXiJ8WJS9iKUi6tTGOmaCjwAHSRpLYJMX2uSinNewR9HWKD4YrNONM3o3ARY
         lpR+v8F70iKsVjuZDUDMT5on7dyS0oR+Pmkj0y7++75ueUqQxjIcbclPC5S20x8tjjAw
         2ql9hEe8rzVCPu8VyZB5uU0H1CaNONtLHPYNXbNlN04jir79lVwB6gxUSmOU/Sde1fDV
         /91g==
X-Gm-Message-State: AIVw111OJYF9ouyOtBSntbXeEI3aS/iN4vY12a9SX1pqEQtzG5dk0rWW
        Df4/kmV8p/eJ1M3NIzEQZw==
X-Received: by 10.84.211.46 with SMTP id b43mr18521700pli.177.1501534604674;
        Mon, 31 Jul 2017 13:56:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6182:3b53:5da6:3508:cb8e:5545])
        by smtp.gmail.com with ESMTPSA id 16sm52881007pfq.151.2017.07.31.13.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:56:44 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 01/13] submodule--helper: introduce get_submodule_displaypath()
Date:   Tue,  1 Aug 2017 02:26:09 +0530
Message-Id: <20170731205621.24305-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170731205621.24305-1-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function get_submodule_displaypath() to replace the code
occurring in submodule_init() for generating displaypath of the
submodule with a call to it.

This new function will also be used in other parts of the system
in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6abdad329..7af4de09b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -220,6 +220,27 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	if (prefix && super_prefix) {
+		BUG("cannot have prefix '%s' and superprefix '%s'",
+		    prefix, super_prefix);
+	} else if (prefix) {
+		struct strbuf sb = STRBUF_INIT;
+		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
+		strbuf_release(&sb);
+		return displaypath;
+	} else if (super_prefix) {
+		int len = strlen(super_prefix);
+		const char *format = is_dir_sep(super_prefix[len - 1]) ? "%s%s" : "%s/%s";
+		return xstrfmt(format, super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -339,16 +360,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 	/* Only loads from .gitmodules, no overlay with .git/config */
 	gitmodules_config();
-
-	if (prefix && get_super_prefix())
-		die("BUG: cannot have prefix and superprefix");
-	else if (prefix)
-		displaypath = xstrdup(relative_path(path, prefix, &sb));
-	else if (get_super_prefix()) {
-		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
-		displaypath = strbuf_detach(&sb, NULL);
-	} else
-		displaypath = xstrdup(path);
+	displaypath = get_submodule_displaypath(path, prefix);
 
 	sub = submodule_from_path(null_sha1, path);
 
@@ -363,7 +375,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_active(the_repository, path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
 	}
-- 
2.13.0

