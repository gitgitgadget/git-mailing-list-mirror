Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDD2C433B4
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 13:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD0261360
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 13:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhDYNdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 09:33:43 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:54592 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhDYNdm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 09:33:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 02EE6E2D;
        Sun, 25 Apr 2021 15:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1619357579; x=1621171980; bh=oaFepvfdcjjIyLyVsb5
        nZ8j2MVCzNTFymgKPyUDDf4c=; b=fc/HmSHGzQxDgSO61EO8i2OMadY2D86mWiY
        hnu8zt1PwHyE11Clz7WlOH1OvJzWkEsYjV1xAQRq7B+WPRCk4Kwoffe36jOc5KuJ
        BPEt0Ku0dQEBaFfzefwdlxdrEDluRSifPhWtjrGN7hjNqwhDtDA2+eZcE1ClfEEk
        xcENmFPzuBsbRFXpgezVHyQlZbxMpU0XB84+nlhZ0Byovqq7GJ/AO9D98sQlfbo5
        7M1e9RDNva5Zbq4AwDvJCr2Wqa9WnUU2/YINX52bYrpzGja6ya/c1sGnNA8SHQrX
        yGc73t/58N/doPLl4lIE2wuMXnZKUgFrF2PUqfWYVdATKTzmsF5ios5MNfTrY3PC
        YMhUAXxn1yo9vIxItzQCE4VjeejdwawpDf8MhUNjmxB2gTIUauZQbFugVw8ldJsZ
        +NRY/mHKbNMSsV5ASgiizHAwFUryKGAPF2O0Zx1wsKozxaHwTrm2+AmOf26x9BCG
        h1VWYPv0et1MAkcOr+zZVLwlIvVwHBoDQPQeSuW4qFPUlUP0OQO5SPG1MwscMmG0
        Ag5IW/FUHs/8S/qsmofMS9XC+d2UUCaw/d6edVktarJ0ec+DF7hAspblFILBR+eA
        RlUnjotER7LycpUvGfCCuw7u7996hg2JeXntZLnLP3jQgLx8SbanEv/0RskSxvAq
        WVe/TVVs=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OxxBuMU1bOsb; Sun, 25 Apr 2021 15:32:59 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id BCF4ACEB;
        Sun, 25 Apr 2021 15:32:57 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 7E5BF5D3;
        Sun, 25 Apr 2021 15:32:56 +0200 (CEST)
Subject: Re: [PATCH 01/12] revision: free remainder of old commit list in
 limit_list
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Andrzej Hunt <ajrhunt@google.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
 <12f0dcaef109e7577eabcc6f94f8ee72695b79aa.1617994052.git.gitgitgadget@gmail.com>
 <797e5ce8-14e2-0689-cf19-4426c1c8bd5d@web.de>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <c883a4b0-668c-3d43-b1d6-183ccd61133f@ahunt.org>
