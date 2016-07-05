Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22DA42023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815AbcGELYB (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:62606 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932720AbcGELXt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:23:49 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MI4yc-1bIk1Z1BnC-003sJY; Tue, 05 Jul 2016 13:23:35
 +0200
Date:	Tue, 5 Jul 2016 13:23:34 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 06/17] merge_recursive: abort properly upon errors
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <a816492a3b22749849eef64dce279e313709fbe8.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NKChO6B1jMDfq0sZn3DAP+/aXhQaytj0e81Y0e3vV1SR8Tf/IAF
 PZrFdmOYeC1QWEMpxq+5JktuNQdxTo0ICyloGH9ngARYmFaOmgz/5/ZyQkGYn7k7zLD2nhv
 FrxFmShEQySRpVsxuljRlgmu5ueWtgXI+9IF4MrLtpDEx6BcD+NzG+7v/kLY6mLw93qPy/X
 RteG6YEuQ3HPUVpfXKgxg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:kvuDxnrYyiU=:c4HDqvjEGS3U/c3v3NUOX3
 bb3Zie0v9UpMGQFhrBmwVVXXjrLu31UwznTRpmgU2MRJt+C4NkKjPI8xnJ1/1NBDwjSYFChAZ
 mRITaJuGtR5qRLzBoO8v8mkUwQ2c/MbitfWMc4jmFfnjA0Ab2ESYRDsZnCeMXAmPuyaZTnYXu
 s84slpmiHoOBzenQsiKZgdIi4nFMnLhDeTHq7fqxF5xLd5iUgP8hAIO/0PSOPkVrUbG/ANzIO
 321Vmu+AcZjsirpErmYJ+//jjiDP/filb1KYenN9WvmqsvV0NUl5z84II+B+mKuvKb7/Eqh3W
 EEVDbIRHnYIsHboTCc6ac4hgsqtQ4f1QVHOlNsSprfZ8D0UYWNGOFlvihJC38UngPH2Hst5jb
 WFoMUzm9P7FF+K+4w/pD4iy1fGSGuB2GPkVpoSZbFbiY5TblfV+5jrMNotfefW9H22pXCIrIm
 2EHfaLUDhYXD3oXNEz9jAgYqXYecTVKpNQI4jc62YJzCzlF9K3B5iT02NTMvtBwaA9m4H513E
 UjGaDqdqFBnMfl9ol9Vy3clfCHGM0chj8Hq9bXUhsvgLi81AUymNFAz1ivqHVHHmAPUuTq6x7
 pu6YdA87SyPDUlPFOAS4dHU1lnkToxPWcJG1VAhx3rwH+I3cr9E2mAkxrq5LnmNAAE23J2ukM
 sLJAsTtyqNXpC74a8lxCCdWpt5LR2tiMjlBQnEQ6KvkDp47avCFMJ1PjsFUuvS7s02DGVWW6c
 ZFhfatBzmQDc2K+g6sMbxI7FHI9MKo8RZeI9qSYES95uQsX61sxmj+TxF5f3iP422QerlvrLN
 ThDaOW6
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are a couple of places where return values indicating errors
are ignored. Let's teach them manners.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 66ce27c..716488b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1942,8 +1942,9 @@ int merge_recursive(struct merge_options *o,
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
 		o->branch2 = "Temporary merge branch 2";
-		merge_recursive(o, merged_common_ancestors, iter->item,
-				NULL, &merged_common_ancestors);
+		if (merge_recursive(o, merged_common_ancestors, iter->item,
+				NULL, &merged_common_ancestors) < 0)
+			return -1;
 		o->branch1 = saved_b1;
 		o->branch2 = saved_b2;
 		o->call_depth--;
@@ -1959,6 +1960,8 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	if (clean < 0)
+		return clean;
 
 	if (o->call_depth) {
 		*result = make_virtual_commit(mrtree, "merged tree");
@@ -2015,6 +2018,9 @@ int merge_recursive_generic(struct merge_options *o,
 	hold_locked_index(lock, 1);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
+	if (clean < 0)
+		return clean;
+
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
-- 
2.9.0.280.g32e2a70


