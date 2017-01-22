Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8769D20A17
	for <e@80x24.org>; Sun, 22 Jan 2017 17:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbdAVR7P (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 12:59:15 -0500
Received: from mout.web.de ([212.227.15.14]:53245 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdAVR7O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 12:59:14 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUir6-1d19Jd2iBo-00YDq6; Sun, 22
 Jan 2017 18:52:17 +0100
Subject: [PATCH v2 2/5] add QSORT_S
To:     Git List <git@vger.kernel.org>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57d9277e-9ed1-40bf-43a7-ff23377cdf77@web.de>
Date:   Sun, 22 Jan 2017 18:52:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:obwvApyPS1atRzn2CzRrnK55rXLHicy0hXXpz5xiNKfR+LDPnwP
 nM5aCtPGg46uYTY1daNj/bXlw/RBEuoZpaV8TF9XFHIB110aqhTzY12C8RjzMDmlgjX/3pZ
 VLJtvWmcZVrfL+8c8wS1Wrm0ALZKofX5mry7d2XOvhaCrpgsL72MZXwqG364LaUbw3MyNQa
 heq7hmchrz2u0M84tOZKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y2eWqMx0+i8=:wMjH7eqh2xhW9b6MpR4BE/
 lzh7nsGjfQ77XkaDQW2vmrJRhoMIKCsI18FZPBv8RjLZtJ9vNKTg6NNdFURcezgsmzGycaXib
 BHQWjBerJK9C2LOyzF7y7q8wk7aBojrINaeRusYSg4hmkMxTyxMvcBUTpluZFhKXnmRfGz6n5
 KCQ6KVTSvp9hZGceW7oDRFa7dC+TEP/hLHRW8/48uiVEk32j0HLrw1utW1g953BQEuBCi+50H
 AtW019Gux6e9r5WoSwkXrL1z0ijnPDCMrxC4J9QYBqli3o/4Jc205sWMRFJDdqpUQLxL3QsoK
 7cUrOkTPep1LlRM7uBJbI0zuucELrIEyFGZXrDWZqc7f86xAHznTe1PrSBV9FNZcJi7VqUSJV
 iou5wvbJ1Ky78oZVNwDV3etabzuXLvSyxNBaLeZvVSgKuSOSfPyR+Mrih8E3NL3IYRGbF34sl
 iZlhtx2pSwEPTkXhMVW53HaqZJVTyHpAKu3sKRd7jO+QNyJXeZvMVOV9TfWvUptq3BUA8nTwk
 CoUkya0kg72saPcCeGadBVzdCprMK7t/C+aVw/vfyaTXADOfViesviHhM3/ijCkF8bptzVeS3
 LypWNqvP57hqwncAMyUMZpvoQBSH2noPcD1RQQT8pj+uyyW+6jw8UtOk8qAQty4GS9AEMgdGT
 DVDIXAsiNHbBNmpgSo+I3ubU/9rxjXJBhtR5cETydB1m/BAqzXL67169kLYj4ygue+FJyqVvU
 7HI7Mc/y900tDXauqODPrM5smkWY4qou9ITzNaJ1DqfOvaUpjJHw81LKNqR+Va+mBsVa4Ia4w
 0NyQ10N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the macro QSORT_S, a convenient wrapper for qsort_s() that infers
the size of the array elements and dies on error.

Basically all possible errors are programming mistakes (passing NULL as
base of a non-empty array, passing NULL as comparison function,
out-of-bounds accesses), so terminating the program should be acceptable
for most callers.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git-compat-util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index f706744e6a..f46d40e4a4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -994,6 +994,11 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 #define qsort_s git_qsort_s
 #endif
 
+#define QSORT_S(base, n, compar, ctx) do {			\
+	if (qsort_s((base), (n), sizeof(*(base)), compar, ctx))	\
+		die("BUG: qsort_s() failed");			\
+} while (0)
+
 #ifndef REG_STARTEND
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
-- 
2.11.0

