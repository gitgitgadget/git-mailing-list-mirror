Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18921F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932908AbcJNNUZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753454AbcJNNSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:09 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31122B8901
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 13:17:12 +0000 (UTC)
Received: from pirat-work.redhat.com (vpn1-4-60.ams2.redhat.com [10.36.4.60])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9EDHAJh008901;
        Fri, 14 Oct 2016 09:17:11 -0400
From:   Petr Stodulka <pstodulk@redhat.com>
To:     git@vger.kernel.org
Cc:     pstodulk@redhat.com
Subject: [PATCH 0/2]  infinite loop in "git ls-tree" for broken symlink
Date:   Fri, 14 Oct 2016 15:16:50 +0200
Message-Id: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 14 Oct 2016 13:17:12 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I have realized that this wasn't fixed after all when refs.c
was "rewritten". Issue is caused by broken symlink under refs/heads,
which causes infinite loop for "git ls-tree" command. It was replied
earlier [0] and Michael previously fixed that in better way probably,
then my proposed patch 2/2, but it contains more changes and I have not
enough time to study changes in refs* code, so I propose now just my
little patch, which was previously modified by Michael.

If you prefer different solution, I am ok with this. It is really
just quick proposal. Patch 1/2 contains test for this issue. If you
will prefer different solution with different exit code, test should
be corrected. Basic idea is, that timeout should'n expire with
exit code 124.

[0] http://marc.info/?l=git&m=142712669103790&w=2
[1] https://github.com/mhagger/git, branch "ref-broken-symlinks"

Michael Haggerty (1):
  resolve_ref_unsafe(): limit the number of "stat_ref" retries

Petr Stodulka (1):
  Add test for ls-tree with broken symlink under refs/heads

 refs/files-backend.c    | 6 ++++--
 refs/refs-internal.h    | 6 ++++++
 t/t3103-ls-tree-misc.sh | 9 +++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.5.5

