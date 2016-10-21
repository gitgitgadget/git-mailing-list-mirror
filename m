Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241AB20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932685AbcJUMZk (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:25:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:49918 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755503AbcJUMZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:25:38 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MEWxh-1c8sTl0gVF-00FnSr; Fri, 21 Oct 2016 14:25:24
 +0200
Date:   Fri, 21 Oct 2016 14:25:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 16/27] sequencer: support amending commits
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <6df19ad36240580e8717d4adafaf7b6e039fe2d6.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ttigOTP0QPsSTP8GItP2o18K6w/Fm4O7ckzh2eQhpCTVCnEHtnH
 GaoxvDGvIztz+YV+Rb16580dS0ejMZL+fLBdFiAVc+g1Xiu9qRnO/1lWRDamXBXe6B1e71o
 UAIdrYhFYn7LaaU0vRKdCp5sNTIwRaTu+NLLXwblSuw/etGzlKcueG2kaqPBduAVKa7ZJJP
 tmAZvpsE3bWTx3QxlnFdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jVLKZLLS3Lo=:7GP/ztMJGcFJsiKXzuEgIO
 gNoNtJ7IZptJUFbjlfkN1Z26hBtK/MyKo0yXW7fNKNO58mRS/5LwagHqMVvoaXTEXLVIEK6lQ
 z9BGpr44AZc7nkCyNFIdtmlVHkFIkMIXweDVPp02n5nOIAUuJGFsowA2SyR5QKtQj91q1WVrW
 DDuJCn6+YsPnSvPX0Z65rWcS0GqrDLVzCiPnb5nr91qKzfPxgGNUdabcBAvUU159OV5xwyIYi
 EfM4hfLii4aONbHfvapxo9Tc5UBWROGp5w67RQGboNhwDdqezYAh2kyLuS98fRI55mb+oBL13
 gVp1ozjiQo0pPpWJq5AjkLbbqDXBfYUm/fp1fLVah0RDO5tgDSOWoZJ8WSSn0kHiX2o/NHr29
 +G/NCrQoshJOyW4CP4yfGfdcw8kwci0kMejL/e6BsTrmwbCXLW4eU+HnhQHSAU95A+WkyxPci
 12j7ua9tBKeDyMfumrUQpneR/uSUSw2a9qdm9ice/JyDSnAmSxND4upCzPdR1bLS7SaVD04+j
 3CVM5kfuWtBj8DJm+Zn9IzrRbCmvsxTPCHLnYPLi5Jl9pjcpKGI5k7E8w8/YZ0uhC7HFGThOE
 hCMj87M7cg1P3qg2gWPExVu/NxnJ0W13iXAsQYETiR5/VcTvzgYC72zAlkvFcDmV14BVhgaAo
 KIA68PnTym5wJqLncmV0sbzs3wa8acbiO/zkBKt29ZjsoC922a97r3ioi3dj+DrBb83hi3PUz
 TvxvQSytDK+JSEKnrfvFWVh5ks+2ewvKVPj8G2UxIndzgUZcE9MNacDXt0SzYU2cqo4OZkLMz
 vuDkoab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the run_git_commit() function to take an argument that will
allow us to implement "todo" commands that need to amend the commit
messages ("fixup", "squash" and "reword").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c0a0aa0..1ef50a0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -484,7 +484,7 @@ static char **read_author_script(void)
  * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit)
+			  int allow_empty, int edit, int amend)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -513,6 +513,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
 
+	if (amend)
+		argv_array_push(&array, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
@@ -786,7 +788,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
-				     opts, allow, opts->edit);
+				     opts, allow, opts->edit, 0);
 
 leave:
 	free_message(commit, &msg);
-- 
2.10.1.583.g721a9e0


