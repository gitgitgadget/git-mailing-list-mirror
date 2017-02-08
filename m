Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7225C1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 12:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbdBHMS0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 07:18:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:55418 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753221AbdBHMS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 07:18:26 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ7bs-1crzc04AY8-00Kttk; Wed, 08
 Feb 2017 13:18:21 +0100
Date:   Wed, 8 Feb 2017 13:18:04 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] worktree: demonstrate a half-working workaround for
 auto-gc
In-Reply-To: <cover.1486556262.git.johannes.schindelin@gmx.de>
Message-ID: <da25bfcebccdeb5ccdbf1f98027859f894fe5c25.1486556262.git.johannes.schindelin@gmx.de>
References: <cover.1486556262.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bHSZ431QRHZdDFGQdLUMCvO8yFZe+5jq0nEFSC1sM3zFZMYmTmB
 v3Q2kV97pkUc/IQ25PNiZK1FHUC/t7ZTlRSFvvWe+tUK8eFGyJ6g1VLsf9wl28OIkPSRyew
 3KKZj1kSkWOtMrvVs6yGYlwSZjU0XN/6BoKcMGiiBRFatBV99yfF8FixNSACMejCYpN0uZ0
 9hGtp3QRfg9kJcLuNEqJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8RRWPC2GSU8=:4M6D4KxDHCgkWVLwEkqW63
 ts5+HKgWHCjglN39zcRgHBfP3lY9mdVMA1uJJgHsOMu+GpQaf3WpBuK/UEOSH9yGDoGVrWu6l
 dhhQkcicbyui7HEYuoixx4/Cqw6IPCGruZPh8ZC/g7xsM9UCnhyLRbDxE2DuRHrD+hChvKaNu
 Fowl5jy7sfuI/N0Xb1ICQfDbvt971pfrc6CN3cceTCDJr1ycH4yEz5O4oslIZhpy/WA/M1GZ0
 nV/EH4fOk03kPDySgW4Jw48TkN9DUHKyqdA6KDg71G2ScuEwzjBeYsj5wiI+4q/fr+MhWUpZM
 fw/SDl69MTm+IcrCS/PAkSgNYpQEsOjvWKtpU7d/XvUayALR8lo8A0Y7EoTx9SCRV6Ba0o56L
 kykDqmFLCD9QJomn9y+xpMmabRZs2WBxZj2IOms7R4BWeQmrEZyUoe/GFyKi+XahnLCzQOCaR
 31hUObv8eitPP9PG0uG4MqQ7qv3lLGumuTDobLEu2iI8FwcV/VF+mTHaSl5QZ9OvgV+kGybcG
 RkgPSqmnTSK3ChIVegxdCtaojT5lNokpNimruGsfo7cAjhWdj2ykS6zrnlxdoKnhBIOybyjAa
 khhMn1mPLX0rTRmODp/d6int78H61ScPj4k9gwwdulGbkdXfAbt36o1fGW0KxCk+0gXeRBA6D
 TJLxdrOcWAWnKZWeEZm0sKnWEKBk9B8N+RyUvjQ0d1jav8td5vllUnjarbigZ07fIoOZjfM+Z
 uFefzWpzKZ9TczXcYzZFWCzaw+nu/R5ngXyPqlVJ91SfIp5B6DkmqKOd1S3+/MNz5qZhZQb6K
 RMa53sN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While worktrees are marked "experimental", there is really no alternative
to using them when trying to work on multiple patch series in parallel.

Sadly, there is still a bug that causes irretrievable data loss caused by
worktree's incomplete handling of reflogs (and of the multiple indices of
the various worktrees), as this developer can testify a dozen times over.

In the --auto case, we can install a hook that runs before-hand,
accumulates all the worktree-specific refs and reflogs and installs them
into a very special reflog in the common refs namespace. The only
purpose of this stunt is to let gc pick up on those refs and reflogs, of
course, and *not* ignore them.

Unfortunately, this still does not address the "git gc" case, but
hopefully a real fix will be here some time soon.

Also, if there are simply too many loose objects for Git's liking, it will
kick off auto-gc (including the hook, which takes a couple of seconds to
run) that subsequently only says that it won't do anything, so the next
Git operation will kick off another auto-gc (including the multi-second
hook run).

Needless to say: this patch is not actually intended for inclusion, but
instead tries to demonstrate the pain and the dear need for a real bug fix
(and not another 8 months of buggy Git).

So here is hoping to a timely fix. Cheers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6500-gc.sh | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index e24a4fb611..2f1e52825d 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -67,6 +67,30 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_line_count = 2 new # There is one new pack and its .idx
 '
 
+test_expect_success 'install pre-auto-gc hook for worktrees' '
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/pre-auto-gc <<-\EOF
+	echo "Preserving refs/reflogs of worktrees" >&2 &&
+	dir="$(git rev-parse --git-common-dir)" &&
+	refsdir="$dir/logs/refs" &&
+	rm -f "$refsdir"/preserve &&
+	ident="$(GIT_COMMITTER_DATE= git var GIT_COMMITTER_IDENT)" &&
+	(
+		find "$dir"/logs "$dir"/worktrees/*/logs \
+			-type f -exec cat {} \; |
+		cut -d" " -f1
+		find "$dir"/HEAD "$dir"/worktrees/*/HEAD "$dir"/refs \
+			"$dir"/worktrees/*/refs -type f -exec cat {} \; |
+		grep -v "^ref:"
+	) 2>/dev/null |
+	sort |
+	uniq |
+	sed "s/.*/& & $ident	dummy/" >"$dir"/preserve &&
+	mkdir -p "$refsdir" &&
+	mv "$dir"/preserve "$refsdir"/
+	EOF
+'
+
 trigger_auto_gc () {
 	# This is unfortunately very, very ugly
 	gdir="$(git rev-parse --git-common-dir)" &&
@@ -76,7 +100,7 @@ trigger_auto_gc () {
 	git -c gc.auto=1 -c gc.pruneexpire=now -c gc.autodetach=0 gc --auto
 }
 
-test_expect_failure 'gc respects refs/reflogs in all worktrees' '
+test_expect_success 'gc respects refs/reflogs in all worktrees' '
 	test_commit something &&
 	git worktree add worktree &&
 	(
-- 
2.11.1.windows.1
