Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23353C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE09C611CA
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhDJPW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:22:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58496 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234680AbhDJPWx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:22:53 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ACE8F61477;
        Sat, 10 Apr 2021 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068157;
        bh=gBXNos+/dhYuFZLfZFAQ81vO5S2jM++n8iLkRMBzqRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MO5DVk0Q8sHkTUpZPE0Vvqvf5WnDgxbCHrdHk6fHsVk6N3SCX/+8XHmkCDy5MLLQF
         SV0FKMR7dWaEuuZB3b+aFiUlk51NnXptBuz2yCSbMPCbZTMCrS002Vly8P/4hEGSix
         uFs5NaimtuSMCzztVF3N3mNgP87FQ0awMX1hoYUqZovt1YvfIhlGFDOeqbq/ugcYFN
         KbhDWBQ+x68zyhK1E8WUTEaz6HvksMf53YM+9o07jbqtEB1GizGoXOyJU8+O+Cr7zz
         GZhRaUsE3DsXz2wxf1eh3Ekd0c+Bu+/ptPDowsm+2F/H6yjaL5p0Byqn1svvu6ejYE
         Nw4bSJjP4Hk3vQpAjakmxrv4bL6aIaD6D3eErm1B7epgGaoBNtAmSUZAucrCxPLUbg
         NUI53z9VOOrjt4CrLweGFfpWlmSRiyGUt3LNNzgWg6/P4BKCqFAPfEktLONntKDs6s
         ctHmTQO+Fkdx9hp//ZH8XN93QzxXexHKlFWrNIfj0CaXtaZuGAS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 15/15] hex: print objects using the hash algorithm member
Date:   Sat, 10 Apr 2021 15:21:40 +0000
Message-Id: <20210410152140.3525040-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that all code paths correctly set the hash algorithm member of
struct object_id, write an object's hex representation using the hash
algorithm member embedded in it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hex.c b/hex.c
index 43597b2dbb..4537e79d3c 100644
--- a/hex.c
+++ b/hex.c
@@ -143,7 +143,7 @@ char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
 
 char *oid_to_hex_r(char *buffer, const struct object_id *oid)
 {
-	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
+	return hash_to_hex_algop_r(buffer, oid->hash, &hash_algos[oid->algo]);
 }
 
 char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *algop)
@@ -161,5 +161,5 @@ char *hash_to_hex(const unsigned char *hash)
 
 char *oid_to_hex(const struct object_id *oid)
 {
-	return hash_to_hex_algop(oid->hash, the_hash_algo);
+	return hash_to_hex_algop(oid->hash, &hash_algos[oid->algo]);
 }
