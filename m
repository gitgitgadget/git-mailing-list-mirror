Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8834320209
	for <e@80x24.org>; Sat,  1 Jul 2017 12:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbdGAMvC (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 08:51:02 -0400
Received: from mout.web.de ([212.227.17.12]:51515 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbdGAMvB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 08:51:01 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEiK-1dXtYg3iEy-00FRmQ; Sat, 01
 Jul 2017 14:50:58 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/2] Check DB_ENVIRONMENT using is_directory()
Date:   Sat,  1 Jul 2017 14:50:57 +0200
Message-Id: <20170701125057.16169-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
In-Reply-To: <20170628162958.519-1-tboegi@web.de>
References: <20170628162958.519-1-tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Fnu4D2qVqkIkn9e1Qrh1yukVivfTIMdlElqfonnisvNMkLxM0ft
 urzl93Of3HVuUBfhITI5W7jIpXJf5aqOqX278s4MB81UE/PtHlFi1dvKjGZCSK+/C3ok47G
 60UO9sPdgaNpt2rWnJ8wjncoAk9XuP6d9fEsAFdD0SN6t+GGv4CVFX2zQtLEs863j2VI0Ix
 RxZ9566Dha3ylhZPAt8ow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VfAXz7I8NLw=:D4P/OKWWhTXnL/Xgp4f8FM
 f+FEB0Yj2PCFj34OSltSt4xm+nzHoOuEq4hex6BM/pZtmLpHfYuA/In3jylSB1YeK3/aat8vY
 ksza2K1fzi80l53PjSvVC3SwC6MynYJiuJOh8A4L6mPzXV4OiVdmBImasxdvZOaQTRAdxKkYE
 wlbBd0yG8oPAfsojLrmVLB2GNuXJF0ZVCoiJb1uO68Hz/ffNDOsB9Kyv6gK8wYMqPpQJkMHvA
 iLe2YAQQ5fQiyIWFqtonSmDpy5sdpQmP2aUPOcruw0SM99DuxbXzN8LeVSrXs0xQEUpDP8mhV
 w7xnVNRBLLr11xe/bgkzs5DHEICgIMITcRdtkWs74cEihaBkxfLKsXgaWatA6tYL6HsuVQ0NF
 BsWpZo780ro5LZ81maVyqlpFxMeKwmArDQ+RSUqOIEFwotl04buto09IEAzQbV9c9LFaV6Q8I
 KL86oJRcwXZGtgu2+kk9D0mvicJ7KvOISGUrSuJQ/JPN1cRgq3ii8zx4kjFtsax2MvbFXQzaL
 WVTWeZnwn7QNKrmMcG5D4Elyqd2PztbxFBeh6imul11avfwA6vx+Zrx4pMz6Fx1yS4BaxvU50
 tIKN0L94+yYgaHsuZVCuTHwD55iOLfm+1ZEd6HKrA6noRKa2dde7Os7AKuyRoC2LY9TW44n+5
 1MRsu+kVlEQZ6Za5PbRX/ZddSeEZw/bOx4yyzB1F336ZZyR2jiLi1DbBlwxJYwAZv2ftprfhj
 BAuCMhI73wIiNp4R+XNBEynrBWcacbvD54T3HmvJbqivyD8R66Zns04YUJRz2FX6GHEGBAHTm
 rYv4yVy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

In setup.c is_git_directory() checks a Git directory using access(X_OK).
This does not check, if path is a file or a directory.
Check path with is_directory() instead.
---
After all the discussions (and lots of tests) I found that this patch
works for my setup.
All in all could the error reporting be improvved for is_git_directory(),
as there may be "access denied", or "not a directory" or others, but
that is for another day.

setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 358fbc2..5a7ee2e 100644
--- a/setup.c
+++ b/setup.c
@@ -321,7 +321,7 @@ int is_git_directory(const char *suspect)
 
 	/* Check non-worktree-related signatures */
 	if (getenv(DB_ENVIRONMENT)) {
-		if (access(getenv(DB_ENVIRONMENT), X_OK))
+		if (!is_directory(getenv(DB_ENVIRONMENT)))
 			goto done;
 	}
 	else {
-- 
2.10.0

