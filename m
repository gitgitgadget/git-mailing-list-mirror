Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A469C2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdCCCE0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:04:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:52121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbdCCCET (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:04:19 -0500
Received: from virtualbox ([89.204.153.4]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1F72-1cPbmb1DNA-00tGoo; Fri, 03
 Mar 2017 03:04:09 +0100
Date:   Fri, 3 Mar 2017 03:04:07 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 2/9] setup_git_directory(): use is_dir_sep() helper
In-Reply-To: <cover.1488506615.git.johannes.schindelin@gmx.de>
Message-ID: <d1342d28fd402615f1f94d9190559070ed04b0d7.1488506615.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mqJh3aqMzhZ7Avl+/nU42x9efStKrPl6Sa1ewc+1ag9TQ2lZFpT
 +kfj/gkkzoApUMzepQIibGyrucKrTmaGYtwqv62vVAHFOc5lNgyW+jQvac9zHJyVYOXhOJk
 Lv0HCM/OrlmNshgQeNoePJeXQ96znezeFNPVSnEE7JDs2lDnHPlq+4sREeguGGBzzf9VX5f
 xyPbEcCUTNemQIrslwU0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PndfibvDOcc=:efitTQApLSesHbWUh3JGdi
 grOr9LEGkAKk4101ghmMqAz/2EHQxehvAbqemDZAp6ReTNflJ1thQqHHX81+VweO46LEbeCSL
 1IRyjkHJ3x87O0Es/hTWY2krb05BO6Aasix08AOXp5oSBQmJoh8VZ8KuNUbL/naIi28NwCoUF
 BSbejh/dd7sqqpp+H0f5dtY/Lo2fL6fNAf+nnfH9ZUHb91UDxMb7ZR0xsMto225kwI9yGe0Hk
 74sw5wtiFlRX6koOnsTfPzNIW/+8y/qJ7mRTaKRGah7moEwoomnjjEBSu9YPWdrSlMDhSq4EA
 IdnwD1NcFR+ADlmxd7LFp/IXA5COXA4H6cO31qjWNow9yL28ffjdCRfc66puFZnFPvsrkVREv
 3YcvctZntTqYTMj22hgb1H05bNdC6SKff1wKe4O2RSW6Ub1AhgL2pA+2aERhZwEdRUPHGIzYb
 ec3cplrzFyg7frvQCZk7/B/id9qfSBOFQ/Zcpx7GIYQxjwz3oBtQzxpAnvdCETtDCnG+t3cTW
 CaM9sOttjyhDmWmsQt4ZF+IprBNCCON8nWF2U60TGpUH0r9CKqDqpKFxm3St+fnGRx/nS9/Ej
 eganWmdPbD2OZMzgtOSHu2yjH+fjzSFhVBH/caPejpWc3c5JuYbCqP2RQHxKxC5l20UTYBWWX
 Cxse/2FuWFAGUQBAo6Z62G1prZy4XxRvVTmdSxcH2G7nI2NDMMdgDXCcpLALqmRoT4wRCNVDl
 2QDUYhtVYGYnOgAEkJvpDibvPRzTCWYDAQW35pl9+7fEFDXMY1dl7gk2bYXALUcf6hXtsRXOJ
 s8vXZVG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is okay in practice to test for forward slashes in the output of
getcwd(), because we go out of our way to convert backslashes to forward
slashes in getcwd()'s output on Windows.

Still, the correct way to test for a dir separator is by using the
helper function we introduced for that very purpose. It also serves as a
good documentation what the code tries to do (not "how").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 967f289f1ef..89a0cef9231 100644
--- a/setup.c
+++ b/setup.c
@@ -910,7 +910,8 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 			return setup_bare_git_dir(&cwd, offset, nongit_ok);
 
 		offset_parent = offset;
-		while (--offset_parent > ceil_offset && cwd.buf[offset_parent] != '/');
+		while (--offset_parent > ceil_offset &&
+		       !is_dir_sep(dir->buf[offset_parent]));
 		if (offset_parent <= ceil_offset)
 			return setup_nongit(cwd.buf, nongit_ok);
 		if (one_filesystem) {
-- 
2.12.0.windows.1.3.g8a117c48243


