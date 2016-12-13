Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98B32042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934215AbcLMPcu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:61614 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933979AbcLMPbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:47 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5tU1-1cWhAf28Nt-00xswB; Tue, 13
 Dec 2016 16:31:36 +0100
Date:   Tue, 13 Dec 2016 16:31:35 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 21/34] sequencer (rebase -i): record interrupted commits
 in rewritten, too
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <db529051453b818c36de71bf35f6dfa6ffba8c3d.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TDaGv3cfcOeVE2EOb/Et5pqOGjjOH1/PJGsjLBODKA/T8IVyGNx
 9D9dJwTbEKHlna+oVjGwzgVQNeYmnSrI/dc29t+FAIwMouHy31ojtqYraelUf17ANfdjn9r
 pOLw8QQuRiqJ+/ohbdiX8Yb9s1Nfqa8X6ClOD1T/JaLCsY6fPlb9sjIehvLxs4ZspqgPCUU
 IRG1JU7gk8yUtWcI8g7SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SgNb9V/OLYk=:po2TaGyq6KGio2YoBAoAu4
 KW55LgCFPZgqgLwPfVZ7asz3A5dqLQ6NSzfMKQ9vN89oiIMSa2yrxYb/z7PCZDtBHi1bwuU0C
 mqPj7WmhVnw6Rip865tdhKTKKFri579JiXSSSHcdiYcbRfE6cmsqlwaQcG4O5qcmxCHbxseth
 bKS4MA+CVpNSfroz/IZxMnrqHKgQotzoNX4N0f+Gr0JTUZK3w1mzmmTjLoGhECbmTZ5l6sw5d
 9BOjquqNJnRvbHJrELvP/+vPzDdVMg9BntEyw5VyUzjK+cIDzCgmj8l/b61kxP/Zw54DG9qqY
 7fWySVTJptPsDrl2FvjKLRkkEced/80heLQ5SJeRbdfG6HbeMreSpOHToXaO+GWQB/vhUtxQO
 Va0OjLJeDTeFf9zpdHlvFY87eENC8eoGmzcKox2ozz+hZDv5UgVqBDwlogXK9rlLufCMxwQkd
 6n5gSx20eu/HfNhMc38vJ2aR/XO+lq7sr6b1VFqcCXbXZp9BzOlpS1Sf13EcNfoxDtV0amcvg
 leaIrVW6scvxQ+zp5IWci/8EH9lQou+P/P2CmhaTs/oA+FJA2BnGnWb+VKaQykPHiijNjNCGf
 TWZwKGguBV6pMAU0Qux5R8Sl+joXmZfeMu0Q6mv6ZFHtddSI8WNAnTK1Fy0ITgyzNaMOUJXQj
 GLnRBa/GSJ9VDJtSA85VDP8fM7UVAu2c5PdPBJfGe4/PC9eG2ZQyY4Zhe5u+bVzvhD8Gz5vsN
 uAuIeqzBmbIhF8KBUCY/AiiOnjE4LKxQEG2s0tkvl9/gv07Jd73F7x6GV+/YigCdjB8ruQOKE
 0WMLu0D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When continuing after a `pick` command failed, we want that commit
to show up in the rewritten-list (and its notes to be rewritten), too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 7ab533abd9..0233999389 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2052,6 +2052,15 @@ int sequencer_continue(struct replay_opts *opts)
 		}
 		todo_list.current++;
 	}
+	else if (file_exists(rebase_path_stopped_sha())) {
+		struct strbuf buf = STRBUF_INIT;
+		struct object_id oid;
+
+		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
+		    !get_sha1_committish(buf.buf, oid.hash))
+			record_in_rewritten(&oid, peek_command(&todo_list, 0));
+		strbuf_release(&buf);
+	}
 
 	res = pick_commits(&todo_list, opts);
 release_todo_list:
-- 
2.11.0.rc3.windows.1


