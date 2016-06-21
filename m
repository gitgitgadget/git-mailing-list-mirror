Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 684971FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 13:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbcFUNzW (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 09:55:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:60896 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbcFUNzV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 09:55:21 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MGAdz-1bCNRd3wxT-00FEW6; Tue, 21 Jun 2016 15:53:47
 +0200
Date:	Tue, 21 Jun 2016 15:53:43 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2] perf: accommodate for MacOSX
In-Reply-To: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de>
Message-ID: <fa788ff09727fc37d8e799dbf1a92e4bba4152c9.1466517188.git.johannes.schindelin@gmx.de>
References: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MoYw1/i4i2qD5MVb4vmHHEY64mzrXi1YuEbYTgp6d1yzrBmOBHD
 igTCCrb8yeaV+OzTmcZH2/Q2zBc+vekAKIKyBk7V16REzms8vlWbytzG2xJXgAZBMCxQIzP
 9PnTn79vNZ+9TnM7ltjdOr1jmzfCDHa9N51jWv9i+lghbCNeE2zkxCz0NApJnna8e8PPcvp
 D06Ll58m22La1u4gSDjyw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:mxduDDfB6hU=:pK3Oqj60CnvFmUgbsrTrfO
 9dYJz5dJ8enBZApfbFCK0Esq8PsW4P+APoNQvczlPglJK3NVnTbJfEfjODSi5b84f5QYJpRRI
 rlkzfW7QHyxQeXzXeU/7yLuwSexwVEzALgOLFCOoo9tDvg9K5DzoOCSXubH2/bKIOOVUtnk52
 6osmcSG4iiEb92SKXhUd32oP0ssGsEzmk+GJmKJCD4ZyGKB/lMs2jvN65Fxfs+WOyB2QKrILv
 yG4euVYkIbT4deCNmWoMhP+xUw3Nhr+OFhaH+j7OQUwVWvRkZuU275/yTM5GviHVtSyLfircc
 gW7H8OD1r+JlQuV368JJJO6EMih2V63FOM4BWm7OKNNrck3MsAUEJ8Z+jJEA3y5MVKcFLvvf5
 oLTArz2cv/mnDdN4nfPcDlhqYLCINyfGCETsaehjoLjoNPkKgh2ro6iwKXFE+TVBzHVYVXL33
 v4BbxWEw2Jdz6KWN7Msa3TGNZFKqwxeBlm2762kw3Nox7q41UeTJVt1/QboSD8KG6wl7JVPsZ
 hmKaALbocvnsIXmgImtPH/L9IUQcKwIUtOQlbaquKSC75Ar59vlBS2zYLRy52LaB2VnIbzhDQ
 LtnvNVu9C0fqn+O5MtHaQBfK4E8ErXMow9GIjAEhhQRAubrJjMFcPrDcGudxGxxGsE4MPRjii
 oRh6P/+MNO+T5lGpRUB51RnJbNUUTRP+hUTY747xhogE0f3Zo72V6bKdFAxlNNCsdGGcgoGN2
 y+ajUKHOI355txPs8nnIwt6RVseL15tbbQf1O4nLLqgINwaPiu1dQqPJE7NNuMWktB9DGKn7m
 lztQxHB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

As this developer has no access to MacOSX developer setups anymore,
Travis becomes the best bet to run performance tests on that OS.

However, on MacOSX /usr/bin/time is that good old BSD executable that
no Linux user cares about, as demonstrated by the perf-lib.sh's use
of GNU-ish extensions. And by the hard-coded path.

Let's just work around this issue by using gtime on MacOSX, the
Homebrew-provided GNU implementation onto which pretty much every
MacOSX power user falls back anyway.

To help other developers use Travis to run performance tests on
MacOSX, the .travis.yml file now sports a commented-out line that
installs GNU time via Homebrew.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/perf-macosx-v2
 .travis.yml        | 2 ++
 t/perf/perf-lib.sh | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)
Interdiff vs v1:

 diff --git a/.travis.yml b/.travis.yml
 index 0e569bc..c2b76f9 100644
 --- a/.travis.yml
 +++ b/.travis.yml
 @@ -82,7 +82,9 @@ before_install:
        brew tap homebrew/binary --quiet
        brew_force_set_latest_binary_hash perforce
        brew_force_set_latest_binary_hash perforce-server
 -      brew install git-lfs perforce-server perforce gettext gnu-time
 +      # Uncomment this if you want to run perf tests:
 +      # brew install gnu-time
 +      brew install git-lfs perforce-server perforce gettext
        brew link --force gettext
        ;;
      esac;


diff --git a/.travis.yml b/.travis.yml
index c20ec54..c2b76f9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -82,6 +82,8 @@ before_install:
       brew tap homebrew/binary --quiet
       brew_force_set_latest_binary_hash perforce
       brew_force_set_latest_binary_hash perforce-server
+      # Uncomment this if you want to run perf tests:
+      # brew install gnu-time
       brew install git-lfs perforce-server perforce gettext
       brew link --force gettext
       ;;
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 18c363e..773f955 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -127,11 +127,15 @@ test_checkout_worktree () {
 # Performance tests should never fail.  If they do, stop immediately
 immediate=t
 
+# Perf tests require GNU time
+case "$(uname -s)" in Darwin) GTIME="${GTIME:-gtime}";; esac
+GTIME="${GTIME:-/usr/bin/time}"
+
 test_run_perf_ () {
 	test_cleanup=:
 	test_export_="test_cleanup"
 	export test_cleanup test_export_
-	/usr/bin/time -f "%E %U %S" -o test_time.$i "$SHELL" -c '
+	"$GTIME" -f "%E %U %S" -o test_time.$i "$SHELL" -c '
 . '"$TEST_DIRECTORY"/test-lib-functions.sh'
 test_export () {
 	[ $# != 0 ] || return 0
-- 
2.9.0.118.g0e1a633

base-commit: ab7797dbe95fff38d9265869ea367020046db118
