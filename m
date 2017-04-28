Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E6D207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426114AbdD1Nt5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:49:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:52817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755605AbdD1Ntz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:49:55 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LuJDv-1e459R2eox-011mTY; Fri, 28
 Apr 2017 15:49:46 +0200
Date:   Fri, 28 Apr 2017 15:49:31 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 02/25] winansi: avoid use of uninitialized value
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <6e471ec11ad13b5d3256d2c579ffad6fc3491d3b.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+VpWbjXdkcHua7EDguTepx/qw0fF0QedkOdXzKcL0pDszU3R4T2
 o/nHlLuEeottKFAPWCI8K0rUZ9zN5MMW7RkjSVFDCito1Ce0q3yYu5eGEyzpMPOJdJz3Z+K
 pV/kBvsgqNEcB2G/Cy4rtTJjcWDJRx2v0vzO7YCleKVDRwIpoWW/v6N44NQlkBa6pW5alSF
 DLU2TVBL5Jp6NwsGzH8Wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WN381FcJpTk=:wQgYW/qUJmvr0Gw6qzy+RR
 /ImZ1iDtlJqK4oK1W2lgIB4OBGrVnizjApEZr5g/Bu/IMsDzCnJ5MXQeeX4c6D4JfO6XqZ2oJ
 CDOhrcT5Q5YHxRKlsCvTysL4TBFBoZwj5S7GIVzrbIcCXQeqgg/FSwA5YNEHFDU3G0sR9+QZc
 IxVIDKFjzzBN4SWjW45llc4V6e1z9CfzkdE1RGf5vTt4QRegACDMUOf9FvTlSIWOBBT/7u/XE
 Jyi44H58YhwZ7TtMuVIMGzvPdi7H38S4071f1ErHONacauB+dRMHpeqA2TVq5J8A5d1u0y2aE
 XCzTdLa/Msjlpfp9XilCLvCswStTMf9gLb1Q7d2bVccTXisccFNtsP8kqSm71HtIsnjK8sfq7
 fQ93yxHvxlJh5bhrfsiGkJsRZq3uYYxG/RmkHkmNXN5WUsCMlK4heaEchy55OybbroFiFOTmM
 bjENBI/ktfNuqrIcmMsglWXR+3VxEd3jGywcxX9nnboeRtsFx68WR+vFNnZGKetGUDsUcEDoW
 KAM7EYIV5bkdoK/k3UAdDb0FLFIwhwWIuQNfUVMhVHAG9svD+ngYNljwU8IMxEF1l9A//Evx5
 lL6J3eelngDh69bONrIwAs9SwKNiC52HtB2k/NPm2LbIrottWtoFKBmu2ejGKEjENPoexJh5a
 0HfbxU+nWVi7eYBqr+h87Ka+Xgpp+3UfXMbMhq2sNaQzXIETR/Jp8eF6luDR/VZ+aS3b75zBJ
 d9rfHlIwfCR2uqpRkD5BKs9tLu5sb+etbwcRC5DNkZYcYAMarbw06IgqRtIx9IZWAckDBOFSg
 GWp0mvB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When stdout is not connected to a Win32 console, we incorrectly used an
uninitialized value for the "plain" character attributes.

Detected by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index 793420f9d0d..fd6910746c8 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -105,6 +105,8 @@ static int is_console(int fd)
 	if (!fd) {
 		if (!GetConsoleMode(hcon, &mode))
 			return 0;
+		sbi.wAttributes = FOREGROUND_BLUE | FOREGROUND_GREEN |
+			FOREGROUND_RED;
 	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
 		return 0;
 
-- 
2.12.2.windows.2.800.gede8f145e06