Date:   Sun, 25 Apr 2021 15:32:53 +0200
MIME-Version: 1.0
In-Reply-To: <797e5ce8-14e2-0689-cf19-4426c1c8bd5d@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/04/2021 09:29, René Scharfe wrote:
> Am 09.04.21 um 20:47 schrieb Andrzej Hunt via GitGitGadget:
>> From: Andrzej Hunt <ajrhunt@google.com>
>>
>> limit_list() iterates over the original revs->commits list, and consumes
>> many of its entries via pop_commit. However we might stop iterating over
>> the list early (e.g. if we realise that the rest of the list is
>> uninteresting). If we do stop iterating early, list will be pointing to
>> the unconsumed portion of revs->commits - and we need to free this list
>> to avoid a leak. (revs->commits itself will be an invalid pointer: it
>> will have been free'd during the first pop_commit.)
>>
>> This leak was found while running t0090. It's not likely to be very
>> impactful, but it can happen quite early during some checkout
>> invocations, and hence seems to be worth fixing:
>>
>> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>>      #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
>>      #1 0x9ac084 in do_xmalloc wrapper.c:41:8
>>      #2 0x9ac05a in xmalloc wrapper.c:62:9
>>      #3 0x7175d6 in commit_list_insert commit.c:540:33
>>      #4 0x71800f in commit_list_insert_by_date commit.c:604:9
>>      #5 0x8f8d2e in process_parents revision.c:1128:5
>>      #6 0x8f2f2c in limit_list revision.c:1418:7
>>      #7 0x8f210e in prepare_revision_walk revision.c:3577:7
>>      #8 0x514170 in orphaned_commit_warning builtin/checkout.c:1185:6
>>      #9 0x512f05 in switch_branches builtin/checkout.c:1250:3
>>      #10 0x50f8de in checkout_branch builtin/checkout.c:1646:9
>>      #11 0x50ba12 in checkout_main builtin/checkout.c:2003:9
>>      #12 0x5086c0 in cmd_checkout builtin/checkout.c:2055:8
>>      #13 0x4cd91d in run_builtin git.c:467:11
>>      #14 0x4cb5f3 in handle_builtin git.c:719:3
>>      #15 0x4ccf47 in run_argv git.c:808:4
>>      #16 0x4caf49 in cmd_main git.c:939:19
>>      #17 0x69dc0e in main common-main.c:52:11
>>      #18 0x7faaabd0e349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>>
>> Indirect leak of 48 byte(s) in 3 object(s) allocated from:
>>      #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
>>      #1 0x9ac084 in do_xmalloc wrapper.c:41:8
>>      #2 0x9ac05a in xmalloc wrapper.c:62:9
>>      #3 0x717de6 in commit_list_append commit.c:1609:35
>>      #4 0x8f1f9b in prepare_revision_walk revision.c:3554:12
>>      #5 0x514170 in orphaned_commit_warning builtin/checkout.c:1185:6
>>      #6 0x512f05 in switch_branches builtin/checkout.c:1250:3
>>      #7 0x50f8de in checkout_branch builtin/checkout.c:1646:9
>>      #8 0x50ba12 in checkout_main builtin/checkout.c:2003:9
>>      #9 0x5086c0 in cmd_checkout builtin/checkout.c:2055:8
>>      #10 0x4cd91d in run_builtin git.c:467:11
>>      #11 0x4cb5f3 in handle_builtin git.c:719:3
>>      #12 0x4ccf47 in run_argv git.c:808:4
>>      #13 0x4caf49 in cmd_main git.c:939:19
>>      #14 0x69dc0e in main common-main.c:52:11
>>      #15 0x7faaabd0e349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>>
>> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
>> ---
>>   revision.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/revision.c b/revision.c
>> index 553c0faa9b38..7b509aab0c87 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1460,6 +1460,7 @@ static int limit_list(struct rev_info *revs)
>>   			update_treesame(revs, c);
>>   		}
>>
>> +	free_commit_list(list);
> 
> This patch would benefit from more context, but this function is quite
> long.  So let me sketch it:
> 
> 	struct commit_list *list = revs->commits;
> 
> 	while (list) {
> 		struct commit *commit = pop_commit(&list);
> 		struct object *obj = &commit->object;
> 
> 		if (obj->flags & UNINTERESTING) {
> 			break;
> 		}
> 	}
> 
>          if (limiting_can_increase_treesame(revs))
>                  for (list = newlist; list; list = list->next) {
> 		}
> 
> 	free_commit_list(list);
> 
> So the while loop can leave list dangling and you want to free its
> remaining entries.  The for loop sometimes overwrites the list pointer,
> though, and you will end up passing NULL to free_commit_list in that
> case.  So either the call should be moved between the loops or a fresh
> variable should be used in the second loop instead of reusing list to
> make sure the entries are released in all cases.

Good catch, I did not look closely enough at this one - V1 definitely is 
buggy*. I've decided I'll add a new variable for the list in V2, but I 
also took the opportunity to rename the original list since I think that 
makes it more obvious where that list came from in the first place.

* However I also didn't run into any failures when running the entire 
test-suite with this change, so I'm guessing this codepath isn't being 
exercised by our tests. I'm hoping to try and investigate this in more 
detail when I find a spare moment.
