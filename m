Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49462202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 16:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754400AbdKGQHJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 11:07:09 -0500
Received: from marcos.anarc.at ([206.248.172.91]:36830 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbdKGQHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 11:07:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 514D71A00AE
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [PATCH v5 3/7] remote-mediawiki: show known namespace choices on failure
Date:   Tue,  7 Nov 2017 11:06:57 -0500
Message-Id: <20171107160701.24202-4-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171107160701.24202-1-anarcat@debian.org>
References: <20171102212518.1601-1-anarcat@debian.org>
 <20171107160701.24202-1-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we fail to find a requested namespace, we should tell the user
which ones we know about, since those were already fetched. This
allows users to fetch all namespaces by specifying a dummy namespace,
failing, then copying the list of namespaces in the config.

Eventually, we should have a flag that allows fetching all namespaces
automatically.

Reviewed-by: Antoine Beaupré <anarcat@debian.org>
Signed-off-by: Antoine Beaupré <anarcat@debian.org>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index a1d783789..5e8845893 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1334,7 +1334,8 @@ sub get_mw_namespace_id {
 	my $id;
 
 	if (!defined $ns) {
-		print {*STDERR} "No such namespace ${name} on MediaWiki.\n";
+		my @namespaces = map { s/ /_/g; $_; } sort keys %namespace_id;
+		print {*STDERR} "No such namespace ${name} on MediaWiki, known namespaces: @namespaces\n";
 		$ns = {is_namespace => 0};
 		$namespace_id{$name} = $ns;
 	}
-- 
2.11.0

