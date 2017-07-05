Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877BD202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 11:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbdGELh7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 07:37:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:64018 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbdGELh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 07:37:58 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtIZH-1drYg90vnf-012snY; Wed, 05
 Jul 2017 13:37:50 +0200
Date:   Wed, 5 Jul 2017 13:37:49 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t5534: fix misleading grep invocation
Message-ID: <936f43ce2c993e545deaee5e196c018933375214.1499254650.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6uD0w8ZDQbAu6hlrdC8lAEj9KFwl2rjTed4CYdo9EvwFEMjvBrw
 D87CBvnKxORPHxx0lWYMKLDOki1NFm0BBt6J6wCjvAXCNRwoaoimC3xk8m75g334B6nSaZe
 S1k2s727IpPgZ4gJlzZfnV9kUdFwe7amK+Rd1AJj/lmIzX2JO67VFZpuHxmsU4Ogk93TDQM
 LuuCLaR8XpH57TfHP13KQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n+RxD3YPTCw=:dqdhhTUV0qLakBVKp1hrkl
 gVTz9Nar1WzjKN3ief/RavLRFiIJO1jIBUTtP+Uv59b/EeUXvAnYRIah4BdI4fdvnE4a086QE
 g3lccA5iwEVEo75sn7sm15Xh3MV17LGy8He4tb7Dt02Oqz+DGLdRbcrJgILFItLoAQiKGgJhi
 Pt8yL3n/vjNpGYnzPC0BPi5YisbZ7ayqfrMoJ631gV2eahUKQGM34nXGT6WUcqJbqX7/IlaMP
 jV7ox9j6rwj2dtuLHiE3g1sG0FxlW71F1d0oEh5RxPLqzNut6gllcgGHV5Bci+Km4plFcve9u
 XO8+uhMbg5EMsQ40TVvxo9b+O2Uvzg2Xv6Uah57449TQvgEOuvf1UBM6esScgbFlQXRfjeFjV
 ZFMEuGe0RcYCG6R+lXT2lAQQb9iAunHKyOVzNzaQIRgYEJUH0MtOxsPZIp17r8kd30o7oPubu
 RgeUrwGzHDgvkn3xDyGn1hJKZQ+XVLvUEyl0LdKSjwG9Uhbk5OcQJxee0deRhdmT1O2Wq5/6X
 MWr9/Fk6qWgBVQH+InolVNGpZtZ5UGcp2y/whbHGy5uUQ24bpKtjplhSePx2gGhrD0FgcklT4
 bK2DBuO2YIoSm1p+TjHb6aF59qIfDOl2VZUTUTeK0YtqwNgo6d4Kx0we7Dr06x+0eXPmTr6Ds
 Gjc43aRybcqGz+/v6Hqe7vtGji/yrb7gU9GUbJESiN/ZxVtUFKbXuqV4WoOC2aMMM0jtKRu1O
 nmjplzOL+LO064f9g0DvrXZ7zNJkccE01AZODmNGNv+HtaczawyA54FJlceOmSh3dko/G06WH
 2ZC0fFQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems to be a little-known feature of `grep` (and it certainly came
as a surprise to this here developer who believed to know the Unix tools
pretty well) that multiple patterns can be passed in the same
command-line argument simply by separating them by newlines. Watch, and
learn:

	$ printf '1\n2\n3\n' | grep "$(printf '1\n3\n')"
	1
	3

That behavior also extends to patterns passed via `-e`, and it is not
modified by passing the option `-E` (but trying this with -P issues the
error "grep: the -P option only supports a single pattern").

It seems that there are more old Unix hands who are surprised by this
behavior, as grep invocations of the form

	grep "$(git rev-parse A B) C" file

were introduced in a85b377d041 (push: the beginning of "git push
--signed", 2014-09-12), and later faithfully copy-edited in b9459019bbb
(push: heed user.signingkey for signed pushes, 2014-10-22).

Please note that the output of `git rev-parse A B` separates the object
IDs via *newlines*, not via spaces, and those newlines are preserved
because the interpolation is enclosed in double quotes.

As a consequence, these tests try to validate that the file contains
either A's object ID, or B's object ID followed by C, or both. Clearly,
however, what the test wanted to see is that there is a line that
contains all of them.

This is clearly unintended, and the grep invocations in question really
match too many lines.

Fix the test by avoiding the newlines in the patterns.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5534-push-signed.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 5bcb288f5c4..464ffdd147a 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -119,8 +119,11 @@ test_expect_success GPG 'signed push sends push certificate' '
 		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
 	) >expect &&
 
-	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
-	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
+	noop=$(git rev-parse noop) &&
+	ff=$(git rev-parse ff) &&
+	noff=$(git rev-parse noff) &&
+	grep "$noop $ff refs/heads/ff" dst/push-cert &&
+	grep "$noop $noff refs/heads/noff" dst/push-cert &&
 	test_cmp expect dst/push-cert-status
 '
 
@@ -200,8 +203,11 @@ test_expect_success GPG 'fail without key and heed user.signingkey' '
 		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
 	) >expect &&
 
-	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
-	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
+	noop=$(git rev-parse noop) &&
+	ff=$(git rev-parse ff) &&
+	noff=$(git rev-parse noff) &&
+	grep "$noop $ff refs/heads/ff" dst/push-cert &&
+	grep "$noop $noff refs/heads/noff" dst/push-cert &&
 	test_cmp expect dst/push-cert-status
 '
 

base-commit: 5116f791c12dda6b6c22fa85b600a8e30dfa168a
-- 
2.13.2.windows.1

Published-As: https://github.com/dscho/git/releases/tag/t5534-fix-grep-pattern-v1
Fetch-It-Via: git fetch https://github.com/dscho/git t5534-fix-grep-pattern-v1
