Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A555FC433E1
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 16:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B092068F
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 16:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QIX3Pop4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgGLQuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 12:50:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40550 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728844AbgGLQuX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 12:50:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8493460479;
        Sun, 12 Jul 2020 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594572621;
        bh=9n3NrHRpVBIl62Dgdy3eXD91/9cgTaYQs2mK9ML7CLE=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=QIX3Pop4uwjSM4X+8LBI9yqx0Z5HQcXOD56qXM2jQwowAgv7kLwGNXy3bqNXVffvJ
         oqmiygU8wsnnDb6XDc8fmozh6HVL6HXn3kz4pWCSq+e7bIGF9lsyFHonou/q3JV9cz
         0Wln+TN6AY5T9XR3FrWdB+S7BcS3g05CkbBgK8NhxbgOxdlwO6UeVQSA24xM+7ISao
         HC+NbvyOLsTCO+TnEW2DHCMRI9tF6NILU7S3j2HV9LtfWAjFTmcHIHXax578fLoQ5a
         kvCVYNy5+tV1EZkHYvH3qAb6QoEGcSbfB+PUEnMDIxK38IS7q6BJWOp9Ba7+8flt45
         hkMED/2op1Rs8R/JLZ4Y5S0Bz9mhQukh/zoaF+Xg+989F5BFq+uug11Ff1ijBf7w9s
         XqXp30kl5MM/DIplsS3Yla206in82CNHRWZWjjDe4PHSziQ8RSOb7/PAqN1I3QeRot
         qOjDWSSuzAGVsrk7I9L59ioWfXWUilrQ+IsuqX4+guOIaV2klT9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>
Subject: [PATCH] bundle: improve message when unknown hash algorithm detected
Date:   Sun, 12 Jul 2020 16:50:05 +0000
Message-Id: <20200712165005.705979-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current code states "unknown hash algorithm length".  This is
slightly confusing, and moreover, we've gotten feedback that it's hard
to translate into other languages.  Since the case is that we cannot
detect the hash algorithm, let's just say that.  This is clearer and
more direct, reflects the intent of the code (which calls the function
detect_hash_algo just a few lines above), and will be easier to
translate.

Suggested-by: Matthias Rüster <matthias.ruester@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Matthias contacted me privately about this message and I thought since
we're still in the RC period, it would make sense to include this in to
help translators and those who aren't native speakers.

 bundle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index 2a0d744d3f..69c807bda9 100644
--- a/bundle.c
+++ b/bundle.c
@@ -66,7 +66,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		if (!header->hash_algo) {
 			header->hash_algo = detect_hash_algo(&buf);
 			if (!header->hash_algo) {
-				error(_("unknown hash algorithm length"));
+				error(_("unable to detect hash algorithm"));
 				status = -1;
 				break;
 			}
