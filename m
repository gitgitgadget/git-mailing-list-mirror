Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F5720899
	for <e@80x24.org>; Sun, 13 Aug 2017 08:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdHMIvP (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 04:51:15 -0400
Received: from mout.web.de ([212.227.17.11]:64407 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbdHMIvO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 04:51:14 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MORqb-1ddmL12rcT-005tqs; Sun, 13
 Aug 2017 10:51:06 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC 1/2] convert: Add SAFE_CRLF_KEEP_CRLF
Date:   Sun, 13 Aug 2017 10:51:04 +0200
Message-Id: <20170813085104.1688-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:UUshZXhal21UwfcV3e0Vq5OTKkN9Loe16ZRlOvouCxck4R4c8ax
 AIpJo3sL1l2Gfw6aRswbw553FA6BrJafFITra7OA9+jKRnQOlSENW9GLmPwwkaSI5IRFjXr
 SYMa3Z4zjRtLlWbbUxVUIpuO9aztqpw5+6VTYNL0P1e83L32ACzZhMQ1Lp4AqYB3nNkNyvp
 +aEGg6gJq8Kl4JPplqwpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nX7Yoa4pBL8=:/BJ0bry1okAAE3S2uywWqQ
 0zxd9lyEsvsyuS0AQQ0rC011XqprIaFACiNTEAoILYazED4V0jkjFlQlrUEBXDXMLJbu6G18r
 dnNIGBsbe/aWL/NkOcXJ4VPXYzShTaQy5SYmqvNlVAQlTP2qRNFhWqMHqTB3ZDD+LwWuX6Kw3
 +U8K9h021u5c65aRFYyZd6fOzuPysZwjr2HVQ3+eFgHbHxouFqJ1tI/IJnKI1aZkHLOMFnc1D
 Pbt1oRgsX7nRfQLSgMs2c8mFzlAwA+ISPAc+NKOho2Pb5Atz90DXG7eZapT+NxiZjjyNq5fMV
 1ESmn9v4CLSn0o2J+jDXz1iWMpODKWw0+u1QN0E0PtJO4gFTKCqzQRxPsOQu3xdfA1dxnG/XQ
 OTdoKkSCtw7OPSBQHyxxH/t/D9nIlOSEJqsXSbulPd3wagbissq6QU0eSP/T7tY0ac2q6o2tU
 O/p6xNzct9LdmhWNMMEDcTVtJ0VlQDNbmyfr/u75+nQVooX8W09pT8q4WMKRH7L3KamhXu1nA
 4cz1WygJ0jHtpwY3ngxZGQKwGcMBgswtvROIUtans5ZHxHg5+RwUGvXoEI6R7bDa0sHWhaKta
 1FXalXO4PpZRe34HYxq+X3v9sA/O5v282T8hgi/RZy3U00joSAXSfwGkjgGs/ThNbbjulMJ1h
 OOMbvnE2WL4SCd3t5zQ3cAkSUkee3C7kUlXw14bw0bqOK1VXqpCN3tsupWFWnIXUSjyfP+7QA
 6dqVNQQ9xEXofZlxXGRhs/aWBmiEiHlDlQAz5gNpPzmwjaq2H8Yd1O6by7C7Bx1ZZ5VeICVBT
 /ajbl/qKoyC4VyNsHwRaO2NV6/nT7V9Eh1b/Toq5GYqp/K+Zf0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When convert_to_git() is called, the caller may want to keep CRLF
to be kept as CRLF (and not converted into LF).

This will be used in the next commit, when apply works with files that have
CRLF and patches are applied onto these files.

Add the new value "SAFE_CRLF_KEEP_CRLF" to safe_crlf.

Prepare convert_to_git() to be able to run the clean filter,
skip the CRLF conversion and run the ident filter.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
convert.c | 10 ++++++----
 convert.h |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/convert.c b/convert.c
index deaf0ba7b3..040123b4fe 100644
--- a/convert.c
+++ b/convert.c
@@ -1104,10 +1104,12 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
-	if (ret && dst) {
-		src = dst->buf;
-		len = dst->len;
+	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
+		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
+		if (ret && dst) {
+			src = dst->buf;
+			len = dst->len;
+		}
 	}
 	return ret | ident_to_git(path, src, len, dst, ca.ident);
 }
diff --git a/convert.h b/convert.h
index cecf59d1aa..cabd5ed6dd 100644
--- a/convert.h
+++ b/convert.h
@@ -10,7 +10,8 @@ enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
 	SAFE_CRLF_WARN = 2,
-	SAFE_CRLF_RENORMALIZE = 3
+	SAFE_CRLF_RENORMALIZE = 3,
+	SAFE_CRLF_KEEP_CRLF = 4
 };
 
 extern enum safe_crlf safe_crlf;
-- 
2.14.1.145.gb3622a4ee9

