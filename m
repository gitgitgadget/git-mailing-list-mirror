Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E160E1F462
	for <e@80x24.org>; Tue, 21 May 2019 13:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfEUNHe convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 21 May 2019 09:07:34 -0400
Received: from elephants.elehost.com ([216.66.27.132]:38274 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUNHd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 09:07:33 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x4LD7T0H066875
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 May 2019 09:07:29 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Duy Nguyen'" <pclouds@gmail.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>,
        "'Jeff Hostetler'" <git@jeffhostetler.com>
References: <019e01d50fc2$324bd400$96e37c00$@nexbridge.com> <87a7fguiwn.fsf@evledraar.gmail.com> <CACsJy8DhsU6CL95W9gsWaTSnN+_7Z_+Q7yPjhuDRRKfCrhnz2w@mail.gmail.com>
In-Reply-To: <CACsJy8DhsU6CL95W9gsWaTSnN+_7Z_+Q7yPjhuDRRKfCrhnz2w@mail.gmail.com>
Subject: RE: [Breakage] 2.22.0-rc1 - t0211-trace2-perf.sh
Date:   Tue, 21 May 2019 09:07:23 -0400
Message-ID: <000501d50fd6$24c0f0e0$6e42d2a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJIlFGcpymIZH5SeOZkw6ZSgofd1QFWivxvAaMBH0ildrb1IA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 21, 2019 07:59, Duy Nguyen wrote:
> On Tue, May 21, 2019 at 6:51 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > But the real bug looks like the trace2 code unconditionally depending
> > on pthreads, even though NonStop has 'NO_PTHREADS =
> UnfortunatelyYes'
> > defined.
> >
> > That's why we get this th%d:unknown stuff, the trace2/tr2_tls.c code
> > using pthreads is failing with whatever pthread-bizarro NonStop has.
> >
> > That seems easy enough to "fix", just always fake up "main" if we
> > don't have pthreads, but perhaps Jeff H. has another opinion on it...
> 
> That's not NonStop. thread-utils.h (re)defines pthread_getspecific() to return
> NULL when NO_PTHREADS, which triggers this I think.

The platform *is* NonStop, which has SPT and PUT pthreads, but we have never been able to make them work with git, so did not include them in the configuration.

