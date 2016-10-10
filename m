Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F1B20989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbcJJR0W (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:65285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752636AbcJJR0S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:18 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MJByE-1bqtBc4AbC-002rB9; Mon, 10 Oct 2016 19:26:15
 +0200
Date:   Mon, 10 Oct 2016 19:26:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 18/25] sequencer: do not try to commit when there were
 merge conflicts
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <c043a4e3eae33dac5b0d1ac802dba14311ab42c9.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9F4N+iNGSUxS/Y/MzReEnB5uiYAD/xUB9ptUONuRw6cy/g2QCR1
 OpK7Q2j2ewhv6rkMVSk3VU6KsqXc4ciYU2HBSlh+GE1w3PqnzjV3qBolqfLedzBdM8ucRin
 B639LFJ+dfracVT78+t9rokoZy0rCqnMdu0RTJTDmwhZTY8tkgt1zT1srVtfrkscnWxJkPG
 ey3xzf2V3decFY3HS00Cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QuuPOPbHVC8=:GLR4cJkoBxbKWLArbpV3Ui
 6g6tL7a5aMBhauk/XVvZipstp7VmX67YHqxfpYnfZNi7ECf7Joua0dRJVf9alDuMbu+qJ9/eH
 u6gzH2wBbMIUYTk6A2J23tsmePwtPQQ+YDdIYEgBlUMW1RImL6nVQznkcb9VNp2cgBVJN4/+S
 7cmtCFR4qRjh2gea3/qdFuwQuVdcukodC5K85To6MHW3HBC0pE8GHI78IUGUnjK4kNOezXVOV
 qSXjHGGaWLF+bzIGSgFe6PO2HadqWEMAklJjRRcI66xZ3f3b8AYjz98YWUuX5/QApv6ycN4PG
 dHFfd4Ptnpba0TOql7DAj7ETZICUxbuOy7JlqvdoiH0rdw4GuSi+n0ME8fh1XBGpjg6CEH/zS
 LW7Hwpu6QjydOr0Cb8zH7IfXKrwtEl/vx29AqcUWTbO3QC1s2tGgydqsu1Wjd+2XWpAXfNyJC
 k3DerJGoNHdeJ7BEwSE5uo9RauPYJ/ySNKY/cDNEK7hpbeyMTkirPn6yHUPBBk/VIDiNLXFew
 fTT1kFoXyVGMdiaIuT8yvBopX4J/aa417W/7o3SnQhmjuGCK/uoqZjF3vN4oqJxi5vI7vTVJg
 OjroYHe4mq5qB6PBbesDgpOboMxRcxihP7meUD2v+hUQmsLwU7C/K9OjBFvm75ZenugHkPnH9
 SNUbQ0PlGOecx+vBHXVbc4FvTgRcFlmkmIiwMFKoYdMilvDi2B4ziunPXdRLV2JAs/gJRGaEy
 9ZbsQBUeKKsdO75fxhTOX1e8GytzgmI/GmxoQzC1HagVU9n2p2JcZTgJTeajKog2nuMIEd4Wn
 KyhOKfo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return value of do_recursive_merge() may be positive (indicating merge
conflicts), or 0 (indicating success). It also may be negative, indicating
a fatal error that requires us to abort.

Now, if the return value indicates that there are merge conflicts, we
should not try to commit those changes, of course.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 108bca8..23fe7db 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -789,7 +789,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		res = allow;
 		goto leave;
 	}
-	if (!opts->no_commit)
+	if (!res && !opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
 				     opts, allow, opts->edit, 0, 0);
 
-- 
2.10.0.windows.1.325.ge6089c1


