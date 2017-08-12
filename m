Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B923208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 14:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdHLO4d (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 10:56:33 -0400
Received: from mout.web.de ([212.227.15.4]:61741 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750851AbdHLO4c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 10:56:32 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvjoa-1dZ4dg3YdQ-017TQv; Sat, 12
 Aug 2017 16:56:24 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC] convert: Add SAFE_CRLF_KEEP_CRLF
Date:   Sat, 12 Aug 2017 16:56:23 +0200
Message-Id: <20170812145623.31517-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:YkkWj3kDvWv9hSxwCdYMobN8nW25+GxS1t5r9xJGWgIzbHK32gp
 u6pKdemnExSPAd84q0bHaCKvlILkdofULmD3GlEMB+HTLhuG/XyVmQMfFDxga4ClEQtX+IU
 XM+qefbsFgcISni/GIX8BctNzPdKH2NfgiD+KeNmhUgscf5AV1ajBY+s4XMpXq/edB0EAHm
 sSUgZ77xvebldv9DNGmlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:du9sIKRuwfc=:6yIWBV6cPBStd2ge7k2DWq
 bd6zRDPMJJRlWLpmOkVXuRNn+UAv2nPu1RtHVv0guJEcbd4NBjzHgcDy2G7DdHMmzJocCBx1f
 1EnPRr/kzv/HY7W8oXgIUpoL/gXJoadHnqXPipcZKO+jGnZEOcXpIbtIQHPiULwXuqZ7Mc4wp
 zVBR6X+zP3m2Nb1DdbzTy/c+yqCi/LIfOsLdW1DQ0eA/zIOCZt19vP302944mGtsuzVA/IWoO
 g6MA1pl9wRtE/rRIc+HUCHfr+Zm51Z1/qTg6f4bi+gXUife1Tf5LsOEO2w/Sn3eaWHNp+5qZ4
 JXXXNRuTS5vDORsdU7Ol3GXdazNLZQp5ataY60Z0G+MTaZTWgTr+gXxVK03I46jVzNMnkvAl+
 iLmpNRUbwRlfky7YMk27+3QwFPifZwkfAY1lInNKd7Q3EZmJQ9Rg96D7jjiwbXfiIvubRw9pQ
 tLsV7PPLs8j82otC4zoWsDmkI2VX2yjl0IL6jO2rX6gtbEWpsCLH2t6fwWwTrGHWPhGsGrT+g
 bPAmI+ghGb0SdA0ty+HOjgG1XbEVIGUTd1bC5tm+ABcZxcBZ2zcpLaFzDmWbw/nvoQOsE4PlO
 T5IZ1Bl3L6K7sA0QqKbXDKLiFASqhVD/ibTmboXbRpPPk7/KkyHns//l106oeZZnOtavmdaYT
 Bi49MEOhI+zJ4+yOrzKzPIy+TZ1CHMSszz0cQ23N2UFQbOmAkbLdHKx+k8PD4BDPZcwoW4OVn
 dAv0uLc7XuLpofvBi0oocs8llnpNSGY3fPLfpNARpT9JdlvbdmevWeAlSZqqn5QqkpzLhOPVS
 x7R1XtpOhDYHmbxE4eCMBwwA7jgjkzG5ADFn+JCZJWzBSQmw30=
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

