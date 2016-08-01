Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D161F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbcHALpj (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:45:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:61377 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316AbcHALpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:45:09 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M4o41-1b4oCA3hHh-00z1Zp; Mon, 01 Aug 2016 13:44:24
 +0200
Date:	Mon, 1 Aug 2016 13:44:23 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 08/16] merge-recursive: allow write_tree_from_memory() to
 error out
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <b20cdc35797d5ed97a738e85928819088e31a01a.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6hwOOJEt2nxR88TD8DHa4NRSZ5NaiHgorO5sCmBFWn2lGlatZ73
 +5OQzqeNHLLANU4/CH7H450lkMddy3Yz2EEctDRRNNAI2ohYDHhkCDiq09fLpcFsjOtABDI
 W8uZufWozMcu7nZ6iFBqcFwuWVme34zyV3FImKC1wiM3WLDYZshRq9UzAtjLdnF9LWq+l2c
 H+zFGEmmgWAEIBrJOG3Sg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:/Dwib303qv8=:Ropr2SMU1g0Q/8DnjX5iCU
 GoYnE1QlZxz+ssAySveE69rSwS3Vjqtk2aEWeYOimN68q9MhEJEIr1SNPS2Qb3W87taliXkUr
 ShWe9pKDbx2TvNxPKn89SHSSUTNqMJwjBp1O0ssYlOQNrhBARq3e7df4IV4qnAVVoT5vpuFqw
 HFcYd4DbLwkHTDqqFi42iak/qlWsYmgQho6p9+cdtajYnUuabFBOMumccDNnnUcwNCAB1uKCb
 TxhF1XrSTphBmycfz9uJi//Rz1KtlxJD6bKzzI71QBkI/mpIggINEBrwtLvJ4IRGiJCmDecrz
 V1R7LGtqXt7+cKi1hSiJgw+Bhtn+cijhPLlRa1osnE7t9UeuCKgCHf81ArOHVGRbUdy1/mQqh
 oahLelFFuH7sqhw/WQQu3uNFLY3AN13cW/awB2zdAbSkaaGuzXjL1AuM2oTQyvsmtQ39OjGXz
 dCXhkWlAYGBqmLL9JJDiXZzJ4rWb/x/3aQDYJ7/2fuWXeh9yhTaOwZLv04P6TPtpZxjDO+yKA
 DSl6YG8WcgqzFFC9r5GFu4TY1PanJHp4dDo4BHWY5vvXDkVlwnFtskeJpISKiaCwhL/Ikl0RZ
 Ccrjfi0xALThiPKR7ORnr8fReL4iUsHs94MWCV/9bxQhwNQAvJ4yHOyBFgDr0eAy7Vsswpvsq
 rab1A9QzBYywFjT8zIJ3dV3rCzhmZrqa6JG7rO50BkJ00tD5pjUkT2JtZx+aBLPpoR9kaXyFl
 ztho1wQXIm7CFGfn40kNdvocXeSJW/dLf89jZEMc3hNeyzLRdSLLTCJkpGbA5ROKb1LCXIWQX
 CU6gQNo
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


