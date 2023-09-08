Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2B9EEB565
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 00:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjIIATT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 20:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243171AbjIIATT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 20:19:19 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E48A133
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 17:19:15 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37030)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdT-00FHHN-9m; Fri, 08 Sep 2023 17:11:35 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdS-009u13-7Y; Fri, 08 Sep 2023 17:11:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:22 -0500
Message-Id: <20230908231049.2035003-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdS-009u13-7Y;;;mid=<20230908231049.2035003-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX196bS0tNajwF/IzzBF9S/OlMhU3CpFLmUA=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 05/32] repository: add a compatibility hash algorithm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently have support for using a full stage 4 SHA-256
implementation.  However, we'd like to support interoperability with
SHA-1 repositories as well.  The transition plan anticipates a
compatibility hash algorithm configuration option that we can use to
implement support for this.  Let's add an element to the repository
structure that indicates the compatibility hash algorithm so we can use
it when we need to consider interoperability between algorithms.

For now, we always set it to NULL, but we'll initialize it differently
in the future.

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 repository.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/repository.h b/repository.h
index 5f18486f6465..6c4130f0c36e 100644
--- a/repository.h
+++ b/repository.h
@@ -160,6 +160,9 @@ struct repository {
 	/* Repository's current hash algorithm, as serialized on disk. */
 	const struct git_hash_algo *hash_algo;
 
+	/* Repository's compatibility hash algorithm. */
+	const struct git_hash_algo *compat_hash_algo;
+
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
 
-- 
2.41.0

