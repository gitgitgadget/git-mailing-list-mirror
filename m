Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD1F1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 21:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfBHVm3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 16:42:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:49922 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBHVm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 16:42:29 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18LgQIq095755
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 16:42:26 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Cc:     "'Duy Nguyen'" <pclouds@gmail.com>
Subject: [Possible Breakage] t1308 - Bad return value from test-tool
Date:   Fri, 8 Feb 2019 16:42:19 -0500
Message-ID: <004901d4bff7$2e17dc50$8a4794f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdS/9a1xUTNtfmgeTPKgN+Mlw1xe5A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t1308 has me perplexed - this is an old breakage on the NonStop platform,
that I have just gotten around to checking with the new bash version we
have. When running sub-test 23, the following was reported:

Value not found for "foo.bar"
test_expect_code: command exited with 1, we wanted 2 test-tool config
configset_get_value foo.bar a-directory

However, when I looked inside t/helper/test-config.c, every path reporting
"Value not found" has a goto exit1 not exit2. It seems, from the code, that
the test is actually incorrect and should be expecting 1 not 2, and that it
is working properly on NonStop (but the test fails as a result).

What is perplexing is that someone else should be seeing this. The
test-config.c code is about 5 years old, but the test was modified a year or
two ago. What am I missing here?

Cheers,
Randall



