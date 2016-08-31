Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEFA31F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759549AbcHaI45 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:56746 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758979AbcHaI4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MNqcR-1blJeN3eZP-007T3Z; Wed, 31 Aug 2016 10:56:48
 +0200
Date:   Wed, 31 Aug 2016 10:56:48 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 34/34] sequencer (rebase -i): write out the final message
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <02db26b4320bd9f8296358acd2a493555acae9aa.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:49XL3TVtAVeIYLwtNhyXbEZxiSpr/tAeUF0t0NmF8xHxRLetHuu
 MupUpM69HSdKwd6m093FuBi4I1+ZHI8qqbnehafvshawh1q/vOWi5i6WjCjl0B/9WCBUuLY
 0CVXtcCXqL/rnfj/BmtMOmFIbr94me315Z8Pn4hcQegba7dziSB9WCWQ6b3jjqlu2wfu/C4
 OKzr6BPonGyhuBeikREyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8UojFtiFhSc=:9tVftT7HZ6j/MY65Yyuohx
 nOfJGu4+ERpec1xmqVvcwqTkoYYeW8Fahva4r96Uy/m2Jvr8dExMKIby9OwYHqIl0WUTrjUM1
 GW/7f4vX9Hwa9odxXSrDJqdVhLsK5mak/7qPup7f6UzNIpugbYZJoCY3hiXX7/7zQoBFYa//X
 qUHPh72dxbEO2LyYav4J1RP9WyzRbF8wcYJtCfrVqMiPtpsHz1USEkUER/w9SzSPKAo3aYiMW
 +9KBrQXnVgck55l363KroaNRSqvhkF8T7rKwyvcCVgtA87+/6AEEVk/6PVgrf2OfDQVC6jig1
 IejSxU9DIOCLwk6WJ70wRbMsf9+EXNjT82gBERTRUmmdsC0dfQI4iVFfe4wGReFKVKAOzHggQ
 0p45bT1yqfsdggvOE9SogHW2tovvNpIrhN2+9dC0aesT/5/Y2KPxABgT4FzmhYpA8P1nhh/VH
 MdNUAYqz/aRwlPh0ZQv6sH20tW+bcciLpn8O/ut4okevgNuQU2gDXDMf8EFBzJxbREyVuomZj
 SyiBItZXRN0XQMK+GPtj4OL5jRltZWgpz5oBbyqjNPixphmKd+D/fdIXrJwXqzTeEFcw9+HQp
 XnWc69V8VrpVVx/N79R26n1KPunE0nL+4F/dpTej5p1WUoKRyTagaB45aYUH1nCJkVxtSemnZ
 QwV0jmuGeklqAL379mzOJZ+u095/RTAJRGEp1+KaBOSYqxmXMxsqBrIZPqJ1ScRYBQDx9cI0X
 G3VxOjfHWHG4tvhi690FovqJS0/P0F8YgYW9ou2szcS7M3GUn0Ej9EOwiQPImGpKQyqjoeTeD
 G0Bx1S0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shell script version of the interactive rebase has a very specific
final message. Teach the sequencer to print the same.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 9a8069e..6064018 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2090,6 +2090,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		}
 		apply_autostash(opts);
 
+		fprintf(stderr, "Successfully rebased and updated %s.\n",
+			head_ref.buf);
+
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
 	}
-- 
2.10.0.rc2.102.g5c102ec
