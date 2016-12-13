Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5B3203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964883AbcLMSGS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 13 Dec 2016 13:06:18 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:51737 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964872AbcLMSGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:06:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 4B7BC100043;
        Tue, 13 Dec 2016 18:06:13 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ppVdar4yJ6dH; Tue, 13 Dec 2016 18:06:13 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 3B29180035;
        Tue, 13 Dec 2016 18:06:13 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Tue, 13 Dec 2016 18:06:12 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%25]) with mapi id
 15.00.1156.000; Tue, 13 Dec 2016 18:06:12 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "bmwill@google.com" <bmwill@google.com>
Subject: RE: [PATCH 6/6] rm: add absorb a submodules git dir before deletion
Thread-Topic: [PATCH 6/6] rm: add absorb a submodules git dir before deletion
Thread-Index: AQHSVOH5YMnWXL2+iE6a6MqGA2ZOpqEGLL0g
Date:   Tue, 13 Dec 2016 18:06:12 +0000
Message-ID: <15196def9a7f4458b053b2d1e182541c@exmbdft7.ad.twosigma.com>
References: <20161213014055.14268-1-sbeller@google.com>
 <20161213014055.14268-7-sbeller@google.com>
In-Reply-To: <20161213014055.14268-7-sbeller@google.com>
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
> From: Stefan Beller [mailto:sbeller@google.com]
> Sent: Monday, December 12, 2016 8:41 PM
> To: gitster@pobox.com
> Cc: git@vger.kernel.org; David Turner; bmwill@google.com; Stefan Beller
> Subject: [PATCH 6/6] rm: add absorb a submodules git dir before deletion
> 
> When deleting a submodule we need to keep the actual git directory around,

Nit: comma after submodule.

> -					strbuf_reset(&buf);
> -					strbuf_addstr(&buf, path);
> -					if (!remove_dir_recursively(&buf, 0)) {
> -						removed = 1;
> -						if
> (!remove_path_from_gitmodules(path))
> -							gitmodules_modified = 1;
> -						strbuf_release(&buf);
> -						continue;
> -					} else if (!file_exists(path))
> -						/* Submodule was removed by user */
> -						if
> (!remove_path_from_gitmodules(path))
> -							gitmodules_modified = 1;
> +					if (file_exists(path))
> +						depopulate_submodule(path);
> +					removed = 1;
> +					if (!remove_path_from_gitmodules(path))
> +						gitmodules_modified = 1;
> +					continue;
>  					/* Fallthrough and let remove_path() fail.
> */

It seems odd to have a continue right before a comment that says "Fallthrough".  

