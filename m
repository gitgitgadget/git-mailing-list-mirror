Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD561FAFC
	for <e@80x24.org>; Sun,  5 Feb 2017 11:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbdBELnq (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 06:43:46 -0500
Received: from mout.web.de ([212.227.15.4]:52723 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbdBELno (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 06:43:44 -0500
Received: from [192.168.178.36] ([79.197.209.108]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8L3a-1cE0tF16yw-00vyiQ; Sun, 05
 Feb 2017 12:43:31 +0100
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] p5302: create repositories for index-pack results explicitly
Message-ID: <251bdc20-19a7-9a6c-9f5a-c7e661810c70@web.de>
Date:   Sun, 5 Feb 2017 12:43:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:7aTK+JtUiwEKUeNJNZ8P4hJfB5o1OaNuP9T6fhkVTRaKh785njh
 ehhyxODYdJG6YJHgpJWVlUinhkystfAdAAUFH9kYLstJBh/lHFZ7bz4ytflsBIckSBemn5N
 WJ9bBQ1NoALTzJ7TFGvaSRv2a158NZSsPfgZrW18HZNuArymua9TjeL6prMFN14zgsERY6G
 LlU88HFWLT4HTO+WdnK8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qcwnmh7nMnc=:LKQRwZu2I24/2bdZrylzk6
 dXtphx8FVKBaZzq3SGbuw/6c3jdOD9RXgRfiaLQzZ5xc8uinD6uqs3Z49xnA0WeeUgR1rN2/h
 wbB8qAstX1aH2dsN8nE9R30tyZ3q6mGLUTi1fSwr193We/eHkyVhNKcBZhlyqD6BluHWfI7Xy
 RmNhbCMtfIn2BL/36pE/Q7pXTobCsW+MBpOy0othIRxQR+qFrp84CKalWGNgLKb9LdGg+yOWw
 eTWvrIZjuo8LsMYSwfbTMOP9BChpecLi4lfbI7P0edKLs0Khe4dQ/wcjcMwK9iBilldW9Iblm
 RmRXgmV+QG6tZKS1RCOvkx3lEv4vfep4RXeCymZ5aZpRkS6lJ6r3UhSGQaou9I4X5ZaDWaHcY
 bwHbAm73uWluPAsFb2/QsBc/ZR7RGxoxWPKNaSbLvcCv/TbLNyCmTfoFgE/spyzVv+YH/d7zP
 T9cwnmX0XsHjP5Syhue4yQbJ3ZyOZl+cxrCGLwSTtJwhPUa3CpSPyUpcdQ7DtmsBZDLkgY9zE
 QvH0MlM7tbFfUS8i9vt2gj+zN6u+aHS0y+sOmRFiFsl4CD1z2RPfm8g7OV/N5eJkd52gljEZ+
 ouM4RsrHtBg8pNxatKX5rBAnjqyL3og+/an4rrVNzmZzxQ5YsYCyrkuHLyTVKwGWUYF3ffrTC
 XAv/ITUAHgmSAxCdnipfehH5XY7cQtH8WsEcfmvzpi2P3u3eJIrwtZIveZvSo5rjrg2RZMPhh
 Le750MOZaP3Tt+irWr8mP2Pdo4fx/Sru6Plc2Lfk4k9wIf8EzMVAom9mjsvfu0iaSxog8mCL7
 5JN9vvK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before 7176a314 (index-pack: complain when --stdin is used outside of a
repo) index-pack silently created a non-existing target directory; now
the command refuses to work unless it's used against a valid repository.
That causes p5302 to fail, which relies on the former behavior.  Fix it
by setting up the destinations for its performance tests using git init.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/perf/p5302-pack-index.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index 5ee9211f98..99bdb16c85 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -13,6 +13,13 @@ test_expect_success 'repack' '
 	export PACK
 '
 
+test_expect_success 'create target repositories' '
+	for repo in t1 t2 t3 t4 t5 t6
+	do
+		git init --bare $repo
+	done
+'
+
 test_perf 'index-pack 0 threads' '
 	GIT_DIR=t1 git index-pack --threads=1 --stdin < $PACK
 '
-- 
2.11.1

