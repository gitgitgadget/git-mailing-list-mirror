Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F1F20A78
	for <e@80x24.org>; Thu,  2 Feb 2017 00:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbdBBAOh convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 1 Feb 2017 19:14:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:50092 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbdBBAOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 19:14:37 -0500
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP; 01 Feb 2017 16:14:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,322,1477983600"; 
   d="scan'208";a="929169058"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2017 16:14:30 -0800
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Wed, 1 Feb 2017 16:14:30 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.108]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.139]) with mapi id 14.03.0248.002;
 Wed, 1 Feb 2017 16:14:30 -0800
From:   "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git commit results in many lstat()s
Thread-Topic: git commit results in many lstat()s
Thread-Index: AQHSfOYEoJRrSN8YSgqDGiFiJtHa4qFU1s9Q
Date:   Thu, 2 Feb 2017 00:14:30 +0000
Message-ID: <DA0A42D68346B1469147552440A645039A9C5929@ORSMSX115.amr.corp.intel.com>
References: <DA0A42D68346B1469147552440A645039A9C56D4@ORSMSX115.amr.corp.intel.com>
        <xmqq8tppo92x.fsf@gitster.mtv.corp.google.com>
        <DA0A42D68346B1469147552440A645039A9C57D6@ORSMSX115.amr.corp.intel.com>
 <xmqq60ktmpwl.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq60ktmpwl.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzFkYWExZjctOTU0Mi00NjlkLWI5NTctZGUyMzllMzk1YWRiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE1LjkuNi42IiwiVHJ1c3RlZExhYmVsSGFzaCI6IlRxc0VOQURcL2RxQnIrTHp1NWFkbmpabVZtSGg3eEsreTJWTytjZVlNUTZ3PSJ9
x-ctpclassification: CTP_IC
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Junio C Hamano <mailto:jch2355@gmail.com> writes:

"Gumbel, Matthew K" <matthew.k.gumbel@intel.com> writes:

>> Yes, I think that when the user passes --only flag to git-commit, then git does not
>> need to call refresh_cache() in prepare_index() in builtin/commit.c.
>>
>> I may experiment with that. Do you see any downside or negative side-effects?

> There may be other fallouts, but one that immediately comes to mind
> is that it may break pre-commit hook.

If pre-commit hook exists, we can fall-back to original behavior and call
refresh_cache(). Many repos will not have pre-commit hook and can 
benefit from the speedup.

I'm testing such a change locally. Git test suite seems to be running for quite
a while. Do you know any way to run it in parallel or otherwise speed it
up?

Thanks,
Matt
