Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1200F1F428
	for <e@80x24.org>; Tue,  2 Jan 2018 23:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeABXjg (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 18:39:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:51176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751116AbeABXjf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 18:39:35 -0500
Received: (qmail 17739 invoked by uid 109); 2 Jan 2018 23:39:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Jan 2018 23:39:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20440 invoked by uid 111); 2 Jan 2018 23:40:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 02 Jan 2018 18:40:05 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jan 2018 18:39:32 -0500
Date:   Tue, 2 Jan 2018 18:39:32 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Stephan Janssen <sjanssen@you-get.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] clone: do not clean up directories we didn't create
Message-ID: <20180102233932.GA27884@sigill.intra.peff.net>
References: <20180102210753.GA10430@sigill.intra.peff.net>
 <20180102211139.GD22556@sigill.intra.peff.net>
 <CAPig+cQOU7d21kDELtFAkM0qJh8pvj7F56oWVYw+kYiUftQEuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQOU7d21kDELtFAkM0qJh8pvj7F56oWVYw+kYiUftQEuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 02, 2018 at 05:49:45PM -0500, Eric Sunshine wrote:

> > diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
> > @@ -42,13 +53,48 @@ test_expect_success 'successful clone must leave the directory' '
> > +test_expect_success 'failed clone into empty leaves directory (separate, git)' '
> > +       mkdir -p empty-git &&
> > +       corrupt_repo &&
> > +       test_must_fail git clone --separate-git-dir empty-git foo no-wt &&
> > +       test_dir_is_empty empty-git &&
> > +       test_path_is_missing no-wt
> > +'
> > +
> > +test_expect_success 'failed clone into empty leaves directory (separate, git)' '
> > +       mkdir -p empty-wt &&
> > +       corrupt_repo &&
> > +       test_must_fail git clone --separate-git-dir no-git foo empty-wt &&
> > +       test_path_is_missing no-git &&
> > +       test_dir_is_empty empty-wt
> > +'
> 
> The final two tests seem to have the same title...

Oops. The second one should be "wt" (since the idea was to flip the
logic from the previous). Like so:

diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 5cd94d5558..4a1a912e03 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -89,7 +89,7 @@ test_expect_success 'failed clone into empty leaves directory (separate, git)' '
 	test_path_is_missing no-wt
 '
 
-test_expect_success 'failed clone into empty leaves directory (separate, git)' '
+test_expect_success 'failed clone into empty leaves directory (separate, wt)' '
 	mkdir -p empty-wt &&
 	corrupt_repo &&
 	test_must_fail git clone --separate-git-dir no-git foo empty-wt &&
