Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F60207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 14:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161156AbdD1ODw (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:03:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:62770 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1036029AbdD1ODu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:03:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRGTX-1dWw2b32Ux-00UbsG; Fri, 28
 Apr 2017 16:03:34 +0200
Date:   Fri, 28 Apr 2017 16:03:33 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 17/25] fast-export: avoid leaking memory in handle_tag()
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <7a701d8239b4413e8733bcde938e2da186b87881.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4SVKz+x0bnp13f0o8AjZcwcYxyhFsVdtR2zj0ZESG7PAE0rXxfE
 z53aVlhI5xYZ32+ygXQepe8UhyadR6wCoCSIsrnq18TCs1T2OcVD9gUkW9vxsXn6HhtJSWZ
 oIGFlM6Hsf0RefDd10wD4zEYNXIzyB85Lc17w4yfyTu51j7lFOQSINbC1BxCXhFVwRCrWUz
 QmWv30PCwxcjoYrDsMV4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GV28JubhI9o=:grm1zsCiEtuwIYz8gHqBpM
 HLAwynCRjf9fkhooOPWiLPtMYgLFPai844KLbdU2NDwKliva55864y1NXEtmsknej6d2lRfM4
 hy47QIH50/+5CZMEWZLcFseDBrrexYC8sz+KZSXiNEmYxSgiKUHdlEZw1MAJm0wjppPMZ9DRT
 kvmg3DNlV2/PCswoXVNEKeS7P7T1OoCV8Y8w7GeEcvPJB1Diu9kgrtSP4HmB/BePSDnj28vs4
 eI7t8t2WnIEWqKlKFgaVkGy/XUTuqNRntmb4+DC+U9u5ELEoiElCoaeuxx0ShnVLrytaXOuou
 RIL2tENPrpnYUUWVvKD4z/2NNJX6KqWu+/ErC/2fth14ghxIEEoz9HP2f3z4CR8C7TPAjTx9D
 7YANuDDxkyEzqoTQKYymRNde8ZmW8HwNtc4IyiXH3m3fSI3d4U6wdMSU17E+FZv4+8YMsuZS+
 7yTh+n1V0bJjcOBEXIznF2S7ZMwFwP/VQJi+LMr+EyX/GaBUHbkdfSzW39tH9pOQ1JWvJfpQr
 Ll0ZvjTS1zsOVU2empHoaCLQ6bQEuvS4EKdNZmu2WVsD4jmmHzP/UKApGgjfrJbhvZWFwIu+v
 IVr6VhQ7KJEOPgDX05enB/FTzuXwhgjc/sw8nR57vSPz+mjxgNze1O+vBC3DhMIJIhrE4Zvny
 3vy5XkiLWxNAQ1cvX0dM5CX179Re9CorCk6+FtT7Unb1CpISAqcIAZnlMktipmPU6EZw3uXQm
 VisfzaQ9VN2Bv2t+1zN+2THKXlluw5SrrUskq0QFZ0IDeSvpX9FNwBhrzBUkHnd15uLexMUAG
 QyfJjD8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by, you guessed it, Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e0220630d00..64617ad8e36 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -734,6 +734,7 @@ static void handle_tag(const char *name, struct tag *tag)
 			     oid_to_hex(&tag->object.oid));
 		case DROP:
 			/* Ignore this tag altogether */
+			free(buf);
 			return;
 		case REWRITE:
 			if (tagged->type != OBJ_COMMIT) {
@@ -765,6 +766,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	       (int)(tagger_end - tagger), tagger,
 	       tagger == tagger_end ? "" : "\n",
 	       (int)message_size, (int)message_size, message ? message : "");
+	free(buf);
 }
 
 static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
-- 
2.12.2.windows.2.800.gede8f145e06


