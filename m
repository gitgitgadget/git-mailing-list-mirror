Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C1F20189
	for <e@80x24.org>; Sat, 18 Jun 2016 13:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbcFRNEJ (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 09:04:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:59508 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbcFRNEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 09:04:07 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MTBLi-1anGbC0uhS-00S6hD; Sat, 18 Jun 2016 15:03:56
 +0200
Date:	Sat, 18 Jun 2016 15:03:55 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] perf: accommodate for MacOSX
Message-ID: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mWiE/K5sVdQOd1uBn9HUiM8/Wy0mVWnHaTB/T8Ri2uivT91b5qz
 +8dMM1BLlViIUVBVVkEgy/fqunTGzLwfVDcopURs6P3OblMAf80WezGyKwl1j2xIceYXw6r
 paiXIjd6fXEILd6dTZm+EJJgim3HVQeY5eAAvlXiLqnfx5sEzhPQ9giPYXnhvMh9i41NAVV
 6RiI42Jh/7b/clseK9t1g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:NpGrzji10OQ=:IXYGEfzxGT6G08j8n3+kzv
 T1cEfSgI5qVE77IPQZj1vdq4XlOxvgipNjb3rKnhIqSWWy0dzkiq4T9YeTs2M5dyryvuFB9Pc
 /HkGaAzpYeLDERl9n1RAQXjF9N0Lo3+oysC8aPVoB3J34RlbkG70Mp3Y1nddXaan9sI2+Knie
 8Q7iruypbiOxv3P+fgO3hRHEQm9eakNpLACMLLXXc7E40fXjzgoxqJ/IooyHoanbg9GMStsHf
 ZCmgH3S3nx2wRdZ6HemX3GL+JiwFRpsQhw+On3AedSzCdxuPM7PE8jiQN5MC4Z9jIBjhl0B0n
 Z2wC8zTLvWpG3Wr2cGjQbZQLv3HrBtFHRW3tZhGIb6/FUuCVCIVjRkjBkFknp5pbXwNbDeSN8
 /4YuOOAy6TbeCBVfUpWAtRiFmBPqgzICYT9Tp54mxedPAM9rsc1YImT67DVVSSTX+6Z2Hum1o
 kESkPGst+ZDCAO7KknVME8h+cuTH9eSUKxF43Z7nN2GQRyI/TKlM2PvBYM1znSaTpAmPZvkFh
 kuM+7+FIW9O7JuBEkIQgpL3enQcCKTld2ZcJ3WijkRj1zAX1annEDHYIFtofe3kjyl0br6tDm
 zRW/J67b+7FHXdgSI7Z6+YAt/0fcIFnWa/idWlj4RlYmrudP4czEfhJ/JrCCXsQVJXEAR0xWR
 eGNcU31OhC9kvv2rzNh9qxp0BV0L335MabEPfB0qk2GSQUZF/552pfk/1ikdhlVzS43G/jeaZ
 BLIHVde8tefu8pSw02ikP3hrmjQ0T/wVyKMhgvDfS07BVIIOcmBDBGBYXcVU6fcJtNuN+AJOy
 1JTS0in
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/perf-macosx-v1

	This is another of those patches that came up in my rebase--helper
	work, even if it is not quite obvious from the patch ;-)

 .travis.yml        | 2 +-
 t/perf/perf-lib.sh | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index c20ec54..0e569bc 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -82,7 +82,7 @@ before_install:
       brew tap homebrew/binary --quiet
       brew_force_set_latest_binary_hash perforce
       brew_force_set_latest_binary_hash perforce-server
-      brew install git-lfs perforce-server perforce gettext
+      brew install git-lfs perforce-server perforce gettext gnu-time
       brew link --force gettext
       ;;
     esac;
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
2.9.0.119.gb7b8d21

base-commit: 05219a1276341e72d8082d76b7f5ed394b7437a4
