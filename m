Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C776A1F89C
	for <e@80x24.org>; Sun, 22 Jan 2017 02:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbdAVCmK (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 21:42:10 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39230 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750846AbdAVCmI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2017 21:42:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 22388280AC;
        Sun, 22 Jan 2017 02:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485052925;
        bh=vkXlm/Txl1TpuPNCWjgdTZIxYaqJYsu5NnIu8rYLsp8=;
        h=From:To:Cc:Subject:Date:From;
        b=x5SAvZNuk4BO/A7my17V6Qa/sz3KUL8tK3t+xlZNwEORQN/GJqur1CNmVuiLvrwLe
         AZMHwV+FA8Qh17zsElySGBPceiU5skd25z+E2g06/rqMjpHgV+LOjS6hF5i+eujlzP
         FZXWuJD0f87WdwW6TuXpc2gXDYrzQpF6A6clbhMQrpvdukoYAmubCwVumV7jxlUSMW
         7NsZ/L5zXGiDuzP10WlRRvrPc4Fcrd4tCDOIw08rjbzmy5BN83ma/R1h0Vis3xdDRz
         tIsGkQBzoQlx2zdz+iPgujcg4AgToZnnHoJMZS+2AO1OBdqpoe7C16z0s3msFcgAa7
         JlmhlU09OcoOgpIxRG7grBbq6/3XhJmf5bRmB1KM01PzGv9XtlSZdu+xVKR4+1XDPv
         8UMK1cijRa6iIAMTaKEqKn74LwfcIa2ykKJ8AfcdYjvAnJPpF3GxNg+vWpyXRvHyrr
         ZyLTt8+EnHsQnY9F7QMOgKa87k3z0VCN2M3JkjCtiHIt8nsUhUf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 0/7] Macros for Asciidoctor support
Date:   Sun, 22 Jan 2017 02:41:49 +0000
Message-Id: <20170122024156.284180-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two major processors of AsciiDoc: AsciiDoc itself, and Asciidoctor.
Both have advantages and disadvantages, but traditionally the documentation has
been built with AsciiDoc, leading to some surprising breakage when building with
Asciidoctor.  Partially, this is due to the need to specify a significant number
of macros on the command line when building with Asciidoctor.

This series cleans up some issues building the documentation with Asciidoctor
and provides two knobs, USE_ASCIIDOCTOR, which controls building with
Asciidoctor, and ASCIIDOCTOR_EXTENSIONS_LAB, which controls the location of the
Asciidoctor Extensions Lab, which is necessary to expand the linkgit macro.

The need for the extensions could be replaced with a small amount of Ruby code,
if that's considered desirable.  Previous opinions on doing so were negative,
however.

In the process, I found several issues with cat-texi.perl, which have been
fixed.  It has also been modernized to use strict, warnings, and lexical file
handles.  I also made an attempt to produce more diffable texi files; I may
follow up with additional series along this line to make the documentation build
reproducibly.

Changes from v1:
* Fix a brown-paper-bag bug.

brian m. carlson (7):
  Documentation: fix warning in cat-texi.perl
  Documentation: modernize cat-texi.perl
  Documentation: remove unneeded argument in cat-texi.perl
  Documentation: sort sources for gitman.texi
  Documentation: add XSLT to fix DocBook for Texinfo
  Documentation: move dblatex arguments into variable
  Makefile: add a knob to enable the use of Asciidoctor

 Documentation/Makefile      | 22 ++++++++++++++++++----
 Documentation/cat-texi.perl | 21 ++++++++++++---------
 Documentation/texi.xsl      | 26 ++++++++++++++++++++++++++
 Makefile                    |  6 ++++++
 4 files changed, 62 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/texi.xsl

