Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A711207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754803AbdEEP2R (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:28:17 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34802 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753362AbdEEP2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:28:15 -0400
Received: by mail-qt0-f195.google.com with SMTP id l39so1235296qtb.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ON/jVuZ/5g/lQp9BTDsODHjG413QwN+XFd0jNuTaT3Y=;
        b=s8+LQF2UYRcFoNmyrnIdZJ7Y34cc3L2T1+pxCKiG+9LXIa32hyb8NLHid1UmG2R64G
         oEsOYtlo+8kzVaG6s5PFEyvS9h5q5qW3CzLnxfToQuO27SjHdQ+IiqkszAAAivJtVUXI
         6Fhc5RZrh/SPZJa9dvmDeROpLPlxr86qVlWOAs3xAGcYl0io5EXepMtn2TY9adLT3rJ5
         lhI5TiRF5AMM6xyPrT6w/Ol01j9iZ/Yo5Od3tuenTEEp9Z6qtykigDWq1UC9trXSyREd
         evipcEP7A4vNFhYlqg2QRxR2WqWBn8LerUcdu6BGFlMrWB1U1DQipd5qDXgy8QkSc5Kh
         pQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ON/jVuZ/5g/lQp9BTDsODHjG413QwN+XFd0jNuTaT3Y=;
        b=m4uIIZz952bpsYkTjIGJrXgghZ53NKq1sDLULNGS0XJznwYmVMnKlh8ducuFL/B3My
         +Gkhjod6yIqXuVHhRMJ+MlVXSFT/Y4bb98tHIKe23MDVnqE5JwVy0w6odreewVa5xtxt
         bDnPynCi/n7c/53LybaXzzE6Cwu2vWOqHds37QNaT1GQV/gvXpuBcR94yKVfjflGSPXL
         FGFeBlKj/e6oxEL994+qBGxvuQUBv4a9lonqh50pc0CEIpPBHA6u1F5jH14g53FnOCpW
         1nqZCBa0K83t3CupvA4d7VdTxFMM4nXJL5Un9Sez7EMnvgojJMeOK4grzEszccEX7nHG
         OmdA==
X-Gm-Message-State: AN3rC/4WKh1FaRUDFqAKDYwby1XF57j9QuWtIOgE3x4eIz3ZVil7YNp7
        A/LsobXofoQuBg==
X-Received: by 10.237.63.20 with SMTP id p20mr45312052qtf.98.1493998094846;
        Fri, 05 May 2017 08:28:14 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t68sm3392792qkc.44.2017.05.05.08.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:28:13 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: [PATCH v7 00/10] refactor the filter process code into a reusable module
Date:   Fri,  5 May 2017 11:27:52 -0400
Message-Id: <20170505152802.6724-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.2.gvfs.2.20.g3624a68d62.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from V6 include:

convert: remove erroneous tests for errno == EPIPE
 - split into separate patch to fix a preexisting bug discovered in the review process

pkt-line: Update packet_read_line() to test for len > 0
 - split into separate patch to deal with errors that return negative lengths

pkt-line: add packet_read_line_gently()
 - update documentation to clarify return values
 - update white space in function definition


Refactor the filter.<driver>.process code into a separate sub-process
module that can be used to reduce the cost of starting up a sub-process
for multiple commands.  It does this by keeping the external process
running and processing all commands by communicating over standard input
and standard output using the packet format (pkt-line) based protocol.
Full documentation is in Documentation/technical/api-sub-process.txt.

This code is refactored from:

	Commit edcc85814c ("convert: add filter.<driver>.process option", 2016-10-16)
	keeps the external process running and processes all commands

Ben Peart (10):
  convert: remove erroneous tests for errno == EPIPE
  pkt-line: fix packet_read_line() to handle len < 0 errors
  pkt-line: add packet_read_line_gently()
  convert: move packet_write_line() into pkt-line as packet_writel()
  convert: split start_multi_file_filter() into two separate functions
  convert: Separate generic structures and variables from the filter
    specific ones
  convert: Update generic functions to only use generic data structures
  convert: rename reusable sub-process functions
  sub-process: move sub-process functions into separate files
  convert: Update subprocess_read_status to not die on EOF

 Documentation/technical/api-sub-process.txt |  59 ++++++++++
 Makefile                                    |   1 +
 convert.c                                   | 161 ++++++----------------------
 pkt-line.c                                  |  33 +++++-
 pkt-line.h                                  |  12 +++
 sub-process.c                               | 106 ++++++++++++++++++
 sub-process.h                               |  49 +++++++++
 7 files changed, 292 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/technical/api-sub-process.txt
 create mode 100644 sub-process.c
 create mode 100644 sub-process.h

-- 
2.12.2.gvfs.2.20.g3624a68d62.dirty

