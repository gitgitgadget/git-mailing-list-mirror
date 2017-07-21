Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A721020288
	for <e@80x24.org>; Fri, 21 Jul 2017 16:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754387AbdGUQoN (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 12:44:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51883 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754161AbdGUQoM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 12:44:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C896499D4F;
        Fri, 21 Jul 2017 12:44:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rGMeOlmR6dnxxAGqKxIMDsWecKk=; b=kYEqp3
        ZcXRqu44skAgxXkKI7rgcGRwruwGTQ11Xlju/Nz6ohx4dJEqSi9RjOG7x5Xsxxn0
        28ciXC+HXfs/0bOC2vx6Z78ifAgKI9O06BvkfbstqPFE7GV6nia/X2RJB6EC5oAW
        BxjyA2EckdqZeDblfNt/iHav+9bb1VojeB2u8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MUwrqxwflNPgahvASg5n+wR7bjHe9qTL
        WtEyvHZfqeSSOKd/5k+sruqyqGxZt0krha2zVJP+tPczK7arMNJXh9cdxM9ZFm2X
        P+EfX/DNRgBr5QmrN46TjCXtcwd8SIrNfuMGbrHq/qYHdIhRwx6AKsimUunmYz0l
        OhDD32gB3sI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C075899D4E;
        Fri, 21 Jul 2017 12:44:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1525499D4B;
        Fri, 21 Jul 2017 12:44:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: Reducing redundant build at Travis?
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com>
        <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com>
        <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com>
        <20170714122401.uahk2fzvcjj3nwve@sigill.intra.peff.net>
        <xmqqbmonrrvr.fsf@gitster.mtv.corp.google.com>
        <20170714153224.6qnupcsa3pkig76k@sigill.intra.peff.net>
        <4BB4EDA1-58A5-45AD-8BEC-1CB06CDC23DD@gmail.com>
        <xmqq4lu7m94h.fsf@gitster.mtv.corp.google.com>
        <333FEA3F-BB43-4183-ADD1-14E73E668EA3@gmail.com>
Date:   Fri, 21 Jul 2017 09:44:03 -0700
In-Reply-To: <333FEA3F-BB43-4183-ADD1-14E73E668EA3@gmail.com> (Lars
        Schneider's message of "Fri, 21 Jul 2017 18:11:26 +0200")
Message-ID: <xmqqo9sdhh9o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEDBEB2A-6E33-11E7-A171-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> To answer your question: I don't see an easy solution to the problem.

That's OK.  Thanks for digging.

I am wondering if the attached would be acceptable as a minimum
impact patch to address this issue.  

I think I got the "are we building a tag, or are we building a
branch that happens to be at a tag?" logic right, but I have no idea
what I am writing in the "script" sections (I am just assuming that
these lines are squashed into a line by removing line-breaks and
become a single loooong shell script), and can certainly use guiding
hands.  I didn't bother skipping the work done in before_script.

Thanks.

diff --git a/.travis.yml b/.travis.yml
index 278943d14a..55af619830 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -53,6 +53,7 @@ matrix:
       script:
         - >
           test "$TRAVIS_REPO_SLUG" != "git/git" ||
+          ci/skip-branch-tip-with-tag.sh ||
           ci/run-windows-build.sh $TRAVIS_BRANCH $(git rev-parse HEAD)
       after_failure:
     - env: Linux32
@@ -65,6 +66,7 @@ matrix:
       before_script:
       script:
         - >
+          ci/skip-branch-tip-with-tag.sh ||
           docker run
           --interactive
           --env DEVELOPER
@@ -145,9 +147,10 @@ before_script: make --jobs=2
 
 script:
   - >
+    ci/skip-branch-tip-with-tag.sh || {
     mkdir -p $HOME/travis-cache;
     ln -s $HOME/travis-cache/.prove t/.prove;
-    make --quiet test;
+    make --quiet test; }
 
 after_failure:
   - >
diff --git a/ci/skip-branch-tip-with-tag.sh b/ci/skip-branch-tip-with-tag.sh
new file mode 100755
index 0000000000..a57e724b35
--- /dev/null
+++ b/ci/skip-branch-tip-with-tag.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+# Sometimes, a branch is pushed at the same time the tag that points
+# at the same commit as the tip of the branch is pushed, and building
+# both at the same time is a waste.
+#
+# Travis gives a tagname e.g. v2.14.0 in $TRAVIS_BRANCH when
+# the build is triggered by a push to a tag.  Let's see if
+# $TRAVIS_BRANCH is exactly at a tag, and if so, if it is 
+# different from $TRAVIS_BRANCH.  That way, we can tell if
+# we are building the tip of a branch that is tagged---and
+# we can skip the build because we won't be skipping a build
+# of a tag.
+
+if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
+	$TAG != $TRAVIS_BRANCH
+then
+	echo "Tip of $TRAVIS_BRANCH is exactly at $TAG"
+	exit 0
+else
+	exit 1
+fi
+
