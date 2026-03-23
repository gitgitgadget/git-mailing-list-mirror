Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57612CDA5
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282233; cv=none; b=PHrnmvojZWzVTPXu5NWtIYHoyIU1631DqAIJUzwqeuOjZF4awfqGe+rN/YB4qh+7YXWiE2Wsi0WB802e7twPCfB2qSEpxcABg8RYRsIT2nA8Fa4OsjMWQEfsiICYEVzjOdcnYAB1FYKlWFU4aFBkki+r8TvPgqvQI1aNReOt1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282233; c=relaxed/simple;
	bh=oTtSoQVMl0ALjO551CS1gB6lL6nIFFS4M0RpWDTGJVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YiR/g30Btdr4EDFqTC3ndB/dW+E7iEgfx4FQ60Wu/QvvEPRRl8XQH8TloytLf5Ft81FX7PurvWvutNGfEKco2On4mD7OYKLXYDYu8WzUAEB7+jPlNekuhRpLXCgwEFi9sBqBO2h2BYw4BIJ2enZ5jIpVILDqEPpumzjMxxQoQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=p5Y2ZGPQ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="p5Y2ZGPQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774282229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ci6RZVH1RCoVK3D+2uL7vj0TGoRe2wYLXgDs5tzLCJg=;
	b=p5Y2ZGPQm+ui89s874kUYkKtrS8fR6UrrPpZ16kq/DgQU/YueEVE73bGj7tXk/Z2QrcBzi
	Up3r1GCIzpZJTcuYjeRFv/9BKBrlC7dB1xzjyIA8ZEBnq4psoiUjR5MRc6yAdOCguFu5DH
	u0vqdwyMn7GRyGy/jojxh0JYJt0dj/c=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 23 Mar 2026 17:09:51 +0100
Subject: [PATCH 2/3] builtin/replay: improve documentation on options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-toon-replay-arbitrary-ref-v1-2-5c7172f675ec@iotcl.com>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
In-Reply-To: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Siddharth Asthana <siddharthasthana31@gmail.com>, 
 Yee Cheng Chin <yeecheng.chin@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Most of the options for the command git-replay(1) expect a value
argument. Make that more clear in the docs, by using an equal sign
between the option and the value.

Also, none of the options are negatable, thus mark them as such using
PARSE_OPT_NONEG.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-replay.adoc |  3 ++-
 builtin/replay.c              | 32 ++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 6698cfc047..e4fef548e0 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,7 +9,8 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
+			     [--ref-action=<mode>] <revision-range>
 
 DESCRIPTION
 -----------
diff --git a/builtin/replay.c b/builtin/replay.c
index fe69f6f8ce..2e9fd6281d 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -83,25 +83,29 @@ int cmd_replay(int argc,
 
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
-		   "([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) "
-		   "[--ref-action[=<mode>]] <revision-range>..."),
+		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
+		   "[--ref-action=<mode>] <revision-range>"),
 		NULL
 	};
 	struct option replay_options[] = {
-		OPT_STRING(0, "advance", &opts.advance,
-			   N_("branch"),
-			   N_("make replay advance given branch")),
-		OPT_STRING(0, "onto", &opts.onto,
-			   N_("revision"),
-			   N_("replay onto given commit")),
+		OPT_STRING_F(0, "onto", &opts.onto,
+			     N_("revision"),
+			     N_("replay onto given commit"),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "advance", &opts.advance,
+			     N_("branch"),
+			     N_("make replay advance given branch"),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "revert", &opts.revert,
+			     N_("branch"),
+			     N_("revert commits onto given branch"),
+			     PARSE_OPT_NONEG),
 		OPT_BOOL(0, "contained", &opts.contained,
 			 N_("update all branches that point at commits in <revision-range>")),
-		OPT_STRING(0, "revert", &opts.revert,
-			   N_("branch"),
-			   N_("revert commits onto given branch")),
-		OPT_STRING(0, "ref-action", &ref_action,
-			   N_("mode"),
-			   N_("control ref update behavior (update|print)")),
+		OPT_STRING_F(0, "ref-action", &ref_action,
+			     N_("mode"),
+			     N_("control ref update behavior (update|print)"),
+			     PARSE_OPT_NONEG),
 		OPT_END()
 	};
 

-- 
2.53.0.310.g728cabbaf7

