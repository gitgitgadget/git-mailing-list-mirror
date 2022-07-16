Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7ABC433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiGPQ7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiGPQ7K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 12:59:10 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD21D11A
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990745;
        bh=ryiAVfB/Kx7xMQB2asycsKme0OLkizPNC8z6/stXibM=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=VRx64lr3k8+3BWkCySkqbfCBCmJ4w1jjC9Pjuthk3CUp36jiKOZE1F1JKF7IfHsol
         Ry7fUPSEsF1WwERxzBUFFJlCshR3APtFII9Yr1L6tApBnp5zpnjMldLIe0xCFhc+eX
         OsUKXY6TZjxmAP6ErQZ7Dp2PCA8eq4Y+P7wxbmlQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ma0PY-1o0ZNF2tuO-00WAhL; Sat, 16
 Jul 2022 18:59:05 +0200
Message-ID: <396b927e-5bbd-1b7d-669e-8e22740b5295@web.de>
Date:   Sat, 16 Jul 2022 18:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: [PATCH 07/10] commit: use DEFINE_LIST_SORT
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pMfAzpF4gVnD7DxVtK0mXlZXiaiwgxyj4CxP8VzJpRIJLXHHGti
 KcmMAdpmArdDD0rPdZsFkQ1476oUXf9Uv1UK4SL9a2Rxwu/VRH+qB6OMPvzGNNe+lFUSV8K
 GFZms8ytTGHIkfRnQqAKt8KVJ8NczxcjA7uaLeBrJRRWlqEHoSczbRAsx7NQTkjlsvY83iC
 bfec7mjThSnzBWcZJyKvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M4PZw6H3/k0=:wvV+l8c3yvVRx6llHVS5TM
 izFYFRuFbbh5Wyoekhcu3l0MGjo0WBhUAV6zkOotl1X2dIYtTCWg6158EbF3AZ0jd7CVJeVgN
 t2JFhkDOk54UwPVIvtWDiMQvy0ALqGRz7+e8uutdmR9oPdK9W+m5zwA6bQ9R19ek6AzZStNVm
 UilqwEvBJfNXt21VfDUckh7M4laRIVp0xi6o6MuvPqLWkUk/YLGkFBlTPhlMinMVsVm4iJlAt
 m+dboJ1mGkxF5hIoVDkLggbCwKH2HVYDQDcb7ok+j9RgXwqHqkbuJyi7IvnBcTQ9MiHaLpusL
 RzUuxqsjoVuzNE5zhsrcy0LbkRsH3UT19IkyPAsuGdL4pOqN7TBecYPGvr59a788dpo/lP/As
 5wcX7dGTnmt3rlgf/90xhmz/nt50QkZMnljpARQiThWjVIuT5twtYnwXyfI3rg5tREmQdxvW5
 bYNhoRYrouk6l6pKZUAVVzViCUcgiHwcLJqN96WROgjT33q0PgeGQxp+p0Zl7XY8Ggl+4et5e
 bOgIB6+qqxWqOEZDyN77MQrjZRvov0npqVl/Ua1Y5VktD2Mes8CC8059173qud7ryfGjS3jpq
 LkGrXAbGeCu1gkYR5Bb0DBLulStEFCPNCvcZGPZtzvZiiZXcCgUfsK2FIIrn++qjrlpbi8MDV
 I00j3lSrlt/x5FyjrVl7YrKeU6LH0oTsCTMeRhPpcLIZQQAC+Jz6Pvb7ZTEH8deL5pHVM771Y
 7UmoEXzyd6RyGTi4oKCAUjI0wp0lpoeEXhhX63VgnF/5oLUHuLt6SiMUZRUdCMbXF8bdDA4aO
 k31LDffF/UiQbk5hM4OPoQPOMuSBto+Lq5554REaEv898TC7M0ey51kVAmuC/q4ClMKrtTQTS
 APCY8jyOUA36TH+tOGumnrjJvsoCIdwYFA50g3Bbavbt4dOImMxjyz9eCHrA5OP8NoUpYDqxc
 IMAqj5l6McFVFvATKw9OyOCbMlAgQ5PI1Db+rEMwELYlsHkfJriITplvjLhUzDMweo11AijwZ
 yEHzn2Jvn45O1DXeI9B+ZgZSZZNXQj5BWKLuiIz4tVxxvVh38zu6VLNn3cFjBsEBu3QenqaqC
 RcXuCMRfpphQ1YunxooPxEM9l/dJ3XxRtLQIy6BcInc4egztvc/NYlRIQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use DEFINE_LIST_SORT to build a typed sort function for commit_list
entries instead of calling llist_mergesort().  This gets rid of the next
pointer accessor functions and their calling overhead at the cost of a
slightly increased object text size.

Before:
__TEXT	__DATA	__OBJC	others	dec	hex
18795	92	0	104654	123541	1e295	commit.o

With this patch:
__TEXT	__DATA	__OBJC	others	dec	hex
18963	92	0	106094	125149	1e8dd	commit.o

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/commit.c b/commit.c
index 1fb1b2ea90..0db461f973 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -642,10 +642,11 @@ struct commit_list * commit_list_insert_by_date(stru=
ct commit *item, struct comm
 	return commit_list_insert(item, pp);
 }

-static int commit_list_compare_by_date(const void *a, const void *b)
+static int commit_list_compare_by_date(const struct commit_list *a,
+				       const struct commit_list *b)
 {
-	timestamp_t a_date =3D ((const struct commit_list *)a)->item->date;
-	timestamp_t b_date =3D ((const struct commit_list *)b)->item->date;
+	timestamp_t a_date =3D a->item->date;
+	timestamp_t b_date =3D b->item->date;
 	if (a_date < b_date)
 		return 1;
 	if (a_date > b_date)
@@ -653,20 +654,11 @@ static int commit_list_compare_by_date(const void *a=
, const void *b)
 	return 0;
 }

-static void *commit_list_get_next(const void *a)
-{
-	return ((const struct commit_list *)a)->next;
-}
-
-static void commit_list_set_next(void *a, void *next)
-{
-	((struct commit_list *)a)->next =3D next;
-}
+DEFINE_LIST_SORT(static, commit_list_sort, struct commit_list, next);

 void commit_list_sort_by_date(struct commit_list **list)
 {
-	*list =3D llist_mergesort(*list, commit_list_get_next, commit_list_set_n=
ext,
-				commit_list_compare_by_date);
+	commit_list_sort(list, commit_list_compare_by_date);
 }

 struct commit *pop_most_recent_commit(struct commit_list **list,
=2D-
2.37.1
