Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F2120281
	for <e@80x24.org>; Thu,  2 Nov 2017 21:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964987AbdKBVZs (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 17:25:48 -0400
Received: from marcos.anarc.at ([206.248.172.91]:35146 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964980AbdKBVZq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 17:25:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 236151A00AE
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [PATCH v3 7/7] remote-mediawiki: show progress while fetching namespaces
Date:   Thu,  2 Nov 2017 17:25:18 -0400
Message-Id: <20171102212518.1601-8-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171102212518.1601-1-anarcat@debian.org>
References: <20171030025142.19421-1-anarcat@debian.org>
 <20171102212518.1601-1-anarcat@debian.org>
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

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Antoine Beaupré <anarcat@debian.org>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index f53e638cf..dc43a950b 100755
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

