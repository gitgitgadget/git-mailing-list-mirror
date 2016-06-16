Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7A751FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 20:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbcFPUde (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 16:33:34 -0400
Received: from kitenet.net ([66.228.36.95]:44980 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbcFPUdd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 16:33:33 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=QEMDTDyJ;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466109184; bh=KLmlK0uvCzmL6PEf3Hw/BcIhQS9GLhcqLiUIyZxLkw4=;
	h=From:To:Cc:Subject:Date:From;
	b=QEMDTDyJj2UxQ6ZlTmc9X2JUta8xUiAnh6DEWN7yACtA1C3/8TNZklibzP7KNuPz/
	 TWzXIgNOb8ZRDuS9JuWSALzZy+jOy5X+aFOHjkibRs397+vufY3fDFXAmyT45vpSzS
	 W3Ijmc3pi7xSDiYLGFSXep66pjJJAhC8xvPOk1DA=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH 0/4] extend smudge/clean filters with direct file access
Date:	Thu, 16 Jun 2016 16:32:55 -0400
Message-Id: <20160616203259.5886-1-joeyh@joeyh.name>
X-Mailer: git-send-email 2.9.0.4.g2856e74.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

As discussed in this thread:
http://thread.gmane.org/gmane.comp.version-control.git/294425
This adds smudge-to-file and clean-from-file commands supplimenting the
smudge and clean filters.

This interface can be much more efficient when operating on large files,
because the whole file content does not need to be streamed through the
filter. It even allows for things like clean-from-file commands that avoid
reading the whole content of the file, and for smudge-to-file commands that
populate a work tree file using an efficient Copy On Write operation.

Joey Hess (4):
  clarify %f documentation
  add smudge-to-file and clean-from-file filter configuration
  use clean-from-file in git add
  use smudge-to-file in git checkout etc

 Documentation/config.txt        |  27 +++++++---
 Documentation/gitattributes.txt |  44 ++++++++++++++++-
 convert.c                       | 107 ++++++++++++++++++++++++++++++++++------
 convert.h                       |  10 ++++
 entry.c                         |  34 ++++++++++---
 sha1_file.c                     |  42 +++++++++++++---
 t/t0021-conversion.sh           |  64 ++++++++++++++++++++++++
 7 files changed, 292 insertions(+), 36 deletions(-)

-- 
2.9.0.4.g2856e74.dirty

