Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72040C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 03:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234AB23A7C
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 03:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbhAODPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 22:15:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50669 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbhAODPU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 22:15:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E3F6115B81;
        Thu, 14 Jan 2021 22:14:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=u
        3/yTq5JnTaEJ1zv9rJvizh06WI=; b=IQoFq8XC6O2aoNgikYBknReF0NbEKBhWM
        ZRSAcZlT7g7TL5b8scxIpchtn5jALGY2bTomLnIuLlyM32LeKP0L2C1uTVVHnVpC
        aGFFSXjq+83pyZjRZ9/Ko1SdC4YKBnaZmxbDMkM8vn0QUecmSLktOTSgAD18AsWw
        iujLUpiQBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=IbF
        QWVJOfl4ffISQKtfjOq1KckpBGAyYzAJ9KxeW1pvC1Gae9mi8IcKqvAIn+B+pSHh
        loDi1yzYPyUx26OQDQ6XRGY0LPYDtGeyWfvuquB9CVO2xwEKr6nXup3XrzdGOI36
        tMwgTkduruL0ACkiA0GyQRHedN/A88GTfBJsqbGk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87724115B80;
        Thu, 14 Jan 2021 22:14:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2CE5115B7F;
        Thu, 14 Jan 2021 22:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
Date:   Thu, 14 Jan 2021 19:14:34 -0800
Message-ID: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB9DAE7E-56DF-11EB-BD51-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems that homebrew suddenly started giving us trouble, like this:

https://github.com/git/git/runs/1705953982?check_suite_focus=true#step:3:70

Here is my attempt to work it around by blindly following the
suggested course of action in the error message, without knowing
what I am doing X-<.  I am not a Mac person.

What is frustrating is that every time we hit a minor snag like this
to break one of the jobs, all other unrelated jobs are also taken
down.

Help by those who know what they are doing on macOS would greatly be
appreciated.  Thanks.

----- >8 ----- >8 ----- >8 ----- >8 ----- >8 ----- >8 -----
We run "git pull" against "$cask_repo"; clarify that we are
expecting not to have any of our own modifications and running "git
pull" to merely update, by passing "--ff-only" on the command line.

Also, the "brew cask install" command line triggers an error message
that says:

    Error: Calling brew cask install is disabled! Use brew install
    [--cask] instead.

In addition, "brew install caskroom/cask/perforce" step triggers an
error that says:

    Error: caskroom/cask was moved. Tap homebrew/cask instead.

Attempt to see if blindly following the suggestion in these error
messages gets us into a better shape.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0229a77f7d..0b1184e04a 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -44,13 +44,13 @@ osx-clang|osx-gcc)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	brew cask install --no-quarantine perforce || {
+	brew install --cask --no-quarantine perforce || {
 		# Update the definitions and try again
 		cask_repo="$(brew --repository)"/Library/Taps/homebrew/homebrew-cask &&
-		git -C "$cask_repo" pull --no-stat &&
-		brew cask install --no-quarantine perforce
+		git -C "$cask_repo" pull --no-stat --ff-only &&
+		brew install --cask --no-quarantine perforce
 	} ||
-	brew install caskroom/cask/perforce
+	brew install homebrew/cask/perforce
 	case "$jobname" in
 	osx-gcc)
 		brew install gcc@9
-- 
2.30.0-386-gfb533afdb4

