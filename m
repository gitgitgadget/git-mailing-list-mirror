Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F159C20282
	for <e@80x24.org>; Sat, 17 Jun 2017 22:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbdFQWsu (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 18:48:50 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35961 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdFQWst (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 18:48:49 -0400
Received: by mail-io0-f193.google.com with SMTP id i93so8011593iod.3
        for <git@vger.kernel.org>; Sat, 17 Jun 2017 15:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bnX7O7nrUlx5iLPx5lKXhzhCiUO5QuZJPR3GV/WB2fk=;
        b=L2KgrqWWlmajoPJWxzmZPMQJcx27mcwucZThakzG2XkraFqFEM+3rkjymblDcsGKCX
         EsTAbZXJG5A+Wk0tDN/8Kh8+YvO5b4AwkmT3addJd15lLDApSadmgQ1Jph+ciI2XRn91
         IAHC1xXgsURiAToGopBBU2EvrSUYiq2a6GF9KlYVGzHFar5Plrk/xpXq+29VZTKqqeyJ
         R+98BBOawVNcKGKbkuJrxYNi9KMjMF8ddblM5Vk1xMnbK5fDAbMaZZ+QAsNPhLdbLyjd
         oPdQhpZJX0oBYhdmzQWKDhK5dZadS2SOd/4Ri5SKDak39nSreyPUCWMNQKW9lu8G9Kqy
         jlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bnX7O7nrUlx5iLPx5lKXhzhCiUO5QuZJPR3GV/WB2fk=;
        b=FRhmmrZu1gF2ip0k8m0l3R/W+/rGYAXh0c20IIDdlJVmTj5BShnKPVfu97ZboL6o4y
         gFTUfYzlTqI10fo3G3COJE5KZKQ6Uqv4M0volDy2Lfkxy4SqLiO6F3Bxmpt5YDuH1XCI
         rhuK7ZTv8Sn+RvITEu/jhLHgK3zFgRk80k3xLZH2PlW3+z9OlKapQcWvBAoBtdPv5HXs
         Bf94xw3Hc8UbHpvyOwaV1P97N2DpXRaH0gcW/kPiHj1Rf4ngwgChUBVhZPzEm/NiVB2j
         qmanQ/o30iIWzY1WRKwzd9MgeICguvc8VZThoV3sWkGKRFIyK014ADxDTjkpXiP167Z2
         qtxg==
X-Gm-Message-State: AKS2vOyOzt8///iBVwclr3t4LUt98/jr8/rYxqnknRfYNGxo81zh1P3h
        EQFXwh4mEzNQRg==
X-Received: by 10.107.164.160 with SMTP id d32mr17928395ioj.158.1497739728776;
        Sat, 17 Jun 2017 15:48:48 -0700 (PDT)
Received: from [192.168.2.102] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id e1sm4088881itd.18.2017.06.17.15.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2017 15:48:48 -0700 (PDT)
Subject: Re: [PATCH v5 08/10] rebase -i: skip unnecessary picks using the
 rebase--helper
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
 <72bbfcae2abcb14f6b1288051a244faadbee29e0.1497444257.git.johannes.schindelin@gmx.de>
 <a12767b9-a947-e0a2-fc82-fc25992fd0d1@gmail.com>
 <alpine.DEB.2.21.1.1706161551030.4200@virtualbox>
From:   Liam Beguin <liambeguin@gmail.com>
Message-ID: <529f6cc7-ab2b-72bb-bc51-f4cca4e98652@gmail.com>
Date:   Sat, 17 Jun 2017 18:48:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1706161551030.4200@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes, 

On 16/06/17 09:56 AM, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Thu, 15 Jun 2017, Liam Beguin wrote:
> 
>> On 14/06/17 09:08 AM, Johannes Schindelin wrote:
>>> diff --git a/sequencer.c b/sequencer.c
>>> index a697906d463..a0e020dab09 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -2640,3 +2640,110 @@ int check_todo_list(void)
>>>  
>>>  	return res;
>>>  }
>>> +
>>> +/* skip picking commits whose parents are unchanged */
>>> +int skip_unnecessary_picks(void)
>>> +{
>>> +	const char *todo_file = rebase_path_todo();
>>> +	struct strbuf buf = STRBUF_INIT;
>>> +	struct todo_list todo_list = TODO_LIST_INIT;
>>> +	struct object_id onto_oid, *oid = &onto_oid, *parent_oid;
>>> +	int fd, i;
>>> +
>>> +	if (!read_oneliner(&buf, rebase_path_onto(), 0))
>>> +		return error(_("could not read 'onto'"));
>>> +	if (get_sha1(buf.buf, onto_oid.hash)) {
>>
>> I missed this last time but we could also replace `get_sha1` with `get_oid`
> 
> Good point!
> 
> I replaced this locally and force-pushed, but there is actually little
> chance of this patch series being integrated in a form with which I would
> be comfortable.

Is there any chance of this moving forward? I was hoping to resend my path to
abbreviate command names on top of this.

> 
> Ciao,
> Dscho
> 
Thanks,

 - Liam
