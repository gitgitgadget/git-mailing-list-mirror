Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB261F424
	for <e@80x24.org>; Thu,  5 Apr 2018 07:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeDEHvO (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 03:51:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57220 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbeDEHvO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 03:51:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EE5F71F424;
        Thu,  5 Apr 2018 07:51:13 +0000 (UTC)
Date:   Thu, 5 Apr 2018 07:51:13 +0000
From:   Eric Wong <e@80x24.org>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] git-svn: allow empty email-address using authors-prog
 and authors-file
Message-ID: <20180405075113.3y6a5nadijswt7pm@untitled>
References: <20180320220743.GA17234@whir>
 <20180324102046.8840-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180324102046.8840-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the update.  The patch itself looks good, but I
noticed one --show-item isn't supported on SVN 1.8.10 for me.

I've tested the following on both SVN 1.8.10 and 1.9.5:

--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -83,7 +83,8 @@ test_expect_success 'authors-prog imported user without email' '
 test_expect_success 'imported without authors-prog and authors-file' '
 	svn mkdir -m hh --username hh "$svnrepo"/hh &&
 	(
-		uuid=$(svn info --show-item=repos-uuid "$svnrepo") &&
+		uuid=$(svn info "$svnrepo" |
+			sed -n "s/^Repository UUID: //p") &&
 		cd x &&
 		git svn fetch &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn | \

Can you confirm it's OK for you?  Thanks.
