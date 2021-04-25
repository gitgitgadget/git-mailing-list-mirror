Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3798C433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 13:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9905E611B0
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 13:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhDYNQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 09:16:49 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:9194 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhDYNQs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 09:16:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 6B7BCDC8;
        Sun, 25 Apr 2021 15:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1619356565; x=1621170966; bh=Ka1bfooF8wkU9Sp+vgP
        mNPE6XvE1fCzNWM3PcHfv4pc=; b=plXRH9BxVpUYSESi1bnTG7BupEntLwv9qSj
        wCHXXpWAjw1w6dnHkegb0TGpHFHeBVlQmhrRllBUmcHN2BdMiCyyZSbRxEODwr0X
        RkSA0MnlGxDdUIcmgO29+FR95DaVmjkqMfcIMcqL/ZlRa8S97DLBGu3Gz7g2FcnV
        Hcco6bwam5WU0DGO1yP214cKgL4qp7aYzhzxPj3okz5NmxT6d1j4sNWY0z2YV1NJ
        zu9wAEW8voYUeCGqTa5pBWMd47WZhaHFpNZLF00Mze4gvIArC4fjsQvGspKz2vY/
        92oLaYbFNUo87a/q/N7+zIeiTay8BFfHv/fYl9Ic2hpjEUzb+Oi/MIqKuiLKhtW9
        DZPeeXSOvmKr0lGR5J9+8rlzHBUcEag+1W4Y1qL8rvfDkC+DH/nHDKzBRSiZ5o71
        FQcL4y2af7gWEcrc38HbDy2dbjIA77wiLSPyB1zkYUeiWCb92zl5fMwbo5pNU72d
        X2Y+Wuf44tKa4So2HDQgImOvq4a6aZVO89z9G9LTUaYF0fXZDdnxAP9RAnp2FsgO
        cSGW/zmhBIE0FSqV55Uqn6OVreP0U7hOxG2ovm4037Dfk9BOGu0OrWfPsgkAHWov
        tSjAco70Lb+RVvryNFUqJgFmWXRMIni4GBLdRx7D0OJZNJ+ox5wiBJ7TUK6KQfMq
        Lkb0fSxo=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id INK6JYw5Nu_k; Sun, 25 Apr 2021 15:16:05 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 9D6BE7D9;
        Sun, 25 Apr 2021 15:16:05 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 4D88D2C7;
        Sun, 25 Apr 2021 15:16:03 +0200 (CEST)
Subject: Re: [PATCH 09/12] mailinfo: also free strbuf lists when clearing
 mailinfo
To:     Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
 <130ef89218a47adc7ee558e75672e0e4eb5f30ca.1617994052.git.gitgitgadget@gmail.com>
 <xmqq4kgdhws6.fsf@gitster.g>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <437e7381-7f93-b314-d9c6-d0f0e26ea683@ahunt.org>
Date:   Sun, 25 Apr 2021 15:15:59 +0200
MIME-Version: 1.0
In-Reply-To: <xmqq4kgdhws6.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/04/2021 13:43, Junio C Hamano wrote:
> "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>   void clear_mailinfo(struct mailinfo *mi)
>>   {
>> -	int i;
>> -
>>   	strbuf_release(&mi->name);
>>   	strbuf_release(&mi->email);
>>   	strbuf_release(&mi->charset);
>>   	strbuf_release(&mi->inbody_header_accum);
>>   	free(mi->message_id);
>>   
>> -	if (mi->p_hdr_data)
>> -		for (i = 0; mi->p_hdr_data[i]; i++)
>> -			strbuf_release(mi->p_hdr_data[i]);
>> -	free(mi->p_hdr_data);
>> -	if (mi->s_hdr_data)
>> -		for (i = 0; mi->s_hdr_data[i]; i++)
>> -			strbuf_release(mi->s_hdr_data[i]);
>> -	free(mi->s_hdr_data);
> 
> So, the original allows mi->p_hdr_data to be NULL and does not do
> this freeing (the same for the .s_hdr_data member).
> 
>> +	strbuf_list_free(mi->p_hdr_data);
>> +	strbuf_list_free(mi->s_hdr_data);
> 
> Is it safe to feed NULL to the helper?
> 
>          void strbuf_list_free(struct strbuf **sbs)
>          {
>                  struct strbuf **s = sbs;
> 
>                  while (*s) {
>                          strbuf_release(*s);
>                          free(*s++);
>                  }
>                  free(sbs);
>          }
> 
> 

Indeed: AFAIUI dereferencing NULL is undefined 	behaviour. I think the 
best solution is to add a NULL check in strbuf_list_free() - which is 
the pattern I've seen in several other *_free() helpers (there are also 
quite a few examples of *_free() helpers that are not NULL safe, but 
IMHO having a NULL check will lead to fewer unpleasant surprises).

Incidentally I did run the entire test-suite against UBSAN, and it 
didn't find any issues here. This seems like something that UBSAN should 
be able to easily catch, so we probably don't have any tests exercising 
clear_mailinfo() with NULL p_hdr_info/s_hdr_info?
