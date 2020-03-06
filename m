Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDCEC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 18:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5EA20684
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 18:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFS6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:58:07 -0500
Received: from siwi.pair.com ([209.68.5.199]:39799 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgCFS6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 13:58:07 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 040703F486B;
        Fri,  6 Mar 2020 13:58:06 -0500 (EST)
Received: from [IPv6:2600:1012:b12d:1120:1e4:1191:77a1:c690] (unknown [IPv6:2600:1012:b12d:1120:1e4:1191:77a1:c690])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id ED35E3F484A;
        Fri,  6 Mar 2020 13:58:04 -0500 (EST)
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200302230400.107428-1-emilyshaffer@google.com>
 <20200302230400.107428-3-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
 <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com>
 <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c3ab15b9-c143-2251-0e5d-a990e50a72ea@jeffhostetler.com>
Date:   Fri, 6 Mar 2020 13:58:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/6/2020 1:08 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> Having this command be a stand-alone exe rather than a builtin allows
>> it to have a different linkage.  For example, you could include the
>> libcurl and other libraries that are only linked into the transports.
>> And then report version numbers for them if you wanted.
> 
> I actually do not think that is a good rationale.  Unless your
> version of "git bugreport" links into the same binary as the
> "transports", it still is possible that the version of cURL (for
> example) "git bugreport" can learn internally from may not have
> anything to do with the version of the library used by the
> transports.
> 
> Of course, making "bugreport" a built-in, i.e. the same binary as
> the non-transport part of Git, is not a solution for that issue,
> either.  As Dscho suggested and recent rounds of "git bugreport"
> implements, teaching the transport binaries an option to report
> relevant pieces of information regarding the libraries they use, and
> making "git bugreport" ask them, is a very good solution for that.
> 
> What makes it possible by making "git bugreport" stand-alone is for
> it to link with libraries that the remainder of Git, including the
> transports that link with libcurl, has no business linking with (a
> library to obtain system details for diagnostic purposes, for
> example).  Early versions of "git bugreport" may not link with
> anything special, but making sure it starts and stays standalone
> leaves it easier to do so _without_ having to worry about splitting
> the code that started as a built-in out to make it independent later.
> 
> 

Yeah, that makes sense.
Thanks
Jeff
