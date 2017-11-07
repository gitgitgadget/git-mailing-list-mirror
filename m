Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705EF202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 16:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757920AbdKGQHb (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 11:07:31 -0500
Received: from marcos.anarc.at ([206.248.172.91]:36844 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbdKGQHK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 11:07:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 695251A00AC
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [PATCH v5 7/7] remote-mediawiki: show progress while fetching namespaces
Date:   Tue,  7 Nov 2017 11:07:01 -0500
Message-Id: <20171107160701.24202-8-anarcat@debian.org>
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

Without this, the fetch process seems hanged while we fetch page
listings across the namespaces. Obviously, it should be possible to
silence this with -q, but that's an issue already present everywhere
in the code and should be fixed separately:

https://github.com/Git-Mediawiki/Git-Mediawiki/issues/30

Signed-off-by: Antoine Beaupré <anarcat@debian.org>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index c9f46359b..af9cbc9d0 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -279,6 +279,7 @@ sub get_mw_tracked_namespaces {
             aplimit => 'max' } )
             || die $mediawiki->{error}->{code} . ': '
                 . $mediawiki->{error}->{details} . "\n";
+        print {*STDERR} "$#{$mw_pages} found in namespace $local_namespace ($namespace_id)\n";
         foreach my $page (@{$mw_pages}) {
             $pages->{$page->{title}} = $page;
         }
-- 
2.11.0

