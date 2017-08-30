Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9754720285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdH3R62 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:58:28 -0400
Received: from mout.web.de ([212.227.17.12]:65496 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751514AbdH3R61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:58:27 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDxKd-1djTqA3Djz-00HKQh for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:58:25 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 03/34] am: release strbuf after use in safe_to_abort()
Date:   Wed, 30 Aug 2017 19:58:06 +0200
Message-Id: <20170830175825.20905-2-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175825.20905-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175825.20905-1-l.s.r@web.de>
X-Provags-ID: V03:K0:Bs3Ej1JLIGx2sbktm1mRcUkl1bm4oYR8HOkutvDyisrHTizjpCV
 lIeksM61Ihnol32Q8KU04q4OIxWOHxf12twzjHSLrY/fMXPmqBqsedSicVnGp7/J4PjAy5M
 sDUQXJZ1GvW/0SYGyhC2B9QYvvlnMLsC6po+3Be1Voozh4E1Q2IKBpJwDGoYFy528SKmZEk
 uL9E+Kg2PYY7cA+3uEiiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hLaRfrPQ1/g=:whjg9yanKTNGnaeRHhiQHp
 FVGDvsLcQpLx7Df508M8vAP0Zt7d1wiGyR3qhNz/dJj/fRtIGCOwQaqX8OSNLP39Zl9R/tODU
 05D0alWH1C1VsRZeML1ulT3D5apL2i+HIyhpr8bYqiyxV30arb2n99XZS+k5acrMSqZwA0Lh0
 5xN8U2Yls59y34l/spp0XQ8sawotpNoImaVu4POYi8JiiJ3KPsE1EkGAlgXy92MyX+Wec82Xm
 geuORUIVrwjhJO67xwkW4NaNcQlYVVMZdkGmZeqdEquSeNwbkM1O9HVGwLDSmtzcLAXExBCdG
 H1Ff+6lKYQ/ZjvxUgDZFVwLb+3eomFmoi/zCfCrNUEBtvo1AFXtd4a7uW5jNXDCiBYqoGvIaL
 1zu+S4IKuZ6PzGlGaP4pUvMq3Av7VudC2N6LHh7rHVdm/iN+zbR+VWhpXlfmFi+xc/g/mhvR+
 LdJl3AI/HvrMfWaZ7qJ5S5xMGIfrOyFetNnM/QWLeaCqBVVpQYoDENOqDBu7cVfh2XmUsnloj
 cb82bAsaBCJbUWf0WbH9mcsCs2ETHM53h78WUIq26mDlS2lcSuixTW7cC3WiEA8Q+xLNliixs
 7tSvqFE5usbbH0+Se6bOq87PQ+RnBDFvKw1FM0EJzWmNvKIAluq+PTs0dRs9eDeN2ZCK9wJek
 e+WBAOFpM2q5N4Mcyt8GJqpL6HbU7oWYtzk9POIJ5jZDF5kZqA/t1bZB14Yk+qYFa6QngaKTF
 UiXhKeH7acFDY44rSH+g0UDn95rhOOkw57U7mSPUk5FsTmxnVbRFW4LmWkpmsQbZl1sV3qAeM
 Rhe76fHCl7soqLXB27dV4NVJDD3jw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/am.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/am.c b/builtin/am.c
index 3d38b3fe9f..d7513f5375 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2095,29 +2095,30 @@ static void am_skip(struct am_state *state)
 static int safe_to_abort(const struct am_state *state)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id abort_safety, head;
 
 	if (file_exists(am_path(state, "dirtyindex")))
 		return 0;
 
 	if (read_state_file(&sb, state, "abort-safety", 1) > 0) {
 		if (get_oid_hex(sb.buf, &abort_safety))
 			die(_("could not parse %s"), am_path(state, "abort-safety"));
 	} else
 		oidclr(&abort_safety);
+	strbuf_release(&sb);
 
 	if (get_oid("HEAD", &head))
 		oidclr(&head);
 
 	if (!oidcmp(&head, &abort_safety))
 		return 1;
 
 	warning(_("You seem to have moved HEAD since the last 'am' failure.\n"
 		"Not rewinding to ORIG_HEAD"));
 
 	return 0;
 }
 
 /**
  * Aborts the current am session if it is safe to do so.
  */
-- 
2.14.1

