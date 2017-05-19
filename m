Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA78F201A7
	for <e@80x24.org>; Fri, 19 May 2017 07:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdESH6r (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 03:58:47 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50225 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750793AbdESH6q (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 May 2017 03:58:46 -0400
X-AuditID: 1207440d-de7ff70000000e33-ce-591ea5ab20f2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A5.65.03635.BA5AE195; Fri, 19 May 2017 03:58:35 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCC1C.dip0.t-ipconnect.de [87.188.204.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4J7wUcC002651
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 19 May 2017 03:58:32 -0400
Subject: Re: [PATCH 12/23] ref_transaction_commit(): break into multiple
 functions
To:     Stefan Beller <sbeller@google.com>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <5ec5f3f9b4c9fc9f719d116b48dcf7b61e74ae49.1495014840.git.mhagger@alum.mit.edu>
 <CAGZ79kYF=MnJKrQakDbEQoR8r2MyeHro9vtzzmggwm6NXH9T2g@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <00f2cef4-70fa-9e77-9833-764d4b133733@alum.mit.edu>
Date:   Fri, 19 May 2017 09:58:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYF=MnJKrQakDbEQoR8r2MyeHro9vtzzmggwm6NXH9T2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1F29VC7S4PBVcYu1z+4wWXRd6Way
        aOi9wmyx5OFrZovuKW8ZLX609DBbbN7czuLA7rFz1l12jwWbSj262o+weTzr3cPocfGSssfn
        TXIBbFFcNimpOZllqUX6dglcGXs3NjAVNPJW/GiYzdrAeJ2ri5GTQ0LARGL938ksILaQwA4m
        iWvTfbsYuYDs80wSHza/ZOti5OAQFgiR2HNQG6RGREBNYuaq2WxQNYwSMw+/ZwRxmAXOMEn8
        v7YfbBKbgK7Eop5mJhCbV8BeYs7ew2wgNouAqsT+H5cZQWxRgQiJh5272CFqBCVOznwC1ssp
        ECgxZfMOVhCbWUBd4s+8S8wQtrzE9rdzmCcw8s9C0jILSdksJGULGJlXMcol5pTm6uYmZuYU
        pybrFicn5uWlFuka6eVmluilppRuYoSEOe8Oxv/rZA4xCnAwKvHwPlghGynEmlhWXJl7iFGS
        g0lJlHdGgFykEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFecTGgHG9KYmVValE+TEqag0VJnFdt
        ibqfkEB6YklqdmpqQWoRTFaGg0NJgld2CVCjYFFqempFWmZOCUKaiYMTZDgP0PB5IDW8xQWJ
        ucWZ6RD5U4yKUuK8KouBEgIgiYzSPLheWBp6xSgO9IowLwdIOw8whcF1vwIazAQ0uPmBNMjg
        kkSElFQDY+wM3X2/Xi3IXlp1dfLCVyvjft1g3HF6utRks/msk88+/Wrjzbxyys4XrFpvLtRa
        Zhc7iB+1ehY7oU9os4p69qOgx/cEFnC51L9+kv2m8ILz3N8bF7lnNn7RFlf4fWyX5++mYyyF
        Cxcs2fe6Ys7dL4p/fVRiYyd3/yrccimy+CaPjdJ1W08/Rg4lluKMREMt5qLiRAAIkEIDHgMA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 07:44 PM, Stefan Beller wrote:
> On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Break the function `ref_transaction_commit()` into two functions,
>> `ref_transaction_prepare()` and `ref_transaction_finish()`, with a
>> third function, `ref_transaction_abort()`, that can be used to abort
>> the transaction. Break up the `ref_store` methods similarly.
>>
>> This split will make it easier to implement compound reference stores,
>> where a transaction might have to span multiple underlying stores. In
>> that case, we would first want to "prepare" the sub-transactions in
>> each of the reference stores. If any of the "prepare" steps fails, we
>> would "abort" all of the sub-transactions. Only if all of the
>> "prepare" steps succeed would we "finish" each of them.
> [...]

Thanks for your comments. While I was incorporating them, I realized
that other parts of the documentation needed updates, too. And while I
was fixing that, I noticed that the interface was unnecessarily
complicated. The old version required either `commit` or `prepare`
followed by `finish`. But there is no reason that the public API has to
expose `finish`. So instead, let's call `prepare` an optional step that
is allowed to precede `commit`, and make `commit` smart enough to call
`prepare` if it hasn't been called already, and then call `finish`.

Furthermore, let's make it possible to call `abort` when the transaction
is in OPEN as well as PREPARED state rather than requiring `free` in
OPEN state and `abort` in PREPARED state.

I will make these changes and revamp the docs for v2.

Michael

