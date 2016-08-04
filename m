Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33EBC20450
	for <e@80x24.org>; Thu,  4 Aug 2016 11:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757008AbcHDLnT (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 07:43:19 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:33734 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758414AbcHDLnJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2016 07:43:09 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id BD724231B4;
	Thu,  4 Aug 2016 12:33:07 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id B82F333E8;
	Thu,  4 Aug 2016 12:33:07 +0100 (BST)
X-Quarantine-ID: <LgkT7g6RgJar>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LgkT7g6RgJar; Thu,  4 Aug 2016 12:33:03 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.9])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 25CB233E1;
	Thu,  4 Aug 2016 12:33:00 +0100 (BST)
Date:	Thu, 4 Aug 2016 12:32:57 +0100
From:	John Keeping <john@keeping.me.uk>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #01; Tue, 2)
Message-ID: <20160804113256.6idrdzfgolm4ne4o@john.keeping.me.uk>
References: <xmqqlh0ebyhn.fsf@gitster.mtv.corp.google.com>
 <4877318E-3CBF-4C87-B24D-AAE35C427D66@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4877318E-3CBF-4C87-B24D-AAE35C427D66@gmail.com>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 10:03:39AM +0200, Lars Schneider wrote:
> 
> > 
> > * jk/push-force-with-lease-creation (2016-07-26) 3 commits
> > - push: allow pushing new branches with --force-with-lease
> > - push: add shorthand for --force-with-lease branch creation
> > - Documentation/git-push: fix placeholder formatting
> > 
> > "git push --force-with-lease" already had enough logic to allow
> > ensuring that such a push results in creation of a ref (i.e. the
> > receiving end did not have another push from sideways that would be
> > discarded by our force-pushing), but didn't expose this possibility
> > to the users.  It does so now.
> > 
> > Will merge to 'next'.
> 
> t5533-push-cas.sh "16 - new branch already exists" seems to be broken 
> for OSX on next. Git bisect indicates that "push: add shorthand for 
> --force-with-lease branch creation" might be the culprit.
> 
> https://travis-ci.org/git/git/jobs/149614431
> https://api.travis-ci.org/jobs/149614431/log.txt?deansi=true (non-JS)

It seems that the test script has already done "test_commit C", so the
newly added "test_commit c" does nothing on a case-insensitive
filesystem.

Something like this will make the test more consistent with the rest of
the file:

diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 5f29664..e5bbbd8 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -220,7 +220,7 @@ test_expect_success 'new branch already exists' '
 	(
 		cd src &&
 		git checkout -b branch master &&
-		test_commit c
+		test_commit F
 	) &&
 	(
 		cd dst &&
