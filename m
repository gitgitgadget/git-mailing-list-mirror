Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 644441F517
	for <e@80x24.org>; Mon,  4 Jun 2018 17:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbeFDRGp (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:06:45 -0400
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:59574
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750853AbeFDRGo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 13:06:44 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id PswJfW62g3MoiPswMfzs43; Mon, 04 Jun 2018 10:06:44 -0700
Date:   Mon, 4 Jun 2018 20:06:40 +0300
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] http-backend: respect CONTENT_LENGTH for
 receive-pack
Message-ID: <20180604170640.GB27650@jessie.local>
References: <20180602212749.21324-1-max@max630.net>
 <20180602212749.21324-3-max@max630.net>
 <xmqqefhn5g01.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefhn5g01.fsf@gitster-ct.c.googlers.com>
From2:  "Maksim Kirillov" <max630@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfBpO3Qc8DRYZQv6wR1DyMubMdEJ0jQD86GbGz9OTLOgXmtJEQdmYRxzXLShL+NuCC+5E0c2berPGr5AAwVRwyqTxkC+kLPgEzu4OiBfwjpd81vPmDUEr
 vNCTnEUc5d1F2WKy9nL6nG3iMGIky7Jijs/xeojiz9rl6rDA3bJ91XUEFCaNIVrsl6Z5W1nVQlq4MxLX2Lw5xI7BJu6U88wsKDC27i6Fd7rYZmncT1ymCkXq
 gEOH12VUKa0TPC9o+ygJZTd/hhVTeK1rgaBgRLWtvQ1D4IBmvh3D5WKQO/nU4lFW/k67JxsITAdT3u73NPgKtfEt9wyKJiZxbUeFviVSXAt6S1WUAPg4ZwoD
 SCaBpHa/Sn9yLHqn757WczvjGFmRINYXqTuaNLObpxmk6OSFekE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 01:31:58PM +0900, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
>> +		size_t n = xread(0, buf, chunk_length);
>> +		if (n < 0)
>> +			die_errno("Reading request failed");
> 
> n that is of type size_t is unsigned and cannot be negative here.

Thanks, fixing it
Do you think sanity check for n <= chunk_length (the code
will go mad in this case) is needed? As far as I can see n
returns straight from system's read()
