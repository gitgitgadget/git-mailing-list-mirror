Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5DE720285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdH2Ijj (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:39:39 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48405 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751237AbdH2Ijg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 04:39:36 -0400
X-AuditID: 12074412-1fdff7000000748d-19-59a528479eab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BA.8D.29837.74825A95; Tue, 29 Aug 2017 04:39:35 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC836.dip0.t-ipconnect.de [87.188.200.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7T8dX9h003757
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 04:39:35 -0400
Subject: Re: [PATCH v2 2/2] refs/files-backend: fix memory leak in
 lock_ref_for_update
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <CAN0heSrkYL6OqVHHnDtA1DqE-FVqjB59bG2MsgxmJyxW33k9JA@mail.gmail.com>
 <fe842671061cea7972b0c8695a4b7f82f854453a.1503951733.git.martin.agren@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <425e16e7-188e-ecff-3a09-228ef1dcf319@alum.mit.edu>
Date:   Tue, 29 Aug 2017 10:39:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <fe842671061cea7972b0c8695a4b7f82f854453a.1503951733.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYndR1PXQWBppsPk+o0XXlW4mi4beK8wW
        f990MTowe+ycdZfd4+IlZY/Pm+QCmKO4bFJSczLLUov07RK4Mg4ebWYu+MFVcXVVO0sD41WO
        LkZODgkBE4mP5+ezdTFycQgJ7GCS6JywlgXCOc8ksfT3FBaQKmGBCImHux+wg9giQPb9mXeZ
        QWxmATWJ9k1TWCEaFjNKLHwzEyzBJqArsainmQnE5hWwl/i2aBoriM0ioCpxdu45MFsUaFDf
        28vsEDWCEidnPgFbxikQK3H7whd2iAXqEn/mXYJaJi5x68l8JghbXqJ562zmCYwCs5C0z0LS
        MgtJyywkLQsYWVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5ihAS10A7G9Sfl
        DjEKcDAq8fCusF4SKcSaWFZcmXuIUZKDSUmUV1J1aaQQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
        Ed5gdqAcb0piZVVqUT5MSpqDRUmc9+didT8hgfTEktTs1NSC1CKYrAwHh5IEr546UKNgUWp6
        akVaZk4JQpqJgxNkOA/QcGuQGt7igsTc4sx0iPwpRkUpcV4/kIQASCKjNA+uF5Z0XjGKA70i
        zMsNUsUDTFhw3a+ABjMBDVYUXAgyuCQRISXVwJimmX6zoJEzbnJX3Ll5U2qau0zbZ805a73o
        p843zYx3BScVUuPbTPVtjEqt5Bea7mLodLu7v7ZxldOC0n+vdjAGql9Ur828V6mzf4fN4RUV
        /n4Br+69+Xtzzp7XTCn+nj1Vy2xrBQ3FVwbb8/Yn7fvSerfg27xJbhsntc+sC1jyUrJOR2jP
        XSWW4oxEQy3mouJEAFO7wh0VAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/28/2017 10:32 PM, Martin Ågren wrote:
> After the previous patch, none of the functions we call hold on to
> `referent.buf`, so we can safely release the string buffer before
> returning.

This patch looks good to me, but I did notice a pre-existing problem in
the area...

> ---
>  refs/files-backend.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index bdb0e22e5..15f34b10e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> [...]
> @@ -2305,10 +2305,12 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  					strbuf_addf(err, "cannot lock ref '%s': "
>  						    "error reading reference",
>  						    original_update_refname(update));
> -					return -1;
> +					ret = -1;
> +					goto out;

It is incorrect to return -1 here. First of all, stylistically, the
return value should be a symbolic constant. But in fact, it should be
returning `TRANSACTION_GENERIC_ERROR` here, whereas -1 is
`TRANSACTION_NAME_CONFLICT`. So the code is not just stylistically
wrong; it is functionally wrong.

I know that this is not your mistake, but would you like to add another
patch to your series to fix this up? I'd do it myself, but it's a little
bit awkward because the fix will conflict with your patch.

Thanks,
Michael
