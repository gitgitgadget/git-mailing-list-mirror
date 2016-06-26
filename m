Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FA5D20179
	for <e@80x24.org>; Sun, 26 Jun 2016 23:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbcFZXV1 (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 19:21:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58142 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbcFZXV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 19:21:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639D720179;
	Sun, 26 Jun 2016 23:21:25 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/2] wrapper: xread/xwrite fixes for non-blocking FDs
Date:	Sun, 26 Jun 2016 23:21:10 +0000
Message-Id: <20160626232112.721-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

1/2 fixes a bug introduced in commit 1079c4be0b720
("xread: poll on non blocking fds") where the "continue"
got dropped.

I noticed the 1/2 bug while working on 2/2 and intentionally
triggering EAGAIN on a custom HTTP server to test 100% CPU
usage.  I originally blindly copied the branch from xread
into xwrite without the "continue" and was greeted with a
failed clone.

Eric Wong (2):
      xread: retry after poll on EAGAIN/EWOULDBLOCK
      xwrite: poll on non-blocking FDs

 wrapper.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)
