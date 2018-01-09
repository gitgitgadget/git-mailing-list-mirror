Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A024D1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 14:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755874AbeAIOdA (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 09:33:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:50889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755927AbeAIOc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 09:32:58 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIQlv-1ear2910P9-004Eaf; Tue, 09
 Jan 2018 15:32:54 +0100
Date:   Tue, 9 Jan 2018 15:32:54 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] git gui: fix staging a second line to a 1-line file
In-Reply-To: <cover.1515508360.git.johannes.schindelin@gmx.de>
Message-ID: <35fabf987c49f3d2adfbbd5b18edcebe3cf06542.1515508360.git.johannes.schindelin@gmx.de>
References: <cover.1515508360.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ddskPAFCLUj9wR81D4ZilkghH4oac+KY4H4MykT1ASw431/EQfd
 oL/012HXethgzpHQOhJyWiAKr7Jf07u06F6U5Qwz83+fk8r1DHss1OzXW9n6vXJpCgK4HwD
 bstEXYe3Na7BUhMJYdkSdMlwgC0ial3uM7XfLqfKmiKMMn2QeTDoKOyV9gOL6sQQgc0+uNV
 8RWOKJcTv4m/NQlmwXduA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cs/AC1BweiY=:G5kAHEoM3EsPrImWFlYGz1
 JEYkKXrP4C5mHds9V5660ktxdUw3L7P/xoInjIbEQkXYv1LJ2pf6URFPiSCUw3Hgeuj2bbli/
 +H431ksFiYKcimvolAsLFjocJE7uxsBs9I6NsJrr1tSMCDzww20NuA/Lxea+xcijwau9FgiYW
 UMmImgvibvHvxnhnidNGfrcspP7kY0lISaJAryC1n5WjOlHQSyf4fzsDizP5nPgQPVpJ+CwIW
 ab63bGGjIVlHlujx8njbGiAZ9rESTGhXQEO+Ae+vO9RrURS96TDK1kOVlYvdp1qju54ecIgfo
 AhGw8s6hwC/dfsSw5kaXTjiYJHA1uQfxRU7hpsZK+tTdQL5x2KIVno4o6tO3w61ZLnYSdmklD
 VwJyGKZdBfWCJCt7LSPqJ2LfeHYc19Jz1FyMUMnvoqqQ8SZ5LS6de2c0ITDF021s6Ii0IJVRy
 NBwkmrQti/2TeGCBYoHvXh4jmfMNEIFNUGnpdyqbBvEMxYkYca+oncgz3wZaxluKXjTypTHoc
 9tkJaZJkAsAD1qJ+VBWw+ndOLVub8QxDoosW4AG5coD3Tlt6XlFH0QOcEinxfNqR4tL6lvjip
 Do6bmddYvB24PrJl/67bb5JW48h8bUY+HRtmSwxds7zpr8wRwHkc8WhDgn/JGqAw10KxO1LtV
 KWEoSbd6wpidrriwGyr+bO52W88uEX2/IebnWZrKGlIifziyXQ5DIzhlFzhRqhWF+6Us8LZDq
 MBNMyikgt3h2kFef9bLuwjBvZsTtEMumZBR7sqHVixmmunZ/sCT2JsCoVpNcK2QzM4uCWzSTc
 ZHMXb5WZv8rKYHLuL0exKTjyCCVD1qRElu7toj99dGPHHh0wV9HyYY7mc8ScmtUtnmr5k08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a 1-line file is augmented by a second line, and the user tries to
stage that single line via the "Stage Line" context menu item, we do not
want to see "apply: corrupt patch at line 5".

The reason for this error was that the hunk header looks like this:

	@@ -1 +1,2 @@

but the existing code expects the original range always to contain a
comma. This problem is easily fixed by cutting the string "1 +1,2"
(that Git GUI formerly mistook for the starting line) at the space.

This fixes https://github.com/git-for-windows/git/issues/515

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui/lib/diff.tcl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 4cae10a4c7f..68c4a6c7366 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -698,6 +698,7 @@ proc apply_range_or_line {x y} {
 		set hh [$ui_diff get $i_l "$i_l + 1 lines"]
 		set hh [lindex [split $hh ,] 0]
 		set hln [lindex [split $hh -] 1]
+		set hln [lindex [split $hln " "] 0]
 
 		# There is a special situation to take care of. Consider this
 		# hunk:
-- 
2.15.1.windows.2.395.g5bb0817ee52


