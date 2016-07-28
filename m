Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76EDD1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759079AbcG1QDW (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:03:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34580 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759032AbcG1QDK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:03:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so11846070wma.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:03:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dViDkst4QnvIZztznFbEDrk+bIxrPadU9g4lM67276c=;
        b=s2UpeKRimEXimi7FM9DRdByc3xT+vC7tkLrdPSfgkQMZQfiL+2aFHRP6q+qsSh09bx
         F4CztPTR73V7i25+JNX1X8xTspBMt6ZAG8SNATegyeXDlwyvSuWUUaFfW3+PZ/kAT/M1
         QW5LeGzHRg5bDZW9jErdzCxHJiDx+adXluGHfUpObVPQ0uDwmLJxzVCiZwi1xbx0G6cM
         q8QKk8UPfxMo6xPSTALwIAhwtQoCAYwedpecuu634Zhl1byA65zrb3lOz7vJOGz8luOJ
         dHYxLLeWv97W8bBQPcfmRef2SEa1aTvi97jy97CvROdwDUikxfnhgHhcoDn73yN6jnoG
         QvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dViDkst4QnvIZztznFbEDrk+bIxrPadU9g4lM67276c=;
        b=J3pzu01A2hw0//0UjoDnQDf3xCfBjAewxD4ZaUInbRSOjW/tczKJunw6+yGiw8LOdP
         rp9g7JPS0Y5TqAyQDcietMlUXL6Hg/2sMaDK94xIG2q91zQAt0bC9c9GkSMaPR224Wyf
         lXS1TQxL9gTuMls1iCkMC2T1jp83WbpPDdgweilNMReg9VwJIVSr9jXECJlZltVslWIT
         /8JHVUn7Vrl36IvuHNZg6+9wxcGZAyoUMUDp7x57LNdbmWJ6+TmMO+vriiiLbmLuHAFg
         Af6lpzerHlDvuOlajYg4KAHVNEDrr+QQoynhslcr1cAj5osEtgLhqURThnF7w5fbXCnG
         ta5w==
X-Gm-Message-State: AEkoouuqvagJ58MJHsigpV/+eBglyIiCfJ8/kmT/t4MBd8Fsh0c7HN9VfK3Ndna65P9YAA==
X-Received: by 10.194.153.5 with SMTP id vc5mr34341122wjb.75.1469721789131;
        Thu, 28 Jul 2016 09:03:09 -0700 (PDT)
Received: from localhost.localdomain (p54A20961.dip0.t-ipconnect.de. [84.162.9.97])
        by smtp.gmail.com with ESMTPSA id ka6sm12118232wjb.38.2016.07.28.09.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 09:03:08 -0700 (PDT)
From:	Robin Ruede <r.ruede@gmail.com>
To:	git@vger.kernel.org
Cc:	Robin Ruede <r.ruede@gmail.com>
Subject: [PATCH/RFC 4/7] fetch-pack: add sparse prefix to smart protocol
Date:	Thu, 28 Jul 2016 18:02:23 +0200
Message-Id: <20160728160226.24018-5-r.ruede@gmail.com>
X-Mailer: git-send-email 2.9.2.472.g105ab30
In-Reply-To: <20160728160226.24018-1-r.ruede@gmail.com>
References: <20160728160226.24018-1-r.ruede@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For example

    git fetch-pack --sparse-prefix=/contrib/ origin HEAD

Should fetch a pack that is generated on the remote by

    echo HEAD | git pack-objects --revs --stdout --sparse-prefix=/contrib/

Signed-off-by: Robin Ruede <r.ruede@gmail.com>
---
 builtin/fetch-pack.c |  6 ++++++
 fetch-pack.c         |  4 ++++
 fetch-pack.h         |  1 +
 remote-curl.c        |  2 ++
 upload-pack.c        | 15 ++++++++++++++-
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index bfd0be4..7f10001 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -64,6 +64,12 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.uploadpack = arg + 14;
 			continue;
 		}
+		if (starts_with(arg, "--sparse-prefix=")) {
+			args.sparse_prefix = arg + 16;
+			if(args.sparse_prefix[0] != '/')
+				die(N_("sparse prefix must start with /"));
+			continue;
+		}
 		if (starts_with(arg, "--exec=")) {
 			args.uploadpack = arg + 7;
 			continue;
diff --git a/fetch-pack.c b/fetch-pack.c
index b501d5c..8571b02 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -326,6 +326,8 @@ static int find_common(struct fetch_pack_args *args,
 		return 1;
 	}
 
+	if(args->sparse_prefix)
+		packet_buf_write(&req_buf, "sparse-prefix %s", args->sparse_prefix);
 	if (is_repository_shallow())
 		write_shallow_commits(&req_buf, 1, NULL);
 	if (args->depth > 0)
@@ -811,6 +813,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
 		die("Server does not support shallow clients");
+	if (args->sparse_prefix && !server_supports("sparse-prefix"))
+		die("Server does not support sparse prefix");
 	if (server_supports("multi_ack_detailed")) {
 		if (args->verbose)
 			fprintf(stderr, "Server supports multi_ack_detailed\n");
diff --git a/fetch-pack.h b/fetch-pack.h
index bb7fd76..8f36ef4 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -8,6 +8,7 @@ struct sha1_array;
 
 struct fetch_pack_args {
 	const char *uploadpack;
+	const char *sparse_prefix;
 	int unpacklimit;
 	int depth;
 	unsigned quiet:1;
diff --git a/remote-curl.c b/remote-curl.c
index 6b83b77..e181e62 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -727,6 +727,8 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 	ALLOC_ARRAY(targets, nr_heads);
 	if (options.depth)
 		die("dumb http transport does not support --depth");
+	if (options.sparse_prefix)
+		die("dumb http transport does not support --sparse-prefix");
 	for (i = 0; i < nr_heads; i++)
 		targets[i] = xstrdup(oid_to_hex(&to_fetch[i]->old_oid));
 
diff --git a/upload-pack.c b/upload-pack.c
index d4cc414..56d8c1a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -57,6 +57,7 @@ static int use_sideband;
 static int advertise_refs;
 static int stateless_rpc;
 static const char *pack_objects_hook;
+static char *sparse_prefix;
 
 static void reset_timeout(void)
 {
@@ -125,6 +126,12 @@ static void create_pack_file(void)
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
+	if (sparse_prefix) {
+		argv_array_push(&pack_objects.args, "--sparse-prefix");
+		argv_array_push(&pack_objects.args, sparse_prefix);
+		free(sparse_prefix);
+		sparse_prefix = NULL;
+	}
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
@@ -582,6 +589,12 @@ static void receive_needs(void)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
+		if (starts_with(line, "sparse-prefix ")) {
+			if(sparse_prefix)
+				die("Only single sparse-prefix is allowed");
+			sparse_prefix = xstrdup(line + 14);
+			continue;
+		}
 		if (!starts_with(line, "want ") ||
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git upload-pack: protocol error, "
@@ -730,7 +743,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed sparse-prefix";
 	const char *refname_nons = strip_namespace(refname);
 	struct object_id peeled;
 
-- 
2.9.1.283.g3ca5b4c.dirty

