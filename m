Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C393B20195
	for <e@80x24.org>; Fri, 15 Jul 2016 15:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbcGOPv5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 11:51:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:61235 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbcGOPv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 11:51:56 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M2cYX-1b7VzZ1B6j-00sOYi; Fri, 15 Jul 2016 17:51:52
 +0200
Date:	Fri, 15 Jul 2016 17:51:51 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Kevin Willford <kcwillford@gmail.com>
cc:	git@vger.kernel.org
Subject: [PATCH 2/1] Verify that --cherry-pick avoids looking at full diffs
Message-ID: <alpine.DEB.2.20.1607151749540.6426@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g2COGD4e7fBh+omxggJrtXu7iTsnNHlhdv9uEiOfzFHvQWY+hX7
 d3y3lX/uj2xRP6gAve//3AEH48N5w7wCjNXrOFGIji5fKhryINwAUZvw4uc6n9h0t4yiq3w
 xpqPGqIBw1i/3nCdb3mJpwkIG82rvvmhcbIT2R3ayErXNCo+Is0fTZc16D64jB423wyclt9
 UMaxk7g6g8KPJk+anZsAA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:oL8jgUzlZno=:koZftMQ/KWxnH58ttC2n6o
 f4EHHw+k1tveKXQVV1cRLSJvKl6linap6HyIetH1SN4BGLCTx4dVarwUwwVhV5CK6P4NfucKd
 C5SbHOacqP907JhqytDJyTCSpH/y7YOap862j/ScZ+LpfWjBia/QF45nBAVofGFZx0Va1fR0k
 NvwwraddpqdtOmsk2h8SUGfIBJTNA1r8A0ezje0aYb7vfM18/Pu3IgQDkSPocHsLjsMzRWUTm
 rgTGbijaDjgIKsEt981gWBr8kBsfNqB0IX7haxr8+GDFDykVi6hxXvXT18KxuRaHJaek23Kwt
 PWs8YL7oxYtFcJY/SvwvUzqI7qc1QJvwDAR6nvwPB6cBS+v2FvVpIOQylxt0yg7gYUhapTvNf
 kCNhk6vLLYN+L8lFgrnHOR2FUfjcf0dBCJo83/SdG5VfTwhAb7Iv5UinmbVDHSUaIof1t4uVs
 6y+I8UA7zmVcbavvBvU90ziV+R7t0A4u9HvJAfEB87YXF4N23we+enFShRcbYg/oee6TFeZFi
 41v8/4NFvdnmgJa/g9QlQ37mWpqfvShJ3zCPiMzS1iPjeMqCSM5hINcdSkMzh5kIFBl/WqyC7
 mOt6Ozr5c/QE9be1+5YgVTYm9+IgNSV/pQFGnlOAB+OeIZJuB3aJ9AtRhPX9J+2CqmTWI1T5R
 pIaZYIBA7GX4+EQvVBD7weYD7gKcVm7PvF/nqSLCeNorYfw9IG18+EzsUP04R7dvbYrEAjac1
 54lTP+EZ58y+V7taKZUQjs8WyBu+JhsGMVp2WK+4VTozfuzjO2EC1dqUIawxXBzYc3sfJaU+R
 B3WH1ek
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


The entire point of the previous patch was to make sure that we look at
abbreviated patch IDs (using the diff *headers* only, but avoiding
to load the blobs into memory and diff them) first, and only look at
full patch IDs when the abbreviated patch IDs were not for the
--cherry-pick test.

Let's make sure that we actually avoid looking at the full patch ID,
simply by corrupting an object that is needed for the full patch ID, and
then seeing that --cherry-pick still works.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	On Fri, 15 Jul 2016, Johannes Schindelin wrote:

	> I also think that this patch series could use a test that
	> verifies that we no longer generate unneeded diffs. Maybe by
	> rebasing a commit on top of an commit touching a different file,
	> after corrupting the blob of the latter one? Let me give it a
	> try.

	And here it is. I verified that this test passes with your patch
	and fails without it.

 t/t6007-rev-list-cherry-pick-file.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 28d4f6b..a5f7c2a 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -207,4 +207,23 @@ test_expect_success '--count --left-right' '
 	test_cmp expect actual
 '
 
+remove_loose_object () {
+	sha1="$(git rev-parse "$1")" &&
+	remainder=${sha1#??} &&
+	firsttwo=${sha1%$remainder} &&
+	rm .git/objects/$firsttwo/$remainder
+}
+
+test_expect_success '--cherry-pick avoids looking at full diffs' '
+	git checkout -b shy-diff &&
+	test_commit dont-look-at-me &&
+	echo Hello >dont-look-at-me.t &&
+	test_tick &&
+	git commit -m tip dont-look-at-me.t &&
+	git checkout -b mainline HEAD^ &&
+	test_commit to-cherry-pick &&
+	remove_loose_object shy-diff^:dont-look-at-me.t &&
+	git rev-list --cherry-pick ...shy-diff
+'
+
 test_done
-- 
2.9.0.281.g286a8d9

