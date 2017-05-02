Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A931F790
	for <e@80x24.org>; Tue,  2 May 2017 16:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdEBQBh (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:01:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:49801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750717AbdEBQBg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:01:36 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcBBl-1domMh0nSP-00jXRJ; Tue, 02
 May 2017 18:01:30 +0200
Date:   Tue, 2 May 2017 18:01:29 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 06/25] get_mail_commit_oid(): avoid resource leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <219203bb33d5229b013e26ff445a8ee1a0ab0aaf.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:902JX+O6FbxE6et/RcDtERiW6+KkryPPK4XbNqOB6zTQP0CGZUU
 IAxS2MESuB7AGiq5Ajufr6qfRB6IiZZ6QcdeRT0C/VEpx4FYpr26cpytbn1N7AMIe2RLPsa
 jrbykOMtSiNpK2nge1pgt6/wYUwLU/j8rWdyqjOQozgUN8sPYiYaKtL/mMHP0jYT4/pFfD3
 /6MXhclyH9sfk8wYeiwDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wo0mEMFXgcs=:JrxE2UHvnhCCLcgw2SuMY/
 FeQIq0yHWMPSNj5My6/855Z7UaRYWdRo0RwZN5LfDuOjqnLMdBzz+O+CUTBATubFxzU3GYQ9+
 iSC4pwKk3fQZr+c66uG8PXPBXHpZmRJEjTvTxDzcT8brUzfM1Kl91WqZgSZEBoEozYvuPvEVe
 EYoOoMXS88W06WuqUdcV6SgqbbQPV03JJV2fwBAYKPHxhByrCXPmsnor8/8CZtJxtECV7aGx1
 iSitNbIbEdhtfMfnB9hJ64MQmOP6nM5UgmEMrXEzmsy41ebQAGhUggeDqHzm9om/7c/cZMrdt
 vA5J7YZF8F0A0rvfFCcjsVvGuUHcyvOsjYHQX1yowdhE69tvX0QqbrnHHPF34QXKUtOtfZOgi
 Eu3iJ2S2/yDMfxyBbDKxqs7TpxJ65SLPjx6uoBBPGCuVeQpbW5EXmsx7dXoH//EXrUYwfuNNP
 cRngoy9v0MyvQs7m8RSIRKl+i76wDSFEhmsrXNPsYoIarLvVlRb5Ad3uxXUZmPCbLye69bYhN
 bR3rYgThF9xY6+PH2iqyVV/w8KGXfgLfzFzLX0bh8fq3ssnXCv7T5/hUw/zSqmaXGGyZNEq+K
 tFoYWxWE3EtcaZ5mGQJb0JvuYonZkOwx/a0UPUhabtvMEWushs4NNtO5kiMkg6YcaclOpPn9A
 oSV/xuPEF4E6MinfFGp/2hSHkoD/Et3aeG2Xq/+hhbJtK6vCoN+0D1b2Pmayuy5cXWbHdbZcv
 yjkbN1UvPyHkMXYAXx3cfZgcKG7raXjfn1VO8QxsHUhWbNE3ysK0wdTrFgYyn+VCauIMLu9UP
 PVRgYX7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we fail to read, or parse, the file, we still want to close the file
descriptor and release the strbuf.

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a95dd8b4e6c..9c5c2c778e2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1351,19 +1351,16 @@ static int get_mail_commit_oid(struct object_id *commit_id, const char *mail)
 	struct strbuf sb = STRBUF_INIT;
 	FILE *fp = xfopen(mail, "r");
 	const char *x;
+	int ret = 0;
 
-	if (strbuf_getline_lf(&sb, fp))
-		return -1;
-
-	if (!skip_prefix(sb.buf, "From ", &x))
-		return -1;
-
-	if (get_oid_hex(x, commit_id) < 0)
-		return -1;
+	if (strbuf_getline_lf(&sb, fp) ||
+	    !skip_prefix(sb.buf, "From ", &x) ||
+	    get_oid_hex(x, commit_id) < 0)
+		ret = -1;
 
 	strbuf_release(&sb);
 	fclose(fp);
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.12.2.windows.2.800.gede8f145e06


