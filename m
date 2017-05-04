Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 912A6207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755473AbdEDN6u (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:58:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:54545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755222AbdEDN6t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:58:49 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc9U3-1dODnf49Pr-00JalF; Thu, 04
 May 2017 15:58:37 +0200
Date:   Thu, 4 May 2017 15:58:35 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 20/25] shallow: avoid memory leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <879e7b73a5e11ade4eb633c2306c6b9d9d4f6018.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QaFXes9hsVm9Vs3dVwE7Qz1FuVnI5fFgXBfjcA9iahnWbe189gf
 bJ/bPCtNE0+KDeyuMcT4P1KEZYdPSV4WoNx/Hr8MTanOgMzFglx2ev42iHWyHsq6Y0SjduH
 J0uFY5gleLkwysQXHJDPjXlS87wEBkmW4wXp+1+3ylv3Opak6i4hPHbizJPxdosMZiH8Gag
 h6NmDysgCuep9nL0ObJEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zmq4G4RUGZU=:WxTebolO3GB76Zkz0fayeR
 LvTKEChHih+mVrW3MR7JVPH95yixgG4FvLv7RpN3VscuExZdInzgrbDhpzlLr94OO8A2BO2x4
 VwiPYkWDCYZ9prnsMhxC57KfwEgArTW2bH+e22A2qKtfZYla5qXG7iryeQ38R9FdxAATnXSri
 N0cdIfXpGT52RKoMDgPfv7YrlEkVIEKv2P7w7EK6l+eltNQndGpHHvI1BlVqfNiLAoC8X95E6
 x26YHh1plxkZCW4wpNnA9xe13MR/XGparCE99WlFaiic6uV9Kn/u8Pd0auCgUEWTz5SYDE3Ls
 twOXdL5eM4TUt+j3iT8hZHgxuNWOVOgCNnxJtVpK1BImPaSblMHaqOXC9uaBNmXLGJHK8qtRc
 4Z/izKpcq08Sms1t9KW5vACC3aP7tZPMZvZm9UiFoErsiViIOiAKXmv7Os3yyCf/ApuG9XOmN
 RgFBrF8rGzq6OdEdB1tBvE64PPOCMmEUCpXkwqJWIKby+C8DdQy/cwdhtm8/spZtJ642Fmnd2
 IgkHHEhHqdT4CVEEyvR4U9d7N2VhSURWXcPd4sUwvGbEM7xo7dw3WfylnzarbSM9Elj4ssKTU
 LAQ2olKNvcYFyl6+gT9iQj7u8eSOzqxp/qvmCoBHyCdRR4h0BkcvT9H8PaNGGXEJyfJU1ffIc
 WGkcFKGLADVz6xfUmnsPrnmSxUUSq7TozNbXGHZiW4w062YR9aX1WL8YybOTbhJjUpJnrAe4C
 1UXXmpqwB/lemB4QxwLQQCJ3j6xqUzt6YYMQ236znoRKaS5504fQivPV1Q4npk+1bJ0tzFJI+
 eh8h+hw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 shallow.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index 25b6db989bf..f9370961f99 100644
--- a/shallow.c
+++ b/shallow.c
@@ -473,11 +473,15 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	struct commit_list *head = NULL;
 	int bitmap_nr = (info->nr_bits + 31) / 32;
 	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
-	uint32_t *tmp = xmalloc(bitmap_size); /* to be freed before return */
-	uint32_t *bitmap = paint_alloc(info);
 	struct commit *c = lookup_commit_reference_gently(sha1, 1);
+	uint32_t *tmp; /* to be freed before return */
+	uint32_t *bitmap;
+
 	if (!c)
 		return;
+
+	tmp = xmalloc(bitmap_size);
+	bitmap = paint_alloc(info);
 	memset(bitmap, 0, bitmap_size);
 	bitmap[id / 32] |= (1U << (id % 32));
 	commit_list_insert(c, &head);
-- 
2.12.2.windows.2.800.gede8f145e06


