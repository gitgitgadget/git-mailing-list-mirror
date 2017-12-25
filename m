Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9AC1F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753094AbdLYRoV (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:44:21 -0500
Received: from mout.web.de ([212.227.17.11]:62321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752815AbdLYRoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:44:21 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeBPe-1eKEBH2DXy-00PtYM; Mon, 25
 Dec 2017 18:44:13 +0100
Subject: [PATCH v2 3/9] ref-filter: use clear_commit_marks_many() in
 do_merge_filter()
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <17b5188e-78d2-5438-369e-9e1f39e53f63@web.de>
Date:   Mon, 25 Dec 2017 18:44:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:k2oqcQxDlGEIPvhb+eJ10vIstyFdtomsQLgC29s+1NZoi9y3HZ/
 VfQQnTbw0KqsuV1cUS+WGeY/HAfyl/BfNS+XhF4WOwccKfk0TaE+LrYiOCodc4Q6NiSYZ7F
 GLJFb84uelYsWbZN1qTsEueLF0beNsXxZuoju6sJPa/mXyF80qM90e69ifczNrXdtr7VjSQ
 0xqU+I39bWBKe+0PuHc2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y53etwNAEY4=:prN4FkscQug2pro+d2GzI8
 6dPXZT19sejvkWvaL6EvDhgvmMAgqAStWfv66LrWVbAciXI5qIpVPIXdpPgLHKE/mehu42d8b
 YpJYcVt4xCCvzb6J0zuVADyE4IA/d/sI8FLODkpHFfRaO4TqNgE6nHrrILK80P16nXX5SXVX8
 t3NuQeP+T4u+q4XIR6cBg4eeNoebUfcSlW8/SRKwZtVgIZhu1LEN2cF/A2m9KQ+EQbXlq5VzE
 lXKTrjz1x+2IBOXVMv4x1eYMq7qM0w4pvqxADAZRs6puGaSqVS5EDh72jDWvfjkNMO7j/jvtk
 Q2ef51pAeD3rNLAQW9789giMLMpaW05frG4KBqXSIiXAVvHLSlzO855PKKyDRBV7ytqRxrSxQ
 HUU8gyjHVNu4MJ3AMlkkyWbc2Sh/4wDu99WDW22whSXgnC6vLoT5CJu0MpyzNmyIr2FQ7MdEZ
 /o4B5EJaI4qBiI5Pd7n7/gaCGxYC8RcytsbGAxDCLUqDintLcG+16llt3JcBKS+se8LCILr5R
 iFCfvWYi66rl+954gBoJn03ZlCmC5XRrDyTs5T/BDFTUuFfBv5TVjVy2JYnxC9nEFh4Nvv1cg
 R+ylKFExoW7GQy7OfcaKfAAqWR0qks/KCa0MDjQ6AZRtZv4yk7kGrOzdX5/79C+NG4C7xc0Yh
 bwhtysg9mUTrUsADreh/WZe3sp8uFBkHQ0lBPh85ZhmUAKIJr0PLTF5sVx6o7KAGBXeJbl8cK
 2IO0B1dnpgW7hZIO76EyrrCBcAEUbjL4v8sn2KAP4TnU8oN9LonHGoltQEyK72S9t1aeVrFMG
 pZRkWNbKixwsMV2/HcCXgj1fyJCS8QbExU59me782JqBcgM7lIo5r8vh2+RtNrAwS8goNH6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 ref-filter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3f9161707e..f9e25aea7a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1995,8 +1995,7 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 			free_array_item(item);
 	}
 
-	for (i = 0; i < old_nr; i++)
-		clear_commit_marks(to_clear[i], ALL_REV_FLAGS);
+	clear_commit_marks_many(old_nr, to_clear, ALL_REV_FLAGS);
 	clear_commit_marks(filter->merge_commit, ALL_REV_FLAGS);
 	free(to_clear);
 }
-- 
2.15.1
