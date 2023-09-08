Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E19FEEB565
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 00:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjIIAFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 20:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjIIAFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 20:05:20 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9077A18E
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 17:05:16 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34576)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdg-007QwX-SO; Fri, 08 Sep 2023 17:11:48 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdf-009u13-SV; Fri, 08 Sep 2023 17:11:48 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:28 -0500
Message-Id: <20230908231049.2035003-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdf-009u13-SV;;;mid=<20230908231049.2035003-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/pOzUKcnpz8GqE4sTVYlTGrUob60OrQRI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 11/32] pack: Communicate the compat_oid through struct pack_idx_entry
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add compat_oid into struct pack_idx_entry to allow communicating the
the compat hash value of the objects being indexed to the code that
builds the indexes for a pack.

Having a mechanism that communicates the compat_oid from the code
building the pack is necessary for bulk-checkin, fast-import, and
index-pack.  Only pack-objects could rely on the existing
comaptibility mappings, but there is not point since the
other creators of indexes can't.

Unfortunately this adds a 4 byte hole into struct pack_idx_entry.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 pack.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pack.h b/pack.h
index 3ab9e3f60c0b..321d38374f70 100644
--- a/pack.h
+++ b/pack.h
@@ -75,6 +75,7 @@ struct pack_idx_header {
  */
 struct pack_idx_entry {
 	struct object_id oid;
+	struct object_id compat_oid;
 	uint32_t crc32;
 	off_t offset;
 };
-- 
2.41.0

