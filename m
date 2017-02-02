Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC471F4E2
	for <e@80x24.org>; Thu,  2 Feb 2017 19:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdBBTtx (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 14:49:53 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35476 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdBBTtw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 14:49:52 -0500
Received: by mail-pg0-f65.google.com with SMTP id 204so2627555pge.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 11:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=w+vmOmCwXlyeYnd9cKxPZL1D3H06OKQ+4h19ZNdvUN8=;
        b=Or3sNqXeeJh3YHpMR75gCfb7eV/ljyOgeZS5n1ydcKBR/25DiNPxzHNLQ+inUpmoXg
         KiezTcBtXETC7IqPs99cOX4cVSo7RHnS97VIskesqmIlw9QTDTBNAktr3Ux7G38Hd+8X
         LOVE7PmBe1B5p+Zv+lDVwDIE4a9JV+s5Xr6auyTsidS6zk9qIF6BbdoQKg3jicSXWPRZ
         xbrM0fLkMbcwWa1N2XqOmKDxu91rJ97QrLkrNmUAUCIsSW4kmi7Bkyz4MeAZUbX80EpQ
         9yXBpjywDGwXBQKNMjBosZb9pJnvgYF3vJ/uQf8CNLq+2F2fNBYLTzxzbZZML5/s4h4Z
         6bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=w+vmOmCwXlyeYnd9cKxPZL1D3H06OKQ+4h19ZNdvUN8=;
        b=kcFi7nlyXhV2BkVIzOJ0USudFtMBRZrxB3431gUDorMTC5msngPJndrb/Tr88snAGi
         fYsgGo3HsgoT2rH9Pixoqzw3DojxVmEI63bmzprEFW4nQrxYpuoFu2isRzHPwxzs8Hbp
         v7CDs+l1ixOW7EvuhUWtsYs08y6V17n4xYnoOgYKsLwPFN+0107YcNsYu3atgdkVtd/n
         9RGRPY2JHglToNgygQatnvGcP53xtLmw5dUnQBYzTv86AaShKViubNpLvvKbUnlph89t
         Ws1n6c2fHUT1le2QoLQqDPfAGU4hgt9A25jRUsOWC5jFeT522ZzPmyKgGK7ZqoX9XYU+
         Cdgg==
X-Gm-Message-State: AIkVDXIbvE9vKj9dlSD2MMk4ADvI1jx4kJSN0u2IzjGI4dF6g86/FjBojtfAG5vdDisZXg==
X-Received: by 10.98.196.202 with SMTP id h71mr12799084pfk.66.1486064991773;
        Thu, 02 Feb 2017 11:49:51 -0800 (PST)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id c18sm60597902pfj.49.2017.02.02.11.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 11:49:50 -0800 (PST)
Date:   Thu, 2 Feb 2017 11:49:50 -0800 (PST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] ls-remote: add "--diff" option to show only refs that
 differ
Message-ID: <alpine.LFD.2.20.1702021143470.21619@i7.lan>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Feb 2017 11:37:49 -0800
Subject: [PATCH] ls-remote: add "--diff" option to show only refs that differ

My main use of "git ls-remote" tends to be to check what the other end
has when some pull request goes wrong (they forgot to push, or they used
the wrong ref name or whatever), and it ends up being hard to see all
the relevant data from the noise of people just having the same basic
tags etc from upstream.

So this adds a "--diff" option that shows only the refs that are
different from the local repository.  So when somebody asks me to pull,
I can now just trivially look at what they have that isn't already my
basic branches and tags.

Note that "--diff" implies "--refs" (ie it also disables showing peeled
tags).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is not a big deal, but maybe others have the same issues I've had. 
And maybe nobody else ever uses "git ls-remote". I dunno.

Also, I considered adding this feature as a more generic flag to 
"check_ref_type()" (ie add a REF_NONLOCAL option to complete the existing 
REF_NORMAL/REF_HEAD/etc flags), but that would have been a more involved 
patch and I'm not convinced it makes much sense for any other use, so I 
made it a specific local hack to ls-remote instead.

Comments?

 builtin/ls-remote.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 66cdd45cc..23469c3a6 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "transport.h"
 #include "remote.h"
+#include "refs.h"
 
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
@@ -31,6 +32,16 @@ static int tail_match(const char **pattern, const char *path)
 	return 0;
 }
 
+static int has_ref_locally(const struct ref *ref)
+{
+	unsigned char sha1[20];
+
+	if (!resolve_ref_unsafe(ref->name, RESOLVE_REF_READING, sha1, NULL))
+		return 0;
+
+	return !hashcmp(ref->old_oid.hash, sha1);
+}
+
 int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 {
 	const char *dest = NULL;
@@ -39,6 +50,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	int status = 0;
 	int show_symref_target = 0;
+	int diff = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
 
@@ -62,6 +74,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			    N_("exit with exit code 2 if no matching refs are found"), 2),
 		OPT_BOOL(0, "symref", &show_symref_target,
 			 N_("show underlying ref in addition to the object pointed by it")),
+		OPT_BOOL(0, "diff", &diff,
+			 N_("show only refs that differ from local refs")),
 		OPT_END()
 	};
 
@@ -98,6 +112,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (transport_disconnect(transport))
 		return 1;
 
+	if (diff)
+		flags |= REF_NORMAL;
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
 	for ( ; ref; ref = ref->next) {
@@ -105,6 +121,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
+		if (diff && has_ref_locally(ref))
+			continue;
 		if (show_symref_target && ref->symref)
 			printf("ref: %s\t%s\n", ref->symref, ref->name);
 		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
