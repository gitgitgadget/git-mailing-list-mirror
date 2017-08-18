Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336C9208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 18:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdHRSd0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 14:33:26 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33529 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdHRSdY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 14:33:24 -0400
Received: by mail-lf0-f65.google.com with SMTP id f7so1919004lfg.0
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZWTx8Lp2hNKVtrw7wvfqdAYuQzGeM2SP55SvYImkUJ4=;
        b=bx/GXp4hWFv+B4o6Q9cyfnDZHttnrAbLv2v7aoWVe63e93qBdsIARFk+dPsWWK6a8J
         6l3UCO6+nqnPH1kgapKA+4HajqXrn/flp0avqLzmaVBljU8jL9RV/uCa9yQVcjLy4/5+
         sw06lyMA3FKYxKcZ3eiUF2R7pUN5CLNQzH78oub+/Hlf0XEPZE8PeCTdL45r2PHTiEMC
         klJ1KtE7FCBXY6vjTJAqDA4PEOQzGxDaFfw8bq3MG7Rb6XVqxQeCGqhTKwhSQLS4N3hB
         XWYJWdiMUxg2eXeipFX8yzu/FKyeMu+3FlxS1y+b2fQRhO8PnsfCzTJbhfLCO1jyHrCy
         3r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=ZWTx8Lp2hNKVtrw7wvfqdAYuQzGeM2SP55SvYImkUJ4=;
        b=BOSdkTCXS/xSX2YYcAuDlXmpx4VZKzds6YGI8xUqiVgQZYM54D/iZIxRpMP96yH4ct
         zkLLf/T+Eb1UhbT6Z9JxsvXvpZ/F/F0MgDTSJduw0469ntRJdI9jJddmTNL4WDKNJNEh
         fnYnsAskOIdz7eAK19WBFcoLu0QrtuJAgxoViX2scZRtrqJjWlVWUyrME96P/PegvsoX
         NRR1K5+BuSmhSMyE55+Rhq92rBys3NW6J15dtU7Lgj/1WRdXL6THPeDMbdpFMdfRaAJ8
         sqGLSLO1T6I0cyPwTQhdJfroBExiOelCW+HEHATKRsXw2PrIEi2tWL6/VRb6SMvxwqsI
         IV3Q==
X-Gm-Message-State: AHYfb5g5B3BV1pAZn55StahTQuhBtJOGmrAoQSUnLgVbdH8nIR2RVGZR
        NdVHBWlOfu3Blqqpnpw=
X-Received: by 10.46.2.74 with SMTP id 71mr3588806ljc.1.1503081201985;
        Fri, 18 Aug 2017 11:33:21 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id r82sm813568lfd.45.2017.08.18.11.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2017 11:33:21 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v4 4/4] commit: rewrite read_graft_line
Date:   Fri, 18 Aug 2017 20:33:14 +0200
Message-Id: <9a4548f1d0832d036cad152771339d853b5885f3.1503079879.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503079879.git.patryk.obara@gmail.com>
References: <cover.1503020338.git.patryk.obara@gmail.com>
 <cover.1503079879.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503079879.git.patryk.obara@gmail.com>
References: <cover.1503079879.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Old implementation determined number of hashes by dividing length of
line by length of hash, which works only if all hash representations
have same length.

New graft line parser works in two phases:

  1. In first phase line is scanned to verify correctness and compute
     number of hashes, then graft struct is allocated.

  2. In second phase line is scanned again to fill up already allocated
     graft struct.

This way graft parsing code can support different sizes of hashes
without any further code adaptations.

A number of alternative implementations were considered and discarded:

  - Modifying graft structure to store oid_array instead of FLEXI_ARRAY
    indicates undesirable usage of struct to readers.

  - Parsing into temporary string_list or oid_array complicates code
    by adding more return paths, as these structures needs to be
    cleared before returning from function.

  - Determining number of hashes by counting separators might cause
    maintenance issues, if this function needs to be modified in future
    again.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 commit.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index 436eb34..3eefd9d 100644
--- a/commit.c
+++ b/commit.c
@@ -137,32 +137,37 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 struct commit_graft *read_graft_line(struct strbuf *line)
 {
 	/* The format is just "Commit Parent1 Parent2 ...\n" */
-	int i;
+	int i, phase;
+	const char *tail = NULL;
 	struct commit_graft *graft = NULL;
-	const int entry_size = GIT_SHA1_HEXSZ + 1;
+	struct object_id dummy_oid, *oid;
 
 	strbuf_rtrim(line);
 	if (!line->len || line->buf[0] == '#')
 		return NULL;
-	if ((line->len + 1) % entry_size)
-		goto bad_graft_data;
-	i = (line->len + 1) / entry_size - 1;
-	graft = xmalloc(st_add(sizeof(*graft),
-	                       st_mult(sizeof(struct object_id), i)));
-	graft->nr_parent = i;
-	if (get_oid_hex(line->buf, &graft->oid))
-		goto bad_graft_data;
-	for (i = GIT_SHA1_HEXSZ; i < line->len; i += entry_size) {
-		if (line->buf[i] != ' ')
-			goto bad_graft_data;
-		if (get_sha1_hex(line->buf + i + 1, graft->parent[i/entry_size].hash))
+	/*
+	 * phase 0 verifies line, counts hashes in line and allocates graft
+	 * phase 1 fills graft
+	 */
+	for (phase = 0; phase < 2; phase++) {
+		oid = graft ? &graft->oid : &dummy_oid;
+		if (parse_oid_hex(line->buf, oid, &tail))
 			goto bad_graft_data;
+		for (i = 0; *tail != '\0'; i++) {
+			oid = graft ? &graft->parent[i] : &dummy_oid;
+			if (!isspace(*tail++) || parse_oid_hex(tail, oid, &tail))
+				goto bad_graft_data;
+		}
+		if (!graft) {
+			graft = xmalloc(st_add(sizeof(*graft),
+			                       st_mult(sizeof(struct object_id), i)));
+			graft->nr_parent = i;
+		}
 	}
 	return graft;
 
 bad_graft_data:
 	error("bad graft data: %s", line->buf);
-	free(graft);
 	return NULL;
 }
 
-- 
2.9.5

