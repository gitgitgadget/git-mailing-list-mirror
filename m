Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00241C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C34223BE
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dpbS16go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgFSWwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:52:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39824 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729746AbgFSWwC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 18:52:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5F7736048A;
        Fri, 19 Jun 2020 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592607090;
        bh=Q/nkYx3TRPYBLfpfGClVMfH8zjh0fvG0JvZJ+Vtnft4=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dpbS16go39t/HKtjhyDdqMMr9z/Ks9tCsrQj5EaNwLPNltwV0aEOFEFqqKYz/xpTT
         NAcbYrYR0hYnUaekBQ9ysu0eeZShEqzO5UB3/JmA8xNgX+Tb9lKMQi3mCBO4QbNObC
         1bonrXoZhaeag7LJbzASpJWCfo96FetX3+1re7NZHiofUxbHx/qKLt3EBEM8wAbFLI
         wXtWC5sbsCI8eTBwL0VCWLhZ3Re66QrRslrQxWlp5VukLIwIiNNN2m4TVjAE3L7uk8
         zp6l8qW4L5G5e+2G4SN70VFyfmoQ8mW1B5W230YbYBIYNaMZR37IxUhzLU9mJxqNha
         2jFdhZpqHPKqN2+E+9ezygAXNwgqz+AUZDd6lBPs9Vr9QVnY3EA4p4qxjwU5xlsMBy
         lpjAm4BeWkrQ7RX0JQDVH2FtdSGwzho2Ec8DDGjLKaGsxAO9E+UBhUBlev28mniMZh
         SqwztC+PzwNTLOPnpjkdU+PRD/E0oYRMHP5YmhmJS61bUQe8OBf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 00/14] SHA-256 CVS and SVN patches
Date:   Fri, 19 Jun 2020 22:39:33 +0000
Message-Id: <20200619223947.947067-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently sent out part 2/3 of the SHA-256 work and then I realized
that I hadn't built with the CVS and SVN adapters.  So this is part
2.5/3 (or, to be pedantic, 3/4).

The patches are ordered roughly with test-only fixes, then SVN, and then
CVS.  There are no additional tests here because everything fails with
SHA-256 before and passes afterwards.

brian m. carlson (14):
  t9109: make test hash independent
  t9168: make test hash independent
  t9108: make test hash independent
  t9100: make test work with SHA-256
  t9104: make hash size independent
  t9101: make hash independent
  t/lib-git-svn: make hash size independent
  perl: create and switch variables for hash constants
  perl: make Git::IndexInfo work with SHA-256
  perl: make SVN code hash independent
  git-svn: set the OID length based on hash algorithm
  git-cvsserver: port to SHA-256
  git-cvsimport: port to SHA-256
  git-cvsexportcommit: port to SHA-256

 git-cvsexportcommit.perl                   | 14 ++--
 git-cvsimport.perl                         |  8 +--
 git-cvsserver.perl                         | 37 +++++-----
 git-svn.perl                               | 25 ++++---
 perl/Git/IndexInfo.pm                      |  6 +-
 perl/Git/SVN.pm                            | 83 +++++++++++-----------
 perl/Git/SVN/Editor.pm                     |  8 +--
 perl/Git/SVN/Fetcher.pm                    |  6 +-
 perl/Git/SVN/Log.pm                        |  2 +-
 perl/Git/SVN/Ra.pm                         |  4 +-
 t/lib-git-svn.sh                           | 25 +++----
 t/t9100-git-svn-basic.sh                   | 19 ++++-
 t/t9101-git-svn-props.sh                   | 12 ++--
 t/t9104-git-svn-follow-parent.sh           |  3 +-
 t/t9108-git-svn-glob.sh                    |  4 +-
 t/t9109-git-svn-multi-glob.sh              |  6 +-
 t/t9168-git-svn-partially-globbed-names.sh |  8 +--
 17 files changed, 154 insertions(+), 116 deletions(-)

