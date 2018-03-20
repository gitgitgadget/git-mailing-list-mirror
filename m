Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0EC41F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 11:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbeCTLLS (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 07:11:18 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:30619 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbeCTLLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 07:11:15 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yFAYeoeajwheayFAfepoFq; Tue, 20 Mar 2018 11:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521544274;
        bh=yRZZeysSIXTn9azti7L6fBNuYwW+GmVA8Q7pNaD6iz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=kCVwliJ14bD5/0kkPsmqeZHuIi3HIlHjeMoHFznPtoFVv9o+Cpy7Nseu3w/q/yhUL
         kOdw7x6IMwxRirbW7w8klQVEyl1uFbbxpiIXtHhq3FSz5JCOTVdZWQTRuHjv9LiLu+
         KSD0WNhDq7T1HDKlCHtm4l+QENNIUklT9nlZB2JE=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=-oOK03TMgPVaF4B7wy4A:9
 a=m3F4Hr05r7qfITCY:21 a=Zh6OIU5l11XxlC6d:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/3] rebase -p: error out if --signoff is given
Date:   Tue, 20 Mar 2018 11:10:56 +0000
Message-Id: <20180320111057.23862-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320111057.23862-1-phillip.wood@talktalk.net>
References: <20180314111127.14217-1-phillip.wood@talktalk.net>
 <20180320111057.23862-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHwBzXrLqkkthml9O2Lnxl5k0riKopV55Yi/aPiyAJt+LuB1GjHGzevuMXW1Q6MOzmrA4e/DwxFPZOep0mHXfiNAaTB8hA2vh+0hTH/kMnhshem+Hw9J
 eJ6/iTNGRjnz0Oqk962EAZA9CRK+lVGobNiKoFsJSnqgXGXQEWariWwTbMEgHB+3gLh3PBPrrFkYh+tfxyG8e+y3CFcaTj5KN2S4y6yLLBsDWNfNBaLIlWFm
 1IKjqSIa/CWZodiVhNI09gAYJZBBZg0MIfzGW+t7g2IBTXZJHdIDsvGxc5lz4Lkn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

rebase --preserve-merges does not support --signoff so error out
rather than just silently ignoring it so that the user knows the
commits will not be signed off.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-rebase.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 5d854657a7..7d3bb9d443 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -479,6 +479,8 @@ fi
 
 if test -n "$signoff"
 then
+	test -n "$preserve_merges" &&
+		die "$(gettext "error: cannot combine '--signoff' with '--preserve-merges'")"
 	git_am_opt="$git_am_opt $signoff"
 	force_rebase=t
 fi
-- 
2.16.2

