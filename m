Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D68B1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbcHCUpV (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:45:21 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34793 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362AbcHCUpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:45:18 -0400
Received: by mail-pa0-f52.google.com with SMTP id fi15so77158022pac.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:44:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AvtI2fQYeT2tN9ffI/CsQgf2whIy9pF9iIIAOo1tRKk=;
        b=gUpLkXRHGYp6uEKpy3SLkZZ5i6fRQUsoRxF/481jr4D4/aJeGnUSbVM5545Mbw/deh
         UvXqKxyDqK235o0c1WwHXBRZZrWb/bpfyHw9Ib8ou0fojD67z99ocmhMh4b+COWJ7VuH
         lY/JQZD4DX+wovpvRefg2FOBy9P+iZtt1Yvrh7An6C7fvgxPsdRRqOCPiP0o4BamneRD
         p2E1y3PiO7Yys+skB/PMuHI2KP3phF64ovEkiF9Ukq+6+OFrnIx/W7AC0KuurIOt5b5V
         lu74wXHpRZgoko+cTev1ZaOaj8D36+4hbmXrZRMbWSvtpvSV5RFLKu11EAoA9aarR0FA
         X/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AvtI2fQYeT2tN9ffI/CsQgf2whIy9pF9iIIAOo1tRKk=;
        b=IcM0Y9ZchwCR321Uy2F//wjoT1Q7mTXU4kUEtynY/Lhc7/mh6FLW8rmCkn132pb0Xs
         3wO/Ldo6tKjcxnDeFjrzqW7as1qbwlqVRg2yWDS+zH79zkexNK6OFcOps04/rzK1M/LT
         hrcbQ59FLhPh5g4J8UZTUsCYyv3NbxFDmLGMqpe5hnX9efUTCskZIHjFPNF49BwcKWmU
         UeLzH7/ZjY+Z7ykQlSC77IBfcUYg5bBXPWCz8WpXNrRmPMcNW8qIZa54EHmLCLVmBMHB
         fxK//6/IlVlb2NY3CAK9WJjhKK6x3QZzaKIZm+rBob05w4OMinPTYfCGAvX1jKaW9AUL
         smoA==
X-Gm-Message-State: AEkoouvxHikRixBi0eSZGnqAOOA0hQW25MilVwzNBXVMECuyT/UlZTJbd0kDDht1Lguj1MJz
X-Received: by 10.66.49.40 with SMTP id r8mr18769537pan.69.1470257063192;
        Wed, 03 Aug 2016 13:44:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f855:e892:92e2:7149])
        by smtp.gmail.com with ESMTPSA id e2sm14725329pfd.45.2016.08.03.13.44.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 13:44:22 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 6/7] submodule--helper: add remote-branch helper
Date:	Wed,  3 Aug 2016 13:44:03 -0700
Message-Id: <20160803204404.3356-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.524.gdbd1860
In-Reply-To: <20160803204404.3356-1-sbeller@google.com>
References: <20160803204404.3356-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In a later patch we want to enhance the logic for the branch selection.
Rewrite the current logic to be in C, so we can directly use C when
we enhance the logic.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 36 +++++++++++++++++++++++++++++++++++-
 git-submodule.sh            |  2 +-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fb90c64..9be2c75 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -899,6 +899,39 @@ static int resolve_relative_path(int argc, const char **argv, const char *prefix
	return 0;
 }
 
+static const char *remote_submodule_branch(const char *path)
+{
+	const struct submodule *sub;
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
+	sub = submodule_from_path(null_sha1, path);
+	if (!sub)
+		return NULL;
+
+	if (!sub->branch)
+		return "master";
+
+	return sub->branch;
+}
+
+static int resolve_remote_submodule_branch(int argc, const char **argv,
+		const char *prefix)
+{
+	const char *ret;
+	struct strbuf sb = STRBUF_INIT;
+	if (argc != 2)
+		die("submodule--helper remote-branch takes exactly one arguments, got %d", argc);
+
+	ret = remote_submodule_branch(argv[1]);
+	if (!ret)
+		die("submodule %s doesn't exist", argv[1]);
+
+	printf("%s", ret);
+	strbuf_release(&sb);
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -912,7 +945,8 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path},
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
-	{"init", module_init}
+	{"init", module_init},
+	{"remote-branch", resolve_remote_submodule_branch}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 41aff65..8c5e898 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -614,7 +614,7 @@ cmd_update()
 
 		if test -n "$remote"
 		then
-			branch=$(get_submodule_config "$name" branch master)
+			branch=$(git submodule--helper remote-branch "$sm_path")
 			if test -z "$nofetch"
 			then
 				# Fetch remote before determining tracking $sha1
-- 
2.9.2.524.gdbd1860

