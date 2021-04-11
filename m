Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0CAC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55EE610E9
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhDKJMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 05:12:45 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:45152 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhDKJMp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 05:12:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id D26DC83A;
        Sun, 11 Apr 2021 11:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1618132345; x=1619946746; bh=FSBL+WRpiLMGt1mp/aj
        5jCcVnQAiT6x4Tzx/XCS5gb4=; b=iBeuzOlF8JHm8De7oek3ocAaA0MHJhecFBf
        dpv+ITBTlgB5GMRrrdLkyc7d6x6SvgkfRJuUqGJRO07DCWh++y25f7Hr2TMIrgBk
        XElNOXnEhm9mbrjWsXvNMlKZc2Lz/DSg1DJMTnOn74Ii1sP3aXaj8uECEQNdUbEH
        vHubieSg09+V0Hry4BxG0XbZl2kmlPiaI9S5lvCo4IsPtg7xA/LtN15xQX0ylxa/
        uWVYdbuFySau7NVq7uH9jWxxQrmDkiiBJrJkc8q5vp3WY6lqfTIW7sqjbSF9EaWd
        snL+ga27dsbBm4xFUL1ttd/3+EO82arna/k7s+/wyAQAeza8Iwl2p9FSEC+cD+ZE
        ZzipXysDhXidVTGXWqHL7CRtQUT3gIkixo1GeGvLvfIzEqMQ7Oq2cd2rpttdRMHV
        YLSz+3v9+0Kl/2h3YMIFLFeC5qC0ssKxgBhsOXp4K6DDa7DZa4zIfDIYh27gTkmT
        LNaoTIUNqctWyJyNiX3ZWEsPkX6GCnrO0XrEuvafWa2Jo4+nwkchEUj3DWJcMV6T
        v4/hUInwLldrIhXTFs7DjuQwHqsW/wU7vwKBtH2U5hjnLS8P4/P+tKkrSdy5cj/S
        LGOHcR4NLKffcp/ddrdu37NDW2Fp9tWzUo6WbWGmfVUhoyJKxwt3e/oWW5lLvUMr
        JlmAAt6I=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BYOwoULtc9HW; Sun, 11 Apr 2021 11:12:25 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 72F1682B;
        Sun, 11 Apr 2021 11:12:25 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 24D34201E;
        Sun, 11 Apr 2021 11:12:23 +0200 (CEST)
Subject: Re: [PATCH] merge-ort: only do pointer arithmetic for non-empty lists
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Andrzej Hunt <ajrhunt@google.com>
References: <pull.930.git.1618043449249.gitgitgadget@gmail.com>
 <1866b90b-fe07-18df-0d60-e2350d935375@web.de>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <a5e9bbd6-23bb-2778-2f2a-dc601c842336@ahunt.org>
Date:   Sun, 11 Apr 2021 11:12:21 +0200
MIME-Version: 1.0
In-Reply-To: <1866b90b-fe07-18df-0d60-e2350d935375@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/04/2021 13:48, René Scharfe wrote:
> Am 10.04.21 um 10:30 schrieb Andrzej Hunt via GitGitGadget:
>> [...]
>> diff --git a/merge-ort.c b/merge-ort.c
>> index 5e118a85ee04..4da4b4688336 100644
>> --- a/merge-ort.c
>> +++ b/merge-ort.c
>> @@ -2504,8 +2504,10 @@ static void write_tree(struct object_id *result_oid,
>>   	 * We won't use relevant_entries again and will let it just pop off the
>>   	 * stack, so there won't be allocation worries or anything.
>>   	 */
>> -	relevant_entries.items = versions->items + offset;
>> -	relevant_entries.nr = versions->nr - offset;
>> +	if (versions->nr) {
>> +		relevant_entries.items = versions->items + offset;
>> +		relevant_entries.nr = versions->nr - offset;
>> +	}
>>   	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
> 
> Reading the diff I was wondering if QSORT now gets handed uninitialized
> values if version-nr is 0.  The answer is no -- relevant_entries is
> initialized at declaration.  Otherwise the compiler would have probably
> warned, but sometimes it gets confused.
> 
> I wonder why relevant_entries is introduced at all, though.  It's not
> referenced later.  So how about this instead?
> 
> 	if (versions->nr)
> 		QSORT(versions->items + offset, nr, tree_entry_order);
> 
> The intent to sort the last versions->nr-offset entries of versions,
> but only if it's not empty, is easier to see like this, I think.
> 

That is much more elegant, I will follow this approach. Thank you for 
the suggestion!

An alternative might be to keep relevant_entries, and replace all later 
usages of versions->items[offset+i] with relevant_entries.items[i], but 
that's more invasive and I don't see any good reason for doing so given 
that the existing pattern works fine.
