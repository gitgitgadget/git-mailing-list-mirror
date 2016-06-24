Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8101FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbcFXXJj (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:09:39 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52530 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751019AbcFXXJi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 19:09:38 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1C9C2280A0;
	Fri, 24 Jun 2016 23:09:37 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466809777;
	bh=3PTYqhB7dcpx/+nUdK3w566YO4U2lsKdnH3HaF1EEYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yi8xVx3Fuv3JHrrwVpSARFJaXetDnvAQcSvL8JS1m+nmqu2eT4+H9xvckh8xa9rHH
	 AkkrXSh0mHsnODfPA35bBXgm+TD64aq1qPioee84XaqvR921PDANYBVFez59QIEehx
	 gmVf/xiItAoz8IGUlg/Vbn+3aqlSgAVSyScgHL1EVSei+jGYUExynlCK8FTDeYeIQn
	 LBmOoWVy/UjMWJt3cth/6qm52MQMeKTkvy4vYwcTviy+7gITGvpcbTAm3lwxjC50Vy
	 5nL3ZlNnALsJktDU8E2gNOpXG5HIw9I1l5g4mi+64B5leAruBmLrRZc0hgWHtOA/ek
	 LKvP6QRgMwomfggc/Cgv6mHqxSdltrBbAsBvMoy1XPzCz3yfNcUDOgSTUuD2V76i1J
	 EKdtwQEvAOL7+bxAsrsxm4H7gCtu2dkN0YTEnI+mQOZt2SBw+hl7BVySjOrQO+Mu2d
	 c4Blm8kaWrudhmdPYOGgZNH9qMDYNNINManc6vJCw6wVKu9PD71
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 01/11] hex: add oid_to_hex_r.
Date:	Fri, 24 Jun 2016 23:09:19 +0000
Message-Id: <20160624230929.82222-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160624230929.82222-1-sandals@crustytoothpaste.net>
References: <20160624230929.82222-1-sandals@crustytoothpaste.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This function works just like sha1_to_hex_r, except that it takes a
pointer to struct object_id instead of a pointer to unsigned char.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 1 +
 hex.c   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/cache.h b/cache.h
index 6049f867..7bd7c472 100644
--- a/cache.h
+++ b/cache.h
@@ -1193,6 +1193,7 @@ extern int get_oid_hex(const char *hex, struct object_id *sha1);
  *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
  */
 extern char *sha1_to_hex_r(char *out, const unsigned char *sha1);
+extern char *oid_to_hex_r(char *out, const struct object_id *oid);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
 
diff --git a/hex.c b/hex.c
index 0519f853..9619b67a 100644
--- a/hex.c
+++ b/hex.c
@@ -77,6 +77,11 @@ char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
 	return buffer;
 }
 
+char *oid_to_hex_r(char *buffer, const struct object_id *oid)
+{
+	return sha1_to_hex_r(buffer, oid->hash);
+}
+
 char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
