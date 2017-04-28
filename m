Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4EE8207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 14:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968030AbdD1OET (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:04:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:49415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968140AbdD1OER (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:04:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfiFU-1dR9f426om-00NBux; Fri, 28
 Apr 2017 16:04:10 +0200
Date:   Fri, 28 Apr 2017 16:03:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 18/25] receive-pack: plug memory leak in update()
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <fabb32a7e994e8053b0ac08a5efa2868509c03d6.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:O4Ehywph029I5vt3WrDMSX4B4zT6biFONai5YhCRY+2rMQnFPMp
 X/nmrKa2nF5GqKIY0rCQM7O9Uf+zQQogCUwfngDVj30l4KynVwneQxqZoUvzy2sWUc+rBO5
 iEl7ohd1f5JDHP1y19DcCfOa9irMtmJmNwYORBYNH56rSRaHqA3kR9zOUVWOpaKOxA1QiYN
 FYj2rhxbMzrWdiTCVLk3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B4GMuw9MwYI=:VQt6aUhwB6HaIsYq+mQg2g
 v6lqdZMZYxFZ5yHoe/hhUuFFqsX1njnXuulqfvKFBCCVHgibSTEzkOO4GH+XBOgBtcyKOKGd6
 C3ZhiVYso3X0psHThbEWu7fcRsTWFF+0Mx+PjjAdKNDScqhX0p2Li2zwScEIMYEIJNwIKB+jJ
 4qy7B05NGVCaSsBjycYi6gVV8qE/76Nn5wvNimhP3OvLotogqeXGHkoyxlBxM1aHW74nx0HKO
 A1MxNMzhB2glQ7i3mqg/t5VRWiTQfwA5A3rHyP+STD0vfJ8vXoTJXifWiH2SClknFJD7dXw99
 vPYaC7a2mp8BC3g6bAOABKk/GJcYL0xG26ch/pFMiA4qgI8TGn4b1cJ14kyuhgWkRuXeLqIW6
 J4BFjdtlzclAdnivXVnu+OmOZSPZ/DS+KBt0D0KXg2kutEJIL/ES5phe/Ku4IsjMULN/JB0vN
 Yc90qZNOdsXDUiwHu59sDh2r2dHjNvLUl0hiXOLuX6WVrn7BxAMS23nnvwuKDElRtkBGMgYAi
 mD/DROrHDNMmPx9+V1gsxMa10o0qcWNzz7sbc2/NHPo3jReQYDc9eEBl8okSGHFU5QYaY2K09
 BxbRBfA1cJ5IS7HpoLmlwGvRdDz8vZQDTWq8PxejGartQn16PBs25Qg9arH4njgP4V6e4Bhnz
 SftloC1bx1Qp8Hld0CHeExyhv13RH+wUm0WohViPAWRvoqZcvsioxzJR5d19vt3HdRoI6b0At
 cFYsU2kfMEDCYwazGEUwjYzrCFVwRAdOO89PeFb0Yh7iJtEfgVXDtrfF3uGHNkqsS5J92zPes
 0yLwr8f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/receive-pack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f96834f42c9..48c07ddb659 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -986,7 +986,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
 	struct strbuf namespaced_name_buf = STRBUF_INIT;
-	const char *namespaced_name, *ret;
+	static char *namespaced_name;
+	const char *ret;
 	struct object_id *old_oid = &cmd->old_oid;
 	struct object_id *new_oid = &cmd->new_oid;
 
@@ -997,6 +998,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 
 	strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
+	free(namespaced_name);
 	namespaced_name = strbuf_detach(&namespaced_name_buf, NULL);
 
 	if (is_ref_checked_out(namespaced_name)) {
-- 
2.12.2.windows.2.800.gede8f145e06


