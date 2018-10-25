Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B1E1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 16:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeJZAvm (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:51:42 -0400
Received: from mout.web.de ([217.72.192.78]:54939 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbeJZAvm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:51:42 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4I6Z-1fOyub1yzL-00rm5B; Thu, 25
 Oct 2018 18:13:10 +0200
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4I6Z-1fOyub1yzL-00rm5B; Thu, 25
 Oct 2018 18:13:10 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/2] path.c: char is not (always) signed
Date:   Thu, 25 Oct 2018 18:13:08 +0200
Message-Id: <20181025161308.29207-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:63zpcYxzvhHZJotdOMjXAym8HcloIyJdfks/fHWbtYZJTjD28mv
 8ZIQg8hSl0QrC/bd/ONbUUbD5YW6unMhCE2E37JZ0ZG3Og3ILJfsGisSJYEU5AM6rai7/nH
 +RyO9ysX4KKZQreKL1bi8nTQLQz0mOJnhXQlEWJoD4Yr/5K/ZNLwu7Oekf+iC46Gnh7OSts
 /JnoUetQ+szD7YUFNHGcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jW58gLvN/+Y=:34j3t9D8tpHXAhTw4o/MyD
 ZPil0g5SZvpGHnj8Bi8vvFDHM7zjEkw/0J1cCIgkB9/L+AOwPJhJm50qvpRZcKCHizgjO+sEC
 HDiOGX3Q9lsuOBduBXXeQVT9uU6xeHTwFct0nf1Zva0ZTZ5zCQGZJs9AuKJ0hitd/0B10IhlT
 Easdpw0AS64tkBVrhEHaKB2Jup4RNru1BGlvsd1qeHjj/zpTpMxxk1PjtS1NBnoprliKcU8zx
 d9YilcI1nhX4DPbPEsM++/bFeg1whWJoKUCfDE9uIYuMmEXo2zO3QyssLfg3SMRgNERaoM/P7
 71Pq0FEG3YFejqyZp1Wbo1+wMvbg3FIURCdVZux57+lNwNhpy8bYd3VbYozfpFXDnlcvxaFVc
 F+6e2k7wMYFox9OZeAweQao1zo+ky6//FgPG5Ig5jqFhIgTVV4up+EI0bOJi5dvmNq0k367xq
 WM02YqTrbIGer2scUjS/E+aXLZgillMnFs4i71XZSl7QXB1RogWLP5x/kgUI/VzwOdY86W3E+
 YZ9f2VX5Ym0ykfe21z6aSwec/kwJjO91x5O7jIU3teBL3zg61cO/dVzXDIXXFfEXhsl2NeeHy
 zQG3dFXaFeBvxKy4bbobmycruEzT73JzyMSNcu8SyAfS6uDGPN0biqFO4JMizra78wAAZEmTK
 qAKF2iGVgAJGFVYBTXEKG1Drtz98iYComLSu4EWDLWpzoV9lf4D9vTuazedFfCWR2qi1E2B+P
 PsVroqsGUCSLmMzlRUXarjWYFnBFHXej1Re5RRFNUsXIBAKSDQ4drhLk50iIZELgyPeKIjSRL
 gfNELsOEBFOM9Y36I1XhR/349xRh52EsbBXYHIH3YBB1XRDwmM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

If a "char" in C is signed or unsigned is not specified, because it is
out of tradition "implementation dependent".
Therefore constructs like "if (name[i] < 0)" are not portable,
use "if (name[i] & 0x80)" instead.

Detected by "gcc (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516" when
setting
DEVELOPER = 1
DEVOPTS = extra-all

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 34f0f98349..ba06ec5b2d 100644
--- a/path.c
+++ b/path.c
@@ -1369,7 +1369,7 @@ static int is_ntfs_dot_generic(const char *name,
 			saw_tilde = 1;
 		} else if (i >= 6)
 			return 0;
-		else if (name[i] < 0) {
+		else if (name[i] & 0x80) {
 			/*
 			 * We know our needles contain only ASCII, so we clamp
 			 * here to make the results of tolower() sane.
-- 
2.11.0

