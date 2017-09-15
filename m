Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5714D20281
	for <e@80x24.org>; Fri, 15 Sep 2017 21:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbdIOVf0 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Sep 2017 17:35:26 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:46192 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdIOVfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 17:35:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id BDB4C10005F;
        Fri, 15 Sep 2017 21:35:24 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iomaZz9TvU4U; Fri, 15 Sep 2017 21:35:24 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id ACA9F8002E;
        Fri, 15 Sep 2017 21:35:24 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Fri, 15 Sep 2017 21:35:24 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Fri, 15 Sep 2017 21:35:24 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <benpeart@microsoft.com>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v6 04/12] fsmonitor: teach git to optionally utilize a
 file system monitor to speed up detecting new or changed files.
Thread-Topic: [PATCH v6 04/12] fsmonitor: teach git to optionally utilize a
 file system monitor to speed up detecting new or changed files.
Thread-Index: AQHTLlfZ9UY7A3HP7kmYSR3gNLzDdaK2XgUA
Date:   Fri, 15 Sep 2017 21:35:24 +0000
Message-ID: <850c2ad20acc4c14be87a767af851b19@exmbdft7.ad.twosigma.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-5-benpeart@microsoft.com>
In-Reply-To: <20170915192043.4516-5-benpeart@microsoft.com>
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
> From: Ben Peart [mailto:benpeart@microsoft.com]
> Sent: Friday, September 15, 2017 3:21 PM
> To: benpeart@microsoft.com
> Cc: David Turner <David.Turner@twosigma.com>; avarab@gmail.com;
> christian.couder@gmail.com; git@vger.kernel.org; gitster@pobox.com;
> johannes.schindelin@gmx.de; pclouds@gmail.com; peff@peff.net
> Subject: [PATCH v6 04/12] fsmonitor: teach git to optionally utilize a file system
> monitor to speed up detecting new or changed files.
 
> +int git_config_get_fsmonitor(void)
> +{
> +	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
> +		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");
> +
> +	if (core_fsmonitor && !*core_fsmonitor)
> +		core_fsmonitor = NULL;
> +
> +	if (core_fsmonitor)
> +		return 1;
> +
> +	return 0;
> +}

This functions return values are backwards relative to the rest of the git_config_* functions.

[snip]

+>	/*
+>	 * With fsmonitor, we can trust the untracked cache's valid field.
+>	 */

[snip]

> +int read_fsmonitor_extension(struct index_state *istate, const void *data,
> +	unsigned long sz)
> +{

If git_config_get_fsmonitor returns 0, fsmonitor_dirty will leak.

[snip]

> +	/* a fsmonitor process can return '*' to indicate all entries are invalid */

That's not documented in your documentation.  Also, I'm not sure I like it: what 
if I have a file whose name starts with '*'?  Yeah, that would be silly, but this indicates the need 
for the protocol to have some sort of signaling mechanism that's out-of-band  Maybe 
have some key\0value\0 pairs and then \0\0 and then the list of files?  Or, if you want to keep
it really simple, allow an entry of '/' (which is an invalid filename) to mean 'all'.

> +void add_fsmonitor(struct index_state *istate) {
> +	int i;
> +
> +	if (!istate->fsmonitor_last_update) {
[snip]
> +		/* reset the untracked cache */

Is this really necessary?  Shouldn't the untracked cache be in a correct state already? 

> +/*
> + * Clear the given cache entries CE_FSMONITOR_VALID bit and invalidate

Nit: "s/entries/entry's/".
 

