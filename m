Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5CB1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 11:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfILL66 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 07:58:58 -0400
Received: from sym2.noone.org ([178.63.92.236]:47778 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731466AbfILL66 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 07:58:58 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 07:58:58 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 46TcZ94gp8zvjc1; Thu, 12 Sep 2019 13:52:01 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] git-svn: trim leading and trailing whitespaces in author name
Date:   Thu, 12 Sep 2019 13:52:01 +0200
Message-Id: <20190912115201.888-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases, the svn author names might contain leading or trailing
whitespaces, leading to messages such as:

  Author: user1
   not defined in authors.txt

(the trailing newline leads to the line break). The user "user1" is
defined in authors.txt though, e.g.

  user1 = User <user1@example.com>

Fix this by trimming the author name retreived from svn before using it
in check_author.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 perl/Git/SVN.pm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 76b29659057d..db412c653d1d 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1491,6 +1491,7 @@ sub call_authors_prog {
 
 sub check_author {
 	my ($author) = @_;
+	$author =~ s/^\s+|\s+$//g;
 	if (!defined $author || length $author == 0) {
 		$author = '(no author)';
 	}
-- 
2.23.0.dirty

