Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C840E1F404
	for <e@80x24.org>; Mon,  1 Jan 2018 21:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeAAVVd (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 16:21:33 -0500
Received: from elephants.elehost.com ([216.66.27.132]:37255 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeAAVVc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 16:21:32 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w01LLTD4035746
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 1 Jan 2018 16:21:29 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git mailing list'" <git@vger.kernel.org>
Subject: [Bug] NO_INTPTR_T not being honoured in compat/regex/regcomp.c
Date:   Mon, 1 Jan 2018 16:21:25 -0500
Message-ID: <004701d38346$7dd4be00$797e3a00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdODQ1D2C2ebOBe6SeS59gxudaCncg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm looking for the proper approach for dealing with the following situation
in 2.8.5:
* I have defined NO_INTPTR_T = UnfortunatelyYes in config.mak.uname for my
platform. The c99 compiler I have does not define it.
* The code compiles except for compat/regex/regcomp.c - not sure why this is
being used since I have also *not* defined NO_REGEX because regex is sane
here.
* If I include git-compat-util.h, where intptr_t is defined, in this
compile, loads of other compile problems result.
* To get around the compile problem, I have wrapped the definition of
intptr_t as follows, temporarily, duplicating content from git-compat-util.h
        #include <stdint.h>
        #if defined __TANDEM
        #ifdef NO_INTPTR_T
        typedef long intptr_t;
        typedef unsigned long uintptr_t;
        #endif
        #endif

So the question now is how best to handle this long term. I'm slowly porting
up to 2.16 - hoping a week or two until I get there with the mods required
and running tests and all. It does not look like the issue of intptr_t is
subsequently resolved in regcomp.c (other than #include <stdint.h> being
removed), so this is going to continue to haunt me as a problem. There are
loads of ways of dealing with it, but I'd like to fix this in a way that
best follows the team's standards. So...

1. I'd rather not worry about regcomp.c, but don't know why it's still
somehow required. 
2. git-compat-util.h is pretty heavy just for intptr_t in this module.
Refactoring might be an option.

Thanks,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.


