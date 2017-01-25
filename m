Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56931F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbdAYWDz (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:55 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33270 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbdAYWD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:26 -0500
Received: by mail-pg0-f45.google.com with SMTP id 204so67749188pge.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qgnhQeY29uB5WiBYcNmhuMeRap6I6oPKnN9IrMFrbWQ=;
        b=p6BXd+3pw1x1CRbC/q08eECM2NOrA9d+kNIg5bKnQY1sAAJMDWa5ImIFlCGJPQkEaR
         LjQLCPP6s61RYZIfSdTj6PcB3CmZx1Zjp0u3lhpdR8B1YQDiy6j1teEhgRCvxIXwGcVi
         sm8cOjEMfZHCZzv4TLuISJQVnTlTto3sR7+1axK+cWos97LEixlhCCJAf7ROQO9WjEJd
         poM39kE9sQGha4PpK5o68uGMpYTOuAW6TaAD3BRplk5YQzsUY0QKoHgUdaE2xjrz07WN
         oahD0pNJPoJ4gPpyvacB0/1e0bJr2h62sM1I4NLqFSfGUP4aBSfmmUTq7pQMZsoQC93J
         Ph1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qgnhQeY29uB5WiBYcNmhuMeRap6I6oPKnN9IrMFrbWQ=;
        b=oX+OjWokyKRNFBIR6KDsLuw1R3YoHREsFuUCx/mPoPqty/AJqfLkWM4iofcqX9zyxM
         5MXnq3s+l8vXQz74O1ZHLnC0kv3DgxMOmMDfMgEOmHpFYAV1ZVGEFd9ou+LCV61LUStj
         q0W2nOEq0LfWIqPQmHQhMvnpB4/gDMqbb6y9IzOTIxi2HAm2U1/uYOz2U4U341XJAyZa
         sm2j6mvHzoPDV/uZm4wsSFniL6PxA8FQ+15Mc8AQAMLlWXNyH1LjGvQet6eco7vScHA3
         lCKF1sq4z+0U9X2UVsXMPjdLWS6tfOJ8H9wLmg83+dwGC8n2StCMBdPb8PXGriJ4QDo4
         Z9qg==
X-Gm-Message-State: AIkVDXI7cUgUnPWXpjRbam4Jgoec+WbCb6f49jjGjDfvhuZUvt7iyZld+wjhQoBHNlgQIzsV
X-Received: by 10.98.16.201 with SMTP id 70mr49167908pfq.25.1485381805686;
        Wed, 25 Jan 2017 14:03:25 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:25 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 08/14] fetch-pack: check returned refs for matches
Date:   Wed, 25 Jan 2017 14:03:01 -0800
Message-Id: <b722c0e310305a7eb4013209122db3a0c7b2052c.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of setting "matched" on matched refs, detect matches by checking
the sought refs against the returned refs.  Also, since the "matched"
field in struct ref is now no longer used, remove it.

This is the 2nd of 3 patches to eliminate using input refs to
communicate information obtained by the fetch mechanism.

(There are possibly ways more efficient than a nested for loop to
accomplish this. However, since a subsequent patch will compare the
user-provided refspecs against the fetched refs directly, and thus
necessitating the nested for loop anyway, I decided to use the nested
for loop in this patch.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch-pack.c | 7 ++++++-
 fetch-pack.c         | 9 ++++++---
 fetch-pack.h         | 2 --
 remote.h             | 3 +--
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index cfe9e447c..f31f874a0 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -4,6 +4,7 @@
 #include "remote.h"
 #include "connect.h"
 #include "sha1-array.h"
+#include "refs.h"
 
 static const char fetch_pack_usage[] =
 "git fetch-pack [--all] [--stdin] [--quiet | -q] [--keep | -k] [--thin] "
@@ -220,7 +221,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	 * an error.
 	 */
 	for (i = 0; i < nr_sought; i++) {
-		if (!sought[i] || sought[i]->matched)
+		struct ref *r;
+		for (r = ref; r; r = r->next)
+			if (!sought[i] || refname_match(sought[i]->name, r->name))
+				break;
+		if (r)
 			continue;
 		error("no such remote ref %s", sought[i]->name);
 		ret = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index 9a87ddd3d..d4642b05c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -562,6 +562,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
 	int i;
+	int *matched = xcalloc(nr_sought, sizeof(*matched));
 
 	i = 0;
 	for (ref = *refs; ref; ref = next) {
@@ -578,7 +579,7 @@ static void filter_refs(struct fetch_pack_args *args,
 					break; /* definitely do not have it */
 				else if (cmp == 0) {
 					keep = 1; /* definitely have it */
-					sought[i]->matched = 1;
+					matched[i] = 1;
 				}
 				i++;
 			}
@@ -604,19 +605,21 @@ static void filter_refs(struct fetch_pack_args *args,
 			unsigned char sha1[20];
 
 			ref = sought[i];
-			if (ref->matched)
+			if (matched[i])
 				continue;
 			if (get_sha1_hex(ref->name, sha1) ||
 			    ref->name[40] != '\0' ||
 			    hashcmp(sha1, ref->old_oid.hash))
 				continue;
 
-			ref->matched = 1;
+			matched[i] = 1;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
 		}
 	}
 	*refs = newlist;
+
+	free(matched);
 }
 
 static void mark_alternate_complete(const struct ref *ref, void *unused)
diff --git a/fetch-pack.h b/fetch-pack.h
index c912e3d32..76f7c719c 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -33,8 +33,6 @@ struct fetch_pack_args {
 
 /*
  * sought represents remote references that should be updated from.
- * On return, the names that were found on the remote will have been
- * marked as such.
  */
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
diff --git a/remote.h b/remote.h
index 57d059431..2f7f23d47 100644
--- a/remote.h
+++ b/remote.h
@@ -89,8 +89,7 @@ struct ref {
 		force:1,
 		forced_update:1,
 		expect_old_sha1:1,
-		deletion:1,
-		matched:1;
+		deletion:1;
 
 	/*
 	 * Order is important here, as we write to FETCH_HEAD
-- 
2.11.0.483.g087da7b7c-goog

