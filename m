Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85561F4B7
	for <e@80x24.org>; Fri,  6 Sep 2019 15:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394811AbfIFPZo (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 11:25:44 -0400
Received: from mout.web.de ([212.227.15.14]:46447 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389797AbfIFPZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 11:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567783531;
        bh=eaqWru405d+5Sw1tCDHmvBYb2UHFhcbFn1drRG4DFTg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=RGNRZNZ3GvHhhsMuU1Tn1L4x8Yt780df9/klN9YVW8b9a0aPQvwwV6Ey8fwlxBscg
         p7vioSFIsuPQlC+rlxIoLnF7eVW323QX+jU0ihDCEhjJctT68qY8efw+C+hA1u8LKm
         358mGayO7nLRAXoLrn/P35KV0L2TZxsdNgttlPjc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmuMO-1ieTPL2YsG-00h4Dw; Fri, 06
 Sep 2019 17:25:31 +0200
Subject: Re: [PATCH 1/2] tag: factor out get_tagged_oid()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Sperling <stsp@stsp.name>,
        Martin Koegler <martin.koegler@chello.at>
References: <1385c954-d9ef-7ef6-6185-0dad885531ec@web.de>
 <20190906071320.GA14343@sigill.intra.peff.net>
 <f44b7abc-cab1-0bd4-029a-1c84cf36ec7b@web.de>
Message-ID: <c1ffd461-7283-eeaa-6f68-778c5a35e8eb@web.de>
Date:   Fri, 6 Sep 2019 17:25:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f44b7abc-cab1-0bd4-029a-1c84cf36ec7b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jVhD9QPuqqjCpghDe32f5kabe4KhohKLGfaIX09CF+CHgvsjY04
 5S0opwTkRQqCjzvVwdcdcFtGFy0iV6LYUSA2loNJCHveoI+dKM3CYux3ltUhTc89QkTwhpA
 jjBFpDalOidqsxmX1b2vIXZcFQtJ351rB9oHVZVBCVt3dPd8rVJySJ7lnGhqDhI66JTvJIr
 kIFfZrFZb+odPDV8Vj4xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tcV6qxaiNsM=:hQrWsbNjuFckDUlKfQYjDw
 WKKpcL+ImcCp3Gup45TRN6JHH1EXn5gViEqaYY75lO83Z+DYTLocqMyfNSinEP4PFSY3trt9f
 +Gcx4YZdtkUbljKSxoH7G2uWowctJobyGlBmZpJcyHlJMvJg9gurApaBH9qOk/zM4YSdP49+w
 ualRrbN+M0JFtumakjxhvh4ceMnQlt9YsTaNIz1SsiD+IsARo/NH7/bS0gHs4t8XP5tCa6kbK
 9aHWVbIbG36UG/tna5r/79aRgqw9QSllsgbR92+4IZ2TPNJLbOw6AnzV8wTHPgNguR0U+rdFh
 LCwRSZG/1N73YJcezCwTmhWa056PD0WfdR4Wh8jOAvLM2zyi5qiJBYcaYJ1bs+QYfEBN+lPST
 Ey5Na7+UaWA+N1MRUhfW7mAgca/Qv0R6X9WuBINe1kTsQSZuhk6nABcaeaOIGKSRrm6+smnNR
 a/DJ8mjZ0k8kxGba4oJ1/fEr9VwkJDB7pYzYVTVvyNVJOX7ruKNRhO4bU/a5mpS+P7/f/alRW
 rhkucvAU6SVxt7ba3FsbwHOy0BqZJ+CGfIHlQOZfUDUNH2wzU+qDTtz5B6SeKmznKp29xBzfV
 1Gx2bkBFTRAG8auNPeOUxoE9eK3NhdltdM/sorMjkC1so1uwwGRD3P2Xl2Z8uF7h9oRnmQHyJ
 apwvjrHPkp5pFDKOpNbGZUHku0nfBtqUzt6AuGEGtVowNXAcXqA9Yg119po66pw4XwaB36yXL
 fSTVa8rkYg9L9OMq/mxWEW8oVQogHY+dZznDPs+fSYwUmTSWcijeBWSkPe3/misu1mwNczSYY
 OD+lcsBYTdwErqgadZx1zbL1OIjtpvILrSJibX3DomL0SgZkWfNFW07eJYB7v/x10BggfY+NJ
 VsCSK95I8CG3/1hilywHQlvD2r3pXDx2sw3VCmccXZRIIZeUyIFB/uRdIxeMMz7RxI9icSgUn
 koo23ae27gk9Bhzo0tkZODwW39hmXa+MTfVK7IhENkW/ReXX0cCUN9gRUdKs87PUf3T4cz7R8
 GENG6lUrNc/pTWBvPphKfv4tJlImuwTgPoJJIXefpMWUu+sFC6ILRIEkmKzXfDBsgX5Y3P5Hd
 JuFbGLKGkb4gfyACb5q6Zd1xTsuWdXVQZvYaMYwqJ8UViQcT63v9ZDkNko0n4uNa/t/nsid1h
 ZQ0ZHrtCDZdPWm+kGY7MEGpLAH83HXSam43i+WOKCbscWroJiOBnPCe5RjPMhfUH9p1Ug=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.09.19 um 17:05 schrieb Ren=C3=A9 Scharfe:
> A tag referencing an unknown object sounds strange to me.  I imagine we
> might get such a thing when the referenced object is lost (broken repo)
> or purpose-built from an attacker.  Could such a tag still be used for
> anything?  Are there other possible causes?
Forward compatibility perhaps, i.e. supporting tags (by ignoring them)
that point to a new type of object introduced by a future version.

Ren=C3=A9
