From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 3/3] Alternates API: Remove unused parameter
Date: Wed, 30 Mar 2011 21:28:11 +0000
Message-ID: <3c357acd119aa836f6cd3298d62cc5098f4c053c.1301521244.git.mfwitten@gmail.com>
References: <cover.1301521243.git.mfwitten@gmail.com>
            <5ed7886ec5e12c8e3a5f45d19625a4f5d2cdd38a.1301521243.git.mfwitten@gmail.com>
            <a0e5204fe8c03b3b6af2150198bad51f86b126c4.1301521243.git.mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 00:21:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q53lC-00081b-Cz
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 00:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933018Ab1C3WUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 18:20:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42540 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933094Ab1C3WUv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 18:20:51 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so1705463iyb.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 15:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:in-reply-to
         :references;
        bh=afWSp2H+X7WeysQkjFvjr5wqkPdj6tEyp6QV+Yc6dxE=;
        b=Wn3lmTGE/HNmAeHGx0Xu/oiUt5ltm9Nyl2ertKJDCmGaH+2e7412pA39EbBccWctCN
         YBM5iBIqlTfOSwVYU68rWcss+xjQinMSGQQKD1+QfKTFeiv2115olpr0VwOLgqhNZnMx
         8l0Lel+6IM0MIQgQTelhr/e5Ovtu5p9rv3sFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:in-reply-to:references;
        b=bm32hPZWY2ceItjkXuvAe7cbahYh0K46KlFQFUxWPwRB5u/iwe6IGy9BFJVwInwOGG
         n52k6Mjd9owhcyFt5nNUFv102BbNUc8NeZaxzYdS1DV4w/HVieWrgDw/q5ACUvvbUaEV
         F/qLQlGFpgGuAnyKWA4jPDngr28gfiEPA6zcQ=
Received: by 10.42.77.8 with SMTP id g8mr1650102ick.478.1301523650629;
        Wed, 30 Mar 2011 15:20:50 -0700 (PDT)
Received: from gmail.com ([109.123.119.163])
        by mx.google.com with ESMTPS id i26sm288621iby.41.2011.03.30.15.20.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 15:20:50 -0700 (PDT)
In-Reply-To: <cover.1301521243.git.mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170430>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 builtin/fetch-pack.c   |    2 +-
 builtin/receive-pack.c |    2 +-
 transport.c            |    2 +-
 transport.h            |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport.h b/transport.h
index 88fa484..cf6fda4 100644
--- a/transport.h
+++ b/transport.h
@@ -166,7 +166,7 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, int *nonfastforward);
 
-typedef void (*transport_alt_refs_fn)(const struct ref *, void *);
+typedef void (*transport_alt_refs_fn)(const struct ref *);
 extern int transport_alt_refs(struct alternate_object_database *, transport_alt_refs_fn);
 
 #endif
diff --git a/transport.c b/transport.c
index 53d37a9..165f69e 100644
--- a/transport.c
+++ b/transport.c
@@ -1217,7 +1217,7 @@ int transport_alt_refs(struct alternate_object_database *d, transport_alt_refs_f
 	for (extra = transport_get_remote_refs(transport);
 	     extra;
 	     extra = extra->next)
-		ref_fn(extra, NULL);
+		ref_fn(extra);
 	transport_disconnect(transport);
 	free(other);
 	return 0;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index b3a9f74..d2e0111 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -219,7 +219,7 @@ static void send_request(int fd, struct strbuf *buf)
 		safe_write(fd, buf->buf, buf->len);
 }
 
-static void insert_one_alternate_ref(const struct ref *ref, void *unused)
+static void insert_one_alternate_ref(const struct ref *ref)
 {
 	rev_list_insert_ref(NULL, ref->old_sha1, 0, NULL);
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a761332..47a5aaa 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -731,7 +731,7 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
-static void add_one_alternate_ref(const struct ref *ref, void *unused)
+static void add_one_alternate_ref(const struct ref *ref)
 {
 	add_extra_ref(".have", ref->old_sha1, 0);
 }
-- 
1.7.4.18.g68fe8
