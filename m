Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EB31FCC7
	for <e@80x24.org>; Sat, 11 Feb 2017 19:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbdBKTvR (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 14:51:17 -0500
Received: from mout.web.de ([212.227.15.14]:58904 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbdBKTvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 14:51:16 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeNUV-1clefP0dyx-00QDT5; Sat, 11
 Feb 2017 20:51:12 +0100
To:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] rm: reuse strbuf for all remove_dir_recursively() calls,
 again
Message-ID: <f2549b5b-b3c8-3935-cdb9-9908914195b6@web.de>
Date:   Sat, 11 Feb 2017 20:51:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:oOkyE+ov6CR543UZ4/5mNxs+MnXVL0ju2+plRKIuriFniUtlJSx
 5ycQO55p8p61mtLruI8BJ2+r5aFUT1mp//i7SymiFiZ0aQfkj6mctdsV/9AvGkOZDsCkkBN
 H1KJSaZOl54YfWXp8pE9Oi1++AuesJJf2Kv45rztctTyNviQryt1xjpvfzmuAd7+tC/tdLE
 zOOuYCzimjQ0I/7QpgVvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CuPnn3DbeUU=:JRCivVSYd6VGwa21wCxWKB
 oyCOtd0F1GgpOTe755NLaaxkN7ewAXu7jlZpLYQd1SILiekYYIyDrq+oIlsRpIMnlDDCU/ley
 RJvb3Io4PSxMDPqm8BfmE2IcsnNtIdu1Zcx5A9qiCc58OmqZUlpvt73AYXWXqG3u4uDTf97tp
 V8vLiWMvjMMaNhmkaPZMSpDmORk1WI3MnjHcnf3a/oIUlojG1dLJ5+AH1foaf0xlWHzVaNXkK
 sgcB3dH/45djf5ife2eQ7YWgtrKrNpYjMcSBjIgvdySWkhb7IObgEP/AjNO3Y5r6FS+Hns52f
 7oD6pySjayZk6xtlgI6f/If+2YWX5073ljEIUhYaMF7roN52YZSUCED0m8PAxFV/GITH7pVEE
 Pxx139W+rOspBBiORtsRWviR8tmqPSYUTni3H2EkdvGTMrEMq+8d8s8LDSzDv0/GNMvAsfil/
 6S83twmJW6FwrEu5pAp4prEfkzGHdm22pkvCj1RO6BgFnkcdQGvf7yCFxE39L3V62ZfPr1Lug
 dVO+3nLpNrVY//ZiRS7gO61SxhYsjIo4tdhr3njhbSMhjnHhTYHocge0oUtx8YJfOnzif+2kw
 mpi0OpqvyBmF3hSKrq4cQNjkMxHnNBuHrDPNdSGO9OLokEY1Tae1jof/eyb63PZ1ln+RsCRbZ
 VdOxjVCP3QHkU4Db684MUXGGEoiTtEj/5NpY0qyJG1ix0tlTPcRq7diMb+dM2Wb09TNuRimsU
 UVGEk+rJal+DkkqsSGrWDBsrkfvKEbIMi7anwbG3HjTxiJ89l/f0tsH+5Kgn381Y/aeUeganS
 RUt+amV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't throw the memory allocated for remove_dir_recursively() away after
a single call, use it for the other entries as well instead.

This change was done before in deb8e15a (rm: reuse strbuf for all
remove_dir_recursively() calls), but was reverted as a side-effect of
55856a35 (rm: absorb a submodules git dir before deletion). Reinstate
the optimization.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Was deb8e15a a rebase victim?

 builtin/rm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 452170a3ab..fb79dcab18 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -360,15 +360,14 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 */
 	if (!index_only) {
 		int removed = 0, gitmodules_modified = 0;
+		struct strbuf buf = STRBUF_INIT;
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.entry[i].name;
 			if (list.entry[i].is_submodule) {
-				struct strbuf buf = STRBUF_INIT;
-
+				strbuf_reset(&buf);
 				strbuf_addstr(&buf, path);
 				if (remove_dir_recursively(&buf, 0))
 					die(_("could not remove '%s'"), path);
-				strbuf_release(&buf);
 
 				removed = 1;
 				if (!remove_path_from_gitmodules(path))
@@ -382,6 +381,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			if (!removed)
 				die_errno("git rm: '%s'", path);
 		}
+		strbuf_release(&buf);
 		if (gitmodules_modified)
 			stage_updated_gitmodules();
 	}
-- 
2.11.1

