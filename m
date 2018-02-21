Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D89CB1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeBUBzL (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:11 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33893 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBUByx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:53 -0500
Received: by mail-pf0-f196.google.com with SMTP id k2so64493pfi.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7j0z1T1MKzhg3bnyjXBl4GMBnEzaHgu2Gsi0sUUyspU=;
        b=UjZg6y2x3xbHqCW5OfSTMTYby/44EffNx5EBSYGr7STv1zyKk1n7HMIFBznWu7UbBp
         QDRv0vhFbRL+dlcX6rrGouXTh0tTyQUP5lfKOtveGrCOrHn79sCbxzrkMKuE1pvZCoAC
         dm/pYc1FmhFYSls9LeStq8vtNzGzgNFf+oTIs0XVnIk3Ct/lm38WU6dOS9nLbyXhbMWS
         PXZk+sQ3bTqjU7OoKzDA4/LoHlYh/NF8acbE9XS4PzqtklY542+QS19RRWmG3TEJpurZ
         gRdK5vakTuQiHckznobtpLwbsFJ+9NYjOdshYSpuAhPO5cVQ0i9YGFHpKYeKmGdANs8Y
         AwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7j0z1T1MKzhg3bnyjXBl4GMBnEzaHgu2Gsi0sUUyspU=;
        b=ImO32760j150Qb+7ItGllUkblKWRcJDYSBvE/NgEMDCia+DEIcLko/4rRapcsKWrTn
         rQIHaAfVrOLOQ760eaHAoA7uUOI4EpEp1MCKCVO//6DNP0vcKNdVkbJk84mxrH8neL7V
         g/Mr3ZiUu1BbKTSnD3DwdCMpL/arF/xXPwCu4fT136Oywqu/P8fyntx9epK9ljrNvsfj
         dovsDU+VKLJA/G/XTPSt9rVku5ne/ED4i5B3Z2X1Vv1EkJKImGMUxV6yOeBQ91oIL03K
         2r0fNRWKQ2Iom6THfvNXc/znWvs7649YB+sAVOKekIT7dl18Su0fYuH039gD34UbrvJv
         Xejw==
X-Gm-Message-State: APf1xPBDKuvaIoEN+G74q0zzkUrff3RG0aosxhtO7xfahBNDNWBQ2OaS
        CNHNLxLtffHJ3vepHoi9m4+I1g==
X-Google-Smtp-Source: AH8x227n/7uBE3ZMON2cDWNP0M6gCqPxPCpBokelRXF6UKCjwjZH2vrvudm9v1s1SaSac7c8ec8RQA==
X-Received: by 10.98.252.22 with SMTP id e22mr1569848pfh.235.1519178093099;
        Tue, 20 Feb 2018 17:54:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m80sm74804271pfj.163.2018.02.20.17.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: [PATCH 09/27] sha1_file: add raw_object_store argument to alt_odb_usable
Date:   Tue, 20 Feb 2018 17:54:12 -0800
Message-Id: <20180221015430.96054-10-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a raw_object_store to alt_odb_usable to be more specific about which
repository to act on. The choice of the repository is delegated to its
only caller link_alt_odb_entry.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1348dce68f..a8e23bd2f8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -346,7 +346,9 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
+static int alt_odb_usable(struct raw_object_store *o,
+			  struct strbuf *path,
+			  const char *normalized_objdir)
 {
 	struct alternate_object_database *alt;
 
@@ -362,7 +364,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = o->alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -414,7 +416,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
-- 
2.16.1.291.g4437f3f132-goog

