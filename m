Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A791A1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934957AbeCHLF5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:05:57 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:49053 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeCHLF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:05:56 -0500
Received: from [192.168.2.201] ([89.242.187.47])
        by smtp.talktalk.net with SMTP
        id ttMueKQPPwheattMwejU1z; Thu, 08 Mar 2018 11:05:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520507154;
        bh=qqB0mht7yl6MFcEPSXEo0c7frOQ5ZK/77zGGgIxAXlE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=B0FtLtRfybghJHTqS4cDAL126qWHmntWK1MEFcXScfX3Wy+4wlDpS0D5V7sHVn5a8
         PADNXgX9KOWEDLNzQWw2GDEkxptZ/kytEnIode/+9gxywCRb6L9TXe10iDjQQLJweB
         daQfYHR9wstIKj2olvCAENTB43CWRdxwjMYQQOM4=
X-Originating-IP: [89.242.187.47]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=xTMdeSjPtcrjTRwaJcecEQ==:117
 a=xTMdeSjPtcrjTRwaJcecEQ==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=bERc_Jam3zfgHG585bgA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] add -p: allow line selection to be inverted
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
 <20180306101750.18794-3-phillip.wood@talktalk.net>
 <xmqq371d3rjz.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6476d776-dbf7-09cf-1c65-e413798b9987@talktalk.net>
Date:   Thu, 8 Mar 2018 11:05:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq371d3rjz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO1uKYFC7G4HL+BwrOFZ/rGWcuh/hXGeb/MxSgv0T5bousgZCeYASf89G0V94+AET3LP6YzwFg9c0OCcSOZMFRvLpTcNfxv+LhVdRm6KyjAiwz3n85jY
 igoLNRi7Tz3E/zbWwvO7PnfzQ96hfKGpL/2cNxVHf7XU6rbHv2N6yKUaBOe6USbA8svIDo+tWgGKzpE0xFOrdGFqgGEEOQDQTnIn8XO+g99JPY+qQQ7M4SyU
 gxMryH6yzuaCUsI24WcB1Fg61NhkNx0s7lFvK/hv5/bW3OxgYLif9+mxt5iOygi0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/18 19:57, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If the list of lines to be selected begins with '^' select all the
>> lines except the ones listed.
> 
> There is "# Input that begins with '-'; unchoose" in list_and_choose
> helper.  Does it make things inconsistent to use '^' for negation
> like this patch does with it?
> 
Hmm yes, I think it probably does (I've just checked and git clean also
uses '-' for de-selection). I think I'll remove support for open-ended
ranges on the left side (it's not so hard to type '1-n' instead of '-n')
and use a leading '-' for inversion. I'm tempted to keep supporting 'n-'
to mean everything from 'n' to the last line though.

Best Wishes

Phillip
