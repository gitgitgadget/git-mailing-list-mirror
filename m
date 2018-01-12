Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C29D1F406
	for <e@80x24.org>; Fri, 12 Jan 2018 16:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964845AbeALQg7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 11:36:59 -0500
Received: from sonic312-25.consmr.mail.ne1.yahoo.com ([66.163.191.206]:35814
        "EHLO sonic312-25.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964832AbeALQg7 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Jan 2018 11:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1515775018; bh=xnF0vwEDl4KsKsgnEmRNbfElkQHkiZ1Km7ELUr+M/ds=; h=From:To:Cc:Subject:Date:From:Subject; b=FqJu4ETKN/A+2WD7zmrT7mcsneYWOgPgsxKPEXgt3R40p8QTDcLtiv+r8GsoFqoDDypiLmsBdDRk+7W4OiCA4GvlpwYihxWssNr1K50pAG3YkQQs1HoSrdWLKbO5eARJVKtJDXmitNqzQy2PhJFpc4TELvWI57/rlhIS5ZFnHHsmW8ISjgq4xkbswnndvOsFzkjOPTq46mBnxVi/gkhavFvQ+Ko8ZyTDN7cH1bRDBAIIfIMhdYNjkmhawbkEONIoSfT+1BNYY/6DQm0yJf3jxwM+GdJuHP+12HSzdvpP3FfmaZ2Klh5aT7kigoPEZBIR9FvFGoWmTb4Oa/blxPwN4w==
X-YMail-OSG: SbJClZgVM1lQI3gdUx7ope8jLyXE5mV7c9LhAs0gdn8LHvxo5a7Z4y3Mxk3LGjy
 W7Sf7XTui_orgT8xky.pZtFxaPTtCO9..rLg4v1MJv8aHq3sx_6L5.sFuDRrNZ0nE4Oy7gtPkJ3j
 52aLtWjmudAKBJgrtEKJuouJthVhDMacbXX8HUZ_zSUofvZ9ht6dUQMXHyVuj9znItuNT43TcK7b
 v5NESb8uMSHo1sp7lnwnHnD7SAANrakcyUIvWUKOfl8s3glcX08sX.O.hSgJUI4PfDYrWhscA05m
 GOJ1IBwXmK4Ut3EI9F5Z0cFkF6ufyXgBpjxHJZVuBZfBFoSMg.lCoH_W32WxL6SpIql6d3zXaoNW
 3FROc36Vs8gKNFpKgd0QMun7MkLcqJyAVtkaQ9gR_iWbOEHNxDRY1.bdxl.bX.zacUj5.VgHDTEx
 A5.vTQbawQV.wzfa9Q6wiLoStT2RdW16GL4yuLkQt284oDCpAvz6ALa3rhbmlIzGi.jXwhajCMAr
 kjfAL7MoLeYMNxPfHvTkkK5A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 12 Jan 2018 16:36:58 +0000
Received: from smtp231.mail.ne1.yahoo.com (EHLO localhost.localdomain) ([10.218.253.210])
          by smtp408.mail.ne1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID d58f1bc7ace46c21762dcec7e73df0f0;
          Fri, 12 Jan 2018 16:36:54 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH] Fixed pervasive enumeration warning in convert.h.
Date:   Fri, 12 Jan 2018 11:36:44 -0500
Message-Id: <20180112163644.14108-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The actual enum value should be used rather than 0 and was causing
a warning in an inline proc.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 convert.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.h b/convert.h
index 4f2da22..a9a6658 100644
--- a/convert.h
+++ b/convert.h
@@ -79,7 +79,7 @@ extern int renormalize_buffer(const struct index_state *istate,
 static inline int would_convert_to_git(const struct index_state *istate,
 				       const char *path)
 {
-	return convert_to_git(istate, path, NULL, 0, NULL, 0);
+	return convert_to_git(istate, path, NULL, 0, NULL, SAFE_CRLF_FALSE);
 }
 /* Precondition: would_convert_to_git_filter_fd(path) == true */
 extern void convert_to_git_filter_fd(const struct index_state *istate,
-- 
2.8.5.23.g6fa7ec3

