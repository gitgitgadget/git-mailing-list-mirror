Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2920205F4
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756366AbdABP23 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:54744 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756358AbdABP21 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:27 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx4dh-1cZN3k0dI1-016iu8; Mon, 02
 Jan 2017 16:28:21 +0100
Date:   Mon, 2 Jan 2017 16:28:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 24/38] sequencer (rebase -i): record interrupted commits
 in rewritten, too
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <90682e922832844663a761eaf96885f255a405d9.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PO6tUxlBPOHho9UXxI5NSYQCVCE0CJ3+PBcJTTpIhFdCk5FZBcY
 kY33aYLFo3Y6zQXOk5OmJM4oxXao6I81NB4VEUQxrwAqNAV3WmXH4Er9mVCrG+4KMozZf9n
 E2i4HtV84YU41vANQb2y3sXIgWtHS6FiBKEoSYn16cWF6IhIDVPS61qZHkWgBhwkRqEoPi+
 DL17hFtMhrawsj8vnXf3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A6gnYJ89Ujk=:FH6Ve4bjz+MAxOHFjuhssV
 zOGVd6D0n1GXsxp7g8bKxvXzxLQY/qzVq8zvKPadhkdWBmtsNl/4eOsLwpz4eQEODgOqrFand
 b3ePoPMAhctQ66rA4BDe+URn1EqFPfc8gZlAHt6ErjF3k/Eq+042jJyidh4HW3wSInuDfPxwr
 a3ZqqL1CH3GO06PBxTf1+WZ+/XQcwo9TRv/a1l/1Kh8e8ouFTuYZQlTIzyuI4PH7X1GGcgTXF
 5wFebKg9ZlXgFkYKTUKybLTPL8VoNwAQZ4A6Nqi22wimu2zd4rkMxsL1SnlTC3iblZyWRF3KH
 VCDO3kFD0cQB++ViNdChO5frMBrXwJe2uNSECO2h+TC92IZTpXStTdlJ2NJfPoJ7EnCyJKKBn
 qR2HclIhoFJtGSbfiMidgl0lxVjhIMVnrjVu6fin8xne24LiHm1d+q4sfjAuYEL02mWeHYbWc
 hC0q1AAINhasBXdxJjIM/GIcnyhe107clxyT663mxNaEFwEgHV1yX18DJK1UXjXWGF3mAeXEP
 /VzaK0hHd4Cv7Y2s4vPIdVPjxrmxKcu2uMbK/sPzD5LtohzK8+C9SBIxLbHCiwW7JNsRiCNc+
 NDH4/JF2QcsxcFtiZqz3NATniSWLB1P7N68PXv9aYdmoWCZzfHUAVEPAhIPZu0+sEuW7FAb8C
 q31yDJO930y+oIxvHPUKKP5Eg/bDkF2jYJ745PqWuRNJKCB/YI1TsQLvQyFKPuUd4YimYMNzS
 gQtaepHf38BPGjDeJUvl0lhdnr9JT7DEFAjZ2PP7NviFi6NWedaxLlMsls9xYQn45uS1+uf7V
 ZhCO3Oj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When continuing after a `pick` command failed, we want that commit
to show up in the rewritten-list (and its notes to be rewritten), too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 50380a15b8..d7273fd1b3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2060,6 +2060,14 @@ int sequencer_continue(struct replay_opts *opts)
 			goto release_todo_list;
 		}
 		todo_list.current++;
+	} else if (file_exists(rebase_path_stopped_sha())) {
+		struct strbuf buf = STRBUF_INIT;
+		struct object_id oid;
+
+		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
+		    !get_sha1_committish(buf.buf, oid.hash))
+			record_in_rewritten(&oid, peek_command(&todo_list, 0));
+		strbuf_release(&buf);
 	}
 
 	res = pick_commits(&todo_list, opts);
-- 
2.11.0.rc3.windows.1


