Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B3D1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 19:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJCBul (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 21:50:41 -0400
Received: from mout.web.de ([212.227.15.3]:44975 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbeJCBul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 21:50:41 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lw0vl-1ffVBl0BFl-017lDP; Tue, 02
 Oct 2018 21:05:36 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lw0vl-1ffVBl0BFl-017lDP; Tue, 02
 Oct 2018 21:05:36 +0200
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <20180811170248.GC27393@sigill.intra.peff.net>
 <20180811172350.GA2689@sigill.intra.peff.net>
 <f69e08d7-b29d-a9b7-b6d4-5294c4379133@web.de>
 <6065f3e5-f831-802f-9adc-099de99405fc@web.de>
 <20180814015842.GA27055@sigill.intra.peff.net>
 <030bac66-eeb4-7bc9-8f27-1e6b4124fd76@web.de>
 <20180827230314.GB10402@sigill.intra.peff.net>
 <9e2440cc-39a6-f51b-9aee-8536020ed033@web.de>
 <20181001202605.GB10234@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d2421f36-563c-92ac-3fc9-29306d94b6fd@web.de>
Date:   Tue, 2 Oct 2018 21:05:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181001202605.GB10234@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DefwByUuBxoBggN1ZLi8ByYnZgtfd3M5y3MDl7NEeZtKAUzzrS1
 Wi3JVsATu+MJbzz5HZGLfD2WkrOJ59ksZfMWy/qcxOohPAGOg0zRfnqC3o7tGX8XVKsp9Q3
 a/49cxDfMGqx1xgJvMO+SMM5XtL5/8Oudq277R1PhLBdy/jhQTnv8nnOr+O1iR76KEQSmpp
 zhIUECFdq7bPRbhBeEGrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1tVmIP8bH0Y=:rMk8l0ZtFxlt67/j/no+gd
 ID4GA77mm8/krytLXpU0tOXoo0HGUsD91Z/JkAkWnseq6/2U8Kt5Ci8MoMftEkX6pOygv64kl
 6sAfQSqv+/LBvG2kEmGa4GspoyfX50jPQyuvF7e4E0ps/dkPrYaQ3Qs00G3qRki9y3pVKf/iQ
 lEBfGRMGCYQy73R+Xd4DPEnPrjG0Cbi0hRNiS6HntZxTsi7Dk7/jS14bFOq8q97jA3vxVztfG
 8khYApen66rh4JhJCHdjCTAgbdUNjt4Q7miW/A3F3HxxCdwt6Zu6jkH7Kvewvm8PuyRVOFmDm
 +XS3fDCF4u+kRX8cKWgjt+WG4QlQrKOW/xry05GEmq9CZ1erj97dkcD6ta1zucHOyKlv4gOP9
 G21FAnaGLBVCNY411xxsSzdmpWhc5g19QCC7riqvmVjYhNadpmMLBPaq0ajrTt/9mXTOBpyMy
 zvVFVyV2G6bbx4unPtUV5UoZm2nIoPsj56/qwbPwv97oOC0OP+GfZ3sv2Axa3mD+b9eUUcLEf
 NCP4q3ntR1w/lcpo/ScEVaVm1p0MuJFzN7O8gov6kBSYKxY8KMmDi+Du5avMKprcT2TEpUkg1
 pshEA9yjW8c/BCfGfekICpJ8TgOUZKGBOFw13CZk4MtFNlDfOByu64EQTk4C78QuC50X/M6fd
 sQQZ+0Sz8jP8DU7vPejTymIYmZtLaTfchpZUe1Q+/ZWXcgpUdwzOSaY+VQJi6s1wtxA8PZ45i
 ebl0DCAfv4SZIqk+Y0mxG1n/yCTkXepk8Q+18Jb94wTScu44H2sONLXLQYEyop1IgdSlE4vgQ
 0iECV4uo+NdtdhrRLViiQB4hBp3fPmz8YyOUmwcyMi9gsgDVyU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.10.2018 um 22:26 schrieb Jeff King:
> On Mon, Oct 01, 2018 at 09:15:53PM +0200, René Scharfe wrote:
> The reason hashmap.c was added was to avoid open addressing. ;)
Because efficient removal of elements is easier to implement with
chaining, according to 6a364ced49 (add a hashtable implementation that
supports O(1) removal).  khash.h deletes using its flags bitmap.  We
didn't compare their performance when entries are removed so far.

> So yeah, I think it could perhaps be improved, but in my mind talking
> about "hashmap.c" is fundamentally talking about chained buckets.

Admittedly I wouldn't touch hashmap.c, as I find its interface too
complex to wrap my head around.  But perhaps I just didn't try hard
enough, yet.

>> But I like how khash.h is both already in the tree and also really easy
>> to deploy, as it's just a single header file.  It's a tasty low-hanging
>> fruit.
> 
> Yeah. And if it really does perform better, I think we should stick with
> it in the code base. I wonder if we could stand to clean up the
> interfaces a little.  E.g., I had a hard time declaring a hash in one
> place, and then defining it somewhere else.

You can't use KHASH_DECLARE and KHASH_INIT together, as both declare
the same structs.  So I guess the idea is to have a header file with
KHASH_DECLARE and a .c file with KHASH_INIT, the latter *not* including
the former, but both including khash.h.  I didn't actually try that,
though.

> And I think as you found
> that it insists on heap-allocating the hash-table struct itself, which
> does not match our usual style.

Perhaps we can fix that with little effort (see below).

>> This is straight-forward, except for oidset_clear(), which needs to
>> allocate a kh_oid_t on the heap in order to be able to feed it to
>> kh_destroy_oid() for release it.  Alternatively we could open-code the
>> relevant parts of the latter, but that would be a layering violation.
> 
> This is kind of a layering violation, too. You're assuming that struct
> assignment is sufficient to make one kh struct freeable from another
> pointer. That's probably reasonable, since you're just destroying them
> both (e.g., some of our FLEX structs point into their own struct memory,
> making a hidden dependency; but they obviously would not need to free
> such a field).

Fair enough.  How about this on top?  (The khash.h part would go in
first in a separate patch in a proper series.)

NB: I stuck to the 4-spaces-tabs formatting in khash.h here.

---
 khash.h  | 9 +++++++--
 oidset.c | 4 +---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/khash.h b/khash.h
index 07b4cc2e67..d10caa0c35 100644
--- a/khash.h
+++ b/khash.h
@@ -82,11 +82,16 @@ static const double __ac_HASH_UPPER = 0.77;
 	SCOPE kh_##name##_t *kh_init_##name(void) {							\
 		return (kh_##name##_t*)xcalloc(1, sizeof(kh_##name##_t));		\
 	}																	\
+	SCOPE void kh_release_##name(kh_##name##_t *h)						\
+	{																	\
+		free(h->flags);													\
+		free((void *)h->keys);											\
+		free((void *)h->vals);											\
+	}																	\
 	SCOPE void kh_destroy_##name(kh_##name##_t *h)						\
 	{																	\
 		if (h) {														\
-			free((void *)h->keys); free(h->flags);					\
-			free((void *)h->vals);										\
+			kh_release_##name(h);										\
 			free(h);													\
 		}																\
 	}																	\
diff --git a/oidset.c b/oidset.c
index d15b2b7a89..9836d427ef 100644
--- a/oidset.c
+++ b/oidset.c
@@ -25,8 +25,6 @@ int oidset_remove(struct oidset *set, const struct object_id *oid)
 
 void oidset_clear(struct oidset *set)
 {
-	kh_oid_t *to_free = kh_init_oid();
-	*to_free = set->set;
-	kh_destroy_oid(to_free);
+	kh_release_oid(&set->set);
 	oidset_init(set, 0);
 }
-- 
2.19.0
