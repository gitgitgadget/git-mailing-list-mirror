Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC83C1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 23:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfBNXEq (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 18:04:46 -0500
Received: from elephants.elehost.com ([216.66.27.132]:60447 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfBNXEq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 18:04:46 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1EN4fAY040612
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Feb 2019 18:04:41 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Max Kirillov'" <max@max630.net>
Cc:     "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>
References: <pull.126.git.gitgitgadget@gmail.com> <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com> <20190214223334.GE3064@jessie.local>
In-Reply-To: <20190214223334.GE3064@jessie.local>
Subject: RE: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
Date:   Thu, 14 Feb 2019 18:04:34 -0500
Message-ID: <005a01d4c4b9$a9c411e0$fd4c35a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJRGauSxHI8crErjTmvoq3vRhvADwFUx24oAoEs3RukyI+EsA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 14, 2019 17:34, Max Kirillov wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Johannes Schindelin via GitGitGadget' <gitgitgadget@gmail.com>;
> git@vger.kernel.org; 'Junio C Hamano' <gitster@pobox.com>; 'Max Kirillov'
> <max@max630.net>
> Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
> 
> On Thu, Feb 14, 2019 at 05:17:26PM -0500, Randall S. Becker wrote:
> > Unfortunately, subtest 13 still hangs on NonStop, even with this
> > patch, so our Pipeline still hangs. I'm glad it's better on Azure, but
> > I don't think this actually addresses the root cause of the hang. This
> > is now the fourth attempt at fixing this. Is it possible this is not
> > the test that is failing, but actually the git-http-backend? The code
> > is not in a loop, if that helps. It is not consuming any significant
> > cycles. I don't know that part of the code at all, sadly. The code is
> > here:
> >
> > * in the operating system from here up *
> >   cleanup_children + 0x5D0 (UCr)
> 
> ... so does the process which the stack was taken from has any children
> processes still?
> 
> I could imagine if a child somehow manages to end up in uninterruptible
> sleep, then probably it would never complete this way, wouldn't it?

Yes, this is typical of a hang. Two processes reading on the same pipe, or
one reading on a pipe and the other waiting for something that never shows.
Or one process attempting both reading and writing on the same pipe (no
kernel threads here). I did not see anything actually in sleep. perl is in a
close call, waiting for its output to be consumed - which never happens,
making me suspect this is a pipe setup issue, but I can't demonstrate that,
sorry.

