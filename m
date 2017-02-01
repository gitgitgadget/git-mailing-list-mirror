Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263571F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 21:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbdBAVp1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 1 Feb 2017 16:45:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:62721 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbdBAVp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 16:45:26 -0500
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP; 01 Feb 2017 13:45:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,321,1477983600"; 
   d="scan'208";a="60781925"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2017 13:45:26 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Wed, 1 Feb 2017 13:45:26 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.108]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.135]) with mapi id 14.03.0248.002;
 Wed, 1 Feb 2017 13:45:25 -0800
From:   "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git commit results in many lstat()s
Thread-Topic: git commit results in many lstat()s
Thread-Index: AdJ8zldaoJRrSN8YSgqDGiFiJtHa4g==
Date:   Wed, 1 Feb 2017 21:45:25 +0000
Message-ID: <DA0A42D68346B1469147552440A645039A9C56D4@ORSMSX115.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmM5MTIyZmEtMWRhZS00M2I2LThhYTYtOWU0ZmFjZjVhMDRmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE1LjkuNi42IiwiVHJ1c3RlZExhYmVsSGFzaCI6IkxXcHFQdUlYQnF4ZEdyMTkwcFRkZjJhbVgyQ09xMDFsN3dFTFM3dDJHZEU9In0=
x-ctpclassification: CTP_IC
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My high level problem is to speed up git commit on a large repository stored on NFS filesystem. I see via strace that it is slow because it makes a large number (~50,000) of lstat() calls in serial. Every call is a round-trip to the NFS server.

I do not understand why git commit must call lstat() on every file in the repository, even when I specify the name of the file I want to commit on the command line. Can somebody explain why it must call lstat on every file?

My command-line looks like this: git commit -uno -o -m asdf file-to-commit.txt

Secondly, are there any optimizations I can make to avoid this behavior?

Thanks,
Matt

