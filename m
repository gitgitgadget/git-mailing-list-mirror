Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57FC2022D
	for <e@80x24.org>; Fri, 18 Nov 2016 23:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbcKRXIa (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 18:08:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:37381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753047AbcKRXI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 18:08:28 -0500
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP; 18 Nov 2016 15:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,660,1473145200"; 
   d="scan'208";a="33066054"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga005.fm.intel.com with ESMTP; 18 Nov 2016 15:08:27 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 0/2] add format specifiers to display trailers
Date:   Fri, 18 Nov 2016 15:08:23 -0800
Message-Id: <20161118230825.20952-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.rc2.152.g4d04e67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

This is based off of jt/use-trailer-api-in-commands so that we can make
use of the public trailer API that will parse a string for trailers.

I use trailers as a way to store extra commit metadata, and would like a
convenient way to obtain the trailers of a commit message easily. This
adds format specifiers to both the ref-filter API and the pretty
formats. I am not a fan of %bT but %t and %T were already taken. I don't
really know if it's ok to use %bT, since I think we used to allow "%bT"
format, though i don't think this is likely used much in practice.

I am open to suggestions for the pretty format specifier.

Additionally, I am somewhat not a fan of the way that if you have a
series of trailers which are trailer format, but not recognized, such
as the following:

<text>

My-tag: my value
My-other-tag: my other value
[non-trailer line]
My-tag: my third value

---

Git interpret-trailers will not recognize this as a trailer block
because it doesn't have any standard git tags within it. Would it be ok
to augment the trailer interpretation to say that if we have over 75%
trailers in the block that we accept it even if it doesn't have any real
recognized tags?

I say this because I regularly use extra tags in my git projects to
represent change metadata, and it would be nice if the tag block could
be recognized even if it has 1-2 lines of non-trailer formatting in
it...

Thoughts?

Jacob Keller (2):
  pretty: add %bT format for displaying trailers of a commit message
  ref-filter: add support to display trailers as part of contents

 Documentation/git-for-each-ref.txt |  2 ++
 Documentation/pretty-formats.txt   |  1 +
 pretty.c                           | 18 ++++++++++++++++++
 ref-filter.c                       | 22 +++++++++++++++++++++-
 t/t4205-log-pretty-formats.sh      | 26 ++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 26 ++++++++++++++++++++++++++
 6 files changed, 94 insertions(+), 1 deletion(-)

-- 
2.11.0.rc2.152.g4d04e67

