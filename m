Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83D3B1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 16:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeCWQaD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 12:30:03 -0400
Received: from siwi.pair.com ([209.68.5.199]:55876 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbeCWQaC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 12:30:02 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A67023F400B;
        Fri, 23 Mar 2018 12:30:01 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 21A843F400A;
        Fri, 23 Mar 2018 12:30:01 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3] routines to generate JSON data
Date:   Fri, 23 Mar 2018 16:29:51 +0000
Message-Id: <20180323162952.81443-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is version 3 of my JSON data format routines.

This version addresses the variable name changes in [v2] and adds additional
test cases.  I also changed the BUG() calls to die() to help with testing.

The json-writer routines can be used generate structured data in a JSON-like
format.  I say "JSON-like" because we don't enforce the Unicode/UTF-8
requirement [3,4] on string values.  This was discussed on the mailing list
in the [v1] and [v2] threads, but to summarize here: Git doesn't know if
various fields, such as Unix pathnames and author names, are Unicode or just
8-bit character data, so Git would not know how to properly encode such
fields and the consumer of such output would not know these strings were
encoded (once or twice).  So, until we have a pressing need to generate
proper Unicode data, we avoid it for now.

The initial use for the json-writer routines is for generating telemetry data
for executed Git commands.  Later, we might want to use them in other commands
such as status.

[v1] https://public-inbox.org/git/20180316194057.77513-1-git@jeffhostetler.com/
[v2] https://public-inbox.org/git/20180321192827.44330-1-git@jeffhostetler.com/
[3]  http://www.ietf.org/rfc/rfc7159.txt
[4]  http://json.org/


Jeff Hostetler (1):
  json_writer: new routines to create data in JSON format

 Makefile                    |   2 +
 json-writer.c               | 321 +++++++++++++++++++++++++++++++++
 json-writer.h               |  86 +++++++++
 t/helper/test-json-writer.c | 420 ++++++++++++++++++++++++++++++++++++++++++++
 t/t0019-json-writer.sh      | 213 ++++++++++++++++++++++
 5 files changed, 1042 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh

-- 
2.9.3

