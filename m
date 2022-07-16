Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4024C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 16:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiGPQxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiGPQxw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 12:53:52 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC764E4
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990426;
        bh=LvdXq/5BE/hS/ln1un1xjC98Al1GF4eDWxuAR4BKsrk=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=nWxQ2FQk/ZkEIQWBkuPq6P/7zh07D+CCQeyOf+SuDraDsmX/YhcEZTTiaOfF1qlum
         gWdn1GRrfDOdAoTz3QPLisCc2sOIT7MQLTCYFeu/6OOl81eiAVwPWGf3oPpQPUrKwk
         /SmyYTHKlEyZc0tQX7K2M6LZ3x+OO8r83LNIVAnQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43GO-1oCl334Bay-0009Cb; Sat, 16
 Jul 2022 18:53:46 +0200
Message-ID: <df2d020d-29e2-6b6b-bde7-576fc1b9c883@web.de>
Date:   Sat, 16 Jul 2022 18:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: [PATCH 02/10] mergesort: tighten merge loop
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5a6LGp29fjpl1k11E3DupnAgbDpZgVKzxOQtQ7C98XKgCKKYR+I
 mlesA+Ajwjr7DfX/n7Rm8QdJWYcjb5/sFw6jNpWSCBzTqupFvxJhch8FkliDhhqdxgx9ofB
 inJ6T2oFKEtpLsiBiF55fzhn0gyvmdU5dFcwAEWKfOgvm7v5D3PmZwcC7pJGrPd0fwqgMN7
 wLk3X6hU06bsGyA3kOqFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jfpfFu3MYI4=:j9IqB1dsj2FgFl1eAFjyP2
 PYXB4Zz3FauWTlX9FpxzX2b0JjAlQtfk0UCeqmp13YeBea0yGneQdP0P4PwBkX+A5H2RoI+hO
 wHND3N0WplGPuW8J2JtFYYWrJal+2l+1sCxN8ALe4aJviV+05rQb2LfDtydWsq8niOR2vPaYb
 hLJ/tsghsgJqq7IzMoA6j2QY/mW5goxl3z/vNOkHxBgzf715gMDM+JNHALv4G5U6ayW68KAGe
 rEVwIRp9aJng1FuYGsS3/FjkSSXpb0Oyxd3WW0vU3BS6bX1qvwA7EjNd/qJ2tgW9OTFlea6Jc
 J2lQxnp9uW7gltVxbacv+nJYH9rfjdSpB7rd7rSMnjqrPd9PQpzsIA7L35WN/DTeiKxvkMvyD
 /Ds6jI3i9f24Rlga1UgyJJqzyQdpCgh+yh//K0xvLT+9Yior2aOm8CgwVoD2Bt+jZ0f8m+VWf
 +bu1BGX/Xj6mBxf4jjAlO8vmrK2QjgdCo8iIQX/zswXNfuB7n3Vyr0YNOGbcW3Qa7hGY/FaCp
 X/Oxz/4MIE61e/Xd+mcNBYO7E6h+PkE6ffDlGspq22/BJmw4oNCg/fMwZQUITI7SpBotv+2I8
 qMJmtOfEzqVzaPIYcYJPanrBkJ5eYZC6rad86/k7+gXs96Rdh8ro2bFn/Gkj+fzClltflks3p
 1XMVxWxmAoVuAH+iXjKsR/k0EM/ZW6Si9rWJlPneABRoTPfxqkaeAy87qgYIvn0s77iRzZAOs
 gmgHDClmVu6a5m5+Swu81q4PwiGUCS0ZQSjdS3Yi4JIRXFdLE44UPSjqaoySDUCVCJSjWmjvB
 Tfq5i5m3lb2YLrgkmQ5feKEPc4L/zkxhExDCyM9Cmf6EEPNF199RezvkY2bxgucOpdKLjoY/X
 avTHSLhFRJK/gItAqKIv/mz1O+xtyMBsuCm4vZ7BgQ3EDliNxlF251qBoW89EgLibvBd0z8t+
 ac4QJjAykzahiToI/oybGUTljR4MMVq7mIcJeq5hECK9bZHodh7wmVoapRFnvap+e065M7L05
 RN7G0DDJPCcA16+NfP3PX3gkyiP5F2ktrWCHEu8cbGpk/0hKPR+LxOqEQ+ULIz46q8enhrUxk
 D3kaMF6qUrE0McmL1v3yiUmOlGk3TsHLBIh8W8F0ARN69/wmU52yrfwUA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

llist_merge() has special inner loops for taking elements from either of
the two lists to merge.  That helps consistently preferring one over the
other, for stability.  Merge the loops, swap the lists when the other
one has the next element for the result and keep track on which one to
prefer on equality.  This results in shorter code and object text:

Before:
__TEXT	__DATA	__OBJC	others	dec	hex
412	0	0	3441	3853	f0d	mergesort.o

With this patch:
__TEXT	__DATA	__OBJC	others	dec	hex
352	0	0	3516	3868	f1c	mergesort.o

Performance doesn't get worse:

Before:
0071.12: llist_mergesort() unsorted    0.24(0.22+0.01)
0071.14: llist_mergesort() sorted      0.12(0.10+0.01)
0071.16: llist_mergesort() reversed    0.12(0.10+0.01)

Benchmark 1: t/helper/test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     109.2 ms =C2=B1   0.2 ms    [User: 107.5 =
ms, System: 1.1 ms]
  Range (min =E2=80=A6 max):   108.9 ms =E2=80=A6 109.6 ms    27 runs

With this patch:
0071.12: llist_mergesort() unsorted    0.24(0.22+0.01)
0071.14: llist_mergesort() sorted      0.12(0.10+0.01)
0071.16: llist_mergesort() reversed    0.12(0.10+0.01)

Benchmark 1: t/helper/test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     108.4 ms =C2=B1   0.2 ms    [User: 106.7 =
ms, System: 1.2 ms]
  Range (min =E2=80=A6 max):   108.0 ms =E2=80=A6 108.8 ms    27 runs

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 mergesort.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/mergesort.c b/mergesort.c
index 92150c4101..6bda3a1c0e 100644
=2D-- a/mergesort.c
+++ b/mergesort.c
@@ -8,10 +8,11 @@ static void *llist_merge(void *list, void *other,
 			 int (*compare_fn)(const void *, const void *))
 {
 	void *result =3D list, *tail;
+	int prefer_list =3D compare_fn(list, other) <=3D 0;

-	if (compare_fn(list, other) > 0) {
+	if (!prefer_list) {
 		result =3D other;
-		goto other;
+		SWAP(list, other);
 	}
 	for (;;) {
 		do {
@@ -21,18 +22,10 @@ static void *llist_merge(void *list, void *other,
 				set_next_fn(tail, other);
 				return result;
 			}
-		} while (compare_fn(list, other) <=3D 0);
+		} while (compare_fn(list, other) < prefer_list);
 		set_next_fn(tail, other);
-	other:
-		do {
-			tail =3D other;
-			other =3D get_next_fn(other);
-			if (!other) {
-				set_next_fn(tail, list);
-				return result;
-			}
-		} while (compare_fn(list, other) > 0);
-		set_next_fn(tail, list);
+		prefer_list ^=3D 1;
+		SWAP(list, other);
 	}
 }

=2D-
2.37.1
