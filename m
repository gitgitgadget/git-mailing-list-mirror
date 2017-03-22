Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2579C20323
	for <e@80x24.org>; Wed, 22 Mar 2017 13:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934758AbdCVNlB (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 09:41:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:49328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934556AbdCVNk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 09:40:59 -0400
Received: (qmail 28486 invoked by uid 109); 22 Mar 2017 13:34:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 13:34:16 +0000
Received: (qmail 26101 invoked by uid 111); 22 Mar 2017 13:34:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 09:34:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 09:34:12 -0400
Date:   Wed, 22 Mar 2017 09:34:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v6 24/27] t/helper: add test-ref-store to test ref-store
 functions
Message-ID: <20170322133412.e2oqmqekreyuf4gr@sigill.intra.peff.net>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-25-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170318020337.22767-25-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 09:03:34AM +0700, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> new file mode 100644

When nd/files-backend-git-dir is merged to 'next', the new tests in
t1405/t1406 break. They need this on top (which should probably just be
squashed into this commit when you re-roll).

-- >8 --
Subject: [PATCH] test-ref-store: setup git directory

Without setting up the git directory, we rely on the ".git"
fallback in setup_git_env(). This will cause us to abort
once b1ef400ee (setup_git_env: avoid blind fall-back to
".git", 2016-10-20) is merged.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-ref-store.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 57849ee59..2d84c45ff 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -261,6 +261,8 @@ int cmd_main(int argc, const char **argv)
 	const char *func;
 	struct command *cmd;
 
+	setup_git_directory();
+
 	argv = get_store(argv + 1, &refs);
 
 	func = *argv++;
-- 
2.12.1.788.g3cf5b5ec6

