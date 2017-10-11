Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B25B1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 13:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757714AbdJKN6n (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 09:58:43 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:48188 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757560AbdJKN6l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 09:58:41 -0400
Received: by mail-qt0-f194.google.com with SMTP id f8so5392353qta.5
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8SVzFAfXY5b4PsSw0ILezEOe+1aT+LiPd7fLTuikDK8=;
        b=uyan+IV49mN0ZIaqoDQR8JnQHZGWXpaUHJjxvhHsb66jyW1hA9VXiIWoPbK0wxYljA
         5Lmy513iss1LY13p5goRClFJf0gYDdZ5dcwX2fx0p8f6mXj6QhmSLHEb6Z7Mnxt9ntWQ
         YozeYkYM3dU7V1e0a6jGPAA6VHB3DRg0HniPAP3EHMftQ47Jykkm9AQp80ekjz80VDmu
         FMuic19MOe/hfchxwrLuIFCw3mnGZu7BvYtPq4fFrVEwyveLOhyifyZZa3Bcyh8RtDmT
         NI1hXvX7DYaGsAjHPBxmXtJSGLjkCXcC2LyhLsIFkaAVZkZ9sOiN6EdmrTCXc2WPPNJd
         z7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8SVzFAfXY5b4PsSw0ILezEOe+1aT+LiPd7fLTuikDK8=;
        b=s0bP2sQVj57SO4fhHLUiFkqa+niPWFkZvT52KiNLD9uxwB4CXbs6zQA2VU9TLa15KH
         CMv815ulM9b0ZCc4XGO6FRsKNDJhA6cXDJvYiTn9Mr7GEEZiTlKDJjOGK1o1LHNnEZ9/
         dAm3ckZ3dycGfYA1/2KTUI/yiqgCdCYFg5XXufdvCwQ0F3LazmBSG8P9oUTXBJvL8iD8
         +y1vYpgppe8FDcyoLh9sNejhiM8Gv+U6HkMwSkypy1SqMIfTDSnloxxv4az33ZBQ/e7k
         vN9NLWVmGrYFszxpBoV9Yffv488+UxWAqvVHZ04HZuFU8nLoNpI9nDNdx078DoUxTuXl
         nfag==
X-Gm-Message-State: AMCzsaVx4fUGFdVP3JFZ2H6A5OSk7K0PuZH6TDHFQ4GsCvkztZKnIoTx
        IkM7yTfD6vjKzQZrQekJeYA=
X-Google-Smtp-Source: AOwi7QDQpuFQE8cmaVgC5kdIgzZI9ohsK2PlQb+tH+mkBx3XHtApb79bluoj0u9b2aY3rKGd2pttJw==
X-Received: by 10.200.35.21 with SMTP id a21mr25327463qta.215.1507730320181;
        Wed, 11 Oct 2017 06:58:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id k11sm7990510qtg.62.2017.10.11.06.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Oct 2017 06:58:39 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] sha1_name: minimize OID comparisons during
 disambiguation
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        ramsay@ramsayjones.plus.com, sbeller@google.com
References: <20171008184942.69444-1-dstolee@microsoft.com>
 <20171008184942.69444-5-dstolee@microsoft.com>
 <20171009134933.vmba67adelqbkx4y@sigill.intra.peff.net>
 <338aab6a-1181-d740-1bf2-2ac86749a6b2@gmail.com>
 <20171010123634.3hdqxpo6mbl6jhbx@sigill.intra.peff.net>
 <xmqqbmlfp3eh.fsf@gitster.mtv.corp.google.com>
 <f9add2c3-5499-085e-e433-799427dda6d8@gmail.com>
 <20171010133040.2j5wpgcvucquizpn@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
Date:   Wed, 11 Oct 2017 09:58:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171010133040.2j5wpgcvucquizpn@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2017 9:30 AM, Jeff King wrote:
> On Tue, Oct 10, 2017 at 09:11:15AM -0400, Derrick Stolee wrote:
>
>> On 10/10/2017 8:56 AM, Junio C Hamano wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> OK, I think that makes more sense. But note the p->num_objects thing I
>>>> mentioned. If I do:
>>>>
>>>>     git pack-objects .git/objects/pack/pack </dev/null
>>>>
>>>> then I have a pack with zero objects, which I think we'd similarly want
>>>> to return early from. I.e., I think we need:
>>>>
>>>>     if (p->num_objects)
>>>> 	return;
>>>>
>>>> Technically that also covers open_pack_index() failure, too, but that's
>>>> a subtlety I don't think we should rely on.
>>> True.  I notice that the early part of the two functions look almost
>>> identical.  Do we need error condition handling for the other one,
>>> too?
>> I prefer to fix the problem in all code clones when they cause review
>> friction, so I'll send a fifth commit showing just the diff for these
>> packfile issues in sha1_name.c. See patch below.
> Ah, that answers my earlier question. Junio mean unique_in_pack(). And
> yeah, I think it suffers from the same problem.
>
>> Should open_pack_index() return a non-zero status if the packfile is empty?
>> Or, is there a meaningful reason to have empty packfiles?
> I can't think of a compelling reason to have an empty packfile. But nor
> do I think we should consider them an error when we can handle them
> quietly (and returning non-zero status would cause Git to complain on
> many operations in a repository that has such a file).
>
> -Peff

Thanks for the comments. I found some typos in my commit messages, too.

I plan to send a (hopefully) final version tomorrow (Thursday). It will 
include:

* Make 'pos' unsigned in get_hex_char_from_oid()

* Check response from open_pack_index()

* Small typos in commit messages

If there are other issues, then please let me know.

Thanks,
-Stolee
