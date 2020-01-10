Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE43C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 20:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E82F2072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 20:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgAJUOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:14:38 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:42181 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgAJUOi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 15:14:38 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47vZ2h3tvHz5tl9;
        Fri, 10 Jan 2020 21:14:36 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1B6D3233;
        Fri, 10 Jan 2020 21:14:36 +0100 (CET)
Subject: Re: [PATCH] userdiff: add Julia to supported userdiff languages
To:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     Ryan Zoeller via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <pull.521.git.1578625810098.gitgitgadget@gmail.com>
 <49decf8e-87a9-120f-4c2b-cafc5aa1d466@kdbg.org>
 <YqXJB_En1hjDpzUmawtrEYBztOGh_1uSmwxsQyQ646RtwGnYppq-xg26rwM0x5pu6E8PMVq22HwfSSFXN9aaD9BowSUH1YfztHRUomhOe6E=@rtzoeller.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <cf486cb7-0ea5-92e8-1454-5059ea009ddf@kdbg.org>
Date:   Fri, 10 Jan 2020 21:14:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <YqXJB_En1hjDpzUmawtrEYBztOGh_1uSmwxsQyQ646RtwGnYppq-xg26rwM0x5pu6E8PMVq22HwfSSFXN9aaD9BowSUH1YfztHRUomhOe6E=@rtzoeller.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.20 um 19:15 schrieb Ryan Zoeller:
> On Friday, January 10, 2020 11:43 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 10.01.20 um 04:10 schrieb Ryan Zoeller via GitGitGadget:
>>> -   /* Real and complex literals */
>>> -   "|[-+0-9.e_(im)]+"
>>
>> I am curious: is '(1+2i)' a single literal -- including the parentheses?
>> The expression would also mistake the character sequence '-1)+(2+' as a
>> single word; is it intended?
> 
> This part of the regular expression has a pretty major mistake due
> to me misunderstanding how the parentheses were being interpreted.
> It should be something along the lines of `([-+0-9.e_]|im)+`.
> 
> Julia uses `im` as the designation for an imaginary value; this regex
> was intended to admit e.g. 1+2im, in addition other numeric values
> such as 1_000_000 and 1e10.
I see. I suggest to treat 1+2im as three words '1', '+', and '2im', and
to model numbers in this way:

	|[0-9][0-9_.]*(e[-+]?[0-9_]*)?(im)?

In particular, require a digit at the begin, and do not allow '-' and
'+' an arbitrary number of times, because it would catch 1+2+3+4 as a
single word.

-- Hannes
