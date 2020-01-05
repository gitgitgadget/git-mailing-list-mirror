Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2116DC3F68F
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A10207FD
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="KT4ArbRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAEN42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 08:56:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35304 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgAEN41 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 08:56:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so25621156pgk.2
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 05:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7J3T2/4gN+snMLfgrgMvF4sEb3cWxs40pk/hybRh2Xo=;
        b=KT4ArbRq4EHW/AAeVurmHY6MrqP2/TNIdy2MDJSigPkZ43Lk68/Sa+dnmYAc+oxfAn
         hZyr7udG1nDa+KdLALTEqSOaA4A9kz+rAGD6UIA7rvZgzaiwUKrujfejZRK2bZf9oSvH
         +PhKPc6WjWMwdlKcNW3M+bWxKT0kBky7QAxHP3UZp1/JB0tVV4qtKiCUKsor2L1ChLLM
         WerMqM2hs3D3N4iJjike3gWx4rWJ3d4sexW3B410cL0myc7MtlOVqX5733PsMEizwAA0
         Azp0I1er2WlBl0GU5YDjh/IxQ8mEKk29TwitEW95JM60VRGGq9VosNrM3CO7SJosCp0E
         KFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7J3T2/4gN+snMLfgrgMvF4sEb3cWxs40pk/hybRh2Xo=;
        b=BRp0ciz1AcfsOa0CXqDpjIILA4mx+PGBlwmAk708zY2oufNL++CHiMfrDKlAG1XX9B
         hndDKYLbYZWrrYyl4yGSWFSNvS8jnOM/sDbyrJoXJSauC9BdpMm7rZysaNp3LHqRFefC
         g4jy1WwRlSg8LzP52YKCDJo5gLEuOVYbuVMA/Z1g1/RPu1BO9EfXC2Ds3paP6ChuwWgf
         tWey4HZNMezDO18NWImpAqNvgo7JEY5NKGYHLLDPwAE95UWwu7Nw97w9Q/8VPktnfIzp
         2JBND22Mmx/GX0PikkMNv22MMjDz58wwji1jP8L+TjppYBHrSZKLLACuRx6iL7gRQpt6
         r7JQ==
X-Gm-Message-State: APjAAAXApEB/numvoolNGip7hWhUwUMof+Li88jPEtlB2AZEgENsGpn7
        14RqPd/378/C+msTIC3dSo1IdjYcpoA=
X-Google-Smtp-Source: APXvYqy6g7T2SGpsFTDm7Wbf32JUaxixQlUSSieaLkXkSgvr4CpMehDZ0f5/9/7WyBj7Crfk107+HQ==
X-Received: by 2002:a63:ff20:: with SMTP id k32mr102963567pgi.448.1578232586528;
        Sun, 05 Jan 2020 05:56:26 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id q11sm74242882pff.111.2020.01.05.05.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 05:56:26 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 2/5] gpg-interface: support one-line summaries in print_signature_buffer()
Date:   Sun,  5 Jan 2020 13:56:13 +0000
Message-Id: <20200105135616.19102-3-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200105135616.19102-1-hji@dyntopia.com>
References: <20200105135616.19102-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most consumers of the GPG interface use print_signature_buffer() to show
the result from signature verifications.  One notable exception was
verify_merge_signature().

Previously, the verify_merge_signature() function processed the
signature_check structure in order to print a one-line summary of the
result.

I think that the one-line summary format has potential use in other
parts of Git; and not only for merges.  I also think that it makes sense
to have /one/ summary format in order to avoid confusing users with
different output styles for different operations.

This patch moves the one-line summary from verify_merge_signature() to
print_signature_buffer().  It also introduces a GPG_VERIFY_SHORT flag
that determines whether the summary should be printed.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 builtin/verify-commit.c |  3 ++-
 commit.c                | 23 +++++------------------
 gpg-interface.c         | 41 ++++++++++++++++++++++++++++++++++++++++-
 gpg-interface.h         |  4 +++-
 tag.c                   |  7 ++++---
 5 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 2a099ec6ba..acc01a7be9 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -28,7 +28,8 @@ static int run_gpg_verify(struct commit *commit, unsigned flags)
 	memset(&signature_check, 0, sizeof(signature_check));
 
 	ret = check_commit_signature(commit, &signature_check);
-	print_signature_buffer(&signature_check, flags);
+	print_signature_buffer(&commit->object.oid, &signature_check, ret,
+			       flags);
 
 	signature_check_clear(&signature_check);
 	return ret;
