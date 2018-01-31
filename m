Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB521F404
	for <e@80x24.org>; Wed, 31 Jan 2018 22:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeAaWOj (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 17:14:39 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44731 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeAaWOi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 17:14:38 -0500
Received: by mail-qt0-f193.google.com with SMTP id l20so23896006qtj.11
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 14:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+rKujInZVm7sx+d99KZ4qTEM01ixSddEZXfgYtC8S5w=;
        b=uGG9AzEXtcVm31mJOx3EV+675sZZwKi7AEvr5p2c385oMLwKdgg0nyLksby+fA1fBQ
         TtX2KXJqAaZUEgKgy53WiJiYK3u4s0kalSOh8OOXnl1CUy8zCnqwep+D2a7Rl6KAgRjZ
         XmRAV5BSMPvMAt3IAGkM4N5jzldIfTFjbZBYEOJ7s0HMAw3XRPfad56Ud7FbTjY9SRYb
         hAb1bTJ2spRSOVWBOq7AqTr+F5o3k+yfNx4JjDKBytonjlR7CsG1Josa3eEMRqu6HGtc
         Gf4klkkHmzMCRcb3JL/A62t9lMQx1bHSz7FOVTrxoNq3SjRnCSRGpDLbteDsoN9YMwYt
         lnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+rKujInZVm7sx+d99KZ4qTEM01ixSddEZXfgYtC8S5w=;
        b=pFnFgyckiTnylrVHWO04aonx9dICN6qHfEqpnH1JSskPTnlxorC2Lt5cuYkaGLUwRs
         053Xf0zkT18/vTEmSTz0SZyc71qvQqpJlg5ScUNQNeavWnLuT4WXNO9sBdSGOMVZ1XJK
         UdzW9VkTx0eKlatHzUvKBDGB5IBhbuZHEy76unTfSJ2a/ClWOIzplhX4p3OMth7RjtH0
         qRVUNEvxusj0UYZ7m/FoW++WKzZGIgsNG87zNRluHWErbh7F80UY1VB0parlLeUH6WLY
         c7Cr+z6aODa9U5Jv3RSmtsCi2W0MK/18yu570WZqAJ3zxTciDAg3jAX0oHWsS97/afcq
         PoTQ==
X-Gm-Message-State: AKwxyteYlMOjjAy23i9MrbCa0gBPpOeMxifyJkKLPu/oALqGQzMmhL5O
        BnbbLrnge+ZaIlyY7i3pzvd12ULWRi0=
X-Google-Smtp-Source: AH8x226CBkdLIpxuxaaozvT/0x7i8CVjSALB+7BqIlLmI3S349eDsWAq7VopE0Kn+fKCbtSghGhT4Q==
X-Received: by 10.200.46.214 with SMTP id i22mr55668310qta.157.1517436877862;
        Wed, 31 Jan 2018 14:14:37 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id s72sm12052482qki.50.2018.01.31.14.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 14:14:37 -0800 (PST)
Subject: Re: [PATCH v2 14/27] connect: request remote refs using v2
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-15-bmwill@google.com>
 <2007efc8-ec31-0267-9b83-392a9d2eaf4a@gmail.com>
 <CAPig+cQvPdMtAWijJaez17m4_fdG6ho_EJW9t=KmnTpocquwgg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <514f4a9a-6c88-1dbd-e126-de4dc4c31a8f@gmail.com>
Date:   Wed, 31 Jan 2018 17:14:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAPig+cQvPdMtAWijJaez17m4_fdG6ho_EJW9t=KmnTpocquwgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/31/2018 3:10 PM, Eric Sunshine wrote:
> On Wed, Jan 31, 2018 at 10:22 AM, Derrick Stolee <stolee@gmail.com> wrote:
>> On 1/25/2018 6:58 PM, Brandon Williams wrote:
>>>   +static int process_ref_v2(const char *line, struct ref ***list)
>>> +{
>>> +       int ret = 1;
>>> +       int i = 0;
>> nit: you set 'i' here, but first use it in a for loop with blank
>> initializer. Perhaps keep the first assignment closer to the first use?
> Hmm, I see 'i' being incremented a couple times before the loop...
>
>>> +       if (string_list_split(&line_sections, line, ' ', -1) < 2) {
>>> +               ret = 0;
>>> +               goto out;
>>> +       }
>>> +
>>> +       if (get_oid_hex(line_sections.items[i++].string, &old_oid)) {
> here...
>
>>> +               ret = 0;
>>> +               goto out;
>>> +       }
>>> +
>>> +       ref = alloc_ref(line_sections.items[i++].string);
> and here...
>
>>> +
>>> +       oidcpy(&ref->old_oid, &old_oid);
>>> +       **list = ref;
>>> +       *list = &ref->next;
>>> +
>>> +       for (; i < line_sections.nr; i++) {
> then it is used in the loop.
>
>>> +               const char *arg = line_sections.items[i].string;
>>> +               if (skip_prefix(arg, "symref-target:", &arg))
>>> +                       ref->symref = xstrdup(arg);

Thanks! Sorry I missed this.

-Stolee
