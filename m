Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7E3F207F8
	for <e@80x24.org>; Sat,  6 May 2017 17:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdEFROH (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 13:14:07 -0400
Received: from mout.web.de ([212.227.15.14]:63212 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751458AbdEFROD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 13:14:03 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmhQx-1dg7FO21pr-00aAao; Sat, 06
 May 2017 19:13:57 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] am: check return value of resolve_refdup before using hash
Message-ID: <f0ca65bf-aaf9-2cd6-1deb-c55c9e7a8fa3@web.de>
Date:   Sat, 6 May 2017 19:13:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:M9EsMNLI01g/j5EPBL3SVV0OcnoKnE5cn+bbDWIzLAN11AXy5ei
 kseNNPSILqeSwbkLgpBV+P33J+fRKwu4+5Cpq3DRU8Jbx7QZtzBMUOcEnIs2bdoESUZaFps
 I6Qx4CsFHj7AMZNZDT+1UMTzUZkUuNZof7fewr7us8YFsJ88YQeiqCX8+5dqOsvd19+H8cO
 HCRNydlia6i5s0I4U8aFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aRX9ikWuZdM=:PoUhJUbgfWvSFVG1Va/suN
 FfwlDv0zCd2O1wSi2VlMylrzxH/8VwKUtP0DJt/Lge93QcQqVrqkHhh/DObICfmzd/HatTKQv
 WBJKXprqkl5qK4Kodu9/eH5/aYPYlMOir66yQ/+dRrucJm/CCoBZLBeyqNJu7JoLWg6gkv03r
 imuiaEUny1Wr818XMc3kby+c8eqIeq01QBoTip7F4yDOmfMgsShkTNLES4Bcm4So71P4GHY1K
 kfg6/a3xreGXiEsn8XQIudAGQ/IydaDe9wU9rf6MjfLFJtqHozKeODRCDlI3LuOqYtQ4F7DrD
 TnyzPi36Ufgwc7zIIwIQrt28JWfoBWtXzokRL7YKFhrM2Ck531F12tUifAjsChxiWW2JacgbP
 a7Jcnvx89a+fmLnA2n5jXTmWW2l4cyoBjQAaqhu8qHsc4DDhvdERmLXiUpqoUhr9AyRokWspu
 b4Nmu2C1INDvuaQ1Dh6Rz/U1N/Ixx5URvAhy2IUC5G//XKeOl9h3fo/ZJGaevAtXRNKypOAEZ
 kkGsfxEks8z/EQFVWISWASIHVRMsvOkKlyndqzDPZ+kcn+YL7FRwONnJjYwcjLbjuKGDkYhpP
 3mwaEllTTS+KWffqYgLPtxTMR+AiZzUy3NlmsuPkKoNI2RfW5Q42u0QRXT2sCZrYBqNqED+gP
 DxY2liOU49jbqISnOoyAhs3g3NMtXdAPLMFW4Z4pOD+3sJsZ+BMrrKIMtWG8zfKMt82AHl1WC
 kUKdonTER5d9mmWxq+Ok5wXaxgv0Kqusm3M/6UHBNKqF+esiuWbqNiZuuaSwYJi2w8PS/Q7iY
 8JIoHQb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If resolve_refdup() fails it returns NULL and possibly leaves its hash
output parameter untouched.  Make sure to use it only if the function
succeeded, in order to avoid accessing uninitialized memory.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index a95dd8b4e6..2c52c820aa 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2156,7 +2156,7 @@ static void am_abort(struct am_state *state)
 	am_rerere_clear();
 
 	curr_branch = resolve_refdup("HEAD", 0, curr_head.hash, NULL);
-	has_curr_head = !is_null_oid(&curr_head);
+	has_curr_head = curr_branch && !is_null_oid(&curr_head);
 	if (!has_curr_head)
 		hashcpy(curr_head.hash, EMPTY_TREE_SHA1_BIN);
 
-- 
2.12.2

