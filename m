Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E639201CF
	for <e@80x24.org>; Fri, 19 May 2017 04:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750738AbdESEtp (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 00:49:45 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:42431 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750703AbdESEto (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 May 2017 00:49:44 -0400
X-AuditID: 12074411-cafff70000003efd-d4-591e7964e2cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 49.C1.16125.4697E195; Fri, 19 May 2017 00:49:43 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCC1C.dip0.t-ipconnect.de [87.188.204.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4J4nbPZ027233
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 19 May 2017 00:49:38 -0400
Subject: Re: [PATCH 11/23] files_transaction_cleanup(): new helper function
To:     Jeff King <peff@peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <d6374d948f4424e4e6b4d999460597d226028be0.1495014840.git.mhagger@alum.mit.edu>
 <20170517131958.nxb5ol3wrtwyskss@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c8eb0a01-9d7d-a8c6-c1bc-31743d677883@alum.mit.edu>
Date:   Fri, 19 May 2017 06:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170517131958.nxb5ol3wrtwyskss@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1E2vlIs0uHWc22LtsztMFl1Xupks
        GnqvMFssefia2aJ7yltGix8tPcwWmze3sziwe+ycdZfdY8GmUo+u9iNsHs969zB6XLyk7PF5
        k1wAWxSXTUpqTmZZapG+XQJXxt0vp1kLHnJUTH2xnaWBsZW9i5GTQ0LARGL1tytsXYxcHEIC
        O5gkbhz7zgThnGeSmHjoBDNIlbCAt0Tzw142EFtEQFbi++GNjBBFhxglXj9rZwJJMAtsYpLY
        etYexGYT0JVY1NMMFucVsJdofTABqJmDg0VAVWL6QyuQsKhAhMTDzl3sECWCEidnPmEBKeEU
        cJG4eSoWYqK6xJ95l5ghbHmJ7W/nME9g5J+FpGMWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3W
        LU5OzMtLLdI11cvNLNFLTSndxAgJcsEdjDNOyh1iFOBgVOLhfbBCNlKINbGsuDL3EKMkB5OS
        KO+MALlIIb6k/JTKjMTijPii0pzUYqDHOZiVRHjFxYByvCmJlVWpRfkwKWkOFiVxXr4l6n5C
        AumJJanZqakFqUUwWRkODiUJ3uQKoEbBotT01Iq0zJwShDQTByfIcB6g4QwgNbzFBYm5xZnp
        EPlTjIpS4rxJ5UAJAZBERmkeXC8sCb1iFAd6RZg3EqSdB5jA4LpfAQ1mAhrc/EAaZHBJIkJK
        qoHROzXsrmX9RfNt/Gd2LjTbsvBv/Vb25V12Z3fmfmDu//s07fr+49dt3skVxvvefCsWOVXt
        vELfilKfz+kfdiqoXfl61131dcKKlHNPgi+z/T+Wkrb82tztXnENSoXKy9RWvROduKtMLKHh
        lvDUcs9KO97Ided3TmqR4VvFe3Dn7sa2TZsnKaeoK7EUZyQaajEXFScCAOSeBBodAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 03:19 PM, Jeff King wrote:
> On Wed, May 17, 2017 at 02:05:34PM +0200, Michael Haggerty wrote:
> 
>> Extract function from `files_transaction_commit()`. It will soon have
>> another caller.
>> [...]
>> @@ -2868,10 +2889,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
>>  	if (transaction->state != REF_TRANSACTION_OPEN)
>>  		die("BUG: commit called for transaction that is not open");
>>  
>> -	if (!transaction->nr) {
>> -		transaction->state = REF_TRANSACTION_CLOSED;
>> -		return 0;
>> -	}
>> +	if (!transaction->nr)
>> +		goto cleanup;
> 
> This is slightly more than it says on the tin. I guess the reason is
> that the cleanup function is going to learn about more than just
> iterating over the transaction, and we'll want to trigger it even for
> empty transactions.

Mostly this is just DRY. For example, later the cleanup will be changed
to set the state to `REF_TRANSACTION_PREPARED` rather than
`REF_TRANSACTION_CLOSED`, and that change will be able to be made in one
place rather than two. I'll mention this in the commit message.

Michael

