Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360721F453
	for <e@80x24.org>; Thu,  4 Oct 2018 15:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeJDWDA (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 18:03:00 -0400
Received: from mout.web.de ([212.227.15.14]:37733 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJDWC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 18:02:59 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M4I79-1fqPyP44qx-00rlfh; Thu, 04
 Oct 2018 17:09:11 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M4I79-1fqPyP44qx-00rlfh; Thu, 04
 Oct 2018 17:09:11 +0200
Subject: [PATCH v3 1/5] fetch-pack: factor out is_unmatched_ref()
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9a7ab468-8d6e-c3d0-3960-b05f06534de5@web.de>
Date:   Thu, 4 Oct 2018 17:09:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Bkl20SCPzn9NjKOSYQun5yvuaAsst51kG9hfnX+Jnjidbf2eHrB
 6gFTY823gYFw2WVLcwocFMu7ee9dE6pVGPjtePavP8YeoLCgmw+h1E3Re67cJhun4Piwiau
 KEYinTEt/Ta11DMleTlEVK8FW1D6UDGg4O7NBUGfYYx02qvmxieGFiNXuezrK8ef2ee2Ofu
 zW0Z/UywyttqRLC7ETbVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JImISu2LjhI=:Ajtv2VtudHy/+K+p9yOic0
 Nl2Z9PqcnJMbsAMPPsFVWQZP2ecLaFKKdLlSv1RbMz3rBPG31KD+gySHPGc7vHt97Mj3GBWrd
 D6pnruKMVbA/XOcgPJZaQPWGB9EJtRNt+rek0ryTJf6FxEMw3KDnOEKd21da0o2DeUKAeI82L
 4FYVcD6szH5xu+TLAiNijTXAOrN5w3kZCwrbv5wLLwZYsByOcQRAUEY87FMpZnAMB3ux+1DQJ
 cd3vv+rUqsNWIIHtS1J/shNftWQzp9T7DfuI9NZwKReR4+7LB/Xnw6KZ1axTS9CVUC65zir+B
 J6AB0bNO1Lb9qkP6QJN5qb6Iib62qp/+gamiT7Fdas3IlsN9HmDbYGOfYQUCfdUwqukYVKfeK
 iEkOkM6oMid+969wJk1APIpY5y7GAR4UXcCWBmoT9eRecORxWM/hdmdJYG7yOG+ybmOnmD/R6
 fx46+Me6OkBp6j2eBmKjOHS14VO1ddQpewrWv47FLPgSTGJYVr9O8vPSirKYwvGMh4ITQkd/b
 /8y1RdpH0pyBvljfm6RvrKII/wIQ+TeyHRGRUNosFkwFl6V6AyqthB9X8eqJOPbUrQgqCirlH
 ens9iVmkUdgpNvBZBLjyUtxwEtIFsunSrpAKeNHF1hYvLu5W2i1ukMwQZCGdGwG5Z+P3UcCpx
 sQmJUlBWfAhw/RsDNyS3R1rP/e7Y/50FDAeVZx5a+ofPKfHtXo5iYsrWcg+I8B5/UUWjwhK3U
 Syz12nC7lSZlPfVMSGa/9j+qL/fx3fLPe1PRVVORJT4hEW4SmoKbsDEcIvHy1MA8KoQK6Y9m7
 DvWpjawYQqLF61z6AAR55oAEBUjbMixXNYckp51TNHx/rEHTLM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the code to determine if a request is unmatched to its own little
helper.  This allows us to reuse it in a subsequent patch.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 fetch-pack.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 75047a4b2a..3b317952f0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -543,6 +543,16 @@ static int tip_oids_contain(struct oidset *tip_oids,
 	return oidset_contains(tip_oids, id);
 }
 
+static int is_unmatched_ref(const struct ref *ref)
+{
+	struct object_id oid;
+	const char *p;
+	return	ref->match_status == REF_NOT_MATCHED &&
+		!parse_oid_hex(ref->name, &oid, &p) &&
+		*p == '\0' &&
+		oideq(&oid, &ref->old_oid);
+}
+
 static void filter_refs(struct fetch_pack_args *args,
 			struct ref **refs,
 			struct ref **sought, int nr_sought)
@@ -591,15 +601,8 @@ static void filter_refs(struct fetch_pack_args *args,
 
 	/* Append unmatched requests to the list */
 	for (i = 0; i < nr_sought; i++) {
-		struct object_id oid;
-		const char *p;
-
 		ref = sought[i];
-		if (ref->match_status != REF_NOT_MATCHED)
-			continue;
-		if (parse_oid_hex(ref->name, &oid, &p) ||
-		    *p != '\0' ||
-		    !oideq(&oid, &ref->old_oid))
+		if (!is_unmatched_ref(ref))
 			continue;
 
 		if ((allow_unadvertised_object_request &
-- 
2.19.0
