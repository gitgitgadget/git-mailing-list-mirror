Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0631120281
	for <e@80x24.org>; Fri, 15 Sep 2017 22:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdIOWAG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Sep 2017 18:00:06 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:56083 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdIOWAF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 18:00:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 64D0F10005B;
        Fri, 15 Sep 2017 22:00:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3ek7L-tEPXbY; Fri, 15 Sep 2017 22:00:04 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 535608002E;
        Fri, 15 Sep 2017 22:00:04 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Fri, 15 Sep 2017 22:00:04 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Fri, 15 Sep 2017 22:00:03 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <benpeart@microsoft.com>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
 extension
Thread-Topic: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
 extension
Thread-Index: AQHTLlfecTYo8c+6f0G9yk1v0OUKpKK2aI1A
Date:   Fri, 15 Sep 2017 22:00:03 +0000
Message-ID: <dc1506689d3d4639b56f0489e4219054@exmbdft7.ad.twosigma.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-11-benpeart@microsoft.com>
In-Reply-To: <20170915192043.4516-11-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> +dirty_repo () {
> +	: >untracked &&
> +	: >dir1/untracked &&
> +	: >dir2/untracked &&
> +	echo 1 >modified &&
> +	echo 2 >dir1/modified &&
> +	echo 3 >dir2/modified &&
> +	echo 4 >new &&
> +	echo 5 >dir1/new &&
> +	echo 6 >dir2/new

If I add an untracked file named dir3/untracked to dirty_repo
 (and write_integration_script), then "status doesn't detect 
unreported modifications", below, fails.  Did I do something 
wrong, or does this turn up a bug?

> +	test_expect_success "setup preloadIndex to $preload_val" '
> +		git config core.preloadIndex $preload_val &&
> +		if [ $preload_val -eq true ]

"-eq" is for numeric equality in POSIX shell.  So this works if your 
/bin/sh is bash but not if it's e.g. dash.  This happens twice more 
below.  Use "=" instead.


