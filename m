Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BDEC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 01:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiGGBy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 21:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiGGBy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 21:54:27 -0400
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B449C2F012
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 18:54:26 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 9GikoJnwCGjO89GilovRPZ; Thu, 07 Jul 2022 02:54:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657158866; bh=kKV6GBlax4JOvd965To19+Pd3pAnqhl/iIH5DoZFtKM=;
        h=Date:To:Cc:From:Subject;
        b=n9hh5Lq73rWP70WcyuHgNlFXlcW4Ortpbn8I7aiyP7cXUkF4i66Z/Hm+P5Zwk9zZU
         mCwqFtoOch+Voi29+nuxcu288lhXMdg2vcHUq610F4k50WNeK+/6iucuSsiW/fQAXT
         rHVvZ4xY61enLOxVvLKp7nib5pevGlyCVMdsjznpEb4ryGGXsM3ZVeWPUKdqLHrB3F
         8OuE3hD2FwiR/Fi4uHsCcylyhsv9FZBquI1dmPIFcm9B7xZWBEOcWGQixF8vPtZdb6
         rxpwheyOc0XYEGMM/WxL7qf8PTE9qcNHTHgWPuE+afv3Khr4w6a5iLbxcrh7Wl0yTF
         J0LHgo2I+Yd1w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HttlpmfS c=1 sm=1 tr=0 ts=62c63cd2
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=7AGlB7ZewKkC4Tew4VYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <c344938b-afe9-edef-1e0d-fbe2425c8c01@ramsayjones.plus.com>
Date:   Thu, 7 Jul 2022 02:54:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-GB
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 1B] credential-cache--daemon: close input before exit-ing
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCwtoFfpEynxVJREmSIPGbXuJvylSBmhP5Cijp2L+sDbstzrG/D0f6AEg4UIz1f7w87LqysRVCPHPKRBsAK2kIFJRC86mZ1A7fvqZt344pQZ6kZ2d1Iv
 hcKSNtqcrqR5UUCeXjpoo8ana/8QW10x8zgkgGtXRGViKTGn4c8Ab1WOnV97sDF6CHnJZD+10lCklzcKUP/SxMX/2i92vukJjRE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/credential-cache--daemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 4c6c89ab0d..556393498f 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -138,6 +138,7 @@ static void serve_one_client(FILE *in, FILE *out)
 		 * process actually ends, which closes the socket and gives
 		 * them EOF.
 		 */
+		fclose(in);
 		exit(0);
 	}
 	else if (!strcmp(action.buf, "erase"))
-- 
2.37.0
