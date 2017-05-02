Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825101F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdEBQCp (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:53594 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751181AbdEBQCo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:44 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQeET-1dVB5w41V7-00U5PU; Tue, 02
 May 2017 18:02:34 +0200
Date:   Tue, 2 May 2017 18:02:33 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 18/25] receive-pack: plug memory leak in update()
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <aab8cdfa2878f23b4d046d8303757031bb6ad0fb.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XVKpjxLA0qQc3+5iUvlrTZNAMk4Mco4d07I9jac/Wx8580mClFn
 yDeqqyGN7Y6h01c81ICaKGe7LSgKrKqhroBE+fMbqryWsOtPLEh9USnn8zuKCidnoI0vTwJ
 mcFISpaCj9G8buj0H+RAzc8y4YLB6YbND6L431c9lkYUM3Hj5nWRF+ItUZP/QLy5XckqLCZ
 taVq4b1OJrIp6fdZSXErg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aAOw13nqRJg=:qS1Mv8gIqVX5g5EqksVaoZ
 60dVBzZwR+LZbOtx8vfhJXgZ12661VKcgmH9lP0Td4bN0/ddEor4ROY7PPhOIxzfWqTWQbdeV
 tWZZg8s5KsFZsr6++YMkgmOUcdPADbSTytbACxsiY+SooJzgZwS+DeBoY8EM0Q6MrNHHMO2Ms
 zcZ2nE/AI36ios4DRV47/TFmqEf61dm4LeMupEwYCM1dAwiTppuVwIQDwrzc3kcOgWByB1vqu
 hqQTFT85rLaob4jbHj0e2XwpYc00Txb7QmXHBnjsWtEOZ6hCcpFsS1Byn2TMRuxyiHv/gt9pk
 Vh+2bZTkR4ZqpAXXVkD7ljRqH6eK0qeq7JJLQO1M1zV9RUXoDpHEs1MDioPxGf2HVSs4JdT1v
 iDUDwmwzIfjW/rPJG2+QsORiK0MylYL6vNAtmCR9Dy77NGKb6o2NIDu3akgm1IgUW8TMAWZ9c
 eLzrS0+XPAJa+ee6g2yDJU8zu3/3QdKYeH15KTCHJkhIhuxKPqaW12BCTToOMjiQJ96VMs8yn
 JpBIWkzDkc6+9nCNOzXPynxgdU4amo3mni51PASOcHmoh6hdXMDqJyPuIifnutD4JKSynIX9V
 Si8E2KhmlPC0S1Cw9/y301aXEpuyNsJipFrTSPFzgCWLJwdm127dc+WD4FZL7WJGtw+ZfzH/2
 CxdQ0MqYOCHa+hKpkIRYITNPSttxiykxrq2H0K9RVDBsERMfaVbvp3272SiB8Yr26sTZWH63p
 fy24nRwdzm8E58xBJG+yGL9yIef2k3z0Y9LuMWLqdgSQJ3aQr1H/o+rTAWb9tor1i0fcWtLXb
 MFtpt59
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


