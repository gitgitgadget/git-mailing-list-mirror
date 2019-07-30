Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82FA1F97E
	for <e@80x24.org>; Tue, 30 Jul 2019 17:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfG3RIw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 30 Jul 2019 13:08:52 -0400
Received: from elephants.elehost.com ([216.66.27.132]:59491 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfG3RIw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 13:08:52 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x6UH8gJ2078696
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 13:08:43 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
Subject: RE: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Date:   Tue, 30 Jul 2019 13:08:37 -0400
Message-ID: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdVG+JQxeN+w6GAoT+abVzFdfKga8A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

A preview of the situation with testing 2.23.0.rc0 on NonStop is not great. We have had some new failures right off the bat on our NonStop platforms. This is a preview of what we find within the first bit of testing. The tests run a long time, so more to come.

t0016: oidmap

Subtest 6 had an ordering issue. We do not know whether the problem is the code or the test result not keeping up with the code changes.
--- expect      2019-07-30 16:56:36 +0000
+++ actual      2019-07-30 16:56:36 +0000
@@ -1,6 +1,6 @@
 NULL
 NULL
 NULL
+7c7cd714e262561f73f3079dfca4e8724682ac21 3
 139b20d8e6c5b496de61f033f642d0e3dbff528d 2
 d79ce1670bdcb76e6d1da2ae095e890ccb326ae9 1
-7c7cd714e262561f73f3079dfca4e8724682ac21 3


t0066: dir-iterator

Subtest 4 depends on a non-portable error code. ENOENT is not guaranteed to be the same on all systems. It is 4002 on NonStop and 2 on many other machines.
--- expected-inexistent-path-output     2019-07-30 16:58:51 +0000
+++ actual-inexistent-path-output       2019-07-30 16:58:50 +0000
@@ -1 +1 @@
-dir_iterator_begin failure: 2
+dir_iterator_begin failure: 4002

Subtest 5 also depends on a non-portable error code. ENOTDIR is not guaranteed to be the same on all systems. It is 4020 on NonStop and 20 on many other machines.
--- expected-non-dir-output     2019-07-30 16:58:51 +0000
+++ actual-non-dir-output       2019-07-30 16:58:51 +0000
@@ -1 +1 @@
-dir_iterator_begin failure: 20
+dir_iterator_begin failure: 4020

Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



