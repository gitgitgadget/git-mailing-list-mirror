Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB36202AE
	for <e@80x24.org>; Sat,  8 Jul 2017 10:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbdGHKvR (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 06:51:17 -0400
Received: from mout.web.de ([212.227.15.4]:58616 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752751AbdGHKvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 06:51:16 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWS0g-1dAYaZ1eeo-00XYlE; Sat, 08
 Jul 2017 12:51:05 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] wt-status: use separate variable for result of
 shorten_unambiguous_ref
Message-ID: <d70bf87c-f8b3-9f02-14bd-b3ceb5e9f7e4@web.de>
Date:   Sat, 8 Jul 2017 12:51:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vJovdTiWDQzxJce4U/Vos7RBsom4GuBWkbHLgapFAEMNMSe91MJ
 Zape6ppVHA8bRL53EZcWLz5cjPAXlFw4KjbVXXjART/kRUhw0KWxgHyPjV0DDeSbUMpNcR3
 KD0PKkmd9OAqDbOqV+Fe5WlpiscKnLssRXXn2lZKT+KHKG4pYgpnrFS/4jaFrkZUeYqKCGE
 TyTGGyzrqgVTZxoNuKekw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xb3AQyiLDuM=:NPWaG9ruKS45yhpgATDVnO
 mWJIKTgKJsnKTF75nyDGMrZTc0DQlujp0+/tqFdOhir+iW0EMrAXxFihdAi+fZwU/zHEpC/lV
 XSjchF5o9TB+MtR9ogDi0mMD1JqzgH25laaVJ6J869rPv+agqgCm4vYToi0yPwDglYvbg0yAR
 7X92gStmUhnoJ1ccAxenePuFB3ovhwGwZWteJNDUFiuXpManGNl8/aqUuRn0RsAKAQ139UvxA
 fEgCTA84Ec3ZZjTAtU/o5lCHUzKB/s+xYNq8GtQN9E5mt7vvGkY7sCD+4h3YeVzSTO0mYtLM0
 3NAElMUDyJa8jJIfmr8Iona3uU1yba+i5XJcBzaUO6bHGG1Tsig4hF4XXzJSdT1bti7EiEi4s
 ii7/LTrLuvl/nvS/Cuc+w47x82J/Xss09GTPyzz+YO9+Ajsm/fJM0+sDH9vH9xzgzmbjJ94ZF
 h3m9tAeXHs8th3cRKZoEyXkndzuXulXbcXO3K9UYaNc+wWOandOR9tkI6Su9YDVrSYR9zvpih
 D1GS/031e007pTjcsELm1ETLSK34bKw6hobmMWvgr2tkSiceHQn2I/6NtT6X/SuwDycZ6eQlv
 sRgT+4J9N/C0FPId4ZkOGKE632O1k7N98uHoeG13BYPxAVSJYov7OC1pMPGiz+hYmtgmOiOQd
 9VFLCZR+SmKQAIVn1aPrMox7uZyP0tFaz82uCSzcxmUCyDBIcZTZdLCzyEScN4nq79u1y6GjI
 fmaOZ0DRNggOanKaJCsUZbKxPgC/i3ExIasynEnli5tu8NMRGyzCaIrbIKhUD7HoxSaWlH108
 6e7D/kl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Store the pointer to the string allocated by shorten_unambiguous_ref in
a dedicated variable, short_base, and keep base unchanged.  A non-const
variable is more appropriate for such an object.  It avoids having to
cast const away on free and stops redefining the meaning of base, making
the code slightly clearer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 wt-status.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8d2fb35b08..77c27c5113 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1763,6 +1763,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	const char *branch_color_remote = color(WT_STATUS_REMOTE_BRANCH, s);
 
 	const char *base;
+	char *short_base;
 	const char *branch_name;
 	int num_ours, num_theirs;
 	int upstream_is_gone = 0;
@@ -1797,10 +1798,10 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		upstream_is_gone = 1;
 	}
 
-	base = shorten_unambiguous_ref(base, 0);
+	short_base = shorten_unambiguous_ref(base, 0);
 	color_fprintf(s->fp, header_color, "...");
-	color_fprintf(s->fp, branch_color_remote, "%s", base);
-	free((char *)base);
+	color_fprintf(s->fp, branch_color_remote, "%s", short_base);
+	free(short_base);
 
 	if (!upstream_is_gone && !num_ours && !num_theirs)
 		goto conclude;
-- 
2.13.2

