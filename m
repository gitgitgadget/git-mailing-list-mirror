Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9351FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbcHZNso (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:64930 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752653AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M9b4B-1bqEr21xkd-00D1kn; Fri, 26 Aug 2016 15:47:59
 +0200
Date:   Fri, 26 Aug 2016 15:47:58 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/14] sequencer: lib'ify create_seq_dir()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <27e7e00297627039d17f6431c58fb1ce3aff08b5.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WuJuisMr9FtEN7lnvm/oRaNy7VApxM+srt1bNIxV3jo2BoTa5Q0
 thfNlqR6w0xPWkwN3Z8jH24TmehM+dhrOd9igP01JuHbhmfk9VoUZZ/VHZ7EZM4qycGP4Wc
 YYz3B53Gah5ANOqhFmPWIZa10d6wsaHmiPvdAiCTJ5thE1Kl+uAsH+SoATT7FhSvJXJRy+S
 bh/xZDLIBUgE9VYdUiQiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7FD0Ao6DuIQ=:0mnmB+PTmDFzEIqe3YmxEn
 sEX/z5Q+Qd2qXg7dzYTySsH2v1xF2D26qKp5uMgHuq3pDSGzPOcoQ+9zLqFx5YDLhTf0nmQvy
 OVvFrY2BIeycmdF2rwwOSm4PSwEJEczyPc/tMngV9r9164U7PVqatOzv+TPpiLlzgw7fdC7NQ
 j3Yw//nwVUId3Chwri56OUsW5d4NAEEWMy2t8rRDQvaomN1Hft2uzekc7oISdxtK5wCFcUP6R
 pxpDm9AaGaW/pOBoagMoa7uc0OSrSFjcf59xcLRLt3hFmke8PAnpmBM/dS34fNmqi2D3Fy5SH
 LoVndyAAldaY4nq1+Rym51d69Y5ECGZCUw91nrQxFPPhePcibA6exM/TIkvAut41STi1v8stQ
 3YkrbWGyszkxDSsvk/EqlzhNs3spMr1uB4woiLgBujJvtHXg8QAu2hi+sqz8RGndtV3qUGitW
 ith7SJ7q0IsX33wYLzRAI434Rct34N2UDIMnCT60dury2b+ILq2IYMk7vyE6HGqBYQVVu+KgC
 tsqTMsR3C7T1sYTS95rlr8dPxVqvYWlJDmcVYCKU9Ufe4XyYKvjcYUDEewOnRmX8+qtNsyI6f
 qHW1V1AKkAcHHTz0DKJnkNf8dKAYXiG3flXo/YTJQBfLOF4avQx/UpBxX9ycNVQAxZ8/aBE56
 1L5HdkFgxoTOO+9D9iKTSiz87MZcJLAokIbqhZRHHE7qUgCzhP6m6lD1K4FesoIx2ScArFnO2
 bN+GJDWwaClcScelAtGzNLTk43ZVBS6BT2EZrPEBJk1GKHmKHdNnkrIbc+lycDsQ9rxjCHUPj
 uUHrgcc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The only caller of create_seq_dir(), sequencer_pick_revisions() can
already return errors, so its caller must be already prepared to
handle error returns, and with this step, we make it notice an error
return from this function.

So this is a safe conversion to make create_seq_dir() callable from
new callers that want it not to die, without changing the external
behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index be6020a..9a1f0af 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -841,8 +841,8 @@ static int create_seq_dir(void)
 		return -1;
 	}
 	else if (mkdir(git_path_seq_dir(), 0777) < 0)
-		die_errno(_("Could not create sequencer directory %s"),
-			  git_path_seq_dir());
+		return error_errno(_("Could not create sequencer directory %s"),
+				   git_path_seq_dir());
 	return 0;
 }
 
-- 
2.10.0.rc1.99.gcd66998


