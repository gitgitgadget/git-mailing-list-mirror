Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9FC2013A
	for <e@80x24.org>; Fri, 17 Feb 2017 10:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932444AbdBQKmd (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 05:42:33 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:47337 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754882AbdBQKmb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 05:42:31 -0500
X-AuditID: 12074414-807ff70000002bfd-4f-58a6d393a5ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F9.A5.11261.393D6A85; Fri, 17 Feb 2017 05:42:29 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF52F.dip0.t-ipconnect.de [79.237.245.47])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1HAgPBB026017
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 17 Feb 2017 05:42:26 -0500
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
To:     Jeff King <peff@peff.net>
References: <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
 <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net>
 <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
 <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
 <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
 <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
 <87tw7uv439.fsf@linux-m68k.org>
 <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
 <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
 <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
 <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
Date:   Fri, 17 Feb 2017 11:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1J16eVmEwcZ7ihZdV7qZLBp6rzBb
        rL2+lNniR0sPs0X/0g42B1aPnbPusnscOtzB6PGsdw+jx8VLyh6fN8kFsEZx2aSk5mSWpRbp
        2yVwZXybfZKx4DZzxZ7es+wNjJ+Zuhg5OSQETCQ67t8Hsrk4hAR2MEns/babDcI5zyTx+9U8
        RpAqYQEbiXXnPrOD2CICshLfD29khCi6wCIx+9gFFhCHWWAPo8TZGyfB5rIJ6Eos6mkGs3kF
        7CWm7L/JAmKzCKhKLDizihXEFhUIkZiz8AEjRI2gxMmZT8BqOAVcJC6df8cGYjMLqEv8mXeJ
        GcKWl9j+dg7zBEb+WUhaZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwS
        vdSU0k2MkHAW2cF45KTcIUYBDkYlHt6M7UsjhFgTy4orcw8xSnIwKYnyLpq2LEKILyk/pTIj
        sTgjvqg0J7X4EKMEB7OSCO+zC0A53pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUw
        WRkODiUJ3tpLQI2CRanpqRVpmTklCGkmDk6Q4TxAwyeA1PAWFyTmFmemQ+RPMepynPp04SWT
        EEtefl6qlDivGUiRAEhRRmke3BxYGnrFKA70ljBvPEgVDzCFwU16BbSECWhJZ8RSkCUliQgp
        qQZGycY31k+OxG7er6l89MN+i9oCyagpcZuPKcj2SeRI1s6Jv3S3XKZ376LI7ScPPZaZE/W9
        ZplDT/Pq2+dll6q/ZpXQkPwT17erxaLkz+mJ1iEtOsKG2SJSYYImPcudIpfvlw05MqHhy5vC
        F5V1l/95t67e+/T+yem1JhNsNvlePsvt0W25IDhNiaU4I9FQi7moOBEAFROd6x4DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/17/2017 09:07 AM, Jeff King wrote:
> [...]
> That's similar to what I wrote earlier, but if we don't mind overwriting
> errno unconditionally, I think just:
> 
>   errno = EIO; /* covers ferror(), overwritten by failing fclose() */
>   err |= ferror(fp);
>   err |= fclose(fp);
> 
> does the same thing.

True; I'd forgotten the convention that non-failing functions are
allowed to change errno. Your solution is obviously simpler and faster.

Michael

