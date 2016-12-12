Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 906281FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 11:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932554AbcLLLJW (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 06:09:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55032 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932487AbcLLLJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 06:09:20 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 11C481FF76;
        Mon, 12 Dec 2016 11:09:15 +0000 (UTC)
Date:   Mon, 12 Dec 2016 11:09:14 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] git-svn: allow "0" in SVN path components
Message-ID: <20161212110914.GA24736@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Blindly checking a path component for falsiness is unwise, as
"0" is false to Perl, but a valid pathname component for SVN
(or any filesystem).

Found via random code reading.

Signed-off-by: Eric Wong <e@80x24.org>
---
  Junio: this bugfix should go to "maint".
  Will push along with a doc fix for Juergen.

 perl/Git/SVN/Ra.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index e764696801..56ad9870bc 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -606,7 +606,7 @@ sub minimize_url {
 			my $latest = $ra->get_latest_revnum;
 			$ra->get_log("", $latest, 0, 1, 0, 1, sub {});
 		};
-	} while ($@ && ($c = shift @components));
+	} while ($@ && defined($c = shift @components));
 
 	return canonicalize_url($url);
 }
-- 
EW
