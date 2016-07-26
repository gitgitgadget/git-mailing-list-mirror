Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256BC203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050AbcGZQGl (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:06:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:57058 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757038AbcGZQGk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:06:40 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Ld0jY-1b1ZlG3iOu-00iF3c; Tue, 26 Jul 2016 18:06:31
 +0200
Date:	Tue, 26 Jul 2016 18:06:17 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 08/16] merge-recursive: allow write_tree_from_memory() to
 error out
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <743ecd0b59dff75017dd56013f5fdf6f14766d5c.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HARYf34PDJzm40ToqBGnnKrGzJBUT4b3xNvjl7cxr3/UoOHZXqW
 /hyyL4YVQPecPXyvZK88FGyaYxUoDxtUM96YHE4bJRStMz5v85A1TYlkETVUlpn0hR20MTw
 KG6DUGbTk4vyliNsX/27r8MpmFGuDqfurqLQYI/dQYtcqKD+WYy2QM5OwUq7vDYTWoqvGRe
 HntoKPCrFKK2Q6k71RnrQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:4iw45kgXFWA=:z8qByO3ncXMX+EGn5tM7ng
 tPXrybhWlO0WtirlmlSy5BRStxwx7KALWXsENw7ziKWdoWCrvW9OOBgbnXysOK9/EhXsj9D5X
 Bpo5/jjcN95bIvCFMoxKIEXwZaa9Mz72duO/vknOK+148+Eo3rih5eHJtBBDiND2twms8+wnH
 M0AslHthNW7N9zAQA1oL3MqTBD2WKH19nmNGOM2Bt5Wurpngfl/zIV5Oj5oMurOxUblqiUfgo
 f59ctxbjJ2erR9PwZ8eU/wj+jkIbxO+DvZYC34URRHbTZOJTExYA/zw+w2fSljqz7Xm6Q+4SX
 1/R6+7ApoROOWDjn4U+DAKCxX5RFBrAiI4kC8bnyupNoDqJmR/GsnJ4zcK5xlfkL4dmUbbWqj
 F8cW2w7EEPcIAB+dPavv+3IV3jcybdjq4dCMwcbJv4Us57zQ9r7jKIb6w5SRWea/UjCsXoDGy
 nGfpLkVuOJQ/p5HW2PV9wqBJEhk7b/eJr+eJ6gEY2evfdSTT645AcpeTxBB+8Ud3RNWmVmEod
 Y7+IPRSaKwQ7rZ8dWhCrQIBMAoedap9jJQ64VtJoxHcReMNkxb+Vfo43CcqKm61AdrdJE29mF
 uZxtg53xjS0FLgW7t0xqnltEzjGwQ8el8m+/kQG8F1iGzH/R+SHSKneUp5xgimCHvDmf3D3eC
 nBvwd73W/IVcCKOneyDEgVfNjZudxHXv9ulCAeVATQzMgKg82AMk9wltabO7OD4JByYcEsAYj
 INOtXZCrMcvoNeIzvzMor+tDi6QKJ6wILlp4udPODIf8n1/pUTTvlkamHfY6iFV7IIrKLlGFq
 Rm71EgX
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is possible that a tree cannot be written (think: disk full). We
will want to give the caller a chance to clean up instead of letting
the program die() in such a case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2be1e17..1f86338 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1888,8 +1888,8 @@ int merge_trees(struct merge_options *o,
 	else
 		clean = 1;
 
-	if (o->call_depth)
-		*result = write_tree_from_memory(o);
+	if (o->call_depth && !(*result = write_tree_from_memory(o)))
+		return -1;
 
 	return clean;
 }
-- 
2.9.0.281.g286a8d9