diff --git a/commit.c b/commit.c
index 3f91d3efc5..519599469b 100644
--- a/commit.c
+++ b/commit.c
@@ -1139,29 +1139,16 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 void verify_merge_signature(struct commit *commit, int verbosity,
 			    int check_trust)
 {
-	char hex[GIT_MAX_HEXSZ + 1];
 	struct signature_check signature_check;
 	int ret;
 	memset(&signature_check, 0, sizeof(signature_check));
 
 	ret = check_commit_signature(commit, &signature_check);
-
-	find_unique_abbrev_r(hex, &commit->object.oid, DEFAULT_ABBREV);
-	switch (signature_check.result) {
-	case 'G':
-		if (ret || (check_trust && signature_check.trust_level < TRUST_MARGINAL))
-			die(_("Commit %s has an untrusted GPG signature, "
-			      "allegedly by %s."), hex, signature_check.signer);
-		break;
-	case 'B':
-		die(_("Commit %s has a bad GPG signature "
-		      "allegedly by %s."), hex, signature_check.signer);
-	default: /* 'N' */
-		die(_("Commit %s does not have a GPG signature."), hex);
-	}
-	if (verbosity >= 0 && signature_check.result == 'G')
-		printf(_("Commit %s has a good GPG signature by %s\n"),
-		       hex, signature_check.signer);
+	ret |= check_trust && signature_check.trust_level < TRUST_MARGINAL;
+	print_signature_buffer(&commit->object.oid, &signature_check, ret,
+			       GPG_VERIFY_SHORT);
+	if (ret)
+		die(_("Signature verification failed"));
 
 	signature_check_clear(&signature_check);
 }
diff --git a/gpg-interface.c b/gpg-interface.c
index fc182d39be..838ece2b37 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -5,6 +5,8 @@
 #include "gpg-interface.h"
 #include "sigchain.h"
 #include "tempfile.h"
+#include "object.h"
+#include "object-store.h"
 
 static char *configured_signing_key;
 static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
@@ -333,16 +335,53 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 	return !!status;
 }
 
-void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
+void print_signature_buffer(const struct object_id *oid,
+			    const struct signature_check *sigc, int status,
+			    unsigned flags)
 {
 	const char *output = flags & GPG_VERIFY_RAW ?
 		sigc->gpg_status : sigc->gpg_output;
+	char hex[GIT_MAX_HEXSZ + 1];
+	char *type;
 
 	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
 		fputs(sigc->payload, stdout);
 
 	if (flags & GPG_VERIFY_FULL && output)
 		fputs(output, stderr);
+
+	if (flags & GPG_VERIFY_SHORT && oid) {
+		type = xstrdup_or_null(
+			type_name(oid_object_info(the_repository, oid, NULL)));
+		if (!type)
+			type = xstrdup("object");
+		*type = toupper(*type);
+
+		find_unique_abbrev_r(hex, oid, DEFAULT_ABBREV);
+
+		switch (sigc->result) {
+		case 'G':
+			if (status)
+				error(_("%s %s has an untrusted GPG signature, "
+					"allegedly by %s."),
+				      type, hex, sigc->signer);
+			else
+				printf(_("%s %s has a good GPG signature by %s\n"),
+				       type, hex, sigc->signer);
+			break;
+		case 'N':
+			error(_("%s %s does not have a GPG signature."), type,
+			      hex);
+			break;
+		default:
+			error(_("%s %s has a bad GPG signature "
+				"allegedly by %s."),
+			      type, hex, sigc->signer);
+			break;
+		}
+
+		free(type);
+	}
 }
 
 size_t parse_signature(const char *buf, size_t size)
diff --git a/gpg-interface.h b/gpg-interface.h
index 4631a91330..2f349f8ed5 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -6,6 +6,7 @@ struct strbuf;
 #define GPG_VERIFY_VERBOSE (1 << 0)
 #define GPG_VERIFY_RAW (1 << 1)
 #define GPG_VERIFY_FULL (1 << 2)
+#define GPG_VERIFY_SHORT (1 << 3)
 
 enum signature_trust_level {
 	TRUST_UNDEFINED,
@@ -60,7 +61,8 @@ const char *get_signing_key(void);
 int check_signature(const char *payload, size_t plen,
 		    const char *signature, size_t slen,
 		    struct signature_check *sigc);
-void print_signature_buffer(const struct signature_check *sigc,
+void print_signature_buffer(const struct object_id *oid,
+			    const struct signature_check *sigc, int status,
 			    unsigned flags);
 
 #endif
diff --git a/tag.c b/tag.c
index b8d6da81eb..f6ad4171f9 100644
--- a/tag.c
+++ b/tag.c
@@ -10,7 +10,8 @@
 
 const char *tag_type = "tag";
 
-static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
+static int run_gpg_verify(const struct object_id *oid, const char *buf,
+			  unsigned long size, unsigned flags)
 {
 	struct signature_check sigc;
 	size_t payload_size;
@@ -28,7 +29,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 
 	ret = check_signature(buf, payload_size, buf + payload_size,
 				size - payload_size, &sigc);
-	print_signature_buffer(&sigc, flags);
+	print_signature_buffer(oid, &sigc, ret, flags);
 
 	signature_check_clear(&sigc);
 	return ret;
@@ -57,7 +58,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 				name_to_report :
 				find_unique_abbrev(oid, DEFAULT_ABBREV));
 
-	ret = run_gpg_verify(buf, size, flags);
+	ret = run_gpg_verify(oid, buf, size, flags);
 
 	free(buf);
 	return ret;
-- 
2.25.0.rc1.302.gc71d20beed

