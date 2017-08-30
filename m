Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51FA420285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbdH3Ru3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:29 -0400
Received: from mout.web.de ([212.227.17.11]:61866 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752043AbdH3RuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:09 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GJ0-1dep8L48Xm-00Cfz5 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:08 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 19/34] merge: release strbuf after use in write_merge_heads()
Date:   Wed, 30 Aug 2017 19:49:50 +0200
Message-Id: <20170830175005.20756-20-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:F4CO2/8v3H5LbBPVttf7u5hhYH2W7/pvDVxnklKs9ppfi2uk7OH
 sPZ/cVVYGqiuq5B0rfofFMz8qit3jM1R+bAnV4UpMkLKIkpP1VNDe05nvqvBZiumclAqgh1
 uFY/ElX+Zwq1HooOLJEca/rEj9dfemAANBgXMFdv9D8gxj/iO0oN8c9dT9H1tGd5K6X0PJA
 vVe1zOga0xzknX5O/eFiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s9eusVYm4WE=:ayA8ekBHGXKkhqD8tH12Vv
 mM2XNA4l+RMh4ryHLk4VSl536cfOLNrPuwt/M6WFtD3aqApJ5+HYAuA7YKEDQ9W+SVZo1pMSe
 5oQ+xnzbn9aQPF1JEVhpO7DnzEy6z+qkGXa8sH9SoZscjTxM4GN2vrLXfbVi9CWWLUTWe0K2u
 ZT4rmNPKP5pvYDSeVCTU7Dt//g7iWZC/T1OXmEV2y8KIskz4rShBLEOWQuvJmsNtM0E6tItiH
 iKRxqBFLRBWVyosyZLI7+PIGIwlAD1gCuwwxhX9Vi+jSwNtWKE8nNU/SwRAdc+/Yk+nCl+cP9
 OOyVa4cQZDD6WDrA1YkMWUpJqmmo/PdYSi2sXamNG/hyUgGMSjL76Jb0yR4KdfqXRi4iXmmZa
 n+NqZPr48zQcMxnV+/GHGnp8UHPMEJEu7CBhEc1ALQ+5vnS3HvPiM5iuJwYukOm6RC3ubh5DX
 0oi5bVE1zJBYv0cd4bOUO88QQl1ful5+mToAHNFAoCDM/9g9kpZjHY7ZeilFaEvc7PIZMbj6L
 RN686Pv41bRjHABTMp9wTsUeBOXw3DJMo/3zPmNvNdZgouttl2I1Mc2+xLLlRV49cA0ZoMg2a
 IEFDCuE1ZwNK3ARZPaAPcmqngDubF4qeCIINrNeMnQLapdY0i0/sSJByTYiFJPh0gLRKPQ5eV
 BejsG4D1CZvSseTp9Oa0qJ70m7kh7I7rKzWYXm2FJ0zM2qu2vdCnlpvsOKYZZ85KhVACFvplO
 WDbn/XfC4wcYFl63/LT2z0BBr1AfFNzh/VXeA8GIhCi3+3u6Z7BRsKieCgcO2E2WeVHhVs5Wg
 fXKQR5OkPw3cUi5/mJ8bnN/YfJTDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/merge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4f8418246b..7bc3fe4b6d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -920,24 +920,25 @@ static int setup_with_upstream(const char ***argv)
 static void write_merge_heads(struct commit_list *remoteheads)
 {
 	struct commit_list *j;
 	struct strbuf buf = STRBUF_INIT;
 
 	for (j = remoteheads; j; j = j->next) {
 		struct object_id *oid;
 		struct commit *c = j->item;
 		if (c->util && merge_remote_util(c)->obj) {
 			oid = &merge_remote_util(c)->obj->oid;
 		} else {
 			oid = &c->object.oid;
 		}
 		strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 	}
 	write_file_buf(git_path_merge_head(), buf.buf, buf.len);
 
 	strbuf_reset(&buf);
 	if (fast_forward == FF_NO)
 		strbuf_addstr(&buf, "no-ff");
 	write_file_buf(git_path_merge_mode(), buf.buf, buf.len);
+	strbuf_release(&buf);
 }
 
 static void write_merge_state(struct commit_list *remoteheads)
-- 
2.14.1

