Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC510C4332F
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 01:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF9060F48
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 01:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhJXBxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 21:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhJXBxa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 21:53:30 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18854C061767
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 18:51:07 -0700 (PDT)
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635039788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUg3Lve2pZsGu4Pq6OkjIwYeQbOuLiADNaWLFP/We6s=;
        b=N25vlTuunyoioBb6mQQrNXzxqACYf2ERt+Q59aKDvjbrDZnrbcdOWVZG7i2ILWCo6PGree
        lylaO0v1YCfGHkBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635039788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUg3Lve2pZsGu4Pq6OkjIwYeQbOuLiADNaWLFP/We6s=;
        b=PHcWpfnHH2iPQgKREDJ/z1mdUw45ZjmXwikCuAM5iKs9+9jWHVpt8CqMP25bmmjlr4yf+n
        UjjHXqPJcp/fya5BblFAVV2GbFXMpBeATcXlDdE1Y0gGddJknMWC4kQ0e20epUVEA87qD5
        FO+/LQ23Zg1rbp1AkjQMqSgxkh0ciCGxMFwd/tEeqdhPtCl+KGt//4J5DeghY14eB6KPEE
        XnWSHWrOO1lHEYzpuIsnvVxgh3vATgqbqeM0O2CKYzUAFQkyN9q8kB7Phs53CCAhGWAwhC
        dEj+y2FRshyL8WMMgF+eqpXR5t/bhW7VPEjAAoHh9uo49fZUb03sxt0ELd0UUysy5ka3Da
        5r5XkHJyxUvCuQ8+1MzDHxdX4tRQ5n83gphnFw28vDW7Wwa0WSS+bRCCARn5jROv36hrku
        HszexOY9606DR+MBSJHcC1Zpt7Nq9DaU1+LJkoNPsPXGyTzHHCH5dZQVVR80CJugYfhIRF
        c9EI/3H0ZygmLO6Zh8L+tPL8zPPxGGee0YGrQ8squAAFq+1DhCUKu/fQzsfuQTR9b+wpzR
        oarY0XhDgnm4e2HnmN6WBf6vlAMwIJPrD9feG9BDAdkNyBWNLdfnS5ITVw2UbJV4+o25T/
        Cag6b6n0YEtaPrOzQqh7LJXdQj6Sbw8q5Vwq9yYv82uy3BLefcL3Y=
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/3] pretty: add tag option to %(describe)
Date:   Sat, 23 Oct 2021 21:42:55 -0400
Message-Id: <20211024014256.3569322-3-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211024014256.3569322-1-eschwartz@archlinux.org>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The %(describe) placeholder by default, like `git describe`, only
supports annotated tags. However, some people do use lightweight tags
for releases, and would like to describe those anyway. The command line
tool has an option to support this.

Teach the placeholder to support this as well.

Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
---
 Documentation/pretty-formats.txt | 11 ++++++-----
 pretty.c                         | 23 +++++++++++++++++++----
 t/t4205-log-pretty-formats.sh    |  8 ++++++++
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index ef6bd420ae..14107ac191 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -220,6 +220,7 @@ The placeholders are:
 			  inconsistent when tags are added or removed at
 			  the same time.
 +
+** 'tags[=<BOOL>]': Also consider lightweight tags.
 ** 'match=<pattern>': Only consider tags matching the given
    `glob(7)` pattern, excluding the "refs/tags/" prefix.
 ** 'exclude=<pattern>': Do not consider tags matching the given
@@ -273,11 +274,6 @@ endif::git-rev-list[]
 			  If any option is provided multiple times the
 			  last occurrence wins.
 +
-The boolean options accept an optional value `[=<BOOL>]`. The values
-`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
-sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
-option is given with no value, it's enabled.
-+
 ** 'key=<K>': only show trailers with specified key. Matching is done
    case-insensitively and trailing colon is optional. If option is
    given multiple times trailer lines matching any of the keys are
@@ -313,6 +309,11 @@ insert an empty string unless we are traversing reflog entries (e.g., by
 decoration format if `--decorate` was not already provided on the command
 line.
 
+The boolean options accept an optional value `[=<BOOL>]`. The values
+`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
+sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
+option is given with no value, it's enabled.
+
 If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
diff --git a/pretty.c b/pretty.c
index 9db2c65538..3a41bedf1a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1216,28 +1216,43 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 
 static size_t parse_describe_args(const char *start, struct strvec *args)
 {
+	const char *options[] = { "tags" };
 	const char *option_arguments[] = { "match", "exclude" };
 	const char *arg = start;
 
 	for (;;) {
 		const char *matched = NULL;
-		const char *argval;
+		const char *argval = NULL;
 		size_t arglen = 0;
+		int optval = 0;
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(option_arguments); i++) {
 			if (match_placeholder_arg_value(arg, option_arguments[i], &arg,
 							&argval, &arglen)) {
 				matched = option_arguments[i];
+				if (!arglen)
+					return 0;
 				break;
 			}
 		}
+		if (!matched)
+			for (i = 0; i < ARRAY_SIZE(options); i++) {
+				if (match_placeholder_bool_arg(arg, options[i], &arg,
+								&optval)) {
+					matched = options[i];
+					break;
+				}
+			}
 		if (!matched)
 			break;
 
-		if (!arglen)
-			return 0;
-		strvec_pushf(args, "--%s=%.*s", matched, (int)arglen, argval);
+
+		if (argval) {
+			strvec_pushf(args, "--%s=%.*s", matched, (int)arglen, argval);
+		} else if (optval) {
+			strvec_pushf(args, "--%s", matched);
+		}
 	}
 	return arg - start;
 }
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 5865daa8f8..d4acf8882f 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1002,4 +1002,12 @@ test_expect_success '%(describe:exclude=...) vs git describe --exclude ...' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(describe:tags) vs git describe --tags' '
+	test_when_finished "git tag -d tagname" &&
+	git tag tagname &&
+	git describe --tags >expect &&
+	git log -1 --format="%(describe:tags)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.1

