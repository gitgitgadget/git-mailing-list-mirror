Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131531F403
	for <e@80x24.org>; Wed, 13 Jun 2018 03:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeFMDKx (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 23:10:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58164 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754263AbeFMDKs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 23:10:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A44E7FD39A;
        Tue, 12 Jun 2018 23:10:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=aOnF
        UcBhRgq4mFHynmmrtF5D4zA=; b=Lcy9YFxOaPUC0bmWnbHo8gjiWJR8HVJqZBAL
        LBsmBWLBL8NOc1JPjTdMXqZspTVfgFpFlE1OQb7WbxmULXSPyG1LD0zWc2Ajtd8J
        jCi7LXWElGW7otYRC8Qwo7hvajvH9Knxd/tj9F8ei0DBFV/EG72NnJ3NJcG0T+Pr
        e7kDxUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        tjyHCTp6NqNevnyAGjkkfpC7K/Qt7+h95oTawoV4HNBKPTERmmKHVSBCAMDO9lrc
        Re9yrD2KBrm5X9WBvnJ3ivGuYMoYwpXm1eH44vqnFODWYoQeE8su14m7I8Ee46aI
        2+nDKWcsGFRVwWUHOrSlIVwtBj5bz5ijV8DiDsPbeVM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B599FD399;
        Tue, 12 Jun 2018 23:10:47 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1EAAFD395;
        Tue, 12 Jun 2018 23:10:45 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 3/4] git-credential-netrc: use in-tree Git.pm for tests
Date:   Tue, 12 Jun 2018 23:10:38 -0400
Message-Id: <20180613031040.3109-4-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607051958.759-1-tmz@pobox.com>
References: <20180607051958.759-1-tmz@pobox.com>
X-Pobox-Relay-ID: 5E1D4C96-6EB7-11E8-81D2-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luis Marsano <luis.marsano@gmail.com>

The netrc test.pl script calls git-credential-netrc which imports the
Git module.  Pass GITPERLLIB to git-credential-netrc via PERL5LIB to
ensure the in-tree Git module is used for testing.

Signed-off-by: Luis Marsano <luis.marsano@gmail.com>
---
 contrib/credential/netrc/t-git-credential-netrc.sh | 3 ++-
 contrib/credential/netrc/test.pl                   | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
index c5661087fe..07227d0228 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -23,9 +23,10 @@
 	# The external test will outputs its own plan
 	test_external_has_tap=1
 
+	export PERL5LIB="$GITPERLLIB"
 	test_external \
 		'git-credential-netrc' \
-		perl "$TEST_DIRECTORY"/../contrib/credential/netrc/test.pl
+		perl "$GIT_BUILD_DIR"/contrib/credential/netrc/test.pl
 
 	test_done
 )
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
index 1e1001030e..2b5280ad6a 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -1,5 +1,4 @@
 #!/usr/bin/perl
-use lib (split(/:/, $ENV{GITPERLLIB}));
 
 use warnings;
 use strict;
