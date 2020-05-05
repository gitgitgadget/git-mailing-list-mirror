Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAC5C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA21920658
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="XbUxE3P8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgEEBNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbgEEBNt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:13:49 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E557C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:13:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q124so250649pgq.13
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vHRIiWx89t6b6i0iG2vGJSmwe30s4IFWz7nTGrcVFZU=;
        b=XbUxE3P8hnaem+sfnKy+gQSgEGQzaffJU61kv72BLziGNCeGcQrrcQ3KIOQ/DBaA/E
         P9/blkBfruBenMETxVbjZFid0DCxX7lLY9EILq0HVvgns0Ovry9t65KPRwh1ggn9IdcU
         9Fz2W0DhY69JKE7OvdaMWAMbRXkSiCkSSOBHOUBSZ1ed+R4w4++CT1P2r3Vw/cxptH89
         eSyi6Nq/kO/ee3pJ9ciJAQEtaUaUOnZYcG/Mk0ln13gQBwuTLuojmKG7RxeLTSFic5eO
         kXQD6NK0Db61P9UPJmOCPAdf480B2qsrj4bMQnTTZH5ceScZP/CRfEt0/mqMWcEsGjD2
         ELlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vHRIiWx89t6b6i0iG2vGJSmwe30s4IFWz7nTGrcVFZU=;
        b=gW1+5twwewEGshhM1pGNdlnHDgmmk4pFc3qrQ32Usq9DvIK41gr4Mf7inYV/29jOYS
         l9cWDUEV09PbQWnBZesJY2vrj6ETYLm0SCTpMMJ8r4c8b2o7BM2xMoXRlN/HO3e+AG4W
         /Spn1oxToN0Dc7oiB2y9TOYrcJ1hWs/iDvkTaox8q6dzLzD6+dAgTgDb3BM0LmCV4k5p
         gxp5URekEZO/tuzsZBYUIxbbbMm2gvJIzOyt0X1qCE1IxS7o2VDIiQJ6KeJPSQLBNlUt
         wLvLFkt5j7ZPjctqV5fJSRGjhHLZXT9PAO8WZSwaxsAQZQc8oab9eRZTgxbDZ4p3WqPM
         amZQ==
X-Gm-Message-State: AGi0PuZla6r0n1hrkYh8p/eOljUoqx2JPQKFMUgTeNbY13DTlYBfo9WG
        2s0Fdhz7r8ZWcguKN0jdOFe4DWBgNRb7+w==
X-Google-Smtp-Source: APiQypJF+HW56OtBnD81SuyhZ0oh4wjRxfS7TwXwprIviYiky5uYER6Y5vaegYDuONgdQAxgzsgGqA==
X-Received: by 2002:aa7:9ac9:: with SMTP id x9mr705851pfp.304.1588641228188;
        Mon, 04 May 2020 18:13:48 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t103sm183437pjb.46.2020.05.04.18.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 18:13:47 -0700 (PDT)
Date:   Mon, 4 May 2020 19:13:46 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 4/8] builtin/commit-graph.c: extract 'read_one_commit()'
Message-ID: <9ae8745dc090de37af0475ab12b79d541a52713d.1588641176.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With either '--stdin-commits' or '--stdin-packs', the commit-graph
builtin will read line-delimited input, and interpret it either as a
series of commit OIDs, or pack names.

In a subsequent commit, we will begin handling '--stdin-commits'
differently by processing each line as it comes in, instead of in one
shot at the end. To make adequate room for this additional logic, split
the '--stdin-commits' case from '--stdin-packs' by only storing the
input when '--stdin-packs' is given.

In the case of '--stdin-commits', feed each line to a new
'read_one_commit' helper, which (for now) will merely call
'parse_oid_hex'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c | 54 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 15fe60317c..f550d8489a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -138,12 +138,25 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int read_one_commit(struct oidset *commits, char *hash)
+{
+	struct object_id oid;
+	const char *end;
+
+	if (parse_oid_hex(hash, &oid, &end)) {
+		error(_("unexpected non-hex object ID: %s"), hash);
+		return 1;
+	}
+
+	oidset_insert(commits, &oid);
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
-	struct string_list *pack_indexes = NULL;
+	struct string_list pack_indexes;
 	struct oidset commits = OIDSET_INIT;
 	struct object_directory *odb = NULL;
-	struct string_list lines;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
 
@@ -209,44 +222,35 @@ static int graph_write(int argc, const char **argv)
 		return 0;
 	}
 
-	string_list_init(&lines, 0);
+	string_list_init(&pack_indexes, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf = STRBUF_INIT;
-
-		while (strbuf_getline(&buf, stdin) != EOF)
-			string_list_append(&lines, strbuf_detach(&buf, NULL));
-
-		if (opts.stdin_packs)
-			pack_indexes = &lines;
 		if (opts.stdin_commits) {
-			struct string_list_item *item;
-			oidset_init(&commits, lines.nr);
-			for_each_string_list_item(item, &lines) {
-				struct object_id oid;
-				const char *end;
-
-				if (parse_oid_hex(item->string, &oid, &end)) {
-					error(_("unexpected non-hex object ID: "
-						"%s"), item->string);
-					return 1;
-				}
-
-				oidset_insert(&commits, &oid);
-			}
+			oidset_init(&commits, 0);
 			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
 		}
 
+		while (strbuf_getline(&buf, stdin) != EOF) {
+			char *line = strbuf_detach(&buf, NULL);
+			if (opts.stdin_commits) {
+				int result = read_one_commit(&commits, line);
+				if (result)
+					return result;
+			} else
+				string_list_append(&pack_indexes, line);
+		}
+
 		UNLEAK(buf);
 	}
 
 	if (write_commit_graph(odb,
-			       pack_indexes,
+			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
 			       &split_opts))
 		result = 1;
 
-	UNLEAK(lines);
+	UNLEAK(pack_indexes);
 	return result;
 }
 
-- 
2.26.0.113.ge9739cdccc

