Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A12C433F7
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 18:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BACF20729
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 18:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7XNhWeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbgG0SOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:14:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731336AbgG0SOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 14:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595873639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n/e46ZMVfAO0gWsUVxolBrpHja1w2fZAR2zrQ+GF2S8=;
        b=S7XNhWeWSwVsAq0s0LhVGRww6qNYee6KWvBUS0izg3tvdo2hhA9ZiX9lP590l4fmxweEqh
        6ZDyF7NNLQkBwPf3H1/4tGHawbMU7LcH4Sv9HIG30AatclmG9R1gS4ZXlJmsrYwZvOiE/B
        1SZS2H1pg6qkxPNM1L/VLE+JIEuRYaw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-eZHaTPmQNlmOVmXVgVc7Dg-1; Mon, 27 Jul 2020 14:13:57 -0400
X-MC-Unique: eZHaTPmQNlmOVmXVgVc7Dg-1
Received: by mail-wm1-f69.google.com with SMTP id l5so8116888wml.7
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 11:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n/e46ZMVfAO0gWsUVxolBrpHja1w2fZAR2zrQ+GF2S8=;
        b=QG0pVxGdy6AxR8O7MvJ8AEmcC/i4SNzuACOxBEiw5sH4JVgq5X40QxbjQtxdagglk6
         UxBj8k1gs8XLn/DKqw1ccq6Orh1pZ/G68uKXHkzjUcndBM2QKJZHTyGeQxCoGpuOMN0c
         ZpQU8KeyDbBaOP+E+end0LQCPq9QUOzehPqA2jBYEJiyufg6MifgTp05YUs+oA8HxoIX
         aHOYIA0d5MQoVqXzmnpmND+5umN4xodn+/F/Li8ARbBBP++Zl3nP2xIReKISqinEAmbG
         alJVsr0Pslx2Vm71WV7p83zQV7G6gk96rUYAqBfxCkH2bbBmTRVWrFH6wbRslBeimfxg
         lSZA==
X-Gm-Message-State: AOAM530QNzsgG/VuqJ7B6RLPC+ll5P+prsio9mSZm1BvE2ij/qaPFI1a
        XUI940IGH70NNNkQQ0cT8XEMtL/FiGocOrJrD305athpS5WAM0PK49xAvMiCrylMC8W3fQ2zppf
        FKDWFX+KNNqV4
X-Received: by 2002:a5d:5486:: with SMTP id h6mr20439427wrv.136.1595873636321;
        Mon, 27 Jul 2020 11:13:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIhd912HOBbTzU2PJF3T7ULPo8oV2HBDgWbB8Yq27q43dNo6jAlA92rg/BTrvGDR7jDWBqtA==
X-Received: by 2002:a5d:5486:: with SMTP id h6mr20439416wrv.136.1595873636058;
        Mon, 27 Jul 2020 11:13:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:80b0:f446:bb61:1dbb? ([2001:b07:6468:f312:80b0:f446:bb61:1dbb])
        by smtp.gmail.com with ESMTPSA id v5sm463324wmh.12.2020.07.27.11.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 11:13:55 -0700 (PDT)
Subject: Re: Verbose commit message diff not showing changes from pre-commit
 hook
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Maxime Louet <maxime@saumon.io>
Cc:     git@vger.kernel.org
References: <CADv3qkGq3jA8iXsjhrqfsUX=gW+KOuLyeVgDzmku1tUpsMdvtw@mail.gmail.com>
 <xmqqr1sziqrm.fsf@gitster.c.googlers.com>
 <xmqqk0yripca.fsf@gitster.c.googlers.com>
 <a8c19b13-3f8c-6602-24dd-ef58af70d702@web.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b5f1769d-5c60-bca4-3f46-e55962fa1805@redhat.com>
Date:   Mon, 27 Jul 2020 20:13:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a8c19b13-3f8c-6602-24dd-ef58af70d702@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/20 19:41, René Scharfe wrote:
>>
>> However, ec84bd00 moved the place where we re-read the on-disk index
>> in the sequence, and updated a message that used to read:
>>
>> -	/*
>> -	 * Re-read the index as pre-commit hook could have updated it,
>> -	 * and write it out as a tree.
>> -	 */
>>
>> to:
>>
>> +	/*
>> +	 * Re-read the index as pre-commit hook could have updated it,
>> +	 * and write it out as a tree.  We must do this before we invoke
>> +	 * the editor and after we invoke run_status above.
>> +	 */
> When I read "refactor" in the title, I assume that the patch in
> question doesn't change user-visible behavior.

That was probably the intention.

>> Unfortunately there is no mention of the reason why we "must" here.
> @Paolo: Do you perhaps remember the reason?

I think the idea was to use run_status for the "commitable" assignment.

Paolo

