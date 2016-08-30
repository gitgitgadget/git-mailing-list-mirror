Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCCC71F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755670AbcH3QMk (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 12:12:40 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:59553 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754557AbcH3QMj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Aug 2016 12:12:39 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 244CB12BD1C
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 16:12:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: class40_512126094185c
X-Filterd-Recvd-Size: 1392
Received: from XPS-9350.home (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 16:12:37 +0000 (UTC)
Message-ID: <1472573556.5512.93.camel@perches.com>
Subject: git am and duplicate signatures
From:   Joe Perches <joe@perches.com>
To:     git <git@vger.kernel.org>
Date:   Tue, 30 Aug 2016 09:12:36 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-am -s will avoid duplicating the last signature
in a patch.

But given a developer creates a patch, send it around for
acks/other signoffs, collects signatures and then does
a git am -s on a different branch, this sort of sign-off
chain is possible:

	Signed-off-by: Original Developer <od@domain.com>
	Acked-by: Random Developer <rd@domain.com>
	Signed-off-by: Original Developer <od@domain.com>

Should there be an option to avoid duplicate signatures
in a sequence where an author can git-am the same patch?

sequencer.c:append_signoff() has a flag for APPEND_SIGNOFF_DEDUP

sequencer.c:void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)

but

builtin/commit.c:               append_signoff(&sb, ignore_non_trailer(&sb), 0);

doesn't have an optional use mechanism available.

