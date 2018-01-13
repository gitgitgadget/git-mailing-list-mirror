Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574671F404
	for <e@80x24.org>; Sat, 13 Jan 2018 17:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeAMRar convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 13 Jan 2018 12:30:47 -0500
Received: from elephants.elehost.com ([216.66.27.132]:18753 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeAMRaq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 12:30:46 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0DHUg8M060153
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 13 Jan 2018 12:30:43 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "=?UTF-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>,
        "'Lars Schneider'" <larsxschneider@gmail.com>,
        "'Jeff Hostetler'" <jeffhost@microsoft.com>
References: <20180112163644.14108-1-randall.s.becker@rogers.com> <xmqqh8rqx4kz.fsf@gitster.mtv.corp.google.com> <004c01d38bde$f0e6bb50$d2b431f0$@nexbridge.com> <f139ed79-1e12-d7b6-dd24-ce77000917ec@web.de>
In-Reply-To: <f139ed79-1e12-d7b6-dd24-ce77000917ec@web.de>
Subject: RE: unused variable in hashmap.h [was: Re: [PATCH] Fixed pervasive enumeration warning in convert.h.]
Date:   Sat, 13 Jan 2018 12:30:35 -0500
Message-ID: <002501d38c94$3b9efd00$b2dcf700$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIaHxLWcrG4akzpY1ZwYOznE60qXALrzaZXAlkKDNAB05GxzaKsJkhQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sent: On January 13, 2018 12:13 PM, René Scharfe wrote:
> Am 12.01.2018 um 20:52 schrieb Randall S. Becker:
> > On a related too many warnings subject, hashmap.h has a variable
> > unused (void *item). Is that addressed soon? If not, I can deal with
> > it.
> Here are the code lines containing the variable in question:
> 
>         void *item;
>         while ((item = hashmap_iter_next(&iter)))
> 
> Intriguing.  The variable "item" is set, but can be removed without effect.
> GCC 7.2 and Clang 5 don't warn about that.
> 
> The code was introduced by 8b604d1951 (hashmap: add API to disable item
> counting when threaded) and there is no patch in pu that touches it again,

I was thinking about just changing it to the following and submitting the trivial patch:

         while (hashmap_iter_next(&iter))

Avoids the frame allocation of void *item so should make it minimally faster when compiled without optimization. 

Cheers,
Randall

