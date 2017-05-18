Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C0D201A7
	for <e@80x24.org>; Thu, 18 May 2017 04:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbdEREzw (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 00:55:52 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56012 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753805AbdEREzv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 May 2017 00:55:51 -0400
X-AuditID: 12074411-cafff70000003efd-fb-591d2953d18c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 73.0B.16125.3592D195; Thu, 18 May 2017 00:55:50 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B7F.dip0.t-ipconnect.de [91.16.75.127])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4I4thWq022174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 18 May 2017 00:55:45 -0400
Subject: Re: [PATCH 06/23] refs: use `size_t` indexes when iterating over ref
 transaction updates
To:     Stefan Beller <sbeller@google.com>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <17922578c2fbec4c0b8040cb37f432f913218489.1495014840.git.mhagger@alum.mit.edu>
 <CAGZ79kYspKC=NZDp8q46KO2pGBfsAfK8A=2PRDb2O1swOLf6MQ@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d9831944-47e0-e886-60ce-e3db151340dd@alum.mit.edu>
Date:   Thu, 18 May 2017 06:55:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYspKC=NZDp8q46KO2pGBfsAfK8A=2PRDb2O1swOLf6MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqBumKRtp8GCpnMXaZ3eYLLqudDNZ
        NPReYbZY8vA1s0X3lLeMFj9aepgtNm9uZ3Fg99g56y67x4JNpR5d7UfYPJ717mH0uHhJ2ePz
        JrkAtigum5TUnMyy1CJ9uwSujL7Zx1gK3rBV3Nq8jbmBcQNrFyMnh4SAicTiV5OAbC4OIYEd
        TBIPp61hhHDOMUncuP+CDaRKWCBZ4uPLfUwgtoiAmsTMVbPZIIrOM0rM3/KHHcRhFjjDJPH/
        2n4WkCo2AV2JRT3NYB28AvYSc6+9YQaxWQRUJd4cucEIYosKREg87NzFDlEjKHFy5hOwXk6B
        QImmv1fB6pkF1CX+zLsEZctLNG+dzTyBkX8WkpZZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZ
        tzg5MS8vtUjXVC83s0QvNaV0EyMk1AV3MM44KXeIUYCDUYmHNyJAJlKINbGsuDL3EKMkB5OS
        KK/rP6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV4rGdlIId6UxMqq1KJ8mJQ0B4uSOC/fEnU/
        IYH0xJLU7NTUgtQimKwMB4eSBK+gBlCjYFFqempFWmZOCUKaiYMTZDgP0PDJ6iDDiwsSc4sz
        0yHypxh1Oebc+/qeSYglLz8vVUqcdypIkQBIUUZpHtwcWIp6xSgO9JYwbzfIOh5geoOb9Apo
        CRPQkuYH0iBLShIRUlINjFlBDzeeeN4ea7AgMlPbdaWVKyO3ZUs3t0SH4c/tqRN3z9u42+1O
        h+pRccNXwjXij04+XrPvpehkJ824YNkb9plnVq/+I3BQREu2QD6QV3EXw4Zdcypy/RkO3DjN
        53313FeGq1am523iL32Y0j05U+my4e1Kdi1nzuePns9Xv6el+1rppVOksBJLcUaioRZzUXEi
        AFdSjFcsAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 06:59 PM, Stefan Beller wrote:
> On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> 
> Now this would want to have some selling words for it?
> I do not see an advantage of this patch as-is.
> 
> I mean technically we don't need a sign, so we use that extra bit
> to be able to process transactions up to twice the size. But I doubt
> that is the real reason. I'll read on, maybe a later patch will explain
> why we do this here.

The reason to use `size_t` is not signedness but rather that it might be
larger than `int` (e.g., 64 vs 32 bits), so you could theoretically get
an integer overflow otherwise. It's unlikely here, because it would be
hard to initiate an update of more than (2³¹-1) references in a single
update, but it's good hygiene anyway.

I'll mention that in the commit message.

Michael

