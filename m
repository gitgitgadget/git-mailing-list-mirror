Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D93020286
	for <e@80x24.org>; Mon, 11 Sep 2017 01:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbdIKBRm (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 21:17:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52717 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751855AbdIKBRl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 21:17:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DEA690796;
        Sun, 10 Sep 2017 21:17:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y6kSSMRL4/OdL9DRBgjIlsPnZrQ=; b=ZqQd85
        ay8PuKIdvw6nqp31INHn7dI95XC+Uh9CJKthH1oLdbh3c91AwZhWjPB56znwGj4z
        ZbQWdzgI754ByFpPUtlnCKu3WdC+tBp3zxX318rfXc5FKW54wP1wyOQTna03cdzl
        aQzcnr6F3PeRzDJTQWaAlXhqh3TEd13ileD8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lBpwHhgOwkCs9WmfEI+NhWC3+kMUS71R
        a3hpzl0mCpNVLadEfjAOB2hOBJhnE8Q57T1xmJlw3GRM6j6P+Q8f4aH3/H6E/WHp
        4kOZtHMGUjuXFjrnGvmmrHtCNhmDPFpgFJV0duZVVSnMbj5czQcvUC7qWAYxAx3L
        iMoRMObiZcY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05BF990795;
        Sun, 10 Sep 2017 21:17:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A3BD90794;
        Sun, 10 Sep 2017 21:17:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/2] travis-ci: move Travis CI code into dedicated scripts
References: <20170910144429.47346-1-larsxschneider@gmail.com>
        <20170910144429.47346-2-larsxschneider@gmail.com>
Date:   Mon, 11 Sep 2017 10:17:38 +0900
In-Reply-To: <20170910144429.47346-2-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Sun, 10 Sep 2017 16:44:28
        +0200")
Message-ID: <xmqqy3pm3ufh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 014415E6-968F-11E7-8285-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Most of the Travis CI commands are in the '.travis.yml'. The yml format
> does not support functions and therefore code duplication is necessary
> to run commands across all builds.
>
> To fix this, add a library for common CI functions. Move all Travis CI
> code into dedicated scripts and make them call the library first.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

Thanks.  I _think_ you ended up not having to use shell function to
avoid code duplication ;-) but I find the script part of the result
much easier to understand.

Two things I noticed:

 - run-windows-build.sh did not use to run with "set -e" but now it
   does because it includes lib-travisci.sh; if (I didn't check with
   fine toothed comb) the original were not "set -e" clean, we may
   see unwanted errors in run-windows-build.sh, but that is
   sometihng we can fix going forward.

 - it seems that the test output section lost ": <- click here...";
   I do not know if there is a negative consequence of this change.

Indentation of some scripts were a bit too deep and I found it hard
to read them, so the following is what I did (but did not commit)
while reading them through.

Thanks.

 ci/install-dependencies.sh | 51 ++++++++++++++++++++++++----------------------
 ci/print-test-failures.sh  | 18 ++++++++--------
 2 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 067e6eb702..a29246af35 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,33 +5,36 @@
 
 . ${0%/*}/lib-travisci.sh
 
+P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
+LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
+
 case "${TRAVIS_OS_NAME:-linux}" in
-	linux)
-		export GIT_TEST_HTTPD=YesPlease
+linux)
+	export GIT_TEST_HTTPD=YesPlease
 
-		mkdir --parents custom/p4
-		pushd custom/p4
-			wget --quiet http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION/bin.linux26x86_64/p4d
-			wget --quiet http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION/bin.linux26x86_64/p4
-			chmod u+x p4d
-			chmod u+x p4
-			export PATH="$(pwd):$PATH"
-		popd
-		mkdir --parents custom/git-lfs
-		pushd custom/git-lfs
-			wget --quiet https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz
-			tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
-			cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
-			export PATH="$(pwd):$PATH"
-		popd
+	mkdir --parents custom/p4
+	pushd custom/p4
+		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
+		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4"
+		chmod u+x p4d
+		chmod u+x p4
+		export PATH="$(pwd):$PATH"
+	popd
+	mkdir --parents custom/git-lfs
+	pushd custom/git-lfs
+		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
+		export PATH="$(pwd):$PATH"
+	popd
 	;;
-	osx)
-		brew update --quiet
-		# Uncomment this if you want to run perf tests:
-		# brew install gnu-time
-		brew install git-lfs gettext
-		brew link --force gettext
-		brew install caskroom/cask/perforce
+osx)
+	brew update --quiet
+	# Uncomment this if you want to run perf tests:
+	# brew install gnu-time
+	brew install git-lfs gettext
+	brew link --force gettext
+	brew install caskroom/cask/perforce
 	;;
 esac
 
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 8583e61839..8c8973cbf3 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -6,13 +6,13 @@
 . ${0%/*}/lib-travisci.sh
 
 for TEST_EXIT in t/test-results/*.exit
-	do
-		if [ "$(cat "$TEST_EXIT")" != "0" ]
-		then
-			TEST_OUT="${TEST_EXIT%exit}out"
-			echo "------------------------------------------------------------------------"
-			echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
-			echo "------------------------------------------------------------------------"
-			cat "${TEST_OUT}"
-		fi
+do
+	if [ "$(cat "$TEST_EXIT")" != "0" ]
+	then
+		TEST_OUT="${TEST_EXIT%exit}out"
+		echo "------------------------------------------------------------------------"
+		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
+		echo "------------------------------------------------------------------------"
+		cat "${TEST_OUT}"
+	fi
 done
