Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73A21F517
	for <e@80x24.org>; Sat,  2 Jun 2018 21:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeFBVgB (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 17:36:01 -0400
Received: from p3plsmtpa09-10.prod.phx3.secureserver.net ([173.201.193.239]:59811
        "EHLO p3plsmtpa09-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750886AbeFBVgB (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Jun 2018 17:36:01 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jun 2018 17:36:01 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id PE4if9a6maUaoPE4nfBxVg; Sat, 02 Jun 2018 14:28:43 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v7 0/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Sun,  3 Jun 2018 00:27:47 +0300
Message-Id: <20180602212749.21324-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-Reply-To: 20171126193813.12531-1-max@max630.net
X-CMAE-Envelope: MS4wfN4tMEb/WWBKSYiTyXqLzaT9OTJSze1byl67gwB/7piHiNPe201Crh6btAlAu+hD2pRsrbdTM6y8us5mNHcU4BgKAXmu9KVeWciZ1Hi6tcIp5UMlBow0
 CMGwv86YBMHvgxIIP7i+sBaCg7xs/4smxtbEh401IvzJPYlNGCL/PliNCtaLv7AcAGIcdDHZr/hDG88FnwYrthmb3cRVTujdnmSkyRtVOnMVxvZ2yujPhGq3
 pDLLMXEailUm+4MsO60xvQDSfN+/j7iEt1bfmSrDCcexD6i53tJnPKLupYmU6M98EAYIotgF0OtV0Rgru6eErtUq4xcpGq4dH3scM5EMWjU00eDA9bGDT1ZW
 uQ6nCEBpgnUcHKT5Sjld+/2jjTXNeZyUt/XYlI8kyxyvhSv1sYY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been time. Thank you for parience.

Changes:

* did most of the changes proposed
* rebase to newer master (latest conflicting change is addition of combined test helper)
* make tests which cover, hopefully, all cases.
* handle incorectly truncated input also in receive-pack. Considering the complications
  pointed out by Jeff, it just filters the input in the frontend process. I hope it
  is acceptable thing to do.

Max Kirillov (2):
  http-backend: respect CONTENT_LENGTH as specified by rfc3875
  http-backend: respect CONTENT_LENGTH for receive-pack

 Makefile                                |   1 +
 config.c                                |   2 +-
 config.h                                |   1 +
 http-backend.c                          |  86 +++++++++++--
 t/helper/test-print-larger-than-ssize.c |  11 ++
 t/helper/test-tool.c                    |   1 +
 t/helper/test-tool.h                    |   1 +
 t/t5560-http-backend-noserver.sh        |  13 ++
 t/t5562-http-backend-content-length.sh  | 155 ++++++++++++++++++++++++
 t/t5562/invoke-with-content-length.pl   |  30 +++++
 10 files changed, 291 insertions(+), 10 deletions(-)
 create mode 100644 t/helper/test-print-larger-than-ssize.c
 create mode 100755 t/t5562-http-backend-content-length.sh
 create mode 100755 t/t5562/invoke-with-content-length.pl

-- 
2.17.0.1185.g782057d875

